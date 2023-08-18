[translated]
module main

type RmtBool = u32
type RmtU8 = u8
type RmtU16 = u16
type RmtU32 = u32
type RmtU64 = i64
type RmtS8 = i8
type RmtS16 = i16
type RmtS32 = int
type RmtS64 = i64
type RmtF32 = f32
type RmtF64 = f64
type RmtPStr = &i8
type RmtSampleTree = Msg_SampleTree
type RmtSample = Sample
enum RmtSampleType {
	rmt_sampletype_cpu	rmt_sampletype_cuda	rmt_sampletype_d3d11	rmt_sampletype_d3d12	rmt_sampletype_opengl	rmt_sampletype_metal	rmt_sampletype_count}

enum RmtError {
	rmt_error_none	rmt_error_recursive_sample	rmt_error_unknown	rmt_error_invalid_input	rmt_error_resource_create_fail	rmt_error_resource_access_fail	rmt_error_timeout	rmt_error_malloc_fail	rmt_error_tls_alloc_fail	rmt_error_virtual_memory_buffer_fail	rmt_error_create_thread_fail	rmt_error_open_thread_handle_fail	rmt_error_socket_invalid_poll	rmt_error_socket_select_fail	rmt_error_socket_poll_errors	rmt_error_socket_send_fail	rmt_error_socket_recv_no_data	rmt_error_socket_recv_timeout	rmt_error_socket_recv_failed	rmt_error_websocket_handshake_not_get	rmt_error_websocket_handshake_no_version	rmt_error_websocket_handshake_bad_version	rmt_error_websocket_handshake_no_host	rmt_error_websocket_handshake_bad_host	rmt_error_websocket_handshake_no_key	rmt_error_websocket_handshake_bad_key	rmt_error_websocket_handshake_string_fail	rmt_error_websocket_disconnected	rmt_error_websocket_bad_frame_header	rmt_error_websocket_bad_frame_header_size	rmt_error_websocket_bad_frame_header_mask	rmt_error_websocket_receive_timeout	rmt_error_remotery_not_created	rmt_error_send_on_incomplete_profile	rmt_error_cuda_deinitialized	rmt_error_cuda_not_initialized	rmt_error_cuda_invalid_context	rmt_error_cuda_invalid_value	rmt_error_cuda_invalid_handle	rmt_error_cuda_out_of_memory	rmt_error_error_not_ready	rmt_error_d3d11_failed_to_create_query	rmt_error_opengl_error	rmt_error_cuda_unknown}

[c:'rmt_GetLastErrorMessage']
fn rmt_getlasterrormessage() RmtPStr

type RmtMallocPtr = fn (voidptr, RmtU32) voidptr
type RmtReallocPtr = fn (voidptr, voidptr, RmtU32) voidptr
type RmtFreePtr = fn (voidptr, voidptr)
type RmtInputHandlerPtr = fn (&i8, voidptr)
type RmtSampleTreeHandlerPtr = fn (voidptr, &RmtSampleTree)
type RmtPropertyHandlerPtr = fn (voidptr, &RmtProperty)
struct RmtSettings { 
	C.malloc RmtMallocPtr
	C.free RmtFreePtr
	port RmtU16
	reuse_open_port RmtBool
	limit_connections_to_localhost RmtBool
	enableThreadSampler RmtBool
	msSleepBetweenServerUpdates RmtU32
	messageQueueSizeInBytes RmtU32
	maxNbMessagesPerUpdate RmtU32

	realloc RmtReallocPtr

	mm_context voidptr
	input_handler RmtInputHandlerPtr
	sampletree_handler RmtSampleTreeHandlerPtr
	sampletree_context voidptr
	snapshot_callback RmtPropertyHandlerPtr
	snapshot_context voidptr
	input_handler_context voidptr
	logPath RmtPStr
}
struct RmtCUDABind { 
	context voidptr
	CtxSetCurrent voidptr
	CtxGetCurrent voidptr
	EventCreate voidptr
	EventDestroy voidptr
	EventRecord voidptr
	EventQuery voidptr
	EventElapsedTime voidptr
}
struct RmtD3D12Bind { 
	device voidptr
	queue voidptr
}
enum RmtPropertyFlags {
	rmt_propertyflags_noflags = 0	rmt_propertyflags_framereset = 1}

enum RmtPropertyType {
	rmt_propertytype_rmtgroup	rmt_propertytype_rmtbool	rmt_propertytype_rmts32	rmt_propertytype_rmtu32	rmt_propertytype_rmtf32	rmt_propertytype_rmts64	rmt_propertytype_rmtu64	rmt_propertytype_rmtf64}

union RmtPropertyValue { 
	Bool RmtBool
	S32 RmtS32
	U32 RmtU32
	F32 RmtF32
	S64 RmtS64
	U64 RmtU64
	F64 RmtF64
}
struct RmtProperty { 
	initialised RmtBool
	type_ RmtPropertyType
	flags RmtPropertyFlags
	value RmtPropertyValue
	lastFrameValue RmtPropertyValue
	prevValue RmtPropertyValue
	prevValueFrame RmtU32
	name &i8
	description &i8
	defaultValue RmtPropertyValue
	parent &RmtProperty
	firstChild &RmtProperty
	lastChild &RmtProperty
	nextSibling &RmtProperty
	nameHash RmtU32
	uniqueID RmtU32
}
[c:'_rmt_PropertySetValue']
fn _rmt_propertysetvalue(property &RmtProperty) 

[c:'_rmt_PropertyAddValue']
fn _rmt_propertyaddvalue(property &RmtProperty, add_value RmtPropertyValue) 

[c:'_rmt_PropertySnapshotAll']
fn _rmt_propertysnapshotall() RmtError

[c:'_rmt_PropertyFrameResetAll']
fn _rmt_propertyframeresetall() 

[c:'_rmt_HashString32']
fn _rmt_hashstring32(s &i8, len int, seed RmtU32) RmtU32

enum RmtSampleFlags {
	rmtsf_none = 0	rmtsf_aggregate = 1	rmtsf_recursive = 2	rmtsf_root = 4	rmtsf_sendonclose = 8}

struct RmtSampleIterator { 
	sample &RmtSample
	initial &RmtSample
}
struct RmtPropertyIterator { 
	property &RmtProperty
	initial &RmtProperty
}
[c:'_rmt_Settings']
fn _rmt_settings() &RmtSettings

[c:'_rmt_CreateGlobalInstance']
fn _rmt_createglobalinstance(remotery &&Remotery) RmtError

[c:'_rmt_DestroyGlobalInstance']
fn _rmt_destroyglobalinstance(remotery &Remotery) 

[c:'_rmt_SetGlobalInstance']
fn _rmt_setglobalinstance(remotery &Remotery) 

[c:'_rmt_GetGlobalInstance']
fn _rmt_getglobalinstance() &Remotery

[c:'_rmt_SetCurrentThreadName']
fn _rmt_setcurrentthreadname(thread_name RmtPStr) 

[c:'_rmt_LogText']
fn _rmt_logtext(text RmtPStr) 

[c:'_rmt_BeginCPUSample']
fn _rmt_begincpusample(name RmtPStr, flags RmtU32, hash_cache &RmtU32) 

[c:'_rmt_EndCPUSample']
fn _rmt_endcpusample() 

[c:'_rmt_MarkFrame']
fn _rmt_markframe() RmtError

[c:'_rmt_IterateChildren']
fn _rmt_iteratechildren(iter &RmtSampleIterator, sample &RmtSample) 

[c:'_rmt_IterateNext']
fn _rmt_iteratenext(iter &RmtSampleIterator) RmtBool

[c:'_rmt_SampleTreeGetThreadName']
fn _rmt_sampletreegetthreadname(sample_tree &RmtSampleTree) &i8

[c:'_rmt_SampleTreeGetRootSample']
fn _rmt_sampletreegetrootsample(sample_tree &RmtSampleTree) &RmtSample

[c:'_rmt_SampleGetName']
fn _rmt_samplegetname(sample &RmtSample) &i8

[c:'_rmt_SampleGetNameHash']
fn _rmt_samplegetnamehash(sample &RmtSample) RmtU32

[c:'_rmt_SampleGetCallCount']
fn _rmt_samplegetcallcount(sample &RmtSample) RmtU32

[c:'_rmt_SampleGetStart']
fn _rmt_samplegetstart(sample &RmtSample) RmtU64

[c:'_rmt_SampleGetTime']
fn _rmt_samplegettime(sample &RmtSample) RmtU64

[c:'_rmt_SampleGetSelfTime']
fn _rmt_samplegetselftime(sample &RmtSample) RmtU64

[c:'_rmt_SampleGetColour']
fn _rmt_samplegetcolour(sample &RmtSample, r &RmtU8, g &RmtU8, b &RmtU8) 

[c:'_rmt_SampleGetType']
fn _rmt_samplegettype(sample &RmtSample) RmtSampleType

[c:'_rmt_PropertyIterateChildren']
fn _rmt_propertyiteratechildren(iter &RmtPropertyIterator, property &RmtProperty) 

[c:'_rmt_PropertyIterateNext']
fn _rmt_propertyiteratenext(iter &RmtPropertyIterator) RmtBool

[c:'_rmt_PropertyGetType']
fn _rmt_propertygettype(property &RmtProperty) RmtPropertyType

[c:'_rmt_PropertyGetNameHash']
fn _rmt_propertygetnamehash(property &RmtProperty) RmtU32

[c:'_rmt_PropertyGetName']
fn _rmt_propertygetname(property &RmtProperty) &i8

[c:'_rmt_PropertyGetDescription']
fn _rmt_propertygetdescription(property &RmtProperty) &i8

[c:'_rmt_PropertyGetValue']
fn _rmt_propertygetvalue(property &RmtProperty) RmtPropertyValue

[weak]__global ( g_Settings RmtSettings 

)

/*!*/[weak] __global ( g_SettingsInitialized  = RmtBool ((RmtBool(0)))
)

type Mach_timebase_info_t = &Mach_timebase_info
type Mach_timebase_info_data_t = Mach_timebase_info
fn mach_timebase_info(info Mach_timebase_info_t) Kern_return_t

fn mach_absolute_time() u64

fn vm_allocate(target_task Vm_map_t, address &Vm_address_t, size Vm_size_t, flags int) Kern_return_t

fn vm_deallocate(target_task Vm_map_t, address Vm_address_t, size Vm_size_t) Kern_return_t

fn vm_map(target_task Vm_map_t, address &Vm_address_t, size Vm_size_t, mask Vm_address_t, flags int, object Mem_entry_name_port_t, offset Vm_offset_t, copy Boolean_t, cur_protection Vm_prot_t, max_protection Vm_prot_t, inheritance Vm_inherit_t) Kern_return_t

fn vm_remap(target_task Vm_map_t, target_address &Vm_address_t, size Vm_size_t, mask Vm_address_t, flags int, src_task Vm_map_t, src_address Vm_address_t, copy Boolean_t, cur_protection &Vm_prot_t, max_protection &Vm_prot_t, inheritance Vm_inherit_t) Kern_return_t

struct Request__vm_region_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	flavor Vm_region_flavor_t
	infoCnt Mach_msg_type_number_t
}
struct Request__vm_allocate_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	flags int
}
struct Request__vm_deallocate_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
}
struct Request__vm_protect_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	set_maximum Boolean_t
	new_protection Vm_prot_t
}
struct Request__vm_inherit_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	new_inheritance Vm_inherit_t
}
struct Request__vm_read_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
}
struct Request__vm_read_list_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	data_list Vm_read_entry_t
	count Natural_t
}
struct Request__vm_write_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	data Mach_msg_ool_descriptor_t
	NDR NDR_record_t
	address Vm_address_t
	dataCnt Mach_msg_type_number_t
}
struct Request__vm_copy_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	source_address Vm_address_t
	size Vm_size_t
	dest_address Vm_address_t
}
struct Request__vm_read_overwrite_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	data Vm_address_t
}
struct Request__vm_msync_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	sync_flags Vm_sync_t
}
struct Request__vm_behavior_set_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	new_behavior Vm_behavior_t
}
struct Request__vm_map_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	object Mach_msg_port_descriptor_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	mask Vm_address_t
	flags int
	offset Vm_offset_t
	copy Boolean_t
	cur_protection Vm_prot_t
	max_protection Vm_prot_t
	inheritance Vm_inherit_t
}
struct Request__vm_machine_attribute_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	attribute Vm_machine_attribute_t
	value Vm_machine_attribute_val_t
}
struct Request__vm_remap_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	src_task Mach_msg_port_descriptor_t
	NDR NDR_record_t
	target_address Vm_address_t
	size Vm_size_t
	mask Vm_address_t
	flags int
	src_address Vm_address_t
	copy Boolean_t
	inheritance Vm_inherit_t
}
struct Request__task_wire_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	must_wire Boolean_t
}
struct Request__mach_make_memory_entry_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	parent_entry Mach_msg_port_descriptor_t
	NDR NDR_record_t
	size Vm_size_t
	offset Vm_offset_t
	permission Vm_prot_t
}
struct Request__vm_map_page_query_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	offset Vm_offset_t
}
struct Request__mach_vm_region_info_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
}
struct Request__vm_mapped_pages_info_t { 
	Head Mach_msg_header_t
}
struct Request__vm_region_recurse_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	nesting_depth Natural_t
	infoCnt Mach_msg_type_number_t
}
struct Request__vm_region_recurse_64_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	nesting_depth Natural_t
	infoCnt Mach_msg_type_number_t
}
struct Request__mach_vm_region_info_64_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
}
struct Request__vm_region_64_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	flavor Vm_region_flavor_t
	infoCnt Mach_msg_type_number_t
}
struct Request__mach_make_memory_entry_64_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	parent_entry Mach_msg_port_descriptor_t
	NDR NDR_record_t
	size Memory_object_size_t
	offset Memory_object_offset_t
	permission Vm_prot_t
}
struct Request__vm_map_64_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	object Mach_msg_port_descriptor_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	mask Vm_address_t
	flags int
	offset Memory_object_offset_t
	copy Boolean_t
	cur_protection Vm_prot_t
	max_protection Vm_prot_t
	inheritance Vm_inherit_t
}
struct Request__vm_purgable_control_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	address Vm_address_t
	control Vm_purgable_t
	state int
}
struct Request__vm_map_exec_lockdown_t { 
	Head Mach_msg_header_t
}
struct Request__vm_remap_new_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	src_task Mach_msg_port_descriptor_t
	NDR NDR_record_t
	target_address Vm_address_t
	size Vm_size_t
	mask Vm_address_t
	flags int
	src_address Vm_address_t
	copy Boolean_t
	cur_protection Vm_prot_t
	max_protection Vm_prot_t
	inheritance Vm_inherit_t
}
union RequestUnion__vm_map_subsystem { 
	Request_vm_region Request__vm_region_t
	Request_vm_allocate Request__vm_allocate_t
	Request_vm_deallocate Request__vm_deallocate_t
	Request_vm_protect Request__vm_protect_t
	Request_vm_inherit Request__vm_inherit_t
	Request_vm_read Request__vm_read_t
	Request_vm_read_list Request__vm_read_list_t
	Request_vm_write Request__vm_write_t
	Request_vm_copy Request__vm_copy_t
	Request_vm_read_overwrite Request__vm_read_overwrite_t
	Request_vm_msync Request__vm_msync_t
	Request_vm_behavior_set Request__vm_behavior_set_t
	Request_vm_map Request__vm_map_t
	Request_vm_machine_attribute Request__vm_machine_attribute_t
	Request_vm_remap Request__vm_remap_t
	Request_task_wire Request__task_wire_t
	Request_mach_make_memory_entry Request__mach_make_memory_entry_t
	Request_vm_map_page_query Request__vm_map_page_query_t
	Request_mach_vm_region_info Request__mach_vm_region_info_t
	Request_vm_mapped_pages_info Request__vm_mapped_pages_info_t
	Request_vm_region_recurse Request__vm_region_recurse_t
	Request_vm_region_recurse_64 Request__vm_region_recurse_64_t
	Request_mach_vm_region_info_64 Request__mach_vm_region_info_64_t
	Request_vm_region_64 Request__vm_region_64_t
	Request_mach_make_memory_entry_64 Request__mach_make_memory_entry_64_t
	Request_vm_map_64 Request__vm_map_64_t
	Request_vm_purgable_control Request__vm_purgable_control_t
	Request_vm_map_exec_lockdown Request__vm_map_exec_lockdown_t
	Request_vm_remap_new Request__vm_remap_new_t
}
struct Reply__vm_region_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	object_name Mach_msg_port_descriptor_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	infoCnt Mach_msg_type_number_t
	info [10]int
}
struct Reply__vm_allocate_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	address Vm_address_t
}
struct Reply__vm_deallocate_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
}
struct Reply__vm_protect_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
}
struct Reply__vm_inherit_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
}
struct Reply__vm_read_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	data Mach_msg_ool_descriptor_t
	NDR NDR_record_t
	dataCnt Mach_msg_type_number_t
}
struct Reply__vm_read_list_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	data_list Vm_read_entry_t
}
struct Reply__vm_write_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
}
struct Reply__vm_copy_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
}
struct Reply__vm_read_overwrite_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	outsize Vm_size_t
}
struct Reply__vm_msync_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
}
struct Reply__vm_behavior_set_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
}
struct Reply__vm_map_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	address Vm_address_t
}
struct Reply__vm_machine_attribute_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	value Vm_machine_attribute_val_t
}
struct Reply__vm_remap_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	target_address Vm_address_t
	cur_protection Vm_prot_t
	max_protection Vm_prot_t
}
struct Reply__task_wire_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
}
struct Reply__mach_make_memory_entry_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	object_handle Mach_msg_port_descriptor_t
	NDR NDR_record_t
	size Vm_size_t
}
struct Reply__vm_map_page_query_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	disposition Integer_t
	ref_count Integer_t
}
struct Reply__mach_vm_region_info_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	objects Mach_msg_ool_descriptor_t
	NDR NDR_record_t
	region Vm_info_region_t
	objectsCnt Mach_msg_type_number_t
}
struct Reply__vm_mapped_pages_info_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	pages Mach_msg_ool_descriptor_t
	NDR NDR_record_t
	pagesCnt Mach_msg_type_number_t
}
struct Reply__vm_region_recurse_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	address Vm_address_t
	size Vm_size_t
	nesting_depth Natural_t
	infoCnt Mach_msg_type_number_t
	info [19]int
}
struct Reply__vm_region_recurse_64_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	address Vm_address_t
	size Vm_size_t
	nesting_depth Natural_t
	infoCnt Mach_msg_type_number_t
	info [19]int
}
struct Reply__mach_vm_region_info_64_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	objects Mach_msg_ool_descriptor_t
	NDR NDR_record_t
	region Vm_info_region_64_t
	objectsCnt Mach_msg_type_number_t
}
struct Reply__vm_region_64_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	object_name Mach_msg_port_descriptor_t
	NDR NDR_record_t
	address Vm_address_t
	size Vm_size_t
	infoCnt Mach_msg_type_number_t
	info [10]int
}
struct Reply__mach_make_memory_entry_64_t { 
	Head Mach_msg_header_t
	msgh_body Mach_msg_body_t
	object_handle Mach_msg_port_descriptor_t
	NDR NDR_record_t
	size Memory_object_size_t
}
struct Reply__vm_map_64_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	address Vm_address_t
}
struct Reply__vm_purgable_control_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	state int
}
struct Reply__vm_map_exec_lockdown_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
}
struct Reply__vm_remap_new_t { 
	Head Mach_msg_header_t
	NDR NDR_record_t
	RetCode Kern_return_t
	target_address Vm_address_t
	cur_protection Vm_prot_t
	max_protection Vm_prot_t
}
union ReplyUnion__vm_map_subsystem { 
	Reply_vm_region Reply__vm_region_t
	Reply_vm_allocate Reply__vm_allocate_t
	Reply_vm_deallocate Reply__vm_deallocate_t
	Reply_vm_protect Reply__vm_protect_t
	Reply_vm_inherit Reply__vm_inherit_t
	Reply_vm_read Reply__vm_read_t
	Reply_vm_read_list Reply__vm_read_list_t
	Reply_vm_write Reply__vm_write_t
	Reply_vm_copy Reply__vm_copy_t
	Reply_vm_read_overwrite Reply__vm_read_overwrite_t
	Reply_vm_msync Reply__vm_msync_t
	Reply_vm_behavior_set Reply__vm_behavior_set_t
	Reply_vm_map Reply__vm_map_t
	Reply_vm_machine_attribute Reply__vm_machine_attribute_t
	Reply_vm_remap Reply__vm_remap_t
	Reply_task_wire Reply__task_wire_t
	Reply_mach_make_memory_entry Reply__mach_make_memory_entry_t
	Reply_vm_map_page_query Reply__vm_map_page_query_t
	Reply_mach_vm_region_info Reply__mach_vm_region_info_t
	Reply_vm_mapped_pages_info Reply__vm_mapped_pages_info_t
	Reply_vm_region_recurse Reply__vm_region_recurse_t
	Reply_vm_region_recurse_64 Reply__vm_region_recurse_64_t
	Reply_mach_vm_region_info_64 Reply__mach_vm_region_info_64_t
	Reply_vm_region_64 Reply__vm_region_64_t
	Reply_mach_make_memory_entry_64 Reply__mach_make_memory_entry_64_t
	Reply_vm_map_64 Reply__vm_map_64_t
	Reply_vm_purgable_control Reply__vm_purgable_control_t
	Reply_vm_map_exec_lockdown Reply__vm_map_exec_lockdown_t
	Reply_vm_remap_new Reply__vm_remap_new_t
}
type Voucher_mach_msg_state_t = &Voucher_mach_msg_state_s
struct Timezone { 
	tz_minuteswest int
	tz_dsttime int
}
struct Clock_t { 
	hz int
	tick int
	tickadj int
	stathz int
	profhz int
}
struct Lldiv_t { 
	quot i64
	rem i64
}
fn mbstowcs( wchar_t &restrict,  char &restrict,  usize 256) usize

fn rand() int

fn mkstemp( &i8) int

fn random() int

fn asin( f64) f64

fn asin( f64) f64

fn cos( f64) f64

fn cos( f64) f64

fn sin( f64) f64

fn sin( f64) f64

fn tan( f64) f64

fn tan( f64) f64

fn exp( f64) f64

fn exp( f64) f64

fn expl( long double) long double

fn expl( long double) long double

fn logf( f32) f32

fn logf( f32) f32

fn log( f64) f64

fn log( f64) f64

fn log2( f64) f64

fn log2( f64) f64

fn fabs( f64) f64

fn fabs( f64) f64

fn pow( f64,  f64) f64

fn pow( f64,  f64) f64

fn erf( f64) f64

fn erf( f64) f64

fn ceil( f64) f64

fn ceil( f64) f64

fn round( f64) f64

fn round( f64) f64

fn trunc( f64) f64

fn trunc( f64) f64

fn fmod( f64,  f64) f64

fn fmod( f64,  f64) f64

fn jn( int,  f64) f64

fn yn( int,  f64) f64

fn finite( f64) int

fn finite( f64) int

type Qos_class_t = u32
fn pthread_getspecific(key &Pthread_key_t) ? &u8 _Nullable

type Pthread_jit_write_callback_t = fn (?) int
fn _exit( int) 

fn access( &i8,  int) int

fn link( &i8,  &i8) int

fn sleep( u32) u32

fn unlink( &i8) int

fn nice( int) int

fn sync() 

fn truncate( &i8,  Off_t) int

fn usleep( Useconds_t) int

fn mkstemp( &i8) int

fn profil( &i8,  usize,  u32,  u32) int

fn mmap( voidptr,  usize,  int,  int,  int,  Off_t) voidptr

fn munmap( voidptr,  usize) int
// type Dl_info = Dl_info
fn dlclose(__handle voidptr) int

fn dlopen(__path &i8, __mode int) voidptr

fn dlsym(__handle voidptr, __symbol &i8) voidptr

type Atomic_bool = Atomic(bool)
type Atomic_char = Atomic(char)
type Atomic_schar = Atomic(signed)
type Atomic_uchar = Atomic(unsigned)
type Atomic_short = Atomic(short)
type Atomic_ushort = Atomic(unsigned)
type Atomic_int = Atomic(int)
type Atomic_uint = Atomic(unsigned)
type Atomic_long = Atomic(long)
type Atomic_ulong = Atomic(unsigned)
type Atomic_llong = Atomic(long)
type Atomic_ullong = Atomic(unsigned)
type Atomic_char16_t = Atomic(uint_least16_t)
type Atomic_char32_t = Atomic(uint_least32_t)
type Atomic_wchar_t = Atomic(wchar_t)
type Atomic_int_least8_t = Atomic(int_least8_t)
type Atomic_uint_least8_t = Atomic(uint_least8_t)
type Atomic_int_least16_t = Atomic(int_least16_t)
type Atomic_uint_least16_t = Atomic(uint_least16_t)
type Atomic_int_least32_t = Atomic(int_least32_t)
type Atomic_uint_least32_t = Atomic(uint_least32_t)
type Atomic_int_least64_t = Atomic(int_least64_t)
type Atomic_uint_least64_t = Atomic(uint_least64_t)
type Atomic_int_fast8_t = Atomic(int_fast8_t)
type Atomic_uint_fast8_t = Atomic(uint_fast8_t)
type Atomic_int_fast16_t = Atomic(int_fast16_t)
type Atomic_uint_fast16_t = Atomic(uint_fast16_t)
type Atomic_int_fast32_t = Atomic(int_fast32_t)
type Atomic_uint_fast32_t = Atomic(uint_fast32_t)
type Atomic_int_fast64_t = Atomic(int_fast64_t)
type Atomic_uint_fast64_t = Atomic(uint_fast64_t)
type Atomic_intptr_t = Atomic(intptr_t)
type Atomic_uintptr_t = Atomic(uintptr_t)
type Atomic_size_t = Atomic(size_t)
type Atomic_ptrdiff_t = Atomic(ptrdiff_t)
type Atomic_intmax_t = Atomic(intmax_t)
type Atomic_uintmax_t = Atomic(uintmax_t)
struct Atomic_flag { 
	_Value Atomic_bool
}
[c:'minU8']
fn minu8(a RmtU8, b RmtU8) RmtU8 {
	return if a < b{ a } else {b}
}

[c:'maxU16']
fn maxu16(a RmtU16, b RmtU16) RmtU16 {
	return if a > b{ a } else {b}
}

[c:'minS32']
fn mins32(a RmtS32, b RmtS32) RmtS32 {
	return if a < b{ a } else {b}
}

[c:'maxS32']
fn maxs32(a RmtS32, b RmtS32) RmtS32 {
	return if a > b{ a } else {b}
}

[c:'minU32']
fn minu32(a RmtU32, b RmtU32) RmtU32 {
	return if a < b{ a } else {b}
}

[c:'maxU32']
fn maxu32(a RmtU32, b RmtU32) RmtU32 {
	return if a > b{ a } else {b}
}

[c:'maxS64']
fn maxs64(a RmtS64, b RmtS64) RmtS64 {
	return if a > b{ a } else {b}
}

[c:'rmtMalloc']
fn rmtmalloc(size RmtU32) voidptr {
	return g_Settings.C.malloc(g_Settings.mm_context, size)
}

[c:'rmtRealloc']
fn rmtrealloc(ptr voidptr, size RmtU32) voidptr {
	return g_Settings.realloc(g_Settings.mm_context, ptr, size)
}

[c:'rmtFree']
fn rmtfree(ptr voidptr)  {
	g_Settings.C.free(g_Settings.mm_context, ptr)
}

[c:'rmtOpenFile']
fn rmtopenfile(filename &i8, mode &i8) &C.FILE {
	return C.fopen(filename, mode)
}

[c:'rmtCloseFile']
fn rmtclosefile(fp &C.FILE)  {
	if fp != (voidptr(0)) {
		C.fclose(fp)
	}
}

[c:'rmtWriteFile']
fn rmtwritefile(fp &C.FILE, data voidptr, size RmtU32) RmtBool {
	(
		if __builtin_expect(!(fp != (voidptr(0))), 0){
			 __assert_rtn( c'Remotery.c', 273, c'fp != NULL') }
			else {return error('error message')}
			)
	return if C.fwrite(data, size, 1, fp) == size{ (RmtBool(1)) } else {(RmtBool(0))}
}

[c:'msTimer_Get']
fn mstimer_get() RmtU32 {
	time := clock()
	mstime := RmtU32((time / ((Clock_t(1000000)) / 1000)))
	return mstime
}

type LARGE_INTEGER = RmtU64
struct UsTimer { 
	counter_start LARGE_INTEGER
	counter_scale f64
}
[c:'usTimer_Init']
fn ustimer_init(timer &UsTimer)  {
	nsscale := Mach_timebase_info_data_t{}
	mach_timebase_info(&nsscale)
	ns_per_us := 1000
	timer.counter_scale = f64((nsscale.numer)) / (f64(nsscale.denom) * ns_per_us)
	timer.counter_start = mach_absolute_time()
}

[c:'usTimer_Get']
fn ustimer_get(timer &UsTimer) RmtU64 {
	curr_time := mach_absolute_time()
	return RmtU64(((curr_time - timer.counter_start) * timer.counter_scale))
}

[c:'msSleep']
fn mssleep(time_ms RmtU32)  {
	usleep(time_ms * 1000)
}

[c:'TimeDateNow']
fn timedatenow() &Tm {
	time_now := time((voidptr(0)))
	return gmtime(&time_now)
}

type RmtTLS = Pthread_key_t
[c:'tlsAlloc']
fn tlsalloc(handle &RmtTLS) RmtError {
	(if __builtin_expect(!(handle != (voidptr(0))), 0){
		 __assert_rtn(c'Remotery.c', 461, c'handle != NULL') 
		 } else {return error('error message')})
	if pthread_key_create(handle, (voidptr(0))) != 0 {
		*handle = 4294967295
		return RmtError.rmt_error_tls_alloc_fail
	}
	return RmtError.rmt_error_none
}

[c:'tlsFree']
fn tlsfree(handle RmtTLS)  {
	(if __builtin_expect(!(handle != 4294967295), 0){
		 __assert_rtn(c'Remotery.c', 483, c'handle != TLS_INVALID_HANDLE') 
		 } else {return error('error message')})
	pthread_key_delete(Pthread_key_t(handle))
}

[c:'tlsSet']
fn tlsset(handle RmtTLS, value voidptr)  {
	(if __builtin_expect(!(handle != 4294967295), 0){ __assert_rtn(c'Remotery.c', 493, c'handle != TLS_INVALID_HANDLE') } else {return error('error message')})
	pthread_setspecific(Pthread_key_t(handle), value)
}

[c:'tlsGet']
fn tlsget(handle RmtTLS) voidptr {
	(if __builtin_expect(!(handle != 4294967295), 0){ __assert_rtn(c'Remotery.c', 503, c'handle != TLS_INVALID_HANDLE') } else {return error('error message')})
	return pthread_getspecific(Pthread_key_t(handle))
}

/*!*/[weak] __global ( g_lastErrorMessageTlsHandle  = RmtTLS (4294967295)
)

[export:'g_errorMessageSize']
const (
g_errorMessageSize   = 1024
)

[c:'rmtMakeError']
fn rmtmakeerror(in_error RmtError, error_message RmtPStr) RmtError {
	thread_message_ptr := &i8(0)
	error_len := RmtU32{}
	if g_lastErrorMessageTlsHandle == 4294967295 {
		{
			error := tlsalloc(&g_lastErrorMessageTlsHandle)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
	}
	thread_message_ptr = &i8(tlsget(g_lastErrorMessageTlsHandle))
	if thread_message_ptr == (voidptr(0)) {
		thread_message_ptr = &i8(rmtmalloc(g_errorMessageSize))
		if thread_message_ptr == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		tlsset(g_lastErrorMessageTlsHandle, voidptr(thread_message_ptr))
	}
	error_len = RmtU32(C.strlen(error_message))
	error_len = if error_len >= g_errorMessageSize{ g_errorMessageSize - 1 } else {error_len}
	C.memcpy(thread_message_ptr, error_message, error_len)
	thread_message_ptr [error_len]  = 0
	return in_error
}

[c:'rmt_GetLastErrorMessage']
fn rmt_getlasterrormessage() RmtPStr {
	thread_message_ptr := RmtPStr{}
	if g_lastErrorMessageTlsHandle == 4294967295 {
		return c'No error message'
	}
	thread_message_ptr = RmtPStr(tlsget(g_lastErrorMessageTlsHandle))
	if thread_message_ptr == (voidptr(0)) {
		return c'No error message'
	}
	return thread_message_ptr
}

type RmtMutex = Pthread_mutex_t
[c:'mtxInit']
fn mtxinit(mutex &RmtMutex)  {
	(if __builtin_expect(!(mutex != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 593, c'mutex != NULL') } else {return error('error message')})
	pthread_mutex_init(mutex, (voidptr(0)))
}

[c:'mtxLock']
fn mtxlock(mutex &RmtMutex)  {
	(if __builtin_expect(!(mutex != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 603, c'mutex != NULL') } else {return error('error message')})
	pthread_mutex_lock(mutex)
}

[c:'mtxUnlock']
fn mtxunlock(mutex &RmtMutex)  {
	(if __builtin_expect(!(mutex != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 613, c'mutex != NULL') } else {return error('error message')})
	pthread_mutex_unlock(mutex)
}

[c:'mtxDelete']
fn mtxdelete(mutex &RmtMutex)  {
	(if __builtin_expect(!(mutex != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 623, c'mutex != NULL') } else {return error('error message')})
	pthread_mutex_destroy(mutex)
}

type RmtAtomicS32 = Atomic(rmtS32)
type RmtAtomicU32 = Atomic(rmtU32)
type RmtAtomicU64 = Atomic(rmtU64)
type RmtAtomicBool = Atomic(rmtBool)
type RmtAtomicVoidPtr = Atomic(voidptr)
[c:'AtomicCompareAndSwapU32']
fn atomiccompareandswapu32(val &RmtAtomicU32, old_val RmtU32, new_val RmtU32) RmtBool {
	return 
}

[c:'AtomicCompareAndSwapU64']
fn atomiccompareandswapu64(val &RmtAtomicU64, old_val RmtU64, new_val RmtU64) RmtBool {
	return 
}

[c:'AtomicCompareAndSwapPointer']
fn atomiccompareandswappointer(ptr &RmtAtomicVoidPtr, old_ptr voidptr, new_ptr voidptr) RmtBool {
	return 
}

[c:'AtomicAddS32']
fn atomicadds32(value &RmtAtomicS32, add RmtS32) RmtS32 {
	return 
}

[c:'AtomicAddU32']
fn atomicaddu32(value &RmtAtomicU32, add RmtU32) RmtU32 {
	return 
}

[c:'AtomicSubS32']
fn atomicsubs32(value &RmtAtomicS32, sub RmtS32)  {
	atomicadds32(value, -sub)
}

[c:'AtomicStoreU32']
fn atomicstoreu32(value &RmtAtomicU32, set RmtU32) RmtU32 {
	return 
}

[c:'AtomicLoadU32']
fn atomicloadu32(value &RmtAtomicU32) RmtU32 {
	return 
}

[c:'CompilerWriteFence']
fn compilerwritefence()  {
	// error: `__asm__` evaluated but not used
	// __asm__
}

[c:'CompilerReadFence']
fn compilerreadfence()  {
	// error: `__asm__` evaluated but not used
	// __asm__
}

[c:'LoadAcquire']
fn loadacquire(address &RmtAtomicU32) RmtU32 {
	value := *address
	compilerreadfence()
	return value
}

[c:'LoadAcquirePointer']
fn loadacquirepointer(ptr &&int) &int {
	value := *ptr
	compilerreadfence()
	return value
}

[c:'StoreRelease']
fn storerelease(address &RmtAtomicU32, value RmtU32)  {
	compilerwritefence()
	*address = value
}

[c:'StoreReleasePointer']
fn storereleasepointer(ptr &&int, value &int)  {
	compilerwritefence()
	*ptr = value
}

[weak]__global ( Well512_State [16]RmtU32 

)

[weak]__global ( Well512_Index RmtU32 

)

[c:'Well512_Init']
fn well512_init(seed RmtU32)  {
	i := RmtU32{}
	Well512_State [0]  = seed
	for i = 1 ; i < 16 ; i ++ {
		prev := Well512_State [i - 1] 
		Well512_State [i]  = (1812433253 * (prev ^ (prev >> 30)) + i)
	}
	Well512_Index = 0
}

[c:'Well512_RandomU32']
fn well512_randomu32() RmtU32 {
	a := RmtU32{}
	b := RmtU32{}
	c := RmtU32{}
	d := RmtU32{}
	
	a = Well512_State [Well512_Index] 
	c = Well512_State [(Well512_Index + 13) & 15] 
	b = a ^ c ^ (a << 16) ^ (c << 15)
	c = Well512_State [(Well512_Index + 9) & 15] 
	c ^= (c >> 11)
	a = b ^ c
	Well512_State [Well512_Index]  = a
	d = a ^ ((a << 5) & 3661901092)
	Well512_Index = (Well512_Index + 15) & 15
	a = Well512_State [Well512_Index] 
	Well512_State [Well512_Index]  = a ^ b ^ d ^ (a << 2) ^ (b << 18) ^ (c << 28)
	return Well512_State [Well512_Index] 
}

[c:'Well512_RandomOpenLimit']
fn well512_randomopenlimit(limit RmtU32) RmtU32 {
	bucket_size := (2147483647 * 2 + 1) / limit
	bucket_limit := bucket_size * limit
	r := RmtU32{}
	for {
	r = well512_randomu32()
	// while()
	if ! (r >= bucket_limit ) { break }
	}
	return r / bucket_size
}

[c:'Log2i']
fn log2i(x RmtU32) RmtU32 {
	multiplydebruijnbitposition := [0, 9, 1, 10, 13, 21, 2, 29, 11, 14, 16, 18, 22, 25, 3, 30, 8, 12, 20, 28, 15, 17, 24, 7, 19, 27, 23, 6, 26, 5, 4, 31]!
	
	x |= x >> 1
	x |= x >> 2
	x |= x >> 4
	x |= x >> 8
	x |= x >> 16
	return multiplydebruijnbitposition [RmtU32((x * 130329821)) >> 27] 
}

[c:'GaloisLFSRMask']
fn galoislfsrmask(table_size_log2 RmtU32) RmtU32 {
	xormasks := [((1 << 0) | (1 << 1)), ((1 << 1) | (1 << 2)), ((1 << 2) | (1 << 3)), ((1 << 2) | (1 << 4)), ((1 << 4) | (1 << 5)), ((1 << 5) | (1 << 6)), ((1 << 3) | (1 << 4) | (1 << 5) | (1 << 7))]!
	
	(if __builtin_expect(!(table_size_log2 >= 2), 0){ __assert_rtn(c'Remotery.c', 940, c'table_size_log2 >= 2') } else {return error('error message')})
	(if __builtin_expect(!(table_size_log2 <= 8), 0){ __assert_rtn(c'Remotery.c', 941, c'table_size_log2 <= 8') } else {return error('error message')})
	return xormasks [table_size_log2 - 2] 
}

[c:'GaloisLFSRNext']
fn galoislfsrnext(value RmtU32, xor_mask RmtU32) RmtU32 {
	lsb := value & 1
	value >>= 1
	if lsb != 0 {
		value ^= xor_mask
	}
	return value
}

struct VirtualMirrorBuffer { 
	size RmtU32
	ptr &RmtU8
}
[c:'VirtualMirrorBuffer_Constructor']
fn virtualmirrorbuffer_constructor(buffer &VirtualMirrorBuffer, size RmtU32, nb_attempts int) RmtError {
	k_64 := 64 * 1024
	if nb_attempts > 0 {
  return error('error message')
}
	
	size = (size + k_64 - 1) / k_64 * k_64
	buffer.size = size
	buffer.ptr = (voidptr(0))
	for nb_attempts -- > 0 {
		cur_prot := Vm_prot_t{}
		max_prot := Vm_prot_t{}
		
		mach_error := Kern_return_t{}
		ptr := (voidptr(0))
		target := (voidptr(0))
		if vm_allocate(mach_task_self_, &Vm_address_t(&ptr), size * 2, 1) != 0 {
		break
		
		}
		target = ptr + size
		if vm_deallocate(mach_task_self_, Vm_address_t(target), size) != 0 {
			vm_deallocate(mach_task_self_, Vm_address_t(ptr), size * 2)
			break
			
		}
		mach_error = vm_remap(mach_task_self_, &Vm_address_t(&target), size, 0, 0, mach_task_self_, Vm_address_t(ptr), 0, &cur_prot, &max_prot, (Vm_inherit_t(1)))
		if mach_error == 3 {
			if vm_deallocate(mach_task_self_, Vm_address_t(ptr), size) != 0 {
			break
			
			}
		}
		else if mach_error == 0 {
			buffer.ptr = ptr
			break
			
		}
		else {
			vm_deallocate(mach_task_self_, Vm_address_t(ptr), size)
			break
			
		}
	}
	if buffer.ptr == (voidptr(0)) {
	return RmtError.rmt_error_virtual_memory_buffer_fail
	}
	return RmtError.rmt_error_none
}

[c:'VirtualMirrorBuffer_Destructor']
fn virtualmirrorbuffer_destructor(buffer &VirtualMirrorBuffer)  {
	(if __builtin_expect(!(buffer != 0), 0){ __assert_rtn(c'Remotery.c', 1438, c'buffer != 0') } else {return error('error message')})
	if buffer.ptr != (voidptr(0)) {
	vm_deallocate(mach_task_self_, Vm_address_t(buffer.ptr), buffer.size * 2)
	}
	buffer.ptr = (voidptr(0))
}

type Errno_t = int
type R_size_t = u32
fn strstr_s(dest &i8, dmax R_size_t, src &i8, slen R_size_t, substring &&u8) Errno_t {
	len := R_size_t{}
	dlen := R_size_t{}
	i := 0
	if substring == (voidptr(0)) {
		return (400)
	}
	*substring = (voidptr(0))
	if dest == (voidptr(0)) {
		return (400)
	}
	if dmax == 0 {
		return (401)
	}
	if dmax > (4 << 10) {
		return (403)
	}
	if src == (voidptr(0)) {
		return (400)
	}
	if slen == 0 {
		return (401)
	}
	if slen > (4 << 10) {
		return (403)
	}
	if *src == ` ` || dest == src {
		*substring = dest
		return (0)
	}
	for *dest && dmax {
		i = 0
		len = slen
		dlen = dmax
		for src [i]  && dlen {
			if dest [i]  != src [i]  {
				break
				
			}
			i ++
			len --
			dlen --
			if src [i]  == ` ` || !len {
				*substring = dest
				return (0)
			}
		}
		dest ++
		dmax --
	}
	*substring = (voidptr(0))
	return (409)
}

[export:'hex_encoding_table']
const (
hex_encoding_table   = c'0123456789ABCDEF'
)

fn itoahex_s(dest &i8, dmax R_size_t, value RmtS32)  {
	len := R_size_t{}
	halfbytepos := RmtS32{}
	halfbytepos = 8
	for halfbytepos > 1 {
		halfbytepos --$
		if value >> (4 * halfbytepos) & 15 {
			halfbytepos ++$
			break
			
		}
	}
	len = 0
	for len + 1 < dmax && halfbytepos > 0 {
		halfbytepos --$
		dest [len]  = hex_encoding_table [value >> (4 * halfbytepos) & 15] 
		len ++$
	}
	if len < dmax {
		dest [len]  = 0
	}
}

fn itoa_s(value RmtS32) &i8 {
	temp_dest := [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]!
	
	pos := 10
	abs_value := C.abs(value)
	for abs_value > 0 {
		temp_dest [pos --]  = `0` + (abs_value % 10)
		abs_value /= 10
	}
	if value < 0 {
		temp_dest [pos --]  = `-`
	}
	return temp_dest + pos + 1
}

type RmtThreadId = Uintptr_t
type RmtThreadHandle = Pthread_t
type RmtCpuContext = int
[c:'rmtGetNbProcessors']
fn rmtgetnbprocessors() RmtU32 {
	return 0
}

[c:'rmtGetCurrentThreadId']
fn rmtgetcurrentthreadid() RmtThreadId {
	return RmtThreadId(pthread_self())
}

[c:'rmtSuspendThread']
fn rmtsuspendthread(thread_handle RmtThreadHandle) RmtBool {
	return (RmtBool(0))
}

[c:'rmtResumeThread']
fn rmtresumethread(thread_handle RmtThreadHandle)  {
}

[c:'rmtGetUserModeThreadContext']
fn rmtgetusermodethreadcontext(thread RmtThreadHandle, context &RmtCpuContext) RmtBool {
	return (RmtBool(0))
}

[c:'rmtSetThreadContext']
fn rmtsetthreadcontext(thread_handle RmtThreadHandle, context &RmtCpuContext)  {
}

[c:'rmtOpenThreadHandle']
fn rmtopenthreadhandle(thread_id RmtThreadId, out_thread_handle &RmtThreadHandle) RmtError {
	return RmtError.rmt_error_none
}

[c:'rmtCloseThreadHandle']
fn rmtclosethreadhandle(thread_handle RmtThreadHandle)  {
}

[c:'rmtGetThreadNameFallback']
fn rmtgetthreadnamefallback(out_thread_name &i8, thread_name_size RmtU32) 

[c:'rmtGetThreadName']
fn rmtgetthreadname(thread_id RmtThreadId, thread_handle RmtThreadHandle, out_thread_name &i8, thread_name_size RmtU32)  {
	rmtgetthreadnamefallback(out_thread_name, thread_name_size)
}

type RmtThread = Thread_t
type ThreadProc = fn (&RmtThread) RmtError
struct Thread_t { 
	handle RmtThreadHandle
	callback ThreadProc
	param voidptr
	error RmtError
	request_exit RmtAtomicBool
}
[c:'StartFunc']
fn startfunc(pargs voidptr) voidptr {
	thread := &RmtThread(pargs)
	(if __builtin_expect(!(thread != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2236, c'thread != NULL') } else {return error('error message')})
	thread.error = thread.callback(thread)
	return (voidptr(0))
}

[c:'rmtThread_Valid']
fn rmtthread_valid(thread &RmtThread) int {
	(if __builtin_expect(!(thread != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2244, c'thread != NULL') } else {return error('error message')})
	return !pthread_equal(thread.handle, pthread_self())
}

[c:'rmtThread_Constructor']
fn rmtthread_constructor(thread &RmtThread, callback ThreadProc, param voidptr) RmtError {
	(if __builtin_expect(!(thread != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2255, c'thread != NULL') } else {return error('error message')})
	thread.callback = callback
	thread.param = param
	thread.error = RmtError.rmt_error_none
	thread.request_exit = (RmtBool(0))
	error := pthread_create(&thread.handle, (voidptr(0)), startfunc, thread)
	if error {
		thread.handle = pthread_self()
		return RmtError.rmt_error_create_thread_fail
	}
	return RmtError.rmt_error_none
}

[c:'rmtThread_RequestExit']
fn rmtthread_requestexit(thread &RmtThread)  {
	(if __builtin_expect(!(thread != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2295, c'thread != NULL') } else {return error('error message')})
	thread.request_exit = (RmtBool(1))
}

[c:'rmtThread_Join']
fn rmtthread_join(thread &RmtThread)  {
	(if __builtin_expect(!(rmtthread_valid(thread)), 0){ __assert_rtn(c'Remotery.c', 2301, c'rmtThread_Valid(thread)') } else {return error('error message')})
	pthread_join(thread.handle, (voidptr(0)))
}

[c:'rmtThread_Destructor']
fn rmtthread_destructor(thread &RmtThread)  {
	(if __builtin_expect(!(thread != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2312, c'thread != NULL') } else {return error('error message')})
	if rmtthread_valid(thread) {
		rmtthread_requestexit(thread)
		rmtthread_join(thread)
	}
}

struct ObjectLink { 
	volatile next &ObjectLink_s
}
type RmtAtomicObjectLinkPtr = Atomic(&ObjectLink)
[c:'ObjectLink_Constructor']
fn objectlink_constructor(link &ObjectLink)  {
	(if __builtin_expect(!(link != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2349, c'link != NULL') } else {return error('error message')})
	link.next = (voidptr(0))
}

type ObjConstructor = fn (voidptr) RmtError
type ObjDestructor = fn (voidptr)
struct ObjectAllocator { 
	object_size RmtU32
	constructor ObjConstructor
	destructor ObjDestructor
	nb_free RmtAtomicS32
	nb_inuse RmtAtomicS32
	nb_allocated RmtAtomicS32
	first_free RmtAtomicObjectLinkPtr
}
[c:'ObjectAllocator_Constructor']
fn objectallocator_constructor(allocator &ObjectAllocator, object_size RmtU32, constructor ObjConstructor, destructor ObjDestructor) RmtError {
	allocator.object_size = object_size
	allocator.constructor = constructor
	allocator.destructor = destructor
	allocator.nb_free = 0
	allocator.nb_inuse = 0
	allocator.nb_allocated = 0
	allocator.first_free = &ObjectLink(0)
	return RmtError.rmt_error_none
}

[c:'ObjectAllocator_Destructor']
fn objectallocator_destructor(allocator &ObjectAllocator)  {
	(if __builtin_expect(!(allocator != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2391, c'allocator != NULL') } else {return error('error message')})
	(if __builtin_expect(!(allocator.nb_inuse == 0), 0){ __assert_rtn(c'Remotery.c', 2392, c'allocator->nb_inuse == 0') } else {return error('error message')})
	for allocator.first_free != (voidptr(0)) {
		next := (&ObjectLink(allocator.first_free)).next
		(if __builtin_expect(!(allocator.destructor != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2398, c'allocator->destructor != NULL') } else {return error('error message')})
		allocator.destructor(voidptr(allocator.first_free))
		rmtfree(voidptr(allocator.first_free))
		allocator.first_free = next
	}
}

[c:'ObjectAllocator_Push']
fn objectallocator_push(allocator &ObjectAllocator, start &ObjectLink, end &ObjectLink)  {
	(if __builtin_expect(!(allocator != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2407, c'allocator != NULL') } else {return error('error message')})
	(if __builtin_expect(!(start != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2408, c'start != NULL') } else {return error('error message')})
	(if __builtin_expect(!(end != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2409, c'end != NULL') } else {return error('error message')})
	for  ;  ;  {
		old_link := &ObjectLink(allocator.first_free)
		end.next = old_link
		if atomiccompareandswappointer(&RmtAtomicVoidPtr(&allocator.first_free), voidptr(old_link), voidptr(start)) == (RmtBool(1)) {
		break
		
		}
	}
}

[c:'ObjectAllocator_Pop']
fn objectallocator_pop(allocator &ObjectAllocator) &ObjectLink {
	link := &ObjectLink(0)
	(if __builtin_expect(!(allocator != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2426, c'allocator != NULL') } else {return error('error message')})
	for  ;  ;  {
		old_link := &ObjectLink(allocator.first_free)
		if old_link == (voidptr(0)) {
			return (voidptr(0))
		}
		next_link := old_link.next
		if atomiccompareandswappointer(&RmtAtomicVoidPtr(&allocator.first_free), voidptr(old_link), voidptr(next_link)) == (RmtBool(1)) {
			link = &ObjectLink(old_link)
			break
			
		}
	}
	link.next = (voidptr(0))
	return link
}

[c:'ObjectAllocator_Alloc']
fn objectallocator_alloc(allocator &ObjectAllocator, object &voidptr) RmtError {
	(if __builtin_expect(!(allocator != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2454, c'allocator != NULL') } else {return error('error message')})
	(if __builtin_expect(!(object != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2455, c'object != NULL') } else {return error('error message')})
	*object = objectallocator_pop(allocator)
	if *object == (voidptr(0)) {
		error := RmtError{}
		*object = rmtmalloc(allocator.object_size)
		if *object == (voidptr(0)) {
		return RmtError.rmt_error_malloc_fail
		}
		(if __builtin_expect(!(allocator.constructor != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2469, c'allocator->constructor != NULL') } else {return error('error message')})
		error = allocator.constructor(*object)
		if error != RmtError.rmt_error_none {
			(if __builtin_expect(!(allocator.destructor != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2474, c'allocator->destructor != NULL') } else {return error('error message')})
			allocator.destructor(*object)
			rmtfree(*object)
			return error
		}
		atomicadds32(&allocator.nb_allocated, 1)
	}
	else {
		atomicsubs32(&allocator.nb_free, 1)
	}
	atomicadds32(&allocator.nb_inuse, 1)
	return RmtError.rmt_error_none
}

[c:'ObjectAllocator_Free']
fn objectallocator_free(allocator &ObjectAllocator, object voidptr)  {
	(if __builtin_expect(!(allocator != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2495, c'allocator != NULL') } else {return error('error message')})
	objectallocator_push(allocator, &ObjectLink(object), &ObjectLink(object))
	atomicsubs32(&allocator.nb_inuse, 1)
	atomicadds32(&allocator.nb_free, 1)
}

[c:'ObjectAllocator_FreeRange']
fn objectallocator_freerange(allocator &ObjectAllocator, start voidptr, end voidptr, count RmtU32)  {
	(if __builtin_expect(!(allocator != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2503, c'allocator != NULL') } else {return error('error message')})
	objectallocator_push(allocator, &ObjectLink(start), &ObjectLink(end))
	atomicsubs32(&allocator.nb_inuse, count)
	atomicadds32(&allocator.nb_free, count)
}

struct Buffer { 
	alloc_granularity RmtU32
	bytes_allocated RmtU32
	bytes_used RmtU32
	data &RmtU8
}
[c:'Buffer_Constructor']
fn buffer_constructor(buffer &Buffer, alloc_granularity RmtU32) RmtError {
	(if __builtin_expect(!(buffer != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2529, c'buffer != NULL') } else {return error('error message')})
	buffer.alloc_granularity = alloc_granularity
	buffer.bytes_allocated = 0
	buffer.bytes_used = 0
	buffer.data = (voidptr(0))
	return RmtError.rmt_error_none
}

[c:'Buffer_Destructor']
fn buffer_destructor(buffer &Buffer)  {
	(if __builtin_expect(!(buffer != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2539, c'buffer != NULL') } else {return error('error message')})
	if buffer.data != (voidptr(0)) {
		rmtfree(buffer.data)
		buffer.data = (voidptr(0))
	}
}

[c:'Buffer_Grow']
fn buffer_grow(buffer &Buffer, length RmtU32) RmtError {
	granularity := buffer.alloc_granularity
	allocate := buffer.bytes_allocated + length
	allocate = allocate + ((granularity - 1) - ((allocate - 1) % granularity))
	buffer.bytes_allocated = allocate
	buffer.data = &RmtU8(rmtrealloc(buffer.data, buffer.bytes_allocated))
	if buffer.data == (voidptr(0)) {
	return RmtError.rmt_error_malloc_fail
	}
	return RmtError.rmt_error_none
}

[c:'Buffer_Pad']
fn buffer_pad(buffer &Buffer, length RmtU32) RmtError {
	(if __builtin_expect(!(buffer != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2565, c'buffer != NULL') } else {return error('error message')})
	if buffer.bytes_used + length > buffer.bytes_allocated {
		{
			error := buffer_grow(buffer, length)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
	}
	buffer.bytes_used += length
	return RmtError.rmt_error_none
}

[c:'Buffer_AlignedPad']
fn buffer_alignedpad(buffer &Buffer, start_pos RmtU32) RmtError {
	return buffer_pad(buffer, (4 - ((buffer.bytes_used - start_pos) & 3)) & 3)
}

[c:'Buffer_Write']
fn buffer_write(buffer &Buffer, data voidptr, length RmtU32) RmtError {
	(if __builtin_expect(!(buffer != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2586, c'buffer != NULL') } else {return error('error message')})
	if buffer.bytes_used + length > buffer.bytes_allocated {
		{
			error := buffer_grow(buffer, length)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
	}
	C.memcpy(buffer.data + buffer.bytes_used, data, length)
	buffer.bytes_used += length
	return RmtError.rmt_error_none
}

[c:'Buffer_WriteStringZ']
fn buffer_writestringz(buffer &Buffer, string_ RmtPStr) RmtError {
	(if __builtin_expect(!(string_ != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2603, c'string != NULL') } else {return error('error message')})
	return buffer_write(buffer, voidptr(string_), RmtU32(strnlen_s_safe_c(string_, 2048)) + 1)
}

[c:'U32ToByteArray']
fn u32tobytearray(dest &RmtU8, value RmtU32)  {
	dest [0]  = value & 255
	dest [1]  = (value >> 8) & 255
	dest [2]  = (value >> 16) & 255
	dest [3]  = value >> 24
}

[c:'Buffer_WriteBool']
fn buffer_writebool(buffer &Buffer, value RmtBool) RmtError {
	return buffer_write(buffer, &value, 1)
}

[c:'Buffer_WriteU32']
fn buffer_writeu32(buffer &Buffer, value RmtU32) RmtError {
	(if __builtin_expect(!(buffer != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2623, c'buffer != NULL') } else {return error('error message')})
	if buffer.bytes_used + sizeof(value) > buffer.bytes_allocated {
		{
			error := buffer_grow(buffer, sizeof(value))
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
	}
	u32tobytearray(buffer.data + buffer.bytes_used, value)
	buffer.bytes_used += sizeof(value)
	return RmtError.rmt_error_none
}

[c:'IsLittleEndian']
fn islittleendian() RmtBool {
	
	u.i = 1
	return if u.c [0]  == 1{ (RmtBool(1)) } else {(RmtBool(0))}
}

[c:'Buffer_WriteF64']
fn buffer_writef64(buffer &Buffer, value RmtF64) RmtError {
	(if __builtin_expect(!(buffer != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2657, c'buffer != NULL') } else {return error('error message')})
	if buffer.bytes_used + sizeof(value) > buffer.bytes_allocated {
		{
			error := buffer_grow(buffer, sizeof(value))
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
	}
	{
		
		dest := buffer.data + buffer.bytes_used
		u.d = value
		if islittleendian() {
			dest [0]  = u.c [0] 
			dest [1]  = u.c [1] 
			dest [2]  = u.c [2] 
			dest [3]  = u.c [3] 
			dest [4]  = u.c [4] 
			dest [5]  = u.c [5] 
			dest [6]  = u.c [6] 
			dest [7]  = u.c [7] 
		}
		else {
			dest [0]  = u.c [7] 
			dest [1]  = u.c [6] 
			dest [2]  = u.c [5] 
			dest [3]  = u.c [4] 
			dest [4]  = u.c [3] 
			dest [5]  = u.c [2] 
			dest [6]  = u.c [1] 
			dest [7]  = u.c [0] 
		}
	}
	buffer.bytes_used += sizeof(value)
	return RmtError.rmt_error_none
}

[c:'Buffer_WriteU64']
fn buffer_writeu64(buffer &Buffer, value RmtU64) RmtError {
	return buffer_writef64(buffer, f64(value))
}

[c:'Buffer_WriteStringWithLength']
fn buffer_writestringwithlength(buffer &Buffer, string_ RmtPStr) RmtError {
	length := RmtU32(strnlen_s_safe_c(string_, 2048))
	{
		error := buffer_writeu32(buffer, length)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return buffer_write(buffer, voidptr(string_), length)
}

struct HashSlot { 
	key RmtU32
	value RmtU64
}
struct RmtHashTable { 
	maxNbSlots RmtU32
	nbSlots RmtU32
	slots &HashSlot
}
[c:'rmtHashTable_Constructor']
fn rmthashtable_constructor(table &RmtHashTable, max_nb_slots RmtU32) RmtError {
	(if __builtin_expect(!(table != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2751, c'table != NULL') } else {return error('error message')})
	table.maxNbSlots = max_nb_slots
	table.nbSlots = 0
	table.slots = &HashSlot(rmtmalloc((table.maxNbSlots) * sizeof(HashSlot)))
	if table.slots == (voidptr(0)) {
		return RmtError.rmt_error_malloc_fail
	}
	0 /* null */
	C.memset(table.slots, 0, table.maxNbSlots * sizeof(HashSlot))
	return RmtError.rmt_error_none
}

[c:'rmtHashTable_Destructor']
fn rmthashtable_destructor(table &RmtHashTable)  {
	(if __builtin_expect(!(table != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2764, c'table != NULL') } else {return error('error message')})
	if table.slots != (voidptr(0)) {
		rmtfree(table.slots)
		table.slots = (voidptr(0))
	}
}

[c:'rmtHashTable_Resize']
fn rmthashtable_resize(table &RmtHashTable) RmtError

[c:'rmtHashTable_Insert']
fn rmthashtable_insert(table &RmtHashTable, key RmtU32, value RmtU64) RmtError {
	slot := (voidptr(0))
	error := RmtError.rmt_error_none
	index_mask := table.maxNbSlots - 1
	index := key & index_mask
	(if __builtin_expect(!(key != 0), 0){ __assert_rtn(c'Remotery.c', 2784, c'key != 0') } else {return error('error message')})
	(if __builtin_expect(!(value != 18446744073709551615), 0){ __assert_rtn(c'Remotery.c', 2785, c'value != RMT_NOT_FOUND') } else {return error('error message')})
	for table.slots [index] .key {
		if table.slots [index] .key == key {
			table.nbSlots --
			break
			
		}
		index = (index + 1) & index_mask
	}
	(if __builtin_expect(!(index < table.maxNbSlots), 0){ __assert_rtn(c'Remotery.c', 2802, c'index < table->maxNbSlots') } else {return error('error message')})
	slot = table.slots + index
	slot.key = key
	slot.value = value
	table.nbSlots ++
	if table.nbSlots > (table.maxNbSlots * 2) / 3 {
		error = rmthashtable_resize(table)
	}
	return error
}

[c:'rmtHashTable_Resize']
fn rmthashtable_resize(table &RmtHashTable) RmtError {
	old_max_nb_slots := table.maxNbSlots
	new_slots := (voidptr(0))
	old_slots := table.slots
	i := RmtU32{}
	new_max_nb_slots := table.maxNbSlots
	if new_max_nb_slots < 8192 * 4 {
		new_max_nb_slots *= 4
	}
	else {
		new_max_nb_slots *= 2
	}
	new_slots = &HashSlot(rmtmalloc((new_max_nb_slots) * sizeof(HashSlot)))
	if new_slots == (voidptr(0)) {
		return RmtError.rmt_error_malloc_fail
	}
	0 /* null */
	C.memset(new_slots, 0, new_max_nb_slots * sizeof(HashSlot))
	table.slots = new_slots
	table.maxNbSlots = new_max_nb_slots
	table.nbSlots = 0
	for i = 0 ; i < old_max_nb_slots ; i ++ {
		slot := old_slots + i
		if slot.key != 0 {
			rmthashtable_insert(table, slot.key, slot.value)
		}
	}
	rmtfree(old_slots)
	return RmtError.rmt_error_none
}

[c:'rmtHashTable_Find']
fn rmthashtable_find(table &RmtHashTable, key RmtU32) RmtU64 {
	index_mask := table.maxNbSlots - 1
	index := key & index_mask
	for table.slots [index] .key {
		slot := table.slots + index
		if slot.key == key {
			return slot.value
		}
		index = (index + 1) & index_mask
	}
	return 18446744073709551615
}

struct StringTable { 
	text &Buffer
	text_map &RmtHashTable
}
[c:'StringTable_Constructor']
fn stringtable_constructor(table &StringTable) RmtError {
	(if __builtin_expect(!(table != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2903, c'table != NULL') } else {return error('error message')})
	table.text = (voidptr(0))
	table.text_map = (voidptr(0))
	{
		table.text = &Buffer(rmtmalloc(sizeof(Buffer)))
		if table.text == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := buffer_constructor(table.text, 8 * 1024)
		if error != RmtError.rmt_error_none {
			if table.text != (voidptr(0)) {
				buffer_destructor(table.text)
				rmtfree(table.text)
				table.text = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	{
		table.text_map = &RmtHashTable(rmtmalloc(sizeof(RmtHashTable)))
		if table.text_map == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := rmthashtable_constructor(table.text_map, 1 * 1024)
		if error != RmtError.rmt_error_none {
			if table.text_map != (voidptr(0)) {
				rmthashtable_destructor(table.text_map)
				rmtfree(table.text_map)
				table.text_map = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'StringTable_Destructor']
fn stringtable_destructor(table &StringTable)  {
	(if __builtin_expect(!(table != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 2916, c'table != NULL') } else {return error('error message')})
	if table.text_map != (voidptr(0)) {
		rmthashtable_destructor(table.text_map)
		rmtfree(table.text_map)
		table.text_map = (voidptr(0))
	}
	0 /* null */
	if table.text != (voidptr(0)) {
		buffer_destructor(table.text)
		rmtfree(table.text)
		table.text = (voidptr(0))
	}
	0 /* null */
}

[c:'StringTable_Find']
fn stringtable_find(table &StringTable, name_hash RmtU32) RmtPStr {
	text_offset := rmthashtable_find(table.text_map, name_hash)
	if text_offset != 18446744073709551615 {
		return RmtPStr((table.text.data + text_offset))
	}
	return (voidptr(0))
}

[c:'StringTable_Insert']
fn stringtable_insert(table &StringTable, name_hash RmtU32, name RmtPStr) RmtBool {
	text_offset := rmthashtable_find(table.text_map, name_hash)
	if text_offset == 18446744073709551615 {
		text_offset = table.text.bytes_used
		buffer_writestringz(table.text, name)
		rmthashtable_insert(table.text_map, name_hash, text_offset)
		return (RmtBool(1))
	}
	return (RmtBool(0))
}

type SOCKET = int
struct TCPSocket { 
	socket SOCKET
}
struct SocketStatus { 
	can_read RmtBool
	can_write RmtBool
	error_state RmtError
}
[c:'TCPSocket_Close']
fn tcpsocket_close(tcp_socket &TCPSocket) 

[c:'InitialiseNetwork']
fn initialisenetwork() RmtError {
	return RmtError.rmt_error_none
}

[c:'ShutdownNetwork']
fn shutdownnetwork()  {
}

[c:'TCPSocket_Constructor']
fn tcpsocket_constructor(tcp_socket &TCPSocket) RmtError {
	(if __builtin_expect(!(tcp_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3013, c'tcp_socket != NULL') } else {return error('error message')})
	tcp_socket.socket = -1
	return initialisenetwork()
}

[c:'TCPSocket_Destructor']
fn tcpsocket_destructor(tcp_socket &TCPSocket)  {
	(if __builtin_expect(!(tcp_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3020, c'tcp_socket != NULL') } else {return error('error message')})
	tcpsocket_close(tcp_socket)
	shutdownnetwork()
}

[c:'TCPSocket_RunServer']
fn tcpsocket_runserver(tcp_socket &TCPSocket, port RmtU16, reuse_open_port RmtBool, limit_connections_to_localhost RmtBool) RmtError {
	s := -1
	sin := Sockaddr_in{}
	C.memset(&sin, 0, sizeof(sin))
	(if __builtin_expect(!(tcp_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3035, c'tcp_socket != NULL') } else {return error('error message')})
	s = socket(2, 1, 6)
	if s == -1 {
		return rmtmakeerror(RmtError.rmt_error_resource_create_fail, c"Can't create a socket for connection to the remote viewer")
	}
	if reuse_open_port {
		enable := 1
		setsockopt(s, 65535, 4, &enable, sizeof(enable))
	}
	sin.sin_family = 2
	sin.sin_addr.s_addr = (if __builtin_constant_p(if limit_connections_to_localhost{ U_int32_t(2130706433) } else {U_int32_t(0)}){ (u32((((u32((if limit_connections_to_localhost{ U_int32_t(2130706433) } else {U_int32_t(0)})) & 4278190080) >> 24) | ((u32((if limit_connections_to_localhost{ U_int32_t(2130706433) } else {U_int32_t(0)})) & 16711680) >> 8) | ((u32((if limit_connections_to_localhost{ U_int32_t(2130706433) } else {U_int32_t(0)})) & 65280) << 8) | ((u32((if limit_connections_to_localhost{ U_int32_t(2130706433) } else {U_int32_t(0)})) & 255) << 24)))) } else {_osswapint32(if limit_connections_to_localhost{ U_int32_t(2130706433) } else {U_int32_t(0)})})
	sin.sin_port = (uint16_t((if __builtin_constant_p(port){ (uint16_t((((uint16_t((port)) & 65280) >> 8) | ((uint16_t((port)) & 255) << 8)))) } else {_osswapint16(port)})))
	if bind(s, &Sockaddr(&sin), sizeof(sin)) == -1 {
		return rmtmakeerror(RmtError.rmt_error_resource_access_fail, c"Can't bind a socket for the server")
	}
	tcp_socket.socket = s
	if listen(s, 1) == -1 {
		return rmtmakeerror(RmtError.rmt_error_resource_access_fail, c'Created server socket failed to enter a listen state')
	}
	if fcntl(tcp_socket.socket, 4, 4) == -1 {
		return rmtmakeerror(RmtError.rmt_error_resource_access_fail, c'Created server socket failed to switch to a non-blocking state')
	}
	return RmtError.rmt_error_none
}

[c:'TCPSocket_Close']
fn tcpsocket_close(tcp_socket &TCPSocket)  {
	(if __builtin_expect(!(tcp_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3099, c'tcp_socket != NULL') } else {return error('error message')})
	if tcp_socket.socket != -1 {
		result := shutdown(tcp_socket.socket, 1)
		if result != -1 {
			total := 0
			temp_buf := [128]i8{}
			for result > 0 {
				result = int(recv(tcp_socket.socket, temp_buf, sizeof(temp_buf), 0))
				total += result
			}
		}
		C.close(tcp_socket.socket)
		tcp_socket.socket = -1
	}
}

[c:'TCPSocket_PollStatus']
fn tcpsocket_pollstatus(tcp_socket &TCPSocket) SocketStatus {
	status := SocketStatus{}
	fd_read := Fd_set{}
	fd_write := Fd_set{}
	fd_errors := Fd_set{}
	
	tv := Timeval{}
	status.can_read = (RmtBool(0))
	status.can_write = (RmtBool(0))
	status.error_state = RmtError.rmt_error_none
	(if __builtin_expect(!(tcp_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3133, c'tcp_socket != NULL') } else {return error('error message')})
	if tcp_socket.socket == -1 {
		status.error_state = RmtError.rmt_error_socket_invalid_poll
		return status
	}
	__builtin_bzero(&fd_read, sizeof(*(&fd_read)))
	__builtin_bzero(&fd_write, sizeof(*(&fd_write)))
	__builtin_bzero(&fd_errors, sizeof(*(&fd_errors)))
	__darwin_fd_set((tcp_socket.socket), (&fd_read))
	__darwin_fd_set((tcp_socket.socket), (&fd_write))
	__darwin_fd_set((tcp_socket.socket), (&fd_errors))
	tv.tv_sec = 0
	tv.tv_usec = 0
	if select(
		(int(tcp_socket.socket)) + 1 &fd_read &fd_write &fd_errors &tv) == -1 {
    status.error_state = RmtError.rmt_error_socket_select_fail
    return status
}
	status.can_read = if __darwin_fd_isset((tcp_socket.socket), (&fd_read)) != 0{ (RmtBool(1)) } else {(RmtBool(0))}
	status.can_write = if __darwin_fd_isset((tcp_socket.socket), (&fd_write)) != 0{ (RmtBool(1)) } else {(RmtBool(0))}
	status.error_state = if __darwin_fd_isset((tcp_socket.socket), (&fd_errors)) != 0{ RmtError.rmt_error_socket_poll_errors } else {RmtError.rmt_error_none}
	return status
}

[c:'TCPSocket_AcceptConnection']
fn tcpsocket_acceptconnection(tcp_socket &TCPSocket, client_socket &&TCPSocket) RmtError {
	status := SocketStatus{}
	s := SOCKET{}
	(if __builtin_expect(!(tcp_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3176, c'tcp_socket != NULL') } else {return error('error message')})
	status = tcpsocket_pollstatus(tcp_socket)
	if status.error_state != RmtError.rmt_error_none || !status.can_read {
	return status.error_state
	}
	s = accept(tcp_socket.socket, 0, 0)
	if s == -1 {
		return rmtmakeerror(RmtError.rmt_error_resource_create_fail, c'Server failed to accept connection from client')
	}
	{
		flag := 1
		setsockopt(s, 65535, 4130, &flag, sizeof(flag))
	}
	(if __builtin_expect(!(client_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3201, c'client_socket != NULL') } else {return error('error message')})
	{
		*client_socket = &TCPSocket(rmtmalloc(sizeof(TCPSocket)))
		if *client_socket == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := tcpsocket_constructor(*client_socket)
		if error != RmtError.rmt_error_none {
			if *client_socket != (voidptr(0)) {
				tcpsocket_destructor(*client_socket)
				rmtfree(*client_socket)
				*client_socket = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	(*client_socket).socket = s
	return RmtError.rmt_error_none
}

[c:'TCPTryAgain']
fn tcptryagain() int {
	return (*__error()) == 35
}

[c:'TCPSocket_Send']
fn tcpsocket_send(tcp_socket &TCPSocket, data voidptr, length RmtU32, timeout_ms RmtU32) RmtError {
	status := SocketStatus{}
	cur_data := (voidptr(0))
	end_data := (voidptr(0))
	start_ms := 0
	cur_ms := 0
	(if __builtin_expect(!(tcp_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3230, c'tcp_socket != NULL') } else {return error('error message')})
	start_ms = mstimer_get()
	status.can_write = (RmtBool(0))
	for !status.can_write {
		status = tcpsocket_pollstatus(tcp_socket)
		if status.error_state != RmtError.rmt_error_none {
		return status.error_state
		}
		cur_ms = mstimer_get()
		if cur_ms - start_ms > timeout_ms {
			return rmtmakeerror(RmtError.rmt_error_timeout, c'Timed out trying to send data')
		}
	}
	cur_data = &i8(data)
	end_data = cur_data + length
	for cur_data < end_data {
		bytes_sent := 0
		send_flags := 0
		send_flags = 524288
		bytes_sent = int(send(tcp_socket.socket, cur_data, int((end_data - cur_data)), send_flags))
		if bytes_sent == -1 || bytes_sent == 0 {
			if bytes_sent != 0 && !tcptryagain() {
			return RmtError.rmt_error_socket_send_fail
			}
			cur_ms = mstimer_get()
			if cur_ms < start_ms {
				start_ms = cur_ms
				continue
				
			}
			if cur_ms - start_ms > timeout_ms {
				return rmtmakeerror(RmtError.rmt_error_timeout, c'Timed out trying to send data')
			}
		}
		else {
			cur_data += bytes_sent
		}
	}
	return RmtError.rmt_error_none
}

[c:'TCPSocket_Receive']
fn tcpsocket_receive(tcp_socket &TCPSocket, data voidptr, length RmtU32, timeout_ms RmtU32) RmtError {
	status := SocketStatus{}
	cur_data := (voidptr(0))
	end_data := (voidptr(0))
	start_ms := 0
	cur_ms := 0
	(if __builtin_expect(!(tcp_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3312, c'tcp_socket != NULL') } else {return error('error message')})
	status = tcpsocket_pollstatus(tcp_socket)
	if status.error_state != RmtError.rmt_error_none {
	return status.error_state
	}
	if !status.can_read {
	return RmtError.rmt_error_socket_recv_no_data
	}
	cur_data = &i8(data)
	end_data = cur_data + length
	start_ms = mstimer_get()
	for cur_data < end_data {
		bytes_received := int(recv(tcp_socket.socket, cur_data, int((end_data - cur_data)), 0))
		if bytes_received == -1 || bytes_received == 0 {
			if bytes_received != 0 && !tcptryagain() {
			return RmtError.rmt_error_socket_recv_failed
			}
			cur_ms = mstimer_get()
			if cur_ms < start_ms {
				start_ms = cur_ms
				continue
				
			}
			if cur_ms - start_ms > timeout_ms {
				return RmtError.rmt_error_socket_recv_timeout
			}
		}
		else {
			cur_data += bytes_received
		}
	}
	return RmtError.rmt_error_none
}

struct SHA1 { 
	data [20]RmtU8
}
fn rol(value u32, steps u32) u32 {
	return ((value << steps) | (value >> (32 - steps)))
}

[c:'clearWBuffert']
fn clearwbuffert(buffert &u32)  {
	pos := 0
	for pos = 16 ; pos -- >= 0 ;  {
		buffert [pos]  = 0
	}
}

[c:'innerHash']
fn innerhash(result &u32, w &u32)  {
	a := result [0] 
	b := result [1] 
	c := result [2] 
	d := result [3] 
	e := result [4] 
	round := 0
	for round < 16 {
		{
			t := rol(a, 5) + ((b & c) | (~b & d)) + e + 1518500249 + w [round] 
			e = d
			d = c
			c = rol(b, 30)
			b = a
			a = t
		}
		0 /* null */
		round ++$
	}
	for round < 20 {
		w [round]  = rol((w [round - 3]  ^ w [round - 8]  ^ w [round - 14]  ^ w [round - 16] ), 1)
		{
			t := rol(a, 5) + ((b & c) | (~b & d)) + e + 1518500249 + w [round] 
			e = d
			d = c
			c = rol(b, 30)
			b = a
			a = t
		}
		0 /* null */
		round ++$
	}
	for round < 40 {
		w [round]  = rol((w [round - 3]  ^ w [round - 8]  ^ w [round - 14]  ^ w [round - 16] ), 1)
		{
			t := rol(a, 5) + (b ^ c ^ d) + e + 1859775393 + w [round] 
			e = d
			d = c
			c = rol(b, 30)
			b = a
			a = t
		}
		0 /* null */
		round ++$
	}
	for round < 60 {
		w [round]  = rol((w [round - 3]  ^ w [round - 8]  ^ w [round - 14]  ^ w [round - 16] ), 1)
		{
			t := rol(a, 5) + ((b & c) | (b & d) | (c & d)) + e + 2400959708 + w [round] 
			e = d
			d = c
			c = rol(b, 30)
			b = a
			a = t
		}
		0 /* null */
		round ++$
	}
	for round < 80 {
		w [round]  = rol((w [round - 3]  ^ w [round - 8]  ^ w [round - 14]  ^ w [round - 16] ), 1)
		{
			t := rol(a, 5) + (b ^ c ^ d) + e + 3395469782 + w [round] 
			e = d
			d = c
			c = rol(b, 30)
			b = a
			a = t
		}
		0 /* null */
		round ++$
	}
	result [0]  += a
	result [1]  += b
	result [2]  += c
	result [3]  += d
	result [4]  += e
}

fn calc(src voidptr, bytelength int, hash &u8)  {
	roundpos := 0
	lastblockbytes := 0
	hashbyte := 0
	result := [1732584193, 4023233417, 2562383102, 271733878, 3285377520]!
	
	sarray := &u8(src)
	w := [80]u32{}
	endoffullblocks := bytelength - 64
	endcurrentblock := 0
	currentblock := 0
	for currentblock <= endoffullblocks {
		endcurrentblock = currentblock + 64
		for roundpos = 0 ; currentblock < endcurrentblock ; currentblock += 4 {
			w [roundpos ++]  = u32(sarray [currentblock + 3] ) | ((u32(sarray [currentblock + 2] )) << 8) | ((u32(sarray [currentblock + 1] )) << 16) | ((u32(sarray [currentblock] )) << 24)
		}
		innerhash(result, w)
	}
	endcurrentblock = bytelength - currentblock
	clearwbuffert(w)
	lastblockbytes = 0
	for  ; lastblockbytes < endcurrentblock ; lastblockbytes ++ {
		w [lastblockbytes >> 2]  |= u32(sarray [lastblockbytes + currentblock] ) << ((3 - (lastblockbytes & 3)) << 3)
	}
	w [lastblockbytes >> 2]  |= 128 << ((3 - (lastblockbytes & 3)) << 3)
	if endcurrentblock >= 56 {
		innerhash(result, w)
		clearwbuffert(w)
	}
	w [15]  = bytelength << 3
	innerhash(result, w)
	for hashbyte = 20 ; hashbyte -- >= 0 ;  {
		hash [hashbyte]  = (result [hashbyte >> 2]  >> (((3 - hashbyte) & 3) << 3)) & 255
	}
}

[c:'SHA1_Calculate']
fn sha1_calculate(src voidptr, length u32) SHA1 {
	hash := SHA1{}
	(if __builtin_expect(!(int(length) >= 0), 0){ __assert_rtn(c'Remotery.c', 3558, c'(int)length >= 0') } else {return error('error message')})
	calc(src, length, hash.data)
	return hash
}

[export:'b64_encoding_table']
const (
b64_encoding_table   = c'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
)

[c:'Base64_CalculateEncodedLength']
fn base64_calculateencodedlength(length RmtU32) RmtU32 {
	return 4 * ((length + 2) / 3)
}

[c:'Base64_Encode']
fn base64_encode(in_bytes &RmtU8, length RmtU32, out_bytes &RmtU8)  {
	i := RmtU32{}
	encoded_length := RmtU32{}
	remaining_bytes := RmtU32{}
	optr := out_bytes
	for i = 0 ; i < length ;  {
		c0 := if i < length{ in_bytes [i ++]  } else {0}
		c1 := if i < length{ in_bytes [i ++]  } else {0}
		c2 := if i < length{ in_bytes [i ++]  } else {0}
		triple := (c0 << 16) + (c1 << 8) + c2
		*optr ++ = b64_encoding_table [(triple >> 3 * 6) & 63] 
		*optr ++ = b64_encoding_table [(triple >> 2 * 6) & 63] 
		*optr ++ = b64_encoding_table [(triple >> 1 * 6) & 63] 
		*optr ++ = b64_encoding_table [(triple >> 0 * 6) & 63] 
	}
	encoded_length = base64_calculateencodedlength(length)
	remaining_bytes = (3 - ((length + 2) % 3)) - 1
	for i = 0 ; i < remaining_bytes ; i ++ {
	out_bytes [encoded_length - 1 - i]  = `=`
	}
	out_bytes [encoded_length]  = 0
}

fn rotl32(x RmtU32, r RmtS8) RmtU32 {
	return (x << r) | (x >> (32 - r))
}

fn getblock32(p &RmtU32, i int) RmtU32 {
	result := RmtU32{}
	src := (&RmtU8(p)) + i * int(sizeof(RmtU32))
	C.memcpy(&result, src, sizeof(result))
	return result
}

fn fmix32(h RmtU32) RmtU32 {
	h ^= h >> 16
	h *= 2246822507
	h ^= h >> 13
	h *= 3266489909
	h ^= h >> 16
	return h
}

[c:'MurmurHash3_x86_32']
fn murmurhash3_x86_32(key voidptr, len int, seed RmtU32) RmtU32 {
	data := &RmtU8(key)
	nblocks := len / 4
	h1 := seed
	c1 := 3432918353
	c2 := 461845907
	i := 0
	blocks := &RmtU32((data + nblocks * 4))
	tail := &RmtU8((data + nblocks * 4))
	k1 := 0
	for i = -nblocks ; i ; i ++ {
		k2 := getblock32(blocks, i)
		k2 *= c1
		k2 = rotl32(k2, 15)
		k2 *= c2
		h1 ^= k2
		h1 = rotl32(h1, 13)
		h1 = h1 * 5 + 3864292196
	}
	match len & 3 {
	 3// case comp body kind=CompoundAssignOperator is_enum=false 
	{
	k1 ^= tail [2]  << 16
	}
	 2// case comp body kind=CompoundAssignOperator is_enum=false 
	{
	k1 ^= tail [1]  << 8
	}
	 1// case comp body kind=CompoundAssignOperator is_enum=false 
	{
	k1 ^= tail [0] 
	k1 *= c1
	k1 = rotl32(k1, 15)
	k1 *= c2
	h1 ^= k1
	}
	else{}
	}
	0 /* null */
	h1 ^= len
	h1 = fmix32(h1)
	return h1
}

[c:'_rmt_HashString32']
fn _rmt_hashstring32(s &i8, len int, seed RmtU32) RmtU32 {
	return murmurhash3_x86_32(s, len, seed)
}

enum WebSocketMode {
	websocket_none = 0	websocket_text = 1	websocket_binary = 2}

struct WebSocket { 
	tcp_socket &TCPSocket
	mode WebSocketMode
	frame_bytes_remaining RmtU32
	mask_offset RmtU32
	data Union (unnamed union at Remotery.c
}
[c:'WebSocket_Close']
fn websocket_close(web_socket &WebSocket) 

[c:'GetField']
fn getfield(buffer &i8, buffer_length R_size_t, field_name RmtPStr) &i8 {
	field := (voidptr(0))
	buffer_end := buffer + buffer_length - 1
	field_length := strnlen_s_safe_c(field_name, buffer_length)
	if field_length == 0 {
	return (voidptr(0))
	}
	if strstr_s(buffer, buffer_length, field_name, field_length, &field) != (0) {
	return (voidptr(0))
	}
	field += C.strlen(field_name)
	for *field == ` ` {
		if field >= buffer_end {
		return (voidptr(0))
		}
		field ++
	}
	return field
}

[export:'websocket_guid']
const (
websocket_guid   = c'258EAFA5-E914-47DA-95CA-C5AB0DC85B11'
)

[export:'websocket_response']
const (
websocket_response   = c'HTTP/1.1 101 Switching Protocols\r\nUpgrade: websocket\r\nConnection: Upgrade\r\nSec-WebSocket-Accept: '
)

[c:'WebSocketHandshake']
fn websockethandshake(tcp_socket &TCPSocket, limit_host RmtPStr) RmtError {
	start_ms := RmtU32{}
	now_ms := RmtU32{}
	
	buffer := [1024]i8{}
	buffer_ptr := buffer
	buffer_len := sizeof(buffer) - 1
	buffer_end := buffer + buffer_len
	response_buffer := [256]i8{}
	response_buffer_len := sizeof(response_buffer) - 1
	version := &i8(0)
	host := &i8(0)
	key := &i8(0)
	key_end := &i8(0)
	hash := SHA1{}
	(if __builtin_expect(!(tcp_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3813, c'tcp_socket != NULL') } else {return error('error message')})
	start_ms = mstimer_get()
	for buffer_ptr - buffer < buffer_len {
		error := tcpsocket_receive(tcp_socket, buffer_ptr, 1, 20)
		if error == RmtError.rmt_error_socket_recv_failed {
		return error
		}
		if error == RmtError.rmt_error_socket_recv_no_data || error == RmtError.rmt_error_socket_recv_timeout {
			now_ms = mstimer_get()
			if now_ms - start_ms > 1000 {
			return RmtError.rmt_error_socket_recv_timeout
			}
			continue
			
		}
		(if __builtin_expect(!(error == RmtError.rmt_error_none), 0){ __assert_rtn(c'Remotery.c', 3836, c'error == RMT_ERROR_NONE') } else {return error('error message')})
		if buffer_ptr - buffer >= 4 {
			if *(buffer_ptr - 3) == `
` && *(buffer_ptr - 2) == `
` && *(buffer_ptr - 1) == `
` && *(buffer_ptr - 0) == `
` {
			break
			
			}
		}
		buffer_ptr ++
	}
	*buffer_ptr = 0
	if C.memcmp(buffer, c'GET', 3) != 0 {
	return RmtError.rmt_error_websocket_handshake_not_get
	}
	version = getfield(buffer, buffer_len, c'Sec-WebSocket-Version:')
	if version == (voidptr(0)) {
	return RmtError.rmt_error_websocket_handshake_no_version
	}
	if buffer_end - version < 2 || (version [0]  != `8` && (version [0]  != `1` || version [1]  != `3`)) {
	return RmtError.rmt_error_websocket_handshake_bad_version
	}
	host = getfield(buffer, buffer_len, c'Host:')
	if host == (voidptr(0)) {
	return RmtError.rmt_error_websocket_handshake_no_host
	}
	if limit_host != (voidptr(0)) {
		limit_host_len := strnlen_s_safe_c(limit_host, 128)
		found := (voidptr(0))
		if strstr_s(host, R_size_t((buffer_end - host)), limit_host, limit_host_len, &found) != (0) {
		return RmtError.rmt_error_websocket_handshake_bad_host
		}
	}
	key = getfield(buffer, buffer_len, c'Sec-WebSocket-Key:')
	if key == (voidptr(0)) {
	return RmtError.rmt_error_websocket_handshake_no_key
	}
	if strstr_s(key, R_size_t((buffer_end - key)), c'\r\n', 2, &key_end) != (0) {
	return RmtError.rmt_error_websocket_handshake_bad_key
	}
	*key_end = 0
	buffer [0]  = 0
	if strncat_s_safe_c(buffer, buffer_len, key, R_size_t((key_end - key))) != (0) {
	return RmtError.rmt_error_websocket_handshake_string_fail
	}
	if strncat_s_safe_c(buffer, buffer_len, websocket_guid, sizeof(websocket_guid)) != (0) {
	return RmtError.rmt_error_websocket_handshake_string_fail
	}
	hash = sha1_calculate(buffer, RmtU32(strnlen_s_safe_c(buffer, buffer_len)))
	base64_encode(hash.data, sizeof(hash.data), &RmtU8(buffer))
	response_buffer [0]  = 0
	if strncat_s_safe_c(response_buffer, response_buffer_len, websocket_response, sizeof(websocket_response)) != (0) {
	return RmtError.rmt_error_websocket_handshake_string_fail
	}
	if strncat_s_safe_c(response_buffer, response_buffer_len, buffer, buffer_len) != (0) {
	return RmtError.rmt_error_websocket_handshake_string_fail
	}
	if strncat_s_safe_c(response_buffer, response_buffer_len, c'\r\n\r\n', 4) != (0) {
	return RmtError.rmt_error_websocket_handshake_string_fail
	}
	return tcpsocket_send(tcp_socket, response_buffer, RmtU32(strnlen_s_safe_c(response_buffer, response_buffer_len)), 1000)
}

[c:'WebSocket_Constructor']
fn websocket_constructor(web_socket &WebSocket, tcp_socket &TCPSocket) RmtError {
	(if __builtin_expect(!(web_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3904, c'web_socket != NULL') } else {return error('error message')})
	web_socket.tcp_socket = tcp_socket
	web_socket.mode = WebSocketMode.websocket_none
	web_socket.frame_bytes_remaining = 0
	web_socket.mask_offset = 0
	web_socket.data.mask [0]  = 0
	web_socket.data.mask [1]  = 0
	web_socket.data.mask [2]  = 0
	web_socket.data.mask [3]  = 0
	if web_socket.tcp_socket == (voidptr(0)) {
		web_socket.tcp_socket = &TCPSocket(rmtmalloc(sizeof(TCPSocket)))
		if web_socket.tcp_socket == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := tcpsocket_constructor(web_socket.tcp_socket)
		if error != RmtError.rmt_error_none {
			if web_socket.tcp_socket != (voidptr(0)) {
				tcpsocket_destructor(web_socket.tcp_socket)
				rmtfree(web_socket.tcp_socket)
				web_socket.tcp_socket = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'WebSocket_Destructor']
fn websocket_destructor(web_socket &WebSocket)  {
	websocket_close(web_socket)
}

[c:'WebSocket_RunServer']
fn websocket_runserver(web_socket &WebSocket, port RmtU16, reuse_open_port RmtBool, limit_connections_to_localhost RmtBool, mode WebSocketMode) RmtError {
	(if __builtin_expect(!(web_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3930, c'web_socket != NULL') } else {return error('error message')})
	web_socket.mode = mode
	return tcpsocket_runserver(web_socket.tcp_socket, port, reuse_open_port, limit_connections_to_localhost)
}

[c:'WebSocket_Close']
fn websocket_close(web_socket &WebSocket)  {
	(if __builtin_expect(!(web_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3937, c'web_socket != NULL') } else {return error('error message')})
	if web_socket.tcp_socket != (voidptr(0)) {
		tcpsocket_destructor(web_socket.tcp_socket)
		rmtfree(web_socket.tcp_socket)
		web_socket.tcp_socket = (voidptr(0))
	}
	0 /* null */
}

[c:'WebSocket_PollStatus']
fn websocket_pollstatus(web_socket &WebSocket) SocketStatus {
	(if __builtin_expect(!(web_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3943, c'web_socket != NULL') } else {return error('error message')})
	return tcpsocket_pollstatus(web_socket.tcp_socket)
}

[c:'WebSocket_AcceptConnection']
fn websocket_acceptconnection(web_socket &WebSocket, client_socket &&WebSocket) RmtError {
	tcp_socket := (voidptr(0))
	(if __builtin_expect(!(web_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3952, c'web_socket != NULL') } else {return error('error message')})
	{
		error := tcpsocket_acceptconnection(web_socket.tcp_socket, &tcp_socket)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	if tcp_socket == (voidptr(0)) {
	return RmtError.rmt_error_none
	}
	{
		error := websockethandshake(tcp_socket, (voidptr(0)))
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	(if __builtin_expect(!(client_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3962, c'client_socket != NULL') } else {return error('error message')})
	{
		*client_socket = &WebSocket(rmtmalloc(sizeof(WebSocket)))
		if *client_socket == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := websocket_constructor(*client_socket, tcp_socket)
		if error != RmtError.rmt_error_none {
			if *client_socket != (voidptr(0)) {
				websocket_destructor(*client_socket)
				rmtfree(*client_socket)
				*client_socket = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	(*client_socket).mode = web_socket.mode
	return RmtError.rmt_error_none
}

[c:'WriteSize']
fn writesize(size RmtU32, dest &RmtU8, dest_size RmtU32, dest_offset RmtU32)  {
	size_size := dest_size - dest_offset
	i := RmtU32{}
	for i = 0 ; i < dest_size ; i ++ {
		j := i - dest_offset
		dest [i]  = if (j < 0){ 0 } else {(size >> ((size_size - j - 1) * 8)) & 255}
	}
}

[c:'WebSocket_PrepareBuffer']
fn websocket_preparebuffer(buffer &Buffer)  {
	empty_frame_header := [10]i8{}
	(if __builtin_expect(!(buffer != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 3988, c'buffer != NULL') } else {return error('error message')})
	buffer.bytes_used = 0
	buffer_write(buffer, empty_frame_header, sizeof(empty_frame_header))
}

[c:'WebSocket_FrameHeaderSize']
fn websocket_frameheadersize(length RmtU32) RmtU32 {
	if length <= 125 {
	return 2
	}
	if length <= 65535 {
	return 4
	}
	return 10
}

[c:'WebSocket_WriteFrameHeader']
fn websocket_writeframeheader(web_socket &WebSocket, dest &RmtU8, length RmtU32)  {
	final_fragment := 1 << 7
	frame_type := RmtU8(web_socket.mode)
	dest [0]  = final_fragment | frame_type
	if length <= 125 {
		dest [1]  = RmtU8(length)
	}
	else if length <= 65535 {
		dest [1]  = 126
		writesize(length, dest + 2, 2, 0)
	}
	else {
		dest [1]  = 127
		writesize(length, dest + 2, 8, 4)
	}
}

[c:'WebSocket_Send']
fn websocket_send(web_socket &WebSocket, data voidptr, length RmtU32, timeout_ms RmtU32) RmtError {
	error := RmtError{}
	status := SocketStatus{}
	payload_length := RmtU32{}
	frame_header_size := RmtU32{}
	delta := RmtU32{}
	
	(if __builtin_expect(!(web_socket != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 4036, c'web_socket != NULL') } else {return error('error message')})
	(if __builtin_expect(!(data != (voidptr(0))), 0){ __assert_rtn(c'Remotery.c', 4037, c'data != NULL') } else {return error('error message')})
	status = websocket_pollstatus(web_socket)
	if status.error_state != RmtError.rmt_error_none {
	return status.error_state
	}
	payload_length = length - 10
	frame_header_size = websocket_frameheadersize(payload_length)
	delta = 10 - frame_header_size
	data = voidptr((&RmtU8(data) + delta))
	length -= delta
	websocket_writeframeheader(web_socket, &RmtU8(data), payload_length)
	error = tcpsocket_send(web_socket.tcp_socket, data, length, timeout_ms)
	return error
}

[c:'ReceiveFrameHeader']
fn receiveframeheader(web_socket &WebSocket) RmtError {
	msg_header := [0, 0]!
	
	msg_length := 0
	size_bytes_remaining := 0
	i := 0
	
	mask_present := RmtBool{}
	(if __builtin_expect(!(web_socket != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4065, c'web_socket != NULL') } else {return error('error message')})
	{
		error := tcpsocket_receive(web_socket.tcp_socket, msg_header, 2, 20)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	if msg_header [0]  == 136 {
	return RmtError.rmt_error_websocket_disconnected
	}
	if msg_header [0]  != 129 && msg_header [0]  != 130 {
	return RmtError.rmt_error_websocket_bad_frame_header
	}
	msg_length = msg_header [1]  & 127
	size_bytes_remaining = 0
	match msg_length {
	 126// case comp body kind=BinaryOperator is_enum=false 
	{
	size_bytes_remaining = 2
	
	}
	 127// case comp body kind=BinaryOperator is_enum=false 
	{
	size_bytes_remaining = 8
	
	}
	else{}
	}
	if size_bytes_remaining > 0 {
		size_bytes := [8]RmtU8{}
		{
			error := tcpsocket_receive(web_socket.tcp_socket, size_bytes, size_bytes_remaining, 20)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		msg_length = 0
		for i = 0 ; i < size_bytes_remaining ; i ++ {
		msg_length |= size_bytes [i]  << ((size_bytes_remaining - 1 - i) * 8)
		}
	}
	mask_present = if (msg_header [1]  & 128) != 0{ (RmtBool(1)) } else {(RmtBool(0))}
	if mask_present {
		{
			error := tcpsocket_receive(web_socket.tcp_socket, web_socket.data.mask, 4, 20)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
	}
	web_socket.frame_bytes_remaining = msg_length
	web_socket.mask_offset = 0
	return RmtError.rmt_error_none
}

[c:'WebSocket_Receive']
fn websocket_receive(web_socket &WebSocket, data voidptr, msg_len &RmtU32, length RmtU32, timeout_ms RmtU32) RmtError {
	status := SocketStatus{}
	cur_data := &i8(0)
	end_data := &i8(0)
	start_ms := RmtU32{}
	now_ms := RmtU32{}
	bytes_to_read := RmtU32{}
	(if __builtin_expect(!(web_socket != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4125, c'web_socket != NULL') } else {return error('error message')})
	status = websocket_pollstatus(web_socket)
	if status.error_state != RmtError.rmt_error_none {
		return status.error_state
	}
	cur_data = &i8(data)
	end_data = cur_data + length
	start_ms = mstimer_get()
	for cur_data < end_data {
		if web_socket.frame_bytes_remaining == 0 {
			{
				error := receiveframeheader(web_socket)
				if error != RmtError.rmt_error_none {
				return error
				}
			}
			0 /* null */
			if msg_len != (voidptr(0)) {
				*msg_len = web_socket.frame_bytes_remaining
			}
		}
		{
			error := RmtError{}
			bytes_to_read = if web_socket.frame_bytes_remaining < length{ web_socket.frame_bytes_remaining } else {length}
			error = tcpsocket_receive(web_socket.tcp_socket, cur_data, bytes_to_read, 20)
			if error == RmtError.rmt_error_socket_recv_failed {
				return error
			}
			if error == RmtError.rmt_error_socket_recv_no_data || error == RmtError.rmt_error_socket_recv_timeout {
				now_ms = mstimer_get()
				if now_ms - start_ms > timeout_ms {
					return RmtError.rmt_error_socket_recv_timeout
				}
				continue
				
			}
		}
		if web_socket.data.mask_u32 != 0 {
			i := RmtU32{}
			for i = 0 ; i < bytes_to_read ; i ++ {
				*(&RmtU8(cur_data) + i) ^= web_socket.data.mask [web_socket.mask_offset & 3] 
				web_socket.mask_offset ++
			}
		}
		cur_data += bytes_to_read
		web_socket.frame_bytes_remaining -= bytes_to_read
	}
	return RmtError.rmt_error_none
}

enum MessageID {
	msgid_notready	msgid_addtostringtable	msgid_logtext	msgid_sampletree	msgid_processorthreads	msgid_none	msgid_propertysnapshot	msgid_force32bits = 4294967295}

struct Message { 
	id MessageID
	payload_size RmtU32
	threadProfiler &ThreadProfiler
	payload [1]RmtU8
}
struct RmtMessageQueue { 
	size RmtU32
	data &VirtualMirrorBuffer
	read_pos RmtAtomicU32
	write_pos RmtAtomicU32
}
[c:'rmtMessageQueue_Constructor']
fn rmtmessagequeue_constructor(queue &RmtMessageQueue, size RmtU32) RmtError {
	(if __builtin_expect(!(queue != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4245, c'queue != NULL') } else {return error('error message')})
	queue.size = 0
	queue.data = (voidptr(0))
	queue.read_pos = 0
	queue.write_pos = 0
	{
		queue.data = &VirtualMirrorBuffer(rmtmalloc(sizeof(VirtualMirrorBuffer)))
		if queue.data == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := virtualmirrorbuffer_constructor(queue.data, size, 10)
		if error != RmtError.rmt_error_none {
			if queue.data != (voidptr(0)) {
				virtualmirrorbuffer_destructor(queue.data)
				rmtfree(queue.data)
				queue.data = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	queue.size = queue.data.size
	C.memset(queue.data.ptr, MessageID.msgid_notready, queue.size)
	return RmtError.rmt_error_none
}

[c:'rmtMessageQueue_Destructor']
fn rmtmessagequeue_destructor(queue &RmtMessageQueue)  {
	(if __builtin_expect(!(queue != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4267, c'queue != NULL') } else {return error('error message')})
	if queue.data != (voidptr(0)) {
		virtualmirrorbuffer_destructor(queue.data)
		rmtfree(queue.data)
		queue.data = (voidptr(0))
	}
	0 /* null */
}

[c:'rmtMessageQueue_SizeForPayload']
fn rmtmessagequeue_sizeforpayload(payload_size RmtU32) RmtU32 {
	size := sizeof(Message) + payload_size
	size = (size + 7) & ~7
	return size
}

[c:'rmtMessageQueue_AllocMessage']
fn rmtmessagequeue_allocmessage(queue &RmtMessageQueue, payload_size RmtU32, thread_profiler &ThreadProfiler) &Message {
	msg := &Message(0)
	write_size := rmtmessagequeue_sizeforpayload(payload_size)
	(if __builtin_expect(!(queue != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4290, c'queue != NULL') } else {return error('error message')})
	for  ;  ;  {
		s := queue.size
		w := loadacquire(&queue.write_pos)
		r := loadacquire(&queue.read_pos)
		if int((w - r)) > (int((s - write_size))) {
		return (voidptr(0))
		}
		msg = &Message((queue.data.ptr + (w & (s - 1))))
		if atomiccompareandswapu32(&queue.write_pos, w, w + write_size) == (RmtBool(1)) {
			msg.payload_size = payload_size
			msg.threadProfiler = thread_profiler
			break
			
		}
	}
	return msg
}

[c:'rmtMessageQueue_CommitMessage']
fn rmtmessagequeue_commitmessage(message &Message, id MessageID)  {
	r := MessageID{}
	(if __builtin_expect(!(message != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4322, c'message != NULL') } else {return error('error message')})
	r = MessageID(loadacquire(&RmtAtomicU32(&message.id)))
	void((if 1{ return error('error message') } else {(void(r))}))
	(if __builtin_expect(!(r == MessageID.msgid_notready), 0){ __assert_rtn(, c'Remotery.c', 4327, c'r == MsgID_NotReady') } else {return error('error message')})
	storerelease(&RmtAtomicU32(&message.id), id)
}

[c:'rmtMessageQueue_PeekNextMessage']
fn rmtmessagequeue_peeknextmessage(queue &RmtMessageQueue) &Message {
	ptr := &Message(0)
	r := RmtU32{}
	w := RmtU32{}
	
	id := MessageID{}
	(if __builtin_expect(!(queue != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4337, c'queue != NULL') } else {return error('error message')})
	w = loadacquire(&queue.write_pos)
	r = queue.read_pos
	if w - r == 0 {
	return (voidptr(0))
	}
	r = r & (queue.size - 1)
	ptr = &Message((queue.data.ptr + r))
	id = MessageID(loadacquire(&RmtAtomicU32(&ptr.id)))
	if id != MessageID.msgid_notready {
	return ptr
	}
	return (voidptr(0))
}

[c:'rmtMessageQueue_ConsumeNextMessage']
fn rmtmessagequeue_consumenextmessage(queue &RmtMessageQueue, message &Message)  {
	message_size := RmtU32{}
	read_pos := RmtU32{}
	
	(if __builtin_expect(!(queue != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4361, c'queue != NULL') } else {return error('error message')})
	(if __builtin_expect(!(message != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4362, c'message != NULL') } else {return error('error message')})
	message_size = rmtmessagequeue_sizeforpayload(message.payload_size)
	C.memset(message, MessageID.msgid_notready, message_size)
	read_pos = queue.read_pos + message_size
	storerelease(&queue.read_pos, read_pos)
}

type Server_ReceiveHandler = fn (voidptr, &i8, RmtU32) RmtError
struct Server { 
	listen_socket &WebSocket
	client_socket &WebSocket
	last_ping_time RmtU32
	port RmtU16
	reuse_open_port RmtBool
	limit_connections_to_localhost RmtBool
	bin_buf &Buffer
	receive_handler Server_ReceiveHandler
	receive_handler_context voidptr
}
[c:'Server_CreateListenSocket']
fn server_createlistensocket(server &Server, port RmtU16, reuse_open_port RmtBool, limit_connections_to_localhost RmtBool) RmtError {
	{
		server.listen_socket = &WebSocket(rmtmalloc(sizeof(WebSocket)))
		if server.listen_socket == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := websocket_constructor(server.listen_socket, (voidptr(0)))
		if error != RmtError.rmt_error_none {
			if server.listen_socket != (voidptr(0)) {
				websocket_destructor(server.listen_socket)
				rmtfree(server.listen_socket)
				server.listen_socket = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	{
		error := websocket_runserver(server.listen_socket, port, reuse_open_port, limit_connections_to_localhost, WebSocketMode.websocket_binary)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'Server_Constructor']
fn server_constructor(server &Server, port RmtU16, reuse_open_port RmtBool, limit_connections_to_localhost RmtBool) RmtError {
	(if __builtin_expect(!(server != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4423, c'server != NULL') } else {return error('error message')})
	server.listen_socket = (voidptr(0))
	server.client_socket = (voidptr(0))
	server.last_ping_time = 0
	server.port = port
	server.reuse_open_port = reuse_open_port
	server.limit_connections_to_localhost = limit_connections_to_localhost
	server.bin_buf = (voidptr(0))
	server.receive_handler = (voidptr(0))
	server.receive_handler_context = (voidptr(0))
	{
		server.bin_buf = &Buffer(rmtmalloc(sizeof(Buffer)))
		if server.bin_buf == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := buffer_constructor(server.bin_buf, 4096)
		if error != RmtError.rmt_error_none {
			if server.bin_buf != (voidptr(0)) {
				buffer_destructor(server.bin_buf)
				rmtfree(server.bin_buf)
				server.bin_buf = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	return server_createlistensocket(server, port, reuse_open_port, limit_connections_to_localhost)
}

[c:'Server_Destructor']
fn server_destructor(server &Server)  {
	(if __builtin_expect(!(server != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4443, c'server != NULL') } else {return error('error message')})
	if server.client_socket != (voidptr(0)) {
		websocket_destructor(server.client_socket)
		rmtfree(server.client_socket)
		server.client_socket = (voidptr(0))
	}
	0 /* null */
	if server.listen_socket != (voidptr(0)) {
		websocket_destructor(server.listen_socket)
		rmtfree(server.listen_socket)
		server.listen_socket = (voidptr(0))
	}
	0 /* null */
	if server.bin_buf != (voidptr(0)) {
		buffer_destructor(server.bin_buf)
		rmtfree(server.bin_buf)
		server.bin_buf = (voidptr(0))
	}
	0 /* null */
}

[c:'Server_IsClientConnected']
fn server_isclientconnected(server &Server) RmtBool {
	(if __builtin_expect(!(server != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4451, c'server != NULL') } else {return error('error message')})
	return if server.client_socket != (voidptr(0)){ (RmtBool(1)) } else {(RmtBool(0))}
}

[c:'Server_DisconnectClient']
fn server_disconnectclient(server &Server)  {
	client_socket := &WebSocket(0)
	(if __builtin_expect(!(server != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4459, c'server != NULL') } else {return error('error message')})
	client_socket = server.client_socket
	server.client_socket = (voidptr(0))
	compilerwritefence()
	if client_socket != (voidptr(0)) {
		websocket_destructor(client_socket)
		rmtfree(client_socket)
		client_socket = (voidptr(0))
	}
	0 /* null */
}

[c:'Server_Send']
fn server_send(server &Server, data voidptr, length RmtU32, timeout RmtU32) RmtError {
	(if __builtin_expect(!(server != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4470, c'server != NULL') } else {return error('error message')})
	if server_isclientconnected(server) {
		error := websocket_send(server.client_socket, data, length, timeout)
		if error == RmtError.rmt_error_socket_send_fail {
		server_disconnectclient(server)
		}
		return error
	}
	return RmtError.rmt_error_none
}

[c:'Server_ReceiveMessage']
fn server_receivemessage(server &Server, message_first_byte i8, message_length RmtU32) RmtError {
	message_data := [1024]i8{}
	if message_length >= sizeof(message_data) - 1 {
		_rmt_logtext(c'Ignoring console input bigger than internal receive buffer (1024 bytes)')
		return RmtError.rmt_error_none
	}
	message_data [0]  = message_first_byte
	{
		error := websocket_receive(server.client_socket, message_data + 1, (voidptr(0)), message_length - 1, 100)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	message_data [message_length]  = 0
	if message_length < 4 {
	return RmtError.rmt_error_none
	}
	if server.receive_handler {
		error := server.receive_handler(server.receive_handler_context, message_data, message_length)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'bin_MessageHeader']
fn bin_messageheader(buffer &Buffer, id &i8, out_write_start_offset &RmtU32) RmtError {
	*out_write_start_offset = buffer.bytes_used
	{
		error := buffer_write(buffer, voidptr(id), 4)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_write(buffer, voidptr(c'    '), 4)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'bin_MessageFooter']
fn bin_messagefooter(buffer &Buffer, write_start_offset RmtU32) RmtError {
	{
		error := buffer_alignedpad(buffer, write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	u32tobytearray(buffer.data + write_start_offset + 4, (buffer.bytes_used - write_start_offset))
	return RmtError.rmt_error_none
}

[c:'Server_Update']
fn server_update(server &Server)  {
	cur_time := RmtU32{}
	(if __builtin_expect(!(server != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4534, c'server != NULL') } else {return error('error message')})
	if server.listen_socket == (voidptr(0)) {
	server_createlistensocket(server, server.port, server.reuse_open_port, server.limit_connections_to_localhost)
	}
	if server.listen_socket != (voidptr(0)) && server.client_socket == (voidptr(0)) {
		client_socket := (voidptr(0))
		error := websocket_acceptconnection(server.listen_socket, &client_socket)
		if error == RmtError.rmt_error_none {
			server.client_socket = client_socket
		}
		else {
			if server.listen_socket != (voidptr(0)) {
				websocket_destructor(server.listen_socket)
				rmtfree(server.listen_socket)
				server.listen_socket = (voidptr(0))
			}
			0 /* null */
		}
	}
	else {
		for  ;  ;  {
			message_first_byte := i8(0)
			message_length := RmtU32{}
			error := websocket_receive(server.client_socket, &message_first_byte, &message_length, 1, 0)
			if error == RmtError.rmt_error_none {
				error = server_receivemessage(server, message_first_byte, message_length)
				if error != RmtError.rmt_error_none {
					server_disconnectclient(server)
					break
					
				}
				continue
				
			}
			if error == RmtError.rmt_error_socket_recv_no_data {
				break
				
			}
			if error == RmtError.rmt_error_socket_recv_timeout {
				break
				
			}
			server_disconnectclient(server)
			break
			
		}
	}
	cur_time = mstimer_get()
	if cur_time - server.last_ping_time > 1000 {
		bin_buf := server.bin_buf
		write_start_offset := RmtU32{}
		websocket_preparebuffer(bin_buf)
		bin_messageheader(bin_buf, c'PING', &write_start_offset)
		bin_messagefooter(bin_buf, write_start_offset)
		server_send(server, bin_buf.data, bin_buf.bytes_used, 10)
		server.last_ping_time = cur_time
	}
}

struct Sample { 
	Link ObjectLink
	type_ RmtSampleType
	name_hash RmtU32
	unique_id RmtU32
	uniqueColour [3]RmtU8
	parent &Sample
	first_child &Sample
	last_child &Sample
	next_sibling &Sample
	nb_children RmtU32
	us_start RmtU64
	us_end RmtU64
	us_length RmtU64
	us_sampled_length RmtU64
	usGpuIssueOnCpu RmtU64
	call_count RmtU32
	recurse_depth RmtU16
	max_recurse_depth RmtU16
}
[c:'Sample_Constructor']
fn sample_constructor(sample &Sample) RmtError {
	(if __builtin_expect(!(sample != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4672, c'sample != NULL') } else {return error('error message')})
	objectlink_constructor(&ObjectLink(sample))
	sample.type_ = RmtSampleType.rmt_sampletype_cpu
	sample.name_hash = 0
	sample.unique_id = 0
	sample.uniqueColour [0]  = 0
	sample.uniqueColour [1]  = 0
	sample.uniqueColour [2]  = 0
	sample.parent = (voidptr(0))
	sample.first_child = (voidptr(0))
	sample.last_child = (voidptr(0))
	sample.next_sibling = (voidptr(0))
	sample.nb_children = 0
	sample.us_start = 0
	sample.us_end = 0
	sample.us_length = 0
	sample.us_sampled_length = 0
	sample.usGpuIssueOnCpu = 0
	sample.call_count = 0
	sample.recurse_depth = 0
	sample.max_recurse_depth = 0
	return RmtError.rmt_error_none
}

[c:'Sample_Destructor']
fn sample_destructor(sample &Sample)  {
	void((if 1{ return error('error message') } else {(void(sample))}))
}

[c:'Sample_Prepare']
fn sample_prepare(sample &Sample, name_hash RmtU32, parent &Sample)  {
	sample.name_hash = name_hash
	sample.unique_id = 0
	sample.parent = parent
	sample.first_child = (voidptr(0))
	sample.last_child = (voidptr(0))
	sample.next_sibling = (voidptr(0))
	sample.nb_children = 0
	sample.us_start = 0
	sample.us_end = 0
	sample.us_length = 0
	sample.us_sampled_length = 0
	sample.usGpuIssueOnCpu = 0
	sample.call_count = 1
	sample.recurse_depth = 0
	sample.max_recurse_depth = 0
}

[c:'Sample_Close']
fn sample_close(sample &Sample, us_end RmtS64)  {
	us_length := 0
	if sample.call_count > 1 && sample.max_recurse_depth == 0 {
		us_length = maxs64(us_end - sample.us_end, 0)
	}
	else {
		us_length = maxs64(us_end - sample.us_start, 0)
	}
	sample.us_length += us_length
	if sample.parent != (voidptr(0)) {
		sample.parent.us_sampled_length += us_length
	}
}

[c:'Sample_CopyState']
fn sample_copystate(dst_sample &Sample, src_sample &Sample)  {
	dst_sample.type_ = src_sample.type_
	dst_sample.name_hash = src_sample.name_hash
	dst_sample.unique_id = src_sample.unique_id
	dst_sample.nb_children = src_sample.nb_children
	dst_sample.us_start = src_sample.us_start
	dst_sample.us_end = src_sample.us_end
	dst_sample.us_length = src_sample.us_length
	dst_sample.us_sampled_length = src_sample.us_sampled_length
	dst_sample.usGpuIssueOnCpu = src_sample.usGpuIssueOnCpu
	dst_sample.call_count = src_sample.call_count
	dst_sample.recurse_depth = src_sample.recurse_depth
	dst_sample.max_recurse_depth = src_sample.max_recurse_depth
	dst_sample.parent = (voidptr(0))
	dst_sample.first_child = (voidptr(0))
	dst_sample.last_child = (voidptr(0))
	dst_sample.next_sibling = (voidptr(0))
}

[c:'bin_SampleArray']
fn bin_samplearray(buffer &Buffer, parent_sample &Sample, depth RmtU8) RmtError

[c:'bin_Sample']
fn bin_sample(buffer &Buffer, sample &Sample, depth RmtU8) RmtError {
	(if __builtin_expect(!(sample != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4773, c'sample != NULL') } else {return error('error message')})
	{
		error := buffer_writeu32(buffer, sample.name_hash)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(buffer, sample.unique_id)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_write(buffer, sample.uniqueColour, 3)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_write(buffer, &depth, 1)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu64(buffer, sample.us_start)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu64(buffer, sample.us_length)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu64(buffer, maxs64(sample.us_length - sample.us_sampled_length, 0))
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu64(buffer, sample.usGpuIssueOnCpu)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(buffer, sample.call_count)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(buffer, sample.max_recurse_depth)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := bin_samplearray(buffer, sample, depth + 1)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'bin_SampleArray']
fn bin_samplearray(buffer &Buffer, parent_sample &Sample, depth RmtU8) RmtError {
	sample := &Sample(0)
	{
		error := buffer_writeu32(buffer, parent_sample.nb_children)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	for sample = parent_sample.first_child ; sample != (voidptr(0)) ; sample = sample.next_sibling {
		error := bin_sample(buffer, sample, depth)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

struct SampleTree { 
	allocator &ObjectAllocator
	root &Sample
	currentParent &Sample
	msLastTreeSendTime RmtAtomicU32
	treeBeingModified RmtAtomicU32
	sendSampleOnClose &Sample
}
[c:'SampleTree_Constructor']
fn sampletree_constructor(tree &SampleTree, sample_size RmtU32, constructor ObjConstructor, destructor ObjDestructor) RmtError {
	(if __builtin_expect(!(tree != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4840, c'tree != NULL') } else {return error('error message')})
	tree.allocator = (voidptr(0))
	tree.root = (voidptr(0))
	tree.currentParent = (voidptr(0))
	storerelease(&tree.msLastTreeSendTime, 0)
	storerelease(&tree.treeBeingModified, 0)
	tree.sendSampleOnClose = (voidptr(0))
	{
		tree.allocator = &ObjectAllocator(rmtmalloc(sizeof(ObjectAllocator)))
		if tree.allocator == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := objectallocator_constructor(tree.allocator, sample_size, constructor, destructor)
		if error != RmtError.rmt_error_none {
			if tree.allocator != (voidptr(0)) {
				objectallocator_destructor(tree.allocator)
				rmtfree(tree.allocator)
				tree.allocator = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	{
		error := objectallocator_alloc(tree.allocator, &voidptr(&tree.root))
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	sample_prepare(tree.root, 0, (voidptr(0)))
	tree.currentParent = tree.root
	return RmtError.rmt_error_none
}

[c:'SampleTree_Destructor']
fn sampletree_destructor(tree &SampleTree)  {
	(if __builtin_expect(!(tree != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4862, c'tree != NULL') } else {return error('error message')})
	if tree.root != (voidptr(0)) {
		objectallocator_free(tree.allocator, tree.root)
		tree.root = (voidptr(0))
	}
	if tree.allocator != (voidptr(0)) {
		objectallocator_destructor(tree.allocator)
		rmtfree(tree.allocator)
		tree.allocator = (voidptr(0))
	}
	0 /* null */
}

[c:'HashCombine']
fn hashcombine(hash_a RmtU32, hash_b RmtU32) RmtU32 {
	random_bits := 2654435769
	hash_a ^= hash_b + random_bits + (hash_a << 6) + (hash_a >> 2)
	return hash_a
}

[c:'SampleTree_Push']
fn sampletree_push(tree &SampleTree, name_hash RmtU32, flags RmtU32, sample &&Sample) RmtError {
	parent := &Sample(0)
	unique_id := RmtU32{}
	(if __builtin_expect(!(tree != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4890, c'tree != NULL') } else {return error('error message')})
	(if __builtin_expect(!(tree.currentParent != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4891, c'tree->currentParent != NULL') } else {return error('error message')})
	parent = tree.currentParent
	if flags != 0 {
		if (flags & RmtSampleFlags.rmtsf_root) != 0 {
			(if __builtin_expect(!(parent.parent == (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4900, c'parent->parent == NULL') } else {return error('error message')})
		}
		if (flags & RmtSampleFlags.rmtsf_aggregate) != 0 {
			sibling := &Sample(0)
			for sibling = parent.first_child ; sibling != (voidptr(0)) ; sibling = sibling.next_sibling {
				if sibling.name_hash == name_hash {
					tree.currentParent = sibling
					sibling.call_count ++
					*sample = sibling
					return RmtError.rmt_error_none
				}
			}
		}
		if (flags & RmtSampleFlags.rmtsf_recursive) != 0 && parent.name_hash == name_hash {
			parent.recurse_depth ++
			parent.max_recurse_depth = maxu16(parent.max_recurse_depth, parent.recurse_depth)
			parent.call_count ++
			*sample = parent
			return RmtError.rmt_error_recursive_sample
		}
		{
			error := objectallocator_alloc(tree.allocator, &voidptr(sample))
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		sample_prepare(*sample, name_hash, parent)
		if (flags & RmtSampleFlags.rmtsf_sendonclose) != 0 {
			(if __builtin_expect(!(tree.currentParent != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4936, c'tree->currentParent != NULL') } else {return error('error message')})
			(if __builtin_expect(!(tree.sendSampleOnClose == (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4937, c'tree->sendSampleOnClose == NULL') } else {return error('error message')})
			tree.sendSampleOnClose = *sample
		}
	}
	else {
		{
			error := objectallocator_alloc(tree.allocator, &voidptr(sample))
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		sample_prepare(*sample, name_hash, parent)
	}
	unique_id = parent.unique_id
	unique_id = hashcombine(unique_id, (*sample).name_hash)
	unique_id = hashcombine(unique_id, parent.nb_children)
	(*sample).unique_id = unique_id
	parent.nb_children ++
	if parent.first_child == (voidptr(0)) {
		parent.first_child = *sample
		parent.last_child = *sample
	}
	else {
		(if __builtin_expect(!(parent.last_child != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4964, c'parent->last_child != NULL') } else {return error('error message')})
		parent.last_child.next_sibling = *sample
		parent.last_child = *sample
	}
	tree.currentParent = *sample
	return RmtError.rmt_error_none
}

[c:'SampleTree_Pop']
fn sampletree_pop(tree &SampleTree, sample &Sample)  {
	(if __builtin_expect(!(tree != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4977, c'tree != NULL') } else {return error('error message')})
	(if __builtin_expect(!(sample != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4978, c'sample != NULL') } else {return error('error message')})
	(if __builtin_expect(!(sample != tree.root), 0){ __assert_rtn(, c'Remotery.c', 4979, c'sample != tree->root') } else {return error('error message')})
	tree.currentParent = sample.parent
}

[c:'FlattenSamples']
fn flattensamples(sample &Sample, nb_samples &RmtU32) &ObjectLink {
	child := &Sample(0)
	cur_link := &sample.Link
	(if __builtin_expect(!(sample != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4988, c'sample != NULL') } else {return error('error message')})
	(if __builtin_expect(!(nb_samples != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 4989, c'nb_samples != NULL') } else {return error('error message')})
	*nb_samples += 1
	sample.Link.next = &ObjectLink(sample.first_child)
	for child = sample.first_child ; child != (voidptr(0)) ; child = child.next_sibling {
		last_link := flattensamples(child, nb_samples)
		last_link.next = &ObjectLink(child.next_sibling)
		cur_link = last_link
	}
	sample.first_child = (voidptr(0))
	sample.last_child = (voidptr(0))
	sample.nb_children = 0
	return cur_link
}

[c:'FreeSamples']
fn freesamples(sample &Sample, allocator &ObjectAllocator)  {
	nb_cleared_samples := 0
	last_link := flattensamples(sample, &nb_cleared_samples)
	if sample.Link.next != (voidptr(0)) {
		objectallocator_freerange(allocator, sample, last_link, nb_cleared_samples)
	}
	else {
		objectallocator_free(allocator, sample)
	}
}

[c:'SampleTree_CopySample']
fn sampletree_copysample(out_dst_sample &&Sample, dst_parent_sample &Sample, allocator &ObjectAllocator, src_sample &Sample) RmtError {
	src_child := &Sample(0)
	dst_sample := &Sample(0)
	{
		error := objectallocator_alloc(allocator, &voidptr(&dst_sample))
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	sample_copystate(dst_sample, src_sample)
	if dst_parent_sample != (voidptr(0)) {
		if dst_parent_sample.first_child == (voidptr(0)) {
			dst_parent_sample.first_child = dst_sample
			dst_parent_sample.last_child = dst_sample
		}
		else {
			(if __builtin_expect(!(dst_parent_sample.last_child != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 5047, c'dst_parent_sample->last_child != NULL') } else {return error('error message')})
			dst_parent_sample.last_child.next_sibling = dst_sample
			dst_parent_sample.last_child = dst_sample
		}
	}
	for src_child = src_sample.first_child ; src_child != (voidptr(0)) ; src_child = src_child.next_sibling {
		dst_child := &Sample(0)
		{
			error := sampletree_copysample(&dst_child, dst_sample, allocator, src_child)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
	}
	*out_dst_sample = dst_sample
	return RmtError.rmt_error_none
}

[c:'SampleTree_Copy']
fn sampletree_copy(dst_tree &SampleTree, src_tree &SampleTree) RmtError {
	allocator := src_tree.allocator
	dst_tree.allocator = allocator
	{
		error := sampletree_copysample(&dst_tree.root, (voidptr(0)), allocator, src_tree.root)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	dst_tree.currentParent = dst_tree.root
	return RmtError.rmt_error_none
}

struct Msg_SampleTree { 
	rootSample &Sample
	allocator &ObjectAllocator
	threadName RmtPStr
	userData RmtU32
	partialTree RmtBool
}
[c:'QueueSampleTree']
fn queuesampletree(queue &RmtMessageQueue, sample &Sample, allocator &ObjectAllocator, thread_name RmtPStr, user_data RmtU32, thread_profiler &ThreadProfiler, partial_tree RmtBool)  {
	payload := &Msg_SampleTree(0)
	message := rmtmessagequeue_allocmessage(queue, sizeof(Msg_SampleTree), thread_profiler)
	if message == (voidptr(0)) {
		freesamples(sample, allocator)
		return 
	}
	payload = &Msg_SampleTree(message.payload)
	payload.rootSample = sample
	payload.allocator = allocator
	payload.threadName = thread_name
	payload.userData = user_data
	payload.partialTree = partial_tree
	rmtmessagequeue_commitmessage(message, MessageID.msgid_sampletree)
}

struct Msg_AddToStringTable { 
	hash RmtU32
	length RmtU32
}
[c:'QueueAddToStringTable']
fn queueaddtostringtable(queue &RmtMessageQueue, hash RmtU32, string_ &i8, length usize, thread_profiler &ThreadProfiler) RmtBool {
	payload := &Msg_AddToStringTable(0)
	nb_string_bytes := length + 1
	message := rmtmessagequeue_allocmessage(queue, sizeof(Msg_AddToStringTable) + nb_string_bytes, thread_profiler)
	if message == (voidptr(0)) {
		return (RmtBool(0))
	}
	payload = &Msg_AddToStringTable(message.payload)
	payload.hash = hash
	payload.length = length
	C.memcpy(payload + 1, string_, nb_string_bytes)
	rmtmessagequeue_commitmessage(message, MessageID.msgid_addtostringtable)
	return (RmtBool(1))
}

struct ThreadProfiler { 
	registerBackup0 RmtU64
	registerBackup1 RmtU64
	registerBackup2 RmtU64
	nbSamplesWithoutCallback RmtAtomicS32
	processorIndex RmtU32
	lastProcessorIndex RmtU32
	threadId RmtThreadId
	threadHandle RmtThreadHandle
	threadName [64]i8
	threadNameHash RmtU32
	sampleTrees [6]&SampleTree
}
[c:'ThreadProfiler_Constructor']
fn threadprofiler_constructor(mq_to_rmt &RmtMessageQueue, thread_profiler &ThreadProfiler, thread_id RmtThreadId) RmtError {
	name_length := RmtU32{}
	thread_profiler.nbSamplesWithoutCallback = 0
	thread_profiler.processorIndex = RmtU32(-1)
	thread_profiler.lastProcessorIndex = RmtU32(-1)
	thread_profiler.threadId = thread_id
	C.memset(thread_profiler.sampleTrees, 0, sizeof(thread_profiler.sampleTrees))
	{
		error := rmtopenthreadhandle(thread_id, &thread_profiler.threadHandle)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	rmtgetthreadname(thread_id, thread_profiler.threadHandle, thread_profiler.threadName, sizeof(thread_profiler.threadName))
	name_length = strnlen_s_safe_c(thread_profiler.threadName, 64)
	thread_profiler.threadNameHash = _rmt_hashstring32(thread_profiler.threadName, name_length, 0)
	queueaddtostringtable(mq_to_rmt, thread_profiler.threadNameHash, thread_profiler.threadName, name_length, thread_profiler)
	{
		thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)]  = &SampleTree(rmtmalloc(sizeof(SampleTree)))
		if thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)]  == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := sampletree_constructor(thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)] , sizeof(Sample), ObjConstructor(sample_constructor), ObjDestructor(sample_destructor))
		if error != RmtError.rmt_error_none {
			if thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)]  != (voidptr(0)) {
				sampletree_destructor(thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)] )
				rmtfree(thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)] )
				thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)]  = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'ThreadProfiler_Destructor']
fn threadprofiler_destructor(thread_profiler &ThreadProfiler)  {
	index := RmtU32{}
	for index = 0 ; index < RmtSampleType.rmt_sampletype_count ; index ++ {
		if thread_profiler.sampleTrees [index]  != (voidptr(0)) {
			sampletree_destructor(thread_profiler.sampleTrees [index] )
			rmtfree(thread_profiler.sampleTrees [index] )
			thread_profiler.sampleTrees [index]  = (voidptr(0))
		}
		0 /* null */
	}
	rmtclosethreadhandle(thread_profiler.threadHandle)
}

[c:'ThreadProfiler_Push']
fn threadprofiler_push(tree &SampleTree, name_hash RmtU32, flags RmtU32, sample &&Sample) RmtError {
	error := RmtError{}
	storerelease(&tree.treeBeingModified, 1)
	error = sampletree_push(tree, name_hash, flags, sample)
	0 /* null */
	storerelease(&tree.treeBeingModified, 0)
	0 /* null */
	return error
}

[c:'CloseOpenSamples']
fn closeopensamples(sample &Sample, sample_time_us RmtU64, parents_are_last RmtU32)  {
	child_sample := &Sample(0)
	for child_sample = sample.first_child ; child_sample != (voidptr(0)) ; child_sample = child_sample.next_sibling {
		is_last := parents_are_last & (if child_sample == sample.last_child{ 1 } else {0})
		closeopensamples(child_sample, sample_time_us, is_last)
	}
	if parents_are_last > 0 {
		sample_close(sample, sample_time_us)
	}
}

[c:'MakePartialTreeCopy']
fn makepartialtreecopy(sample_tree &SampleTree, sample_time_us RmtU64, out_sample_tree_copy &SampleTree) RmtError {
	sample_time_s := RmtU32((sample_time_us / 1000))
	storerelease(&sample_tree.msLastTreeSendTime, sample_time_s)
	{
		error := sampletree_copy(out_sample_tree_copy, sample_tree)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	closeopensamples(out_sample_tree_copy.root, sample_time_us, 1)
	return RmtError.rmt_error_none
}

[c:'ThreadProfiler_Pop']
fn threadprofiler_pop(thread_profiler &ThreadProfiler, queue &RmtMessageQueue, sample &Sample, msg_user_data RmtU32) RmtBool {
	tree := thread_profiler.sampleTrees [sample.type_] 
	sampletree_pop(tree, sample)
	if tree.currentParent == tree.root {
		root := &Sample(0)
		storerelease(&tree.treeBeingModified, 1)
		root = tree.root
		root.first_child = (voidptr(0))
		root.last_child = (voidptr(0))
		root.nb_children = 0
		0 /* null */
		storerelease(&tree.treeBeingModified, 0)
		0 /* null */
		queuesampletree(queue, sample, tree.allocator, thread_profiler.threadName, msg_user_data, thread_profiler, (RmtBool(0)))
		storerelease(&tree.msLastTreeSendTime, RmtU32((sample.us_end / 1000)))
		return (RmtBool(1))
	}
	if tree.sendSampleOnClose == sample {
		partial_tree := SampleTree{}
		if makepartialtreecopy(tree, sample.us_start + sample.us_length, &partial_tree) == RmtError.rmt_error_none {
			root_sample := partial_tree.root.first_child
			(if __builtin_expect(!(root_sample != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 5336, c'root_sample != NULL') } else {return error('error message')})
			queuesampletree(queue, root_sample, partial_tree.allocator, thread_profiler.threadName, msg_user_data, thread_profiler, (RmtBool(1)))
		}
		if partial_tree.root != (voidptr(0)) {
			freesamples(partial_tree.root, partial_tree.allocator)
		}
		tree.sendSampleOnClose = (voidptr(0))
	}
	return (RmtBool(0))
}

[c:'ThreadProfiler_GetNameHash']
fn threadprofiler_getnamehash(thread_profiler &ThreadProfiler, queue &RmtMessageQueue, name RmtPStr, hash_cache &RmtU32) RmtU32 {
	name_len := usize(0)
	name_hash := RmtU32{}
	if hash_cache != (voidptr(0)) {
		name_hash = atomicloadu32(&RmtAtomicU32(hash_cache))
		if name_hash == 0 {
			(if __builtin_expect(!(name != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 5364, c'name != NULL') } else {return error('error message')})
			name_len = strnlen_s_safe_c(name, 256)
			name_hash = _rmt_hashstring32(name, name_len, 0)
			if queueaddtostringtable(queue, name_hash, name, name_len, thread_profiler) == (RmtBool(1)) {
				atomicstoreu32(&RmtAtomicU32(hash_cache), name_hash)
			}
		}
		return name_hash
	}
	name_len = strnlen_s_safe_c(name, 256)
	name_hash = _rmt_hashstring32(name, name_len, 0)
	queueaddtostringtable(queue, name_hash, name, name_len, thread_profiler)
	return name_hash
}

struct ThreadProfilers { 
	timer &UsTimer
	mqToRmtThread &RmtMessageQueue
	compiledSampleFn voidptr
	compiledSampleFnSize RmtU32
	threadProfilerTlsHandle RmtTLS
	threadProfilers [256]ThreadProfiler
	nbThreadProfilers RmtAtomicU32
	maxNbThreadProfilers RmtU32
	threadProfilerMutex RmtMutex
	threadSampleThread &RmtThread
	threadGatherThread &RmtThread
}
[c:'SampleThreadsLoop']
fn samplethreadsloop(rmt_thread &RmtThread) RmtError

[c:'ThreadProfilers_Constructor']
fn threadprofilers_constructor(thread_profilers &ThreadProfilers, timer &UsTimer, mq_to_rmt_thread &RmtMessageQueue) RmtError {
	thread_profilers.timer = timer
	thread_profilers.mqToRmtThread = mq_to_rmt_thread
	thread_profilers.compiledSampleFn = (voidptr(0))
	thread_profilers.compiledSampleFnSize = 0
	thread_profilers.threadProfilerTlsHandle = 4294967295
	thread_profilers.nbThreadProfilers = 0
	thread_profilers.maxNbThreadProfilers = sizeof(thread_profilers.threadProfilers) / sizeof(thread_profilers.threadProfilers [0] )
	mtxinit(&thread_profilers.threadProfilerMutex)
	thread_profilers.threadSampleThread = (voidptr(0))
	thread_profilers.threadGatherThread = (voidptr(0))
	{
		error := tlsalloc(&thread_profilers.threadProfilerTlsHandle)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	if g_Settings.enableThreadSampler == (RmtBool(1)) {
		{
			thread_profilers.threadSampleThread = &RmtThread(rmtmalloc(sizeof(RmtThread)))
			if thread_profilers.threadSampleThread == (voidptr(0)) {
				return RmtError.rmt_error_malloc_fail
			}
			error := rmtthread_constructor(thread_profilers.threadSampleThread, samplethreadsloop, thread_profilers)
			if error != RmtError.rmt_error_none {
				if thread_profilers.threadSampleThread != (voidptr(0)) {
					rmtthread_destructor(thread_profilers.threadSampleThread)
					rmtfree(thread_profilers.threadSampleThread)
					thread_profilers.threadSampleThread = (voidptr(0))
				}
				0 /* null */
				return error
			}
		}
		0 /* null */
	}
	return RmtError.rmt_error_none
}

[c:'ThreadProfilers_Destructor']
fn threadprofilers_destructor(thread_profilers &ThreadProfilers)  {
	thread_index := RmtU32{}
	if thread_profilers.threadSampleThread != (voidptr(0)) {
		rmtthread_destructor(thread_profilers.threadSampleThread)
		rmtfree(thread_profilers.threadSampleThread)
		thread_profilers.threadSampleThread = (voidptr(0))
	}
	0 /* null */
	for thread_index = 0 ; thread_index < thread_profilers.nbThreadProfilers ; thread_index ++ {
		thread_profiler := thread_profilers.threadProfilers + thread_index
		threadprofiler_destructor(thread_profiler)
	}
	if thread_profilers.threadProfilerTlsHandle != 4294967295 {
		tlsfree(thread_profilers.threadProfilerTlsHandle)
	}
	mtxdelete(&thread_profilers.threadProfilerMutex)
}

[c:'ThreadProfilers_GetThreadProfiler']
fn threadprofilers_getthreadprofiler(thread_profilers &ThreadProfilers, thread_id RmtThreadId, out_thread_profiler &&ThreadProfiler) RmtError {
	profiler_index := RmtU32{}
	thread_profiler := &ThreadProfiler(0)
	error := RmtError{}
	mtxlock(&thread_profilers.threadProfilerMutex)
	for profiler_index = 0 ; profiler_index < thread_profilers.nbThreadProfilers ; profiler_index ++ {
		thread_profiler = thread_profilers.threadProfilers + profiler_index
		if thread_profiler.threadId == thread_id {
			*out_thread_profiler = thread_profiler
			mtxunlock(&thread_profilers.threadProfilerMutex)
			return RmtError.rmt_error_none
		}
	}
	if thread_profilers.nbThreadProfilers + 1 > thread_profilers.maxNbThreadProfilers {
		mtxunlock(&thread_profilers.threadProfilerMutex)
		return RmtError.rmt_error_malloc_fail
	}
	thread_profiler = thread_profilers.threadProfilers + thread_profilers.nbThreadProfilers
	error = threadprofiler_constructor(thread_profilers.mqToRmtThread, thread_profiler, thread_id)
	if error != RmtError.rmt_error_none {
		threadprofiler_destructor(thread_profiler)
		mtxunlock(&thread_profilers.threadProfilerMutex)
		return error
	}
	*out_thread_profiler = thread_profiler
	storerelease(&thread_profilers.nbThreadProfilers, thread_profilers.nbThreadProfilers + 1)
	mtxunlock(&thread_profilers.threadProfilerMutex)
	return RmtError.rmt_error_none
}

[c:'ThreadProfilers_GetCurrentThreadProfiler']
fn threadprofilers_getcurrentthreadprofiler(thread_profilers &ThreadProfilers, out_thread_profiler &&ThreadProfiler) RmtError {
	*out_thread_profiler = &ThreadProfiler(tlsget(thread_profilers.threadProfilerTlsHandle))
	if *out_thread_profiler == (voidptr(0)) {
		{
			error := threadprofilers_getthreadprofiler(thread_profilers, rmtgetcurrentthreadid(), out_thread_profiler)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		tlsset(thread_profilers.threadProfilerTlsHandle, *out_thread_profiler)
	}
	return RmtError.rmt_error_none
}

[c:'ThreadProfilers_ThreadInCallback']
fn threadprofilers_threadincallback(thread_profilers &ThreadProfilers, context &RmtCpuContext) RmtBool {
	return (RmtBool(0))
}

[c:'GatherThreads']
fn gatherthreads(thread_profilers &ThreadProfilers)  {
	handle := RmtThreadHandle{}
	(if __builtin_expect(!(thread_profilers != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 5587, c'thread_profilers != NULL') } else {return error('error message')})
}

[c:'GatherThreadsLoop']
fn gatherthreadsloop(thread &RmtThread) RmtError {
	thread_profilers := &ThreadProfilers(thread.param)
	sleep_time := 100
	(if __builtin_expect(!(thread_profilers != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 5630, c'thread_profilers != NULL') } else {return error('error message')})
	_rmt_setcurrentthreadname(c'RemoteryGatherThreads')
	for thread.request_exit == (RmtBool(0)) {
		gatherthreads(thread_profilers)
		mssleep(sleep_time)
		sleep_time = minu32(sleep_time * 2, 2000)
	}
	return RmtError.rmt_error_none
}

struct Processor { 
	threadProfiler &ThreadProfiler
	sampleCount RmtU32
	sampleTime RmtU64
}
struct Msg_ProcessorThreads { 
	messageIndex RmtU64
	nbProcessors RmtU32
	processors [1]Processor
}
[c:'QueueProcessorThreads']
fn queueprocessorthreads(queue &RmtMessageQueue, message_index RmtU64, nb_processors RmtU32, processors &Processor)  {
	payload := &Msg_ProcessorThreads(0)
	array_size := (nb_processors - 1) * sizeof(Processor)
	message := rmtmessagequeue_allocmessage(queue, sizeof(Msg_ProcessorThreads) + array_size, (voidptr(0)))
	if message == (voidptr(0)) {
		return 
	}
	payload = &Msg_ProcessorThreads(message.payload)
	payload.messageIndex = message_index
	payload.nbProcessors = nb_processors
	C.memcpy(payload.processors, processors, nb_processors * sizeof(Processor))
	rmtmessagequeue_commitmessage(message, MessageID.msgid_processorthreads)
}

[c:'CheckForStallingSamples']
fn checkforstallingsamples(stalling_sample_tree &SampleTree, thread_profiler &ThreadProfiler, sample_time_us RmtU64) RmtError {
	sample_tree := &SampleTree(0)
	sample_time_s := RmtU32((sample_time_us / 1000))
	stalling_sample_tree.root = (voidptr(0))
	stalling_sample_tree.allocator = (voidptr(0))
	sample_tree = thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)] 
	if loadacquire(&sample_tree.treeBeingModified) != 0 {
		return RmtError.rmt_error_none
	}
	if sample_tree != (voidptr(0)) {
		root_sample := sample_tree.root
		if root_sample != (voidptr(0)) && root_sample.nb_children > 0 {
			if sample_time_s - loadacquire(&sample_tree.msLastTreeSendTime) > 1000 {
				{
					error := makepartialtreecopy(sample_tree, sample_time_us, stalling_sample_tree)
					if error != RmtError.rmt_error_none {
					return error
					}
				}
				0 /* null */
			}
		}
	}
	return RmtError.rmt_error_none
}

[c:'InitThreadSampling']
fn initthreadsampling(thread_profilers &ThreadProfilers) RmtError {
	_rmt_setcurrentthreadname(c'RemoterySampleThreads')
	gatherthreads(thread_profilers)
	{
		thread_profilers.threadGatherThread = &RmtThread(rmtmalloc(sizeof(RmtThread)))
		if thread_profilers.threadGatherThread == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := rmtthread_constructor(thread_profilers.threadGatherThread, gatherthreadsloop, thread_profilers)
		if error != RmtError.rmt_error_none {
			if thread_profilers.threadGatherThread != (voidptr(0)) {
				rmtthread_destructor(thread_profilers.threadGatherThread)
				rmtfree(thread_profilers.threadGatherThread)
				thread_profilers.threadGatherThread = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	well512_init(RmtU32(time((voidptr(0)))))
	return RmtError.rmt_error_none
}

[c:'SampleThreadsLoop']
fn samplethreadsloop(rmt_thread &RmtThread) RmtError {
	context := RmtCpuContext{}
	processor_message_index := 0
	nb_processors := RmtU32{}
	processors := &Processor(0)
	processor_index := RmtU32{}
	thread_profilers := &ThreadProfilers(rmt_thread.param)
	nb_processors = rmtgetnbprocessors()
	if nb_processors == 0 {
		return RmtError.rmt_error_unknown
	}
	{
		error := initthreadsampling(thread_profilers)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	processors = &Processor(rmtmalloc((nb_processors) * sizeof(Processor)))
	if processors == (voidptr(0)) {
		return RmtError.rmt_error_malloc_fail
	}
	0 /* null */
	for processor_index = 0 ; processor_index < nb_processors ; processor_index ++ {
		processors [processor_index] .threadProfiler = (voidptr(0))
		processors [processor_index] .sampleTime = 0
	}
	for rmt_thread.request_exit == (RmtBool(0)) {
		lfsr_seed := RmtU32{}
		lfsr_value := RmtU32{}
		nb_thread_profilers := loadacquire(&thread_profilers.nbThreadProfilers)
		highest_bit_set := log2i(nb_thread_profilers)
		table_size_log2 := highest_bit_set + 1
		xor_mask := galoislfsrmask(table_size_log2)
		lfsr_seed = well512_randomopenlimit(nb_thread_profilers)
		lfsr_value = lfsr_seed
		for {
		thread_index := RmtU32{}
		thread_id := RmtThreadId{}
		thread_profiler := &ThreadProfiler(0)
		thread_handle := RmtThreadHandle{}
		sample_time_us := RmtU64{}
		sample_count := RmtU32{}
		stalling_sample_tree := SampleTree{}
		lfsr_value = galoislfsrnext(lfsr_value, xor_mask)
		thread_index = lfsr_value - 1
		if thread_index >= nb_thread_profilers {
			continue
			
		}
		thread_id = rmtgetcurrentthreadid()
		thread_profiler = thread_profilers.threadProfilers + thread_index
		if thread_profiler.threadId == thread_id {
			continue
			
		}
		thread_handle = thread_profiler.threadHandle
		if rmtsuspendthread(thread_handle) == (RmtBool(0)) {
			continue
			
		}
		sample_time_us = ustimer_get(thread_profilers.timer)
		sample_count = atomicadds32(&thread_profiler.nbSamplesWithoutCallback, 1)
		processor_index = thread_profiler.processorIndex
		if processor_index != RmtU32(-1) {
			(if __builtin_expect(!(processor_index < nb_processors), 0){ __assert_rtn(, c'Remotery.c', 5989, c'processor_index < nb_processors') } else {return error('error message')})
			processors [processor_index] .threadProfiler = thread_profiler
			processors [processor_index] .sampleCount = sample_count
			processors [processor_index] .sampleTime = sample_time_us
		}
		if sample_count == 0 {
			if rmtgetusermodethreadcontext(thread_handle, &context) == (RmtBool(1)) && threadprofilers_threadincallback(thread_profilers, &context) == (RmtBool(0)) {
				rmtsetthreadcontext(thread_handle, &context)
			}
			else {
				atomicadds32(&thread_profiler.nbSamplesWithoutCallback, -1)
			}
		}
		if RmtError.rmt_error_none != checkforstallingsamples(&stalling_sample_tree, thread_profiler, sample_time_us) {
			(if __builtin_expect(!(stalling_sample_tree.allocator != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6037, c'stalling_sample_tree.allocator != NULL') } else {return error('error message')})
			if stalling_sample_tree.root != (voidptr(0)) {
				freesamples(stalling_sample_tree.root, stalling_sample_tree.allocator)
			}
		}
		rmtresumethread(thread_handle)
		if stalling_sample_tree.root != (voidptr(0)) {
			sample := stalling_sample_tree.root.first_child
			(if __builtin_expect(!(sample != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6052, c'sample != NULL') } else {return error('error message')})
			queuesampletree(thread_profilers.mqToRmtThread, sample, stalling_sample_tree.allocator, thread_profiler.threadName, 0, thread_profiler, (RmtBool(1)))
			stalling_sample_tree.root.first_child = (voidptr(0))
			stalling_sample_tree.root.last_child = (voidptr(0))
			stalling_sample_tree.root.nb_children = 0
			(if __builtin_expect(!(stalling_sample_tree.allocator != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6061, c'stalling_sample_tree.allocator != NULL') } else {return error('error message')})
			freesamples(stalling_sample_tree.root, stalling_sample_tree.allocator)
		}
		// while()
		if ! (lfsr_value != lfsr_seed ) { break }
		}
		for processor_index = 0 ; processor_index < nb_processors ; processor_index ++ {
			processor := processors + processor_index
			thread_profiler := processor.threadProfiler
			if thread_profiler != (voidptr(0)) {
				last_processor_index := thread_profiler.lastProcessorIndex
				if last_processor_index != RmtU32(-1) && last_processor_index != processor_index {
					(if __builtin_expect(!(last_processor_index < nb_processors), 0){ __assert_rtn(, c'Remotery.c', 6081, c'last_processor_index < nb_processors') } else {return error('error message')})
					if processors [last_processor_index] .threadProfiler == thread_profiler {
						processors [last_processor_index] .threadProfiler = (voidptr(0))
					}
				}
				else if processor.sampleCount > 1 {
					processor.threadProfiler = (voidptr(0))
				}
				thread_profiler.lastProcessorIndex = thread_profiler.processorIndex
			}
		}
		queueprocessorthreads(thread_profilers.mqToRmtThread, processor_message_index ++, nb_processors, processors)
	}
	if thread_profilers.threadGatherThread != (voidptr(0)) {
		rmtthread_destructor(thread_profilers.threadGatherThread)
		rmtfree(thread_profilers.threadGatherThread)
		thread_profilers.threadGatherThread = (voidptr(0))
	}
	0 /* null */
	rmtfree(processors)
	return RmtError.rmt_error_none
}

struct PropertySnapshot { 
	Link ObjectLink
	type_ RmtPropertyType
	value RmtPropertyValue
	prevValue RmtPropertyValue
	prevValueFrame RmtU32
	nameHash RmtU32
	uniqueID RmtU32
	depth RmtU8
	nbChildren RmtU32
	nextSnapshot &PropertySnapshot
}
struct Msg_PropertySnapshot { 
	rootSnapshot &PropertySnapshot
	nbSnapshots RmtU32
	propertyFrame RmtU32
}
[c:'PropertySnapshot_Constructor']
fn propertysnapshot_constructor(snapshot &PropertySnapshot) RmtError {
	(if __builtin_expect(!(snapshot != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6164, c'snapshot != NULL') } else {return error('error message')})
	objectlink_constructor(&ObjectLink(snapshot))
	snapshot.type_ = RmtPropertyType.rmt_propertytype_rmtbool
	snapshot.value.Bool = (RmtBool(0))
	snapshot.nameHash = 0
	snapshot.uniqueID = 0
	snapshot.nbChildren = 0
	snapshot.depth = 0
	snapshot.nextSnapshot = (voidptr(0))
	return RmtError.rmt_error_none
}

[c:'PropertySnapshot_Destructor']
fn propertysnapshot_destructor(snapshot &PropertySnapshot)  {
	void((if 1{ return error('error message') } else {(void(snapshot))}))
}

struct Remotery { 
	server &Server
	timer UsTimer
	mq_to_rmt_thread &RmtMessageQueue
	thread &RmtThread
	string_table &StringTable
	logfile &C.FILE
	map_message_queue_fn fn (&Remotery, &Message)
	map_message_queue_data voidptr
	threadProfilers &ThreadProfilers
	propertyMutex RmtMutex
	rootProperty RmtProperty
	propertyAllocator &ObjectAllocator
	propertyFrame RmtU32
	countThreads RmtAtomicS32
}
/*!*/[weak] __global ( g_Remotery  = &Remotery ((voidptr(0)))
)

/*!*/[weak] __global ( g_RemoteryCreated  = RmtBool ((RmtBool(0)))
)

[c:'rmtGetThreadNameFallback']
fn rmtgetthreadnamefallback(out_thread_name &i8, thread_name_size RmtU32)  {
	out_thread_name [0]  = 0
	strncat_s_safe_c(out_thread_name, thread_name_size, c'Thread', 6)
	itoahex_s(out_thread_name + 6, thread_name_size - 6, atomicadds32(&g_Remotery.countThreads, 1))
}

fn saturate(v f64) f64 {
	if v < 0 {
		return 0
	}
	if v > 1 {
		return 1
	}
	return v
}

[c:'PostProcessSamples']
fn postprocesssamples(sample &Sample, nb_samples &RmtU32)  {
	child := &Sample(0)
	(if __builtin_expect(!(sample != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6276, c'sample != NULL') } else {return error('error message')})
	(if __builtin_expect(!(nb_samples != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6277, c'nb_samples != NULL') } else {return error('error message')})
	(*nb_samples) ++
	{
		h := f64(sample.name_hash) / f64(4294967295)
		r := saturate(fabs(fmod(h * 6 + 0, 6) - 3) - 1)
		g := saturate(fabs(fmod(h * 6 + 4, 6) - 3) - 1)
		b := saturate(fabs(fmod(h * 6 + 2, 6) - 3) - 1)
		r = r * r * (3 - 2 * r)
		g = g * g * (3 - 2 * g)
		b = b * b * (3 - 2 * b)
		k := 0.40000000000000002
		r = r * k + (1 - k)
		g = g * k + (1 - k)
		b = b * k + (1 - k)
		sample.uniqueColour [0]  = RmtU8(maxs32(mins32(RmtS32((r * 255)), 255), 0))
		sample.uniqueColour [1]  = RmtU8(maxs32(mins32(RmtS32((g * 255)), 255), 0))
		sample.uniqueColour [2]  = RmtU8(maxs32(mins32(RmtS32((b * 255)), 255), 0))
	}
	for child = sample.first_child ; child != (voidptr(0)) ; child = child.next_sibling {
		postprocesssamples(child, nb_samples)
	}
}

[c:'Remotery_SendLogTextMessage']
fn remotery_sendlogtextmessage(rmt &Remotery, message &Message) RmtError {
	bin_buf := &Buffer(0)
	write_start_offset := RmtU32{}
	(if __builtin_expect(!(rmt != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6323, c'rmt != NULL') } else {return error('error message')})
	(if __builtin_expect(!(message != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6324, c'message != NULL') } else {return error('error message')})
	bin_buf = rmt.server.bin_buf
	websocket_preparebuffer(bin_buf)
	{
		error := bin_messageheader(bin_buf, c'LOGM', &write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_write(bin_buf, message.payload, message.payload_size)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := bin_messagefooter(bin_buf, write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	if rmt.logfile != (voidptr(0)) {
		rmtwritefile(rmt.logfile, bin_buf.data + 10, bin_buf.bytes_used - 10)
	}
	if server_isclientconnected(rmt.server) == (RmtBool(1)) {
		{
			error := server_send(rmt.server, bin_buf.data, bin_buf.bytes_used, 20)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
	}
	return RmtError.rmt_error_none
}

[c:'bin_SampleName']
fn bin_samplename(buffer &Buffer, name &i8, name_hash RmtU32, name_length RmtU32) RmtError {
	write_start_offset := RmtU32{}
	{
		error := bin_messageheader(buffer, c'SSMP', &write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(buffer, name_hash)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(buffer, name_length)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_write(buffer, voidptr(name), name_length)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := bin_messagefooter(buffer, write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'Remotery_AddToStringTable']
fn remotery_addtostringtable(rmt &Remotery, message &Message) RmtError {
	payload := &Msg_AddToStringTable(message.payload)
	name := &i8((payload + 1))
	name_inserted := stringtable_insert(rmt.string_table, payload.hash, name)
	if name_inserted == (RmtBool(1)) && rmt.logfile != (voidptr(0)) {
		bin_buf := rmt.server.bin_buf
		bin_buf.bytes_used = 0
		{
			error := bin_samplename(bin_buf, name, payload.hash, payload.length)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		rmtwritefile(rmt.logfile, bin_buf.data, bin_buf.bytes_used)
	}
	return RmtError.rmt_error_none
}

[c:'bin_SampleTree']
fn bin_sampletree(buffer &Buffer, msg &Msg_SampleTree) RmtError {
	root_sample := &Sample(0)
	thread_name := [256]i8{}
	nb_samples := 0
	write_start_offset := 0
	(if __builtin_expect(!(buffer != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6383, c'buffer != NULL') } else {return error('error message')})
	(if __builtin_expect(!(msg != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6384, c'msg != NULL') } else {return error('error message')})
	root_sample = msg.rootSample
	(if __builtin_expect(!(root_sample != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6388, c'root_sample != NULL') } else {return error('error message')})
	thread_name [0]  = 0
	strncat_s_safe_c(thread_name, sizeof(thread_name), msg.threadName, strnlen_s_safe_c(msg.threadName, 255))
	if root_sample.type_ == RmtSampleType.rmt_sampletype_cuda {
		strncat_s_safe_c(thread_name, sizeof(thread_name), c' (CUDA)', 7)
	}
	if root_sample.type_ == RmtSampleType.rmt_sampletype_d3d11 {
		strncat_s_safe_c(thread_name, sizeof(thread_name), c' (D3D11)', 8)
	}
	if root_sample.type_ == RmtSampleType.rmt_sampletype_d3d12 {
		strncat_s_safe_c(thread_name, sizeof(thread_name), c' (D3D12)', 8)
	}
	if root_sample.type_ == RmtSampleType.rmt_sampletype_opengl {
		strncat_s_safe_c(thread_name, sizeof(thread_name), c' (OpenGL)', 9)
	}
	if root_sample.type_ == RmtSampleType.rmt_sampletype_metal {
		strncat_s_safe_c(thread_name, sizeof(thread_name), c' (Metal)', 8)
	}
	postprocesssamples(root_sample, &nb_samples)
	{
		error := bin_messageheader(buffer, c'SMPL', &write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writestringwithlength(buffer, thread_name)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(buffer, nb_samples)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(buffer, if msg.partialTree{ 1 } else {0})
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_alignedpad(buffer, write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := bin_sample(buffer, root_sample, 0)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := bin_messagefooter(buffer, write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'Remotery_SendToViewerAndLog']
fn remotery_sendtoviewerandlog(rmt &Remotery, bin_buf &Buffer, timeout RmtU32) RmtError {
	error := RmtError.rmt_error_none
	if server_isclientconnected(rmt.server) == (RmtBool(1)) {
		{
			rmt_sample_hash_server_send := 0
			_rmt_begincpusample(c'Server_Send', RmtSampleFlags.rmtsf_aggregate, &rmt_sample_hash_server_send)
		}
		0 /* null */
		error = server_send(rmt.server, bin_buf.data, bin_buf.bytes_used, timeout)
		_rmt_endcpusample()
	}
	if rmt.logfile != (voidptr(0)) {
		rmtwritefile(rmt.logfile, bin_buf.data + 10, bin_buf.bytes_used - 10)
	}
	return error
}

[c:'Remotery_SendSampleTreeMessage']
fn remotery_sendsampletreemessage(rmt &Remotery, message &Message) RmtError {
	error := RmtError.rmt_error_none
	sample_tree := &Msg_SampleTree(0)
	sample := &Sample(0)
	bin_buf := &Buffer(0)
	(if __builtin_expect(!(rmt != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6467, c'rmt != NULL') } else {return error('error message')})
	(if __builtin_expect(!(message != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6468, c'message != NULL') } else {return error('error message')})
	sample_tree = &Msg_SampleTree(message.payload)
	sample = sample_tree.rootSample
	(if __builtin_expect(!(sample != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6473, c'sample != NULL') } else {return error('error message')})
	bin_buf = rmt.server.bin_buf
	websocket_preparebuffer(bin_buf)
	{
		rmt_sample_hash_bin_sampletree := 0
		_rmt_begincpusample(c'bin_SampleTree', RmtSampleFlags.rmtsf_aggregate, &rmt_sample_hash_bin_sampletree)
	}
	0 /* null */
	error = bin_sampletree(bin_buf, sample_tree)
	_rmt_endcpusample()
	if g_Settings.sampletree_handler != (voidptr(0)) {
		g_Settings.sampletree_handler(g_Settings.sampletree_context, sample_tree)
	}
	freesamples(sample, sample_tree.allocator)
	if error != RmtError.rmt_error_none {
		return error
	}
	return remotery_sendtoviewerandlog(rmt, bin_buf, 50000)
}

[c:'Remotery_SendProcessorThreads']
fn remotery_sendprocessorthreads(rmt &Remotery, message &Message) RmtError {
	processor_index := RmtU32{}
	processor_threads := &Msg_ProcessorThreads(message.payload)
	bin_buf := &Buffer(0)
	write_start_offset := RmtU32{}
	bin_buf = rmt.server.bin_buf
	websocket_preparebuffer(bin_buf)
	{
		error := bin_messageheader(bin_buf, c'PRTH', &write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(bin_buf, processor_threads.nbProcessors)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu64(bin_buf, processor_threads.messageIndex)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	for processor_index = 0 ; processor_index < processor_threads.nbProcessors ; processor_index ++ {
		processor := processor_threads.processors + processor_index
		if processor.threadProfiler != (voidptr(0)) {
			{
				error := buffer_writeu32(bin_buf, processor.threadProfiler.threadId)
				if error != RmtError.rmt_error_none {
				return error
				}
			}
			0 /* null */
			{
				error := buffer_writeu32(bin_buf, processor.threadProfiler.threadNameHash)
				if error != RmtError.rmt_error_none {
				return error
				}
			}
			0 /* null */
			{
				error := buffer_writeu64(bin_buf, processor.sampleTime)
				if error != RmtError.rmt_error_none {
				return error
				}
			}
			0 /* null */
		}
		else {
			{
				error := buffer_writeu32(bin_buf, RmtU32(-1))
				if error != RmtError.rmt_error_none {
				return error
				}
			}
			0 /* null */
			{
				error := buffer_writeu32(bin_buf, 0)
				if error != RmtError.rmt_error_none {
				return error
				}
			}
			0 /* null */
			{
				error := buffer_writeu64(bin_buf, 0)
				if error != RmtError.rmt_error_none {
				return error
				}
			}
			0 /* null */
		}
	}
	{
		error := bin_messagefooter(bin_buf, write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return remotery_sendtoviewerandlog(rmt, bin_buf, 50)
}

[c:'FreePropertySnapshots']
fn freepropertysnapshots(snapshot &PropertySnapshot)  {
	if snapshot == (voidptr(0)) {
		return 
	}
	if snapshot.nextSnapshot != (voidptr(0)) {
		freepropertysnapshots(snapshot.nextSnapshot)
	}
	objectallocator_free(g_Remotery.propertyAllocator, snapshot)
}

[c:'Remotery_SerialisePropertySnapshots']
fn remotery_serialisepropertysnapshots(bin_buf &Buffer, msg_snapshot &Msg_PropertySnapshot) RmtError {
	snapshot := &PropertySnapshot(0)
	empty_group := [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]!
	
	write_start_offset := RmtU32{}
	{
		error := bin_messageheader(bin_buf, c'PSNP', &write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(bin_buf, msg_snapshot.nbSnapshots)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	{
		error := buffer_writeu32(bin_buf, msg_snapshot.propertyFrame)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	for snapshot = msg_snapshot.rootSnapshot ; snapshot != (voidptr(0)) ; snapshot = snapshot.nextSnapshot {
		colour_depth := [0, 0, 0]!
		
		{
			error := buffer_writeu32(bin_buf, snapshot.nameHash)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		{
			error := buffer_writeu32(bin_buf, snapshot.uniqueID)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		colour_depth [3]  = snapshot.depth
		{
			error := buffer_write(bin_buf, colour_depth, 4)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		{
			error := buffer_writeu32(bin_buf, snapshot.type_)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		match snapshot.type_ {
		 .rmt_propertytype_rmtgroup// case comp stmt
			error := buffer_write(bin_buf, empty_group, 16)
			if error != .rmt_error_none {
			return error
			}
		}
		0 /* null */
		
		}
		 .rmt_propertytype_rmtbool// case comp stmt
			error := buffer_writef64(bin_buf, snapshot.value.Bool)
			if error != .rmt_error_none {
			return error
			}
		}
		0 /* null */
		{
			error := buffer_writef64(bin_buf, snapshot.prevValue.Bool)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		
		}
		 .rmt_propertytype_rmts32// case comp stmt
			error := buffer_writef64(bin_buf, snapshot.value.S32)
			if error != .rmt_error_none {
			return error
			}
		}
		0 /* null */
		{
			error := buffer_writef64(bin_buf, snapshot.prevValue.S32)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		
		}
		 .rmt_propertytype_rmtu32// case comp stmt
			error := buffer_writef64(bin_buf, snapshot.value.U32)
			if error != .rmt_error_none {
			return error
			}
		}
		0 /* null */
		{
			error := buffer_writef64(bin_buf, snapshot.prevValue.U32)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		
		}
		 .rmt_propertytype_rmtf32// case comp stmt
			error := buffer_writef64(bin_buf, snapshot.value.F32)
			if error != .rmt_error_none {
			return error
			}
		}
		0 /* null */
		{
			error := buffer_writef64(bin_buf, snapshot.prevValue.F32)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		
		}
		 .rmt_propertytype_rmts64, .rmt_propertytype_rmtu64{
		{
			error := buffer_writeu64(bin_buf, snapshot.value.U64)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		{
			error := buffer_writeu64(bin_buf, snapshot.prevValue.U64)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		
		}
		 .rmt_propertytype_rmtf64// case comp stmt
			error := buffer_writef64(bin_buf, snapshot.value.F64)
			if error != .rmt_error_none {
			return error
			}
		}
		0 /* null */
		{
			error := buffer_writef64(bin_buf, snapshot.prevValue.F64)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		
		}
		else{}
		}
		{
			error := buffer_writeu32(bin_buf, snapshot.prevValueFrame)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
		{
			error := buffer_writeu32(bin_buf, snapshot.nbChildren)
			if error != RmtError.rmt_error_none {
			return error
			}
		}
		0 /* null */
	}
	{
		error := bin_messagefooter(bin_buf, write_start_offset)
		if error != RmtError.rmt_error_none {
		return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'Remotery_SendPropertySnapshot']
fn remotery_sendpropertysnapshot(rmt &Remotery, message &Message) RmtError {
	msg_snapshot := &Msg_PropertySnapshot(message.payload)
	error := RmtError.rmt_error_none
	bin_buf := &Buffer(0)
	bin_buf = rmt.server.bin_buf
	websocket_preparebuffer(bin_buf)
	error = remotery_serialisepropertysnapshots(bin_buf, msg_snapshot)
	if error == RmtError.rmt_error_none {
		error = remotery_sendtoviewerandlog(rmt, bin_buf, 50)
	}
	freepropertysnapshots(msg_snapshot.rootSnapshot)
	return error
}

[c:'Remotery_ConsumeMessageQueue']
fn remotery_consumemessagequeue(rmt &Remotery) RmtError {
	nb_messages_sent := 0
	maxnbmessagesperupdate := g_Settings.maxNbMessagesPerUpdate
	(if __builtin_expect(!(rmt != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6681, c'rmt != NULL') } else {return error('error message')})
	for nb_messages_sent < maxnbmessagesperupdate {
		error := RmtError.rmt_error_none
		message := rmtmessagequeue_peeknextmessage(rmt.mq_to_rmt_thread)
		if message == (voidptr(0)) {
		break
		
		}
		match message.id {
		 .msgid_notready// case comp body kind=ParenExpr is_enum=true 
		{
		(if __builtin_expect(!((RmtBool(0))), 0){ __assert_rtn(, c'Remotery.c', 6696, c'RMT_FALSE') } else {return error('error message')})
		
		}
		 .msgid_addtostringtable// case comp body kind=BinaryOperator is_enum=true 
		{
		error = remotery_addtostringtable(rmt, message)
		
		}
		 .msgid_logtext// case comp body kind=BinaryOperator is_enum=true 
		{
		error = remotery_sendlogtextmessage(rmt, message)
		nb_messages_sent ++
		
		}
		 .msgid_sampletree// case comp stmt
			rmt_sample_hash_sendsampletreemessage := 0
			_rmt_begincpusample(c'SendSampleTreeMessage', .rmtsf_aggregate, &rmt_sample_hash_sendsampletreemessage)
		}
		0 /* null */
		error = remotery_sendsampletreemessage(rmt, message)
		nb_messages_sent ++
		_rmt_endcpusample()
		
		}
		 .msgid_processorthreads// case comp body kind=CallExpr is_enum=true 
		{
		remotery_sendprocessorthreads(rmt, message)
		nb_messages_sent ++
		
		}
		 .msgid_propertysnapshot// case comp body kind=BinaryOperator is_enum=true 
		{
		error = remotery_sendpropertysnapshot(rmt, message)
		
		}
		else {
		
		}
		}
		rmtmessagequeue_consumenextmessage(rmt.mq_to_rmt_thread, message)
		if error != RmtError.rmt_error_none {
			return error
		}
	}
	return RmtError.rmt_error_none
}

[c:'Remotery_FlushMessageQueue']
fn remotery_flushmessagequeue(rmt &Remotery)  {
	(if __builtin_expect(!(rmt != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6738, c'rmt != NULL') } else {return error('error message')})
	for  ;  ;  {
		message := rmtmessagequeue_peeknextmessage(rmt.mq_to_rmt_thread)
		if message == (voidptr(0)) {
		break
		
		}
		match message.id {
		 .msgid_notready, .msgid_addtostringtable, .msgid_logtext{
		
		}
		 .msgid_sampletree// case comp stmt
			sample_tree := &Msg_SampleTree(message.payload)
			freesamples(sample_tree.rootSample, sample_tree.allocator)
			
		}
		}
		 .msgid_propertysnapshot// case comp stmt
			msg_snapshot := &Msg_PropertySnapshot(message.payload)
			freepropertysnapshots(msg_snapshot.rootSnapshot)
			
		}
		}
		else {
		
		}
		}
		rmtmessagequeue_consumenextmessage(rmt.mq_to_rmt_thread, message)
	}
}

[c:'Remotery_MapMessageQueue']
fn remotery_mapmessagequeue(rmt &Remotery)  {
	read_pos := RmtU32{}
	write_pos := RmtU32{}
	
	queue := &RmtMessageQueue(0)
	(if __builtin_expect(!(rmt != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6781, c'rmt != NULL') } else {return error('error message')})
	for loadacquirepointer(&&int(&rmt.map_message_queue_data)) == (voidptr(0)) {
	mssleep(1)
	}
	queue = rmt.mq_to_rmt_thread
	write_pos = loadacquire(&queue.write_pos)
	read_pos = queue.read_pos
	for read_pos < write_pos {
		r := read_pos & (queue.size - 1)
		message := &Message((queue.data.ptr + r))
		message_size := rmtmessagequeue_sizeforpayload(message.payload_size)
		rmt.map_message_queue_fn(rmt, message)
		read_pos += message_size
	}
	storereleasepointer(&&int(&rmt.map_message_queue_data), (voidptr(0)))
}

[c:'Remotery_ThreadMain']
fn remotery_threadmain(thread &RmtThread) RmtError {
	rmt := &Remotery(thread.param)
	(if __builtin_expect(!(rmt != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6809, c'rmt != NULL') } else {return error('error message')})
	_rmt_setcurrentthreadname(c'Remotery')
	for thread.request_exit == (RmtBool(0)) {
		{
			rmt_sample_hash_wakeup := 0
			_rmt_begincpusample(c'Wakeup', 0, &rmt_sample_hash_wakeup)
		}
		0 /* null */
		{
			rmt_sample_hash_serverupdate := 0
			_rmt_begincpusample(c'ServerUpdate', 0, &rmt_sample_hash_serverupdate)
		}
		0 /* null */
		server_update(rmt.server)
		_rmt_endcpusample()
		{
			rmt_sample_hash_consumemessagequeue := 0
			_rmt_begincpusample(c'ConsumeMessageQueue', 0, &rmt_sample_hash_consumemessagequeue)
		}
		0 /* null */
		remotery_consumemessagequeue(rmt)
		_rmt_endcpusample()
		_rmt_endcpusample()
		if loadacquirepointer(&&int(&rmt.map_message_queue_fn)) != (voidptr(0)) {
			remotery_mapmessagequeue(rmt)
			storereleasepointer(&&int(&rmt.map_message_queue_fn), (voidptr(0)))
		}
		mssleep(g_Settings.msSleepBetweenServerUpdates)
	}
	remotery_flushmessagequeue(rmt)
	return RmtError.rmt_error_none
}

[c:'Remotery_ReceiveMessage']
fn remotery_receivemessage(context voidptr, message_data &i8, message_length RmtU32) RmtError {
	rmt := &Remotery(context)
	message_id := *&RmtU32(message_data)
	match message_id {
	 RmtU32((((`I`) << 24) | ((`N`) << 16) | ((`O`) << 8) | (`C`)))// case comp stmt
		_rmt_logtext(c'Console message received...')
		_rmt_logtext(message_data + 4)
		if g_Settings.input_handler != (voidptr(0)) {
		g_Settings.input_handler(message_data + 4, g_Settings.input_handler_context)
		}
		
	}
	}
	 RmtU32((((`P`) << 24) | ((`M`) << 16) | ((`S`) << 8) | (`G`)))// case comp stmt
		name := RmtPStr{}
		name_hash := 0
		cur := message_data + 4
		end := cur + message_length - 4
		for cur < end {
		name_hash = name_hash * 10 + *cur ++ - `0`
		}
		name = stringtable_find(rmt.string_table, name_hash)
		if name != (voidptr(0)) {
			name_length := RmtU32(strnlen_s_safe_c(name, 256 - 12))
			bin_buf := rmt.server.bin_buf
			websocket_preparebuffer(bin_buf)
			bin_samplename(bin_buf, name, name_hash, name_length)
			return server_send(rmt.server, bin_buf.data, bin_buf.bytes_used, 10)
		}
		
	}
	}
	else{}
	}
	return RmtError.rmt_error_none
}

[c:'Remotery_Constructor']
fn remotery_constructor(rmt &Remotery) RmtError {
	(if __builtin_expect(!(rmt != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 6911, c'rmt != NULL') } else {return error('error message')})
	rmt.server = (voidptr(0))
	rmt.mq_to_rmt_thread = (voidptr(0))
	rmt.thread = (voidptr(0))
	rmt.string_table = (voidptr(0))
	rmt.logfile = (voidptr(0))
	rmt.map_message_queue_fn = (voidptr(0))
	rmt.map_message_queue_data = (voidptr(0))
	rmt.threadProfilers = (voidptr(0))
	mtxinit(&rmt.propertyMutex)
	rmt.propertyAllocator = (voidptr(0))
	rmt.propertyFrame = 0
	root_property := &rmt.rootProperty
	root_property.initialised = (RmtBool(1))
	root_property.type_ = RmtPropertyType.rmt_propertytype_rmtgroup
	root_property.value.Bool = (RmtBool(0))
	root_property.flags = RmtPropertyFlags.rmt_propertyflags_noflags
	root_property.name = c'Root Property'
	root_property.description = c''
	root_property.defaultValue.Bool = (RmtBool(0))
	root_property.parent = (voidptr(0))
	root_property.firstChild = (voidptr(0))
	root_property.lastChild = (voidptr(0))
	root_property.nextSibling = (voidptr(0))
	root_property.nameHash = 0
	root_property.uniqueID = 0
	ustimer_init(&rmt.timer)
	{
		rmt.server = &Server(rmtmalloc(sizeof(Server)))
		if rmt.server == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := server_constructor(rmt.server, g_Settings.port, g_Settings.reuse_open_port, g_Settings.limit_connections_to_localhost)
		if error != RmtError.rmt_error_none {
			if rmt.server != (voidptr(0)) {
				server_destructor(rmt.server)
				rmtfree(rmt.server)
				rmt.server = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	rmt.server.receive_handler = remotery_receivemessage
	rmt.server.receive_handler_context = rmt
	{
		rmt.mq_to_rmt_thread = &RmtMessageQueue(rmtmalloc(sizeof(RmtMessageQueue)))
		if rmt.mq_to_rmt_thread == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := rmtmessagequeue_constructor(rmt.mq_to_rmt_thread, g_Settings.messageQueueSizeInBytes)
		if error != RmtError.rmt_error_none {
			if rmt.mq_to_rmt_thread != (voidptr(0)) {
				rmtmessagequeue_destructor(rmt.mq_to_rmt_thread)
				rmtfree(rmt.mq_to_rmt_thread)
				rmt.mq_to_rmt_thread = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	{
		rmt.string_table = &StringTable(rmtmalloc(sizeof(StringTable)))
		if rmt.string_table == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := stringtable_constructor(rmt.string_table)
		if error != RmtError.rmt_error_none {
			if rmt.string_table != (voidptr(0)) {
				stringtable_destructor(rmt.string_table)
				rmtfree(rmt.string_table)
				rmt.string_table = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	if g_Settings.logPath != (voidptr(0)) {
		now_tm := timedatenow()
		filename := [0]!
		
		strncat_s_safe_c(filename, sizeof(filename), g_Settings.logPath, 512)
		strncat_s_safe_c(filename, sizeof(filename), c'/remotery-log-', 14)
		strncat_s_safe_c(filename, sizeof(filename), itoa_s(now_tm.tm_year + 1900), 11)
		strncat_s_safe_c(filename, sizeof(filename), c'-', 1)
		strncat_s_safe_c(filename, sizeof(filename), itoa_s(now_tm.tm_mon + 1), 11)
		strncat_s_safe_c(filename, sizeof(filename), c'-', 1)
		strncat_s_safe_c(filename, sizeof(filename), itoa_s(now_tm.tm_mday), 11)
		strncat_s_safe_c(filename, sizeof(filename), c'-', 1)
		strncat_s_safe_c(filename, sizeof(filename), itoa_s(now_tm.tm_hour), 11)
		strncat_s_safe_c(filename, sizeof(filename), c'-', 1)
		strncat_s_safe_c(filename, sizeof(filename), itoa_s(now_tm.tm_min), 11)
		strncat_s_safe_c(filename, sizeof(filename), c'-', 1)
		strncat_s_safe_c(filename, sizeof(filename), itoa_s(now_tm.tm_sec), 11)
		strncat_s_safe_c(filename, sizeof(filename), c'.rbin', 5)
		rmt.logfile = rmtopenfile(filename, c'w')
		if rmt.logfile != (voidptr(0)) {
			rmtwritefile(rmt.logfile, c'RMTBLOGF', 8)
		}
	}
	{
		rmt.threadProfilers = &ThreadProfilers(rmtmalloc(sizeof(ThreadProfilers)))
		if rmt.threadProfilers == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := threadprofilers_constructor(rmt.threadProfilers, &rmt.timer, rmt.mq_to_rmt_thread)
		if error != RmtError.rmt_error_none {
			if rmt.threadProfilers != (voidptr(0)) {
				threadprofilers_destructor(rmt.threadProfilers)
				rmtfree(rmt.threadProfilers)
				rmt.threadProfilers = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	{
		rmt.propertyAllocator = &ObjectAllocator(rmtmalloc(sizeof(ObjectAllocator)))
		if rmt.propertyAllocator == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := objectallocator_constructor(rmt.propertyAllocator, sizeof(PropertySnapshot), ObjConstructor(propertysnapshot_constructor), ObjDestructor(propertysnapshot_destructor))
		if error != RmtError.rmt_error_none {
			if rmt.propertyAllocator != (voidptr(0)) {
				objectallocator_destructor(rmt.propertyAllocator)
				rmtfree(rmt.propertyAllocator)
				rmt.propertyAllocator = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	(if __builtin_expect(!(g_Remotery == (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 7031, c'g_Remotery == NULL') } else {return error('error message')})
	g_Remotery = rmt
	g_RemoteryCreated = (RmtBool(1))
	g_Remotery.countThreads = 0
	compilerwritefence()
	{
		rmt.thread = &RmtThread(rmtmalloc(sizeof(RmtThread)))
		if rmt.thread == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := rmtthread_constructor(rmt.thread, remotery_threadmain, rmt)
		if error != RmtError.rmt_error_none {
			if rmt.thread != (voidptr(0)) {
				rmtthread_destructor(rmt.thread)
				rmtfree(rmt.thread)
				rmt.thread = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'Remotery_Destructor']
fn remotery_destructor(rmt &Remotery)  {
	(if __builtin_expect(!(rmt != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 7047, c'rmt != NULL') } else {return error('error message')})
	if rmt.thread != (voidptr(0)) {
		rmtthread_destructor(rmt.thread)
		rmtfree(rmt.thread)
		rmt.thread = (voidptr(0))
	}
	0 /* null */
	if g_RemoteryCreated {
		g_Remotery = (voidptr(0))
		g_RemoteryCreated = (RmtBool(0))
	}
	if rmt.propertyAllocator != (voidptr(0)) {
		objectallocator_destructor(rmt.propertyAllocator)
		rmtfree(rmt.propertyAllocator)
		rmt.propertyAllocator = (voidptr(0))
	}
	0 /* null */
	if rmt.threadProfilers != (voidptr(0)) {
		threadprofilers_destructor(rmt.threadProfilers)
		rmtfree(rmt.threadProfilers)
		rmt.threadProfilers = (voidptr(0))
	}
	0 /* null */
	rmtclosefile(rmt.logfile)
	if rmt.string_table != (voidptr(0)) {
		stringtable_destructor(rmt.string_table)
		rmtfree(rmt.string_table)
		rmt.string_table = (voidptr(0))
	}
	0 /* null */
	if rmt.mq_to_rmt_thread != (voidptr(0)) {
		rmtmessagequeue_destructor(rmt.mq_to_rmt_thread)
		rmtfree(rmt.mq_to_rmt_thread)
		rmt.mq_to_rmt_thread = (voidptr(0))
	}
	0 /* null */
	if rmt.server != (voidptr(0)) {
		server_destructor(rmt.server)
		rmtfree(rmt.server)
		rmt.server = (voidptr(0))
	}
	0 /* null */
	if g_lastErrorMessageTlsHandle != 4294967295 {
		tlsfree(g_lastErrorMessageTlsHandle)
		g_lastErrorMessageTlsHandle = 4294967295
	}
	mtxdelete(&rmt.propertyMutex)
}

[c:'CRTMalloc']
fn crtmalloc(mm_context voidptr, size RmtU32) voidptr {
	void((if 1{ return error('error message') } else {(void(mm_context))}))
	return C.malloc(usize(size))
}

[c:'CRTFree']
fn crtfree(mm_context voidptr, ptr voidptr)  {
	void((if 1{ return error('error message') } else {(void(mm_context))}))
	C.free(ptr)
}

[c:'CRTRealloc']
fn crtrealloc(mm_context voidptr, ptr voidptr, size RmtU32) voidptr {
	void((if 1{ return error('error message') } else {(void(mm_context))}))
	return realloc(ptr, size)
}

[c:'_rmt_Settings']
fn _rmt_settings() &RmtSettings {
	if g_SettingsInitialized == (RmtBool(0)) {
		g_Settings.port = 17815
		g_Settings.reuse_open_port = (RmtBool(0))
		g_Settings.limit_connections_to_localhost = (RmtBool(0))
		g_Settings.enableThreadSampler = (RmtBool(1))
		g_Settings.msSleepBetweenServerUpdates = 4
		g_Settings.messageQueueSizeInBytes = 1024 * 1024
		g_Settings.maxNbMessagesPerUpdate = 1000
		g_Settings.C.malloc = crtmalloc
		g_Settings.C.free = crtfree
		g_Settings.realloc = crtrealloc
		g_Settings.input_handler = (voidptr(0))
		g_Settings.input_handler_context = (voidptr(0))
		g_Settings.logPath = (voidptr(0))
		g_Settings.sampletree_handler = (voidptr(0))
		g_Settings.sampletree_context = (voidptr(0))
		g_Settings.snapshot_callback = (voidptr(0))
		g_Settings.snapshot_context = (voidptr(0))
		g_SettingsInitialized = (RmtBool(1))
	}
	return &g_Settings
}

[c:'_rmt_CreateGlobalInstance']
fn _rmt_createglobalinstance(remotery &&Remotery) RmtError {
	(if __builtin_expect(!(sizeof(MessageID) == sizeof(RmtU32)), 0){ __assert_rtn(, c'Remotery.c', 7147, c'sizeof(MessageID) == sizeof(rmtU32)') } else {return error('error message')})
	_rmt_settings()
	(if __builtin_expect(!(remotery != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 7153, c'remotery != NULL') } else {return error('error message')})
	{
		*remotery = &Remotery(rmtmalloc(sizeof(Remotery)))
		if *remotery == (voidptr(0)) {
			return RmtError.rmt_error_malloc_fail
		}
		error := remotery_constructor(*remotery)
		if error != RmtError.rmt_error_none {
			if *remotery != (voidptr(0)) {
				remotery_destructor(*remotery)
				rmtfree(*remotery)
				*remotery = (voidptr(0))
			}
			0 /* null */
			return error
		}
	}
	0 /* null */
	return RmtError.rmt_error_none
}

[c:'_rmt_DestroyGlobalInstance']
fn _rmt_destroyglobalinstance(remotery &Remotery)  {
	(if __builtin_expect(!(g_RemoteryCreated == (RmtBool(1))), 0){ __assert_rtn(, c'Remotery.c', 7161, c'g_RemoteryCreated == RMT_TRUE') } else {return error('error message')})
	(if __builtin_expect(!(g_Remotery == remotery), 0){ __assert_rtn(, c'Remotery.c', 7162, c'g_Remotery == remotery') } else {return error('error message')})
	if remotery != (voidptr(0)) {
		remotery_destructor(remotery)
		rmtfree(remotery)
		remotery = (voidptr(0))
	}
	0 /* null */
}

[c:'_rmt_SetGlobalInstance']
fn _rmt_setglobalinstance(remotery &Remotery)  {
	_rmt_settings()
	g_Remotery = remotery
}

[c:'_rmt_GetGlobalInstance']
fn _rmt_getglobalinstance() &Remotery {
	return g_Remotery
}

[c:'MakeWideString']
fn makewidestring(string_ &i8) &wchar_t {
	wlen := usize(0)
	wstr := &wchar_t(0)
	wlen = mbstowcs((voidptr(0)), string_, 256)
	wstr = &wchar_t((rmtmalloc((wlen + 1) * sizeof(wchar_t))))
	if wstr == (voidptr(0)) {
		return (voidptr(0))
	}
	if mbstowcs(wstr, string_, wlen + 1) != wlen {
		rmtfree(wstr)
		return (voidptr(0))
	}
	return wstr
}

[c:'SetDebuggerThreadName']
fn setdebuggerthreadname(name &i8)  {
	void((if 1{ return error('error message') } else {(void(name))}))
}

[c:'_rmt_SetCurrentThreadName']
fn _rmt_setcurrentthreadname(thread_name RmtPStr)  {
	thread_profiler := &ThreadProfiler(0)
	name_length := RmtU32{}
	if g_Remotery == (voidptr(0)) {
		return 
	}
	if threadprofilers_getcurrentthreadprofiler(g_Remotery.threadProfilers, &thread_profiler) != RmtError.rmt_error_none {
		return 
	}
	strcpy_s_safe_c(thread_profiler.threadName, sizeof(thread_profiler.threadName), thread_name)
	thread_profiler.threadNameHash = _rmt_hashstring32(thread_name, strnlen_s_safe_c(thread_name, 64), 0)
	setdebuggerthreadname(thread_name)
}

[c:'QueueLine']
fn queueline(queue &RmtMessageQueue, text &u8, size RmtU32, thread_profiler &ThreadProfiler) RmtBool {
	message := &Message(0)
	text_size := RmtU32{}
	(if __builtin_expect(!(queue != (voidptr(0))), 0){ __assert_rtn(, c'Remotery.c', 7317, c'queue != NULL') } else {return error('error message')})
	text_size = size - 4
	u32tobytearray(text, text_size)
	message = rmtmessagequeue_allocmessage(queue, size, thread_profiler)
	if message == (voidptr(0)) {
	return (RmtBool(0))
	}
	C.memcpy(message.payload, text, size)
	rmtmessagequeue_commitmessage(message, MessageID.msgid_logtext)
	return (RmtBool(1))
}

[c:'_rmt_LogText']
fn _rmt_logtext(text RmtPStr)  {
	start_offset := 0
	offset := 0
	i := 0
	
	line_buffer := [0]!
	
	thread_profiler := &ThreadProfiler(0)
	if g_Remotery == (voidptr(0)) {
	return 
	}
	if threadprofilers_getcurrentthreadprofiler(g_Remotery.threadProfilers, &thread_profiler) != RmtError.rmt_error_none {
		return 
	}
	line_buffer [0]  = ` `
	line_buffer [1]  = ` `
	line_buffer [2]  = ` `
	line_buffer [3]  = ` `
	start_offset = 4
	offset = start_offset
	for i = 0 ; text [i]  != 0 ; i ++ {
		c := text [i] 
		if offset == sizeof(line_buffer) - 1 || c == `
` {
			if queueline(g_Remotery.mq_to_rmt_thread, line_buffer, offset, thread_profiler) == (RmtBool(0)) {
			return 
			}
			offset = start_offset
			if c == `
` {
			continue
			
			}
		}
		line_buffer [offset ++]  = c
	}
	if offset > start_offset {
		(if __builtin_expect(!(offset < int(sizeof(line_buffer))), 0){ __assert_rtn(, c'Remotery.c', 7386, c'offset < (int)sizeof(line_buffer)') } else {return error('error message')})
		queueline(g_Remotery.mq_to_rmt_thread, line_buffer, offset, thread_profiler)
	}
}

[c:'_rmt_BeginCPUSample']
fn _rmt_begincpusample(name RmtPStr, flags RmtU32, hash_cache &RmtU32)  {
	thread_profiler := &ThreadProfiler(0)
	if g_Remotery == (voidptr(0)) {
	return 
	}
	if threadprofilers_getcurrentthreadprofiler(g_Remotery.threadProfilers, &thread_profiler) == RmtError.rmt_error_none {
		sample := &Sample(0)
		name_hash := threadprofiler_getnamehash(thread_profiler, g_Remotery.mq_to_rmt_thread, name, hash_cache)
		if threadprofiler_push(thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)] , name_hash, flags, &sample) == RmtError.rmt_error_none {
			if sample.call_count > 1 {
			sample.us_end = ustimer_get(&g_Remotery.timer)
			}
			else { // 3
			sample.us_start = ustimer_get(&g_Remotery.timer)
}
		}
	}
}

[c:'_rmt_EndCPUSample']
fn _rmt_endcpusample()  {
	thread_profiler := &ThreadProfiler(0)
	if g_Remotery == (voidptr(0)) {
	return 
	}
	if threadprofilers_getcurrentthreadprofiler(g_Remotery.threadProfilers, &thread_profiler) == RmtError.rmt_error_none {
		sample := thread_profiler.sampleTrees [int(RmtSampleType.rmt_sampletype_cpu)] .currentParent
		if sample.recurse_depth > 0 {
			sample.recurse_depth --
		}
		else {
			us_end := ustimer_get(&g_Remotery.timer)
			sample_close(sample, us_end)
			threadprofiler_pop(thread_profiler, g_Remotery.mq_to_rmt_thread, sample, 0)
		}
	}
}

[c:'_rmt_MarkFrame']
fn _rmt_markframe() RmtError {
	if g_Remotery == (voidptr(0)) {
		return RmtError.rmt_error_remotery_not_created
	}
	return RmtError.rmt_error_none
}

[c:'_rmt_IterateChildren']
fn _rmt_iteratechildren(iterator &RmtSampleIterator, sample &RmtSample)  {
	iterator.sample = 0
	iterator.initial = if sample != (voidptr(0)){ sample.first_child } else {0}
}

[c:'_rmt_IterateNext']
fn _rmt_iteratenext(iter &RmtSampleIterator) RmtBool {
	if iter.initial != (voidptr(0)) {
		iter.sample = iter.initial
		iter.initial = 0
	}
	else {
		if iter.sample != (voidptr(0)) {
		iter.sample = iter.sample.next_sibling
		}
	}
	return if iter.sample != (voidptr(0)){ (RmtBool(1)) } else {(RmtBool(0))}
}

[c:'_rmt_SampleTreeGetThreadName']
fn _rmt_sampletreegetthreadname(sample_tree &RmtSampleTree) &i8 {
	return sample_tree.threadName
}

[c:'_rmt_SampleTreeGetRootSample']
fn _rmt_sampletreegetrootsample(sample_tree &RmtSampleTree) &RmtSample {
	return sample_tree.rootSample
}

[c:'_rmt_SampleGetName']
fn _rmt_samplegetname(sample &RmtSample) &i8 {
	name := stringtable_find(g_Remotery.string_table, sample.name_hash)
	if name == (voidptr(0)) {
		return c'null'
	}
	return name
}

[c:'_rmt_SampleGetNameHash']
fn _rmt_samplegetnamehash(sample &RmtSample) RmtU32 {
	return sample.name_hash
}

[c:'_rmt_SampleGetCallCount']
fn _rmt_samplegetcallcount(sample &RmtSample) RmtU32 {
	return sample.call_count
}

[c:'_rmt_SampleGetStart']
fn _rmt_samplegetstart(sample &RmtSample) RmtU64 {
	return sample.us_start
}

[c:'_rmt_SampleGetTime']
fn _rmt_samplegettime(sample &RmtSample) RmtU64 {
	return sample.us_length
}

[c:'_rmt_SampleGetSelfTime']
fn _rmt_samplegetselftime(sample &RmtSample) RmtU64 {
	return RmtU64(maxs64(sample.us_length - sample.us_sampled_length, 0))
}

[c:'_rmt_SampleGetType']
fn _rmt_samplegettype(sample &RmtSample) RmtSampleType {
	return sample.type_
}

[c:'_rmt_SampleGetColour']
fn _rmt_samplegetcolour(sample &RmtSample, r &RmtU8, g &RmtU8, b &RmtU8)  {
	*r = sample.uniqueColour [0] 
	*g = sample.uniqueColour [1] 
	*b = sample.uniqueColour [2] 
}

[c:'_rmt_PropertyIterateChildren']
fn _rmt_propertyiteratechildren(iterator &RmtPropertyIterator, property &RmtProperty)  {
	iterator.property = 0
	iterator.initial = if property != (voidptr(0)){ property.firstChild } else {0}
}

[c:'_rmt_PropertyIterateNext']
fn _rmt_propertyiteratenext(iter &RmtPropertyIterator) RmtBool {
	if iter.initial != (voidptr(0)) {
		iter.property = iter.initial
		iter.initial = 0
	}
	else {
		if iter.property != (voidptr(0)) {
		iter.property = iter.property.nextSibling
		}
	}
	return if iter.property != (voidptr(0)){ (RmtBool(1)) } else {(RmtBool(0))}
}

[c:'_rmt_PropertyGetName']
fn _rmt_propertygetname(property &RmtProperty) &i8 {
	return property.name
}

[c:'_rmt_PropertyGetDescription']
fn _rmt_propertygetdescription(property &RmtProperty) &i8 {
	return property.description
}

[c:'_rmt_PropertyGetNameHash']
fn _rmt_propertygetnamehash(property &RmtProperty) RmtU32 {
	return property.nameHash
}

[c:'_rmt_PropertyGetType']
fn _rmt_propertygettype(property &RmtProperty) RmtPropertyType {
	return property.type_
}

[c:'_rmt_PropertyGetValue']
fn _rmt_propertygetvalue(property &RmtProperty) RmtPropertyValue {
	return property.value
}

[c:'RegisterProperty']
fn registerproperty(property &RmtProperty, can_lock RmtBool)  {
	if property.initialised == (RmtBool(0)) {
		if can_lock {
			mtxlock(&g_Remotery.propertyMutex)
		}
		if property.initialised == (RmtBool(0)) {
			name_len := RmtU32{}
			parent_property := property.parent
			if parent_property == (voidptr(0)) {
				property.parent = &g_Remotery.rootProperty
				parent_property = property.parent
			}
			registerproperty(parent_property, (RmtBool(0)))
			if parent_property.firstChild != (voidptr(0)) {
				parent_property.lastChild.nextSibling = property
				parent_property.lastChild = property
			}
			else {
				parent_property.firstChild = property
				parent_property.lastChild = property
			}
			name_len = strnlen_s_safe_c(property.name, 256)
			property.nameHash = _rmt_hashstring32(property.name, name_len, 0)
			queueaddtostringtable(g_Remotery.mq_to_rmt_thread, property.nameHash, property.name, name_len, (voidptr(0)))
			property.uniqueID = parent_property.uniqueID
			property.uniqueID = hashcombine(property.uniqueID, property.nameHash)
			property.initialised = (RmtBool(1))
		}
		if can_lock {
			mtxunlock(&g_Remotery.propertyMutex)
		}
	}
}

[c:'_rmt_PropertySetValue']
fn _rmt_propertysetvalue(property &RmtProperty)  {
	if g_Remotery == (voidptr(0)) {
		return 
	}
	registerproperty(property, (RmtBool(1)))
}

[c:'_rmt_PropertyAddValue']
fn _rmt_propertyaddvalue(property &RmtProperty, add_value RmtPropertyValue)  {
	if g_Remotery == (voidptr(0)) {
		return 
	}
	registerproperty(property, (RmtBool(1)))
	void((if 1{ return error('error message') } else {(void(add_value))}))
}

[c:'TakePropertySnapshot']
fn takepropertysnapshot(property &RmtProperty, parent_snapshot &PropertySnapshot, first_snapshot &&PropertySnapshot, prev_snapshot &&PropertySnapshot, depth RmtU32) RmtError {
	error := RmtError{}
	child_property := &RmtProperty(0)
	snapshot := &PropertySnapshot(0)
	error = objectallocator_alloc(g_Remotery.propertyAllocator, &voidptr(&snapshot))
	if error != RmtError.rmt_error_none {
		return error
	}
	snapshot.type_ = property.type_
	snapshot.value = property.value
	snapshot.prevValue = property.prevValue
	snapshot.prevValueFrame = property.prevValueFrame
	snapshot.nameHash = property.nameHash
	snapshot.uniqueID = property.uniqueID
	snapshot.nbChildren = 0
	snapshot.depth = RmtU8(depth)
	snapshot.nextSnapshot = (voidptr(0))
	if parent_snapshot != (voidptr(0)) {
		parent_snapshot.nbChildren ++
	}
	if *first_snapshot == (voidptr(0)) {
		*first_snapshot = snapshot
	}
	if *prev_snapshot != (voidptr(0)) {
		(*prev_snapshot).nextSnapshot = snapshot
	}
	*prev_snapshot = snapshot
	for child_property = property.firstChild ; child_property != (voidptr(0)) ; child_property = child_property.nextSibling {
		error = takepropertysnapshot(child_property, snapshot, first_snapshot, prev_snapshot, depth + 1)
		if error != RmtError.rmt_error_none {
			return error
		}
	}
	return RmtError.rmt_error_none
}

[c:'_rmt_PropertySnapshotAll']
fn _rmt_propertysnapshotall() RmtError {
	error := RmtError{}
	first_snapshot := &PropertySnapshot(0)
	prev_snapshot := &PropertySnapshot(0)
	payload := &Msg_PropertySnapshot(0)
	message := &Message(0)
	nb_snapshot_allocs := RmtU32{}
	if g_Remotery == (voidptr(0)) {
		return RmtError.rmt_error_remotery_not_created
	}
	if g_Remotery.rootProperty.firstChild == (voidptr(0)) {
		return RmtError.rmt_error_none
	}
	nb_snapshot_allocs = g_Remotery.propertyAllocator.nb_inuse
	first_snapshot = (voidptr(0))
	prev_snapshot = (voidptr(0))
	mtxlock(&g_Remotery.propertyMutex)
	error = takepropertysnapshot(&g_Remotery.rootProperty, (voidptr(0)), &first_snapshot, &prev_snapshot, 0)
	if g_Settings.snapshot_callback != (voidptr(0)) {
		g_Settings.snapshot_callback(g_Settings.snapshot_context, &g_Remotery.rootProperty)
	}
	mtxunlock(&g_Remotery.propertyMutex)
	if error != RmtError.rmt_error_none {
		freepropertysnapshots(first_snapshot)
		return error
	}
	message = rmtmessagequeue_allocmessage(g_Remotery.mq_to_rmt_thread, sizeof(Msg_PropertySnapshot), (voidptr(0)))
	if message == (voidptr(0)) {
		freepropertysnapshots(first_snapshot)
		return RmtError.rmt_error_unknown
	}
	payload = &Msg_PropertySnapshot(message.payload)
	payload.rootSnapshot = first_snapshot
	payload.nbSnapshots = g_Remotery.propertyAllocator.nb_inuse - nb_snapshot_allocs
	payload.propertyFrame = g_Remotery.propertyFrame
	rmtmessagequeue_commitmessage(message, MessageID.msgid_propertysnapshot)
	return RmtError.rmt_error_none
}

[c:'PropertyFrameReset']
fn propertyframereset(rmt &Remotery, first_property &RmtProperty)  {
	property := &RmtProperty(0)
	for property = first_property ; property != (voidptr(0)) ; property = property.nextSibling {
		propertyframereset(rmt, property.firstChild)
		changed := (RmtBool(0))
		match property.type_ {
		 .rmt_propertytype_rmtgroup// case comp body kind=BreakStmt is_enum=true 
		{
		
		}
		 .rmt_propertytype_rmtbool// case comp body kind=BinaryOperator is_enum=true 
		{
		changed = property.lastFrameValue.Bool != property.value.Bool
		
		}
		 .rmt_propertytype_rmts32, .rmt_propertytype_rmtu32, .rmt_propertytype_rmtf32{
		changed = property.lastFrameValue.U32 != property.value.U32
		
		}
		 .rmt_propertytype_rmts64, .rmt_propertytype_rmtu64, .rmt_propertytype_rmtf64{
		changed = property.lastFrameValue.U64 != property.value.U64
		
		}
		else{}
		}
		if changed {
			property.prevValue = property.lastFrameValue
			property.prevValueFrame = rmt.propertyFrame
		}
		property.lastFrameValue = property.value
		if (property.flags & RmtPropertyFlags.rmt_propertyflags_framereset) != 0 {
			property.value = property.defaultValue
		}
	}
}

[c:'_rmt_PropertyFrameResetAll']
fn _rmt_propertyframeresetall()  {
	if g_Remotery == (voidptr(0)) {
		return 
	}
	mtxlock(&g_Remotery.propertyMutex)
	propertyframereset(g_Remotery, g_Remotery.rootProperty.firstChild)
	mtxunlock(&g_Remotery.propertyMutex)
	g_Remotery.propertyFrame ++
}

