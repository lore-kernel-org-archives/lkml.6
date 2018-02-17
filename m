Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeBQGVt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 01:21:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:11085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeBQGVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 01:21:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="xz'?yaml'?scan'208";a="18833374"
Date: Sat, 17 Feb 2018 14:21:19 +0800
From: kernel test robot <fengguang.wu@intel.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>, lkp@01.org
Subject: [perf/x86/intel]  41e062cd2e:
 WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_save_and_restart_reload
Message-ID: <20180217062119.cemwsj6dsf4ezfn6@inn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="slirspzpiurloqnr"
Content-Disposition: inline
In-Reply-To: <1518474035-21006-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); Message bigger than SAmaxbody (256000)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--slirspzpiurloqnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: 41e062cd2eca8ad3f98159b87fb6cd4409ec8e68 ("perf/x86/intel: Fix event update for auto-reload")
url: https://github.com/0day-ci/linux/commits/kan-liang-linux-intel-com/bugs-fix-for-auto-reload-mmap-read-and-rdpmc-read/20180216-060737


in testcase: netperf
with following parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: TCP_SENDFILE
	cpufreq_governor: performance

test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
test-url: http://www.netperf.org/netperf/


on test machine: 4 threads Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz with 4G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+------------------------------------------------------------------------------------------+-------+------------+
|                                                                                          | v4.15 | 41e062cd2e |
+------------------------------------------------------------------------------------------+-------+------------+
| boot_successes                                                                           | 3410  | 0          |
| boot_failures                                                                            | 1077  | 7          |
| invoked_oom-killer:gfp_mask=0x                                                           | 841   | 4          |
| Mem-Info                                                                                 | 848   | 4          |
| Out_of_memory:Kill_process                                                               | 4     |            |
| IP-Config:Auto-configuration_of_network_failed                                           | 136   |            |
| RIP:poll_idle                                                                            | 19    |            |
| page_allocation_failure:order:#,mode:#(GFP_ATOMIC|__GFP_COMP|__GFP_ZERO),nodemask=(null) | 7     |            |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c              | 2     |            |
| WARNING:at_kernel/workqueue.c:#destroy_workqueue                                         | 1     |            |
| RIP:destroy_workqueue                                                                    | 1     |            |
| RIP:cpuidle_enter_state                                                                  | 16    |            |
| RIP:copy_page                                                                            | 1     |            |
| RIP:SyS_rmdir                                                                            | 1     |            |
| WARNING:at_net/sched/sch_generic.c:#dev_watchdog                                         | 1     |            |
| RIP:dev_watchdog                                                                         | 1     |            |
| End_of_test:RCU_HOTPLUG                                                                  | 5     |            |
| WARNING:at_arch/x86/events/intel/core.c:#intel_pmu_handle_irq                            | 2     |            |
| RIP:intel_pmu_handle_irq                                                                 | 2     |            |
| RIP:native_write_msr                                                                     | 2     | 3          |
| BUG:unable_to_handle_kernel                                                              | 1     |            |
| Oops:#[##]                                                                               | 1     |            |
| RIP:xhci_ring_trb_show                                                                   | 1     |            |
| Kernel_panic-not_syncing:Fatal_exception                                                 | 2     |            |
| WARNING:at_fs/iomap.c:#iomap_dio_complete                                                | 3     |            |
| RIP:iomap_dio_complete                                                                   | 3     |            |
| WARNING:at_fs/direct-io.c:#dio_complete                                                  | 19    |            |
| RIP:dio_complete                                                                         | 19    |            |
| WARNING:at_fs/btrfs/disk-io.c:#free_fs_root[btrfs]                                       | 1     |            |
| RIP:free_fs_root[btrfs]                                                                  | 1     |            |
| WARNING:at_fs/btrfs/extent-tree.c:#btrfs_put_block_group[btrfs]                          | 1     |            |
| RIP:btrfs_free_block_groups[btrfs]                                                       | 1     |            |
| WARNING:at_fs/btrfs/inode.c:#cow_file_range[btrfs]                                       | 2     |            |
| RIP:cow_file_range[btrfs]                                                                | 2     |            |
| Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes                         | 837   | 4          |
| Assertion_failed                                                                         | 1     |            |
| kernel_BUG_at_fs/xfs/xfs_message.c                                                       | 1     |            |
| invalid_opcode:#[##]                                                                     | 1     |            |
| RIP:assfail[xfs]                                                                         | 1     |            |
| BUG:kernel_hang_in_test_stage                                                            | 16    |            |
| BUG:kernel_reboot-without-warning_in_test_stage                                          | 5     |            |
| BUG:kernel_hang_in_boot_stage                                                            | 1     |            |
| WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_save_and_restart_reload                 | 0     | 3          |
| RIP:intel_pmu_save_and_restart_reload                                                    | 0     | 3          |
| RIP:copy_user_enhanced_fast_string                                                       | 0     | 3          |
| RIP:syscall_return_via_sysret                                                            | 0     | 3          |
| RIP:__radix_tree_lookup                                                                  | 0     | 3          |
| RIP:tcp_v4_send_check                                                                    | 0     | 2          |
| RIP:entry_SYSCALL_64_after_hwframe                                                       | 0     | 3          |
| RIP:ip_rcv                                                                               | 0     | 3          |
| RIP:skb_release_head_state                                                               | 0     | 3          |
| RIP:do_sendfile                                                                          | 0     | 3          |
| RIP:tcp_established_options                                                              | 0     | 3          |
| RIP:current_kernel_time64                                                                | 0     | 2          |
| RIP:___might_sleep                                                                       | 0     | 3          |
| RIP:exit_to_usermode_loop                                                                | 0     | 2          |
| RIP:netif_rx_internal                                                                    | 0     | 2          |
| RIP:do_tcp_sendpages                                                                     | 0     | 3          |
| RIP:selinux_file_permission                                                              | 0     | 3          |
| RIP:tcp_transmit_skb                                                                     | 0     | 3          |
| RIP:sock_sendpage                                                                        | 0     | 3          |
| RIP:generic_file_read_iter                                                               | 0     | 3          |
| RIP:__schedule                                                                           | 0     | 3          |
| RIP:_raw_spin_lock_bh                                                                    | 0     | 3          |
| RIP:__tcp_v4_send_check                                                                  | 0     | 3          |
| RIP:tcp_v4_rcv                                                                           | 0     | 2          |
| RIP:copy_page_to_iter                                                                    | 0     | 3          |
| RIP:skb_try_coalesce                                                                     | 0     | 1          |
| RIP:pipe_wait                                                                            | 0     | 2          |
| RIP:tcp_send_mss                                                                         | 0     | 2          |
| RIP:fsnotify                                                                             | 0     | 3          |
| RIP:tcp_sendpage_locked                                                                  | 0     | 2          |
| RIP:find_get_entry                                                                       | 0     | 2          |
| RIP:release_sock                                                                         | 0     | 3          |
| RIP:select_task_rq_fair                                                                  | 0     | 3          |
| RIP:_find_next_bit                                                                       | 0     | 3          |
| RIP:avc_has_perm                                                                         | 0     | 3          |
| RIP:splice_direct_to_actor                                                               | 0     | 2          |
| RIP:pipe_write                                                                           | 0     | 2          |
| RIP:__sk_mem_raise_allocated                                                             | 0     | 1          |
| RIP:__switch_to                                                                          | 0     | 3          |
| RIP:enqueue_to_backlog                                                                   | 0     | 2          |
| RIP:lock_sock_nested                                                                     | 0     | 2          |
| RIP:tcp_rcv_established                                                                  | 0     | 2          |
| RIP:__dev_queue_xmit                                                                     | 0     | 3          |
| RIP:rcu_all_qs                                                                           | 0     | 2          |
| RIP:update_cfs_group                                                                     | 0     | 3          |
| RIP:pipe_to_sendpage                                                                     | 0     | 3          |
| RIP:kernel_sendpage                                                                      | 0     | 3          |
| RIP:tcp_tso_segs                                                                         | 0     | 3          |
| RIP:mod_timer                                                                            | 0     | 3          |
| RIP:__fget_light                                                                         | 0     | 3          |
| RIP:entry_SYSCALL_64_fastpath                                                            | 0     | 3          |
| RIP:tcp_send_delayed_ack                                                                 | 0     | 2          |
| RIP:rb_erase                                                                             | 0     | 2          |
| RIP:splice_from_pipe                                                                     | 0     | 3          |
| RIP:SyS_sendfile64                                                                       | 0     | 2          |
| RIP:__x86_indirect_thunk_rax                                                             | 0     | 3          |
| RIP:pick_next_task_fair                                                                  | 0     | 3          |
| RIP:file_has_perm                                                                        | 0     | 2          |
| RIP:security_sock_rcv_skb                                                                | 0     | 3          |
| RIP:ipv4_mtu                                                                             | 0     | 3          |
| RIP:tcp_wfree                                                                            | 0     | 3          |
| RIP:_cond_resched                                                                        | 0     | 2          |
| RIP:rb_erase_cached                                                                      | 0     | 3          |
| RIP:__splice_from_pipe                                                                   | 0     | 3          |
| RIP:tcp_v4_md5_lookup                                                                    | 0     | 2          |
| RIP:sanity                                                                               | 0     | 2          |
| RIP:finish_task_switch                                                                   | 0     | 2          |
| RIP:ksize                                                                                | 0     | 3          |
| RIP:inet_sendpage                                                                        | 0     | 3          |
| RIP:touch_atime                                                                          | 0     | 3          |
| RIP:anon_pipe_buf_release                                                                | 0     | 2          |
| RIP:tcp_sendpage                                                                         | 0     | 3          |
| RIP:sock_def_readable                                                                    | 0     | 2          |
| RIP:rb_first                                                                             | 0     | 2          |
| RIP:page_cache_pipe_buf_release                                                          | 0     | 3          |
| RIP:skb_copy_datagram_iter                                                               | 0     | 3          |
| RIP:_raw_spin_lock_irqsave                                                               | 0     | 2          |
| RIP:validate_xmit_skb                                                                    | 0     | 3          |
| RIP:tcp_current_mss                                                                      | 0     | 3          |
| RIP:dequeue_task_fair                                                                    | 0     | 3          |
| RIP:select_idle_sibling                                                                  | 0     | 3          |
| RIP:copy_page_from_iter                                                                  | 0     | 2          |
| RIP:__wake_up_common_lock                                                                | 0     | 2          |
| RIP:mark_page_accessed                                                                   | 0     | 3          |
| RIP:update_curr                                                                          | 0     | 2          |
| RIP:direct_splice_actor                                                                  | 0     | 2          |
| RIP:tcp_md5_do_lookup                                                                    | 0     | 2          |
| RIP:ip_rcv_finish                                                                        | 0     | 2          |
| RIP:pagecache_get_page                                                                   | 0     | 2          |
| RIP:vfs_write                                                                            | 0     | 2          |
| RIP:page_cache_pipe_buf_confirm                                                          | 0     | 3          |
| RIP:tcp_v4_do_rcv                                                                        | 0     | 2          |
| RIP:tcp_ack                                                                              | 0     | 3          |
| RIP:entry_SYSCALL_64_stage2                                                              | 0     | 2          |
| RIP:copy_user_generic_unrolled                                                           | 0     | 2          |
| RIP:enqueue_entity                                                                       | 0     | 3          |
| RIP:scheduler_tick                                                                       | 0     | 1          |
| RIP:tcp_rcv_space_adjust                                                                 | 0     | 2          |
| RIP:load_new_mm_cr3                                                                      | 0     | 3          |
| RIP:tcp_rate_check_app_limited                                                           | 0     | 3          |
| RIP:__netif_receive_skb_core                                                             | 0     | 3          |
| RIP:__might_sleep                                                                        | 0     | 3          |
| RIP:do_splice_to                                                                         | 0     | 3          |
| RIP:jiffies_to_usecs                                                                     | 0     | 2          |
| RIP:check_preempt_wakeup                                                                 | 0     | 2          |
| RIP:pipe_read                                                                            | 0     | 2          |
| RIP:kmalloc_slab                                                                         | 0     | 2          |
| RIP:tcp_event_new_data_sent                                                              | 0     | 3          |
| RIP:io_serial_in                                                                         | 0     | 1          |
| RIP:tcp_schedule_loss_probe                                                              | 0     | 2          |
| RIP:io_serial_out                                                                        | 0     | 1          |
| RIP:cfb_imageblit                                                                        | 0     | 1          |
| RIP:sched_clock_cpu                                                                      | 0     | 1          |
| RIP:lapic_next_deadline                                                                  | 0     | 1          |
| RIP:native_queued_spin_lock_slowpath                                                     | 0     | 1          |
| RIP:switch_mm_irqs_off                                                                   | 0     | 2          |
| RIP:kmem_cache_alloc_node                                                                | 0     | 2          |
| RIP:sk_filter_trim_cap                                                                   | 0     | 2          |
| RIP:nf_hook_slow                                                                         | 0     | 1          |
| RIP:tcp_recvmsg                                                                          | 0     | 2          |
| RIP:_raw_spin_lock                                                                       | 0     | 1          |
| RIP:unmap_page_range                                                                     | 0     | 1          |
| RIP:tcp_release_cb                                                                       | 0     | 2          |
| RIP:ktime_get_with_offset                                                                | 0     | 2          |
| RIP:sk_wait_data                                                                         | 0     | 1          |
| RIP:__clear_user                                                                         | 0     | 1          |
| RIP:update_rq_clock                                                                      | 0     | 1          |
| RIP:copyout                                                                              | 0     | 1          |
| RIP:ktime_get_update_offsets_now                                                         | 0     | 1          |
| RIP:set_next_entity                                                                      | 0     | 1          |
| RIP:__wake_up_common                                                                     | 0     | 1          |
| RIP:__list_add_valid                                                                     | 0     | 1          |
| RIP:wakeup_preempt_entity                                                                | 0     | 1          |
| RIP:security_file_permission                                                             | 0     | 2          |
| RIP:__do_softirq                                                                         | 0     | 2          |
| RIP:reweight_entity                                                                      | 0     | 1          |
| RIP:netif_skb_features                                                                   | 0     | 1          |
| RIP:schedule_timeout                                                                     | 0     | 1          |
| RIP:try_to_wake_up                                                                       | 0     | 1          |
| RIP:rw_verify_area                                                                       | 0     | 2          |
| RIP:tcp_rate_skb_delivered                                                               | 0     | 1          |
| RIP:___perf_sw_event                                                                     | 0     | 2          |
| RIP:ip_finish_output2                                                                    | 0     | 2          |
| RIP:tcp_event_data_recv                                                                  | 0     | 1          |
| RIP:tcp_v4_inbound_md5_hash                                                              | 0     | 1          |
| RIP:__kfree_skb_flush                                                                    | 0     | 1          |
| RIP:net_rx_action                                                                        | 0     | 2          |
| RIP:ip_output                                                                            | 0     | 2          |
| RIP:__netif_receive_skb                                                                  | 0     | 1          |
| RIP:process_backlog                                                                      | 0     | 2          |
| RIP:__calc_delta                                                                         | 0     | 2          |
| RIP:tcp_check_space                                                                      | 0     | 1          |
| RIP:native_sched_clock                                                                   | 0     | 1          |
| RIP:selinux_ip_postroute                                                                 | 0     | 1          |
| RIP:filemap_map_pages                                                                    | 0     | 1          |
| RIP:clear_buddies                                                                        | 0     | 1          |
| RIP:netdev_pick_tx                                                                       | 0     | 1          |
| RIP:tcp_write_xmit                                                                       | 0     | 2          |
| RIP:skb_release_data                                                                     | 0     | 1          |
| RIP:ipv4_dst_check                                                                       | 0     | 1          |
| RIP:vmacache_find                                                                        | 0     | 1          |
| RIP:iov_iter_pipe                                                                        | 0     | 1          |
| RIP:tcp_clean_rtx_queue                                                                  | 0     | 2          |
| RIP:dst_release                                                                          | 0     | 1          |
| RIP:loopback_xmit                                                                        | 0     | 1          |
| RIP:read_tsc                                                                             | 0     | 1          |
| RIP:__ip_local_out                                                                       | 0     | 1          |
| RIP:wait_woken                                                                           | 0     | 2          |
| RIP:native_flush_tlb_single                                                              | 0     | 1          |
| RIP:detach_if_pending                                                                    | 0     | 1          |
| RIP:__skb_clone                                                                          | 0     | 1          |
| RIP:update_load_avg                                                                      | 0     | 1          |
| RIP:__inet_lookup_established                                                            | 0     | 2          |
| RIP:__sb_start_write                                                                     | 0     | 1          |
| RIP:enqueue_task_fair                                                                    | 0     | 1          |
| RIP:__update_load_avg_se                                                                 | 0     | 2          |
| RIP:put_prev_entity                                                                      | 0     | 2          |
| RIP:vfs_read                                                                             | 0     | 1          |
| RIP:finish_wait                                                                          | 0     | 1          |
| RIP:rb_next                                                                              | 0     | 2          |
| RIP:set_next_buddy                                                                       | 0     | 1          |
| RIP:tcp_chrono_start                                                                     | 0     | 1          |
| RIP:tcp_v4_fill_cb                                                                       | 0     | 1          |
| RIP:__local_bh_enable_ip                                                                 | 0     | 2          |
| RIP:__vfs_read                                                                           | 0     | 1          |
| RIP:kfree                                                                                | 0     | 2          |
| RIP:dequeue_entity                                                                       | 0     | 1          |
| RIP:__alloc_skb                                                                          | 0     | 2          |
| RIP:skb_network_protocol                                                                 | 0     | 1          |
| RIP:account_entity_enqueue                                                               | 0     | 2          |
| RIP:selinux_parse_skb                                                                    | 0     | 2          |
| RIP:account_entity_dequeue                                                               | 0     | 1          |
| RIP:selinux_netlbl_sock_rcv_skb                                                          | 0     | 1          |
| RIP:idle_cpu                                                                             | 0     | 2          |
| RIP:tcp_send_ack                                                                         | 0     | 1          |
| RIP:generic_file_splice_read                                                             | 0     | 1          |
| RIP:__inode_security_revalidate                                                          | 0     | 1          |
| RIP:kmem_cache_free                                                                      | 0     | 1          |
| RIP:cpumask_next                                                                         | 0     | 1          |
| RIP:perf_exclude_event                                                                   | 0     | 1          |
| RIP:netlbl_enabled                                                                       | 0     | 2          |
| RIP:tcp_ack_update_rtt                                                                   | 0     | 2          |
| RIP:__mark_inode_dirty                                                                   | 0     | 1          |
| RIP:hrtick_update                                                                        | 0     | 1          |
| RIP:kill_fasync                                                                          | 0     | 1          |
| RIP:_raw_spin_unlock_irqrestore                                                          | 0     | 2          |
| RIP:do_softirq                                                                           | 0     | 1          |
| RIP:pick_next_entity                                                                     | 0     | 2          |
| RIP:selinux_socket_sock_rcv_skb                                                          | 0     | 2          |
| RIP:minmax_subwin_update                                                                 | 0     | 2          |
| RIP:__vfs_write                                                                          | 0     | 1          |
| RIP:schedule                                                                             | 0     | 1          |
| RIP:ip_local_deliver_finish                                                              | 0     | 1          |
| RIP:rb_insert_color_cached                                                               | 0     | 1          |
| RIP:ttwu_do_wakeup                                                                       | 0     | 1          |
| RIP:cpumask_next_wrap                                                                    | 0     | 2          |
| RIP:tcp_options_write                                                                    | 0     | 1          |
| RIP:tcp_tx_timestamp                                                                     | 0     | 1          |
| RIP:tcp_filter                                                                           | 0     | 1          |
| RIP:__kmalloc_node_track_caller                                                          | 0     | 2          |
| RIP:__usecs_to_jiffies                                                                   | 0     | 1          |
| RIP:find_next_bit                                                                        | 0     | 1          |
| RIP:resched_curr                                                                         | 0     | 1          |
| RIP:SyS_write                                                                            | 0     | 1          |
| RIP:tcp_grow_window                                                                      | 0     | 2          |
| RIP:bictcp_acked                                                                         | 0     | 1          |
| RIP:syscall_return_slowpath                                                              | 0     | 2          |
| RIP:prepare_to_wait                                                                      | 0     | 1          |
| RIP:__fsnotify_parent                                                                    | 0     | 1          |
| RIP:tcp_update_pacing_rate                                                               | 0     | 2          |
| RIP:tcp_push                                                                             | 0     | 2          |
| RIP:generic_splice_sendpage                                                              | 0     | 1          |
| RIP:update_min_vruntime                                                                  | 0     | 1          |
| RIP:__hrtimer_run_queues                                                                 | 0     | 1          |
| RIP:__might_fault                                                                        | 0     | 2          |
| RIP:dev_hard_start_xmit                                                                  | 0     | 2          |
| RIP:__list_del_entry_valid                                                               | 0     | 1          |
| RIP:__tcp_select_window                                                                  | 0     | 2          |
| RIP:return_from_SYSCALL_64                                                               | 0     | 1          |
| RIP:__switch_to_asm                                                                      | 0     | 1          |
| RIP:sk_free                                                                              | 0     | 1          |
| RIP:mutex_lock                                                                           | 0     | 1          |
| RIP:memcpy_erms                                                                          | 0     | 1          |
| RIP:current_time                                                                         | 0     | 1          |
| RIP:raw_local_deliver                                                                    | 0     | 1          |
| RIP:selinux_sock_rcv_skb_compat                                                          | 0     | 1          |
| RIP:ip_queue_xmit                                                                        | 0     | 2          |
| RIP:update_wall_time                                                                     | 0     | 1          |
| RIP:__wake_up_sync_key                                                                   | 0     | 1          |
| RIP:deactivate_task                                                                      | 0     | 1          |
| RIP:tcp_recv_timestamp                                                                   | 0     | 1          |
| RIP:timespec_trunc                                                                       | 0     | 1          |
| RIP:sockfd_lookup_light                                                                  | 0     | 2          |
| RIP:ip_send_check                                                                        | 0     | 1          |
| RIP:tcp_small_queue_check                                                                | 0     | 1          |
| RIP:tcp_rbtree_insert                                                                    | 0     | 1          |
| RIP:SYSC_recvfrom                                                                        | 0     | 1          |
| RIP:__tcp_ack_snd_check                                                                  | 0     | 1          |
| RIP:run_timer_softirq                                                                    | 0     | 1          |
| RIP:selinux_ipv4_postroute                                                               | 0     | 1          |
| RIP:__mnt_want_write                                                                     | 0     | 1          |
| RIP:ns_to_timespec64                                                                     | 0     | 2          |
| RIP:woken_wake_function                                                                  | 0     | 2          |
| RIP:default_wake_function                                                                | 0     | 1          |
| RIP:tcp_queue_rcv                                                                        | 0     | 1          |
| RIP:__sb_end_write                                                                       | 0     | 2          |
| RIP:iov_iter_init                                                                        | 0     | 1          |
| RIP:inet_ehashfn                                                                         | 0     | 2          |
| RIP:__xfrm_policy_check2                                                                 | 0     | 1          |
| RIP:mutex_unlock                                                                         | 0     | 1          |
| RIP:tcp_chrono_stop                                                                      | 0     | 2          |
| RIP:file_update_time                                                                     | 0     | 1          |
| RIP:skb_entail                                                                           | 0     | 1          |
| RIP:__atime_needs_update                                                                 | 0     | 2          |
| RIP:pipe_unlock                                                                          | 0     | 1          |
| RIP:tcp_cleanup_rbuf                                                                     | 0     | 1          |
| RIP:perf_iterate_sb                                                                      | 0     | 1          |
| RIP:tcp_rearm_rto                                                                        | 0     | 2          |
| RIP:skb_clone_tx_timestamp                                                               | 0     | 1          |
| RIP:pipe_lock                                                                            | 0     | 1          |
| RIP:rcu_note_context_switch                                                              | 0     | 1          |
| RIP:format_decode                                                                        | 0     | 1          |
| RIP:ip_finish_output                                                                     | 0     | 2          |
| RIP:skb_clone                                                                            | 0     | 1          |
| RIP:hrtimer_forward                                                                      | 0     | 1          |
| RIP:sock_rfree                                                                           | 0     | 2          |
| RIP:check_cfs_rq_runtime                                                                 | 0     | 1          |
| RIP:number                                                                               | 0     | 1          |
| RIP:autoremove_wake_function                                                             | 0     | 1          |
| RIP:sock_put                                                                             | 0     | 2          |
| RIP:tcp_stream_memory_free                                                               | 0     | 1          |
| RIP:__handle_mm_fault                                                                    | 0     | 1          |
| RIP:devkmsg_read                                                                         | 0     | 1          |
| RIP:free_pgd_range                                                                       | 0     | 1          |
| RIP:__x86_indirect_thunk_r8                                                              | 0     | 1          |
| RIP:__x86_indirect_thunk_r10                                                             | 0     | 1          |
| RIP:sock_has_perm                                                                        | 0     | 1          |
| RIP:remove_wait_queue                                                                    | 0     | 2          |
| RIP:sched_clock                                                                          | 0     | 1          |
| RIP:skb_release_all                                                                      | 0     | 1          |
| RIP:tcp_rate_skb_sent                                                                    | 0     | 1          |
| RIP:SyS_read                                                                             | 0     | 1          |
| RIP:copyin                                                                               | 0     | 1          |
| RIP:bictcp_cong_avoid                                                                    | 0     | 1          |
| RIP:skb_csum_hwoffload_help                                                              | 0     | 1          |
| RIP:check_preempt_curr                                                                   | 0     | 1          |
| RIP:tcp_add_backlog                                                                      | 0     | 1          |
| RIP:decay_load                                                                           | 0     | 1          |
| RIP:__release_sock                                                                       | 0     | 2          |
| RIP:_copy_from_user                                                                      | 0     | 1          |
| RIP:page_fault                                                                           | 0     | 1          |
| RIP:vsnprintf                                                                            | 0     | 1          |
| RIP:native_load_tls                                                                      | 0     | 1          |
| RIP:__sock_wfree                                                                         | 0     | 1          |
| RIP:ip_local_out                                                                         | 0     | 1          |
| RIP:perf_swevent_event                                                                   | 0     | 1          |
| RIP:apic_timer_interrupt                                                                 | 0     | 1          |
| RIP:security_socket_recvmsg                                                              | 0     | 2          |
| RIP:tick_sched_timer                                                                     | 0     | 1          |
| RIP:import_single_range                                                                  | 0     | 2          |
| RIP:clockevents_program_event                                                            | 0     | 1          |
| RIP:activate_task                                                                        | 0     | 1          |
| RIP:selinux_xfrm_postroute_last                                                          | 0     | 2          |
| RIP:__enqueue_entity                                                                     | 0     | 1          |
| RIP:radix_tree_lookup_slot                                                               | 0     | 1          |
| RIP:acct_account_cputime                                                                 | 0     | 1          |
| RIP:tcp_rate_gen                                                                         | 0     | 1          |
| RIP:SyS_access                                                                           | 0     | 1          |
| RIP:kfree_skbmem                                                                         | 0     | 1          |
| RIP:get_nohz_timer_target                                                                | 0     | 1          |
| RIP:__sk_dst_check                                                                       | 0     | 1          |
| RIP:cap_bprm_set_creds                                                                   | 0     | 1          |
| RIP:inet_recvmsg                                                                         | 0     | 2          |
| RIP:sock_recvmsg                                                                         | 0     | 1          |
| RIP:cpu_load_update_active                                                               | 0     | 1          |
| RIP:PageHuge                                                                             | 0     | 1          |
| RIP:netif_rx                                                                             | 0     | 1          |
| RIP:__fdget_pos                                                                          | 0     | 1          |
| RIP:selinux_xfrm_sock_rcv_skb                                                            | 0     | 2          |
| RIP:osq_lock                                                                             | 0     | 1          |
| RIP:seq_write                                                                            | 0     | 1          |
| RIP:ret_from_intr                                                                        | 0     | 1          |
| RIP:rcu_bh_qs                                                                            | 0     | 1          |
| RIP:find_vma                                                                             | 0     | 1          |
| RIP:calc_wheel_index                                                                     | 0     | 1          |
| RIP:do_softirq_own_stack                                                                 | 0     | 2          |
| RIP:sk_reset_timer                                                                       | 0     | 2          |
| RIP:vma_compute_subtree_gap                                                              | 0     | 1          |
| RIP:ip_local_deliver                                                                     | 0     | 2          |
| RIP:__rb_insert_augmented                                                                | 0     | 1          |
| RIP:bictcp_cwnd_event                                                                    | 0     | 1          |
| RIP:smp_apic_timer_interrupt                                                             | 0     | 1          |
| RIP:rcu_check_callbacks                                                                  | 0     | 1          |
| RIP:ttwu_do_activate                                                                     | 0     | 1          |
| RIP:generic_pipe_buf_confirm                                                             | 0     | 1          |
| RIP:mutex_spin_on_owner                                                                  | 0     | 1          |
| RIP:__alloc_pages_nodemask                                                               | 0     | 1          |
| RIP:selinux_ip_postroute_compat                                                          | 0     | 2          |
| RIP:get_seconds                                                                          | 0     | 1          |
| RIP:__put_user_8                                                                         | 0     | 1          |
| RIP:__fdget                                                                              | 0     | 1          |
| RIP:vma_merge                                                                            | 0     | 1          |
| RIP:rcu_implicit_dynticks_qs                                                             | 0     | 1          |
| RIP:native_smp_send_reschedule                                                           | 0     | 1          |
| RIP:avc_has_perm_noaudit                                                                 | 0     | 1          |
| RIP:cpu_load_update                                                                      | 0     | 1          |
| RIP:unfreeze_partials                                                                    | 0     | 1          |
| RIP:worker_enter_idle                                                                    | 0     | 1          |
| RIP:__printk_safe_exit                                                                   | 0     | 1          |
| RIP:sync_regs                                                                            | 0     | 1          |
| RIP:path_openat                                                                          | 0     | 1          |
| RIP:_raw_spin_unlock_bh                                                                  | 0     | 2          |
| RIP:eth_type_trans                                                                       | 0     | 2          |
| RIP:selinux_ipv4_output                                                                  | 0     | 1          |
| RIP:__slab_free                                                                          | 0     | 1          |
| RIP:smp_call_function_single                                                             | 0     | 1          |
| RIP:__x86_indirect_thunk_r13                                                             | 0     | 1          |
| RIP:perf_event_task_tick                                                                 | 0     | 1          |
| RIP:ktime_get                                                                            | 0     | 1          |
| RIP:minmax_running_min                                                                   | 0     | 1          |
+------------------------------------------------------------------------------------------+-------+------------+



[  242.731381] WARNING: CPU: 3 PID: 1107 at arch/x86/events/intel/ds.c:1326 intel_pmu_save_and_restart_reload+0x87/0x90
[  242.731382] Modules linked in: netconsole snd_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc wmi_bmof aesni_intel crypto_simd glue_helper i915 cryptd snd_hda_intel snd_hda_codec uvcvideo videobuf2_vmalloc videobuf2_memops pcspkr serio_raw ahci drm_kms_helper libahci syscopyarea sysfillrect snd_hda_core videobuf2_v4l2 sysimgblt fb_sys_fops videobuf2_core snd_hwdep snd_pcm snd_timer bcma snd libata soundcore videodev drm shpchp ideapad_laptop wmi sparse_keymap rfkill video ip_tables
[  242.731417] CPU: 3 PID: 1107 Comm: netserver Not tainted 4.15.0-00001-g41e062c #1
[  242.731418] Hardware name: LENOVO IdeaPad U410    /Lenovo          , BIOS 65CN15WW 06/05/2012
[  242.731422] RIP: 0010:intel_pmu_save_and_restart_reload+0x87/0x90
[  242.731423] RSP: 0018:fffffe000008c8d0 EFLAGS: 00010002
[  242.731425] RAX: 0000000000000001 RBX: ffff88007d069800 RCX: 0000000000000000
[  242.731426] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff88007d069800
[  242.731427] RBP: 0000000000000010 R08: 0000000000000001 R09: 0000000000000001
[  242.731428] R10: 00000000000000b0 R11: 0000000000003000 R12: 00000000000f4243
[  242.731429] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
[  242.731431] FS:  00007f1501639700(0000) GS:ffff880112ac0000(0000) knlGS:0000000000000000
[  242.731432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  242.731433] CR2: 00007f65a1394d68 CR3: 000000007f62a006 CR4: 00000000001606e0
[  242.731434] Call Trace:
[  242.731438]  <NMI>
[  242.731443]  __intel_pmu_pebs_event+0xc8/0x260
[  242.731452]  ? intel_pmu_drain_pebs_nhm+0x211/0x2f0
[  242.731454]  intel_pmu_drain_pebs_nhm+0x211/0x2f0
[  242.731457]  intel_pmu_handle_irq+0x12d/0x4b0
[  242.731464]  ? perf_event_nmi_handler+0x2d/0x50
[  242.731466]  perf_event_nmi_handler+0x2d/0x50
[  242.731470]  nmi_handle+0x6a/0x130
[  242.731473]  default_do_nmi+0x4e/0x110
[  242.731475]  do_nmi+0xe5/0x140
[  242.731479]  end_repeat_nmi+0x1a/0x54
[  242.731483] RIP: 0010:__dev_queue_xmit+0x47/0x780
[  242.731484] RSP: 0018:ffffc9000141fb70 EFLAGS: 00000206
[  242.731486] RAX: 00000000000000ee RBX: ffff88010d501000 RCX: ffff88007eb60cfc
[  242.731487] RDX: ffff88007eb60c00 RSI: 0000000000000000 RDI: ffff88007d5c4400
[  242.731488] RBP: ffffc9000141fbe0 R08: 0000000000000000 R09: 0000000000000000
[  242.731489] R10: ffffc9000141fc00 R11: 0000000000003000 R12: ffff88007d5c4400
[  242.731490] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88007d5c4400
[  242.731495]  ? __dev_queue_xmit+0x47/0x780
[  242.731497]  ? __dev_queue_xmit+0x47/0x780
[  242.731498]  </NMI>
[  242.731502]  ? selinux_ip_postroute+0x160/0x3b0
[  242.731506]  ? pick_next_task_fair+0x2e9/0x5d0
[  242.731509]  ? ip_finish_output2+0x26f/0x380
[  242.731510]  ip_finish_output2+0x26f/0x380
[  242.731513]  ? ip_output+0x5c/0xe0
[  242.731515]  ip_output+0x5c/0xe0
[  242.731517]  ? ip_fragment+0x80/0x80
[  242.731519]  ip_queue_xmit+0x147/0x3c0
[  242.731522]  tcp_transmit_skb+0x51d/0x9f0
[  242.731525]  tcp_recvmsg+0x2ff/0x9f0
[  242.731530]  inet_recvmsg+0x40/0xb0
[  242.731533]  SYSC_recvfrom+0xb0/0x110
[  242.731538]  entry_SYSCALL_64_fastpath+0x20/0x83
[  242.731541] RIP: 0033:0x7f1500c5d04d
[  242.731542] RSP: 002b:00007ffd9cde9748 EFLAGS: 00000246
[  242.731544] Code: e6 48 d3 f8 49 d3 fe 4c 29 f0 4c 01 e0 48 01 83 90 00 00 00 48 89 df e8 a8 6b 18 00 31 c0 5b 5d 41 5c 41 5d 41 5e c3 0f ff eb a3 <0f> ff eb aa 0f 1f 44 00 00 0f 1f 44 00 00 41 56 41 55 48 c7 c2 
[  242.731572] ---[ end trace 27afcd40ecad57ab ]---


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
lkp

--slirspzpiurloqnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.15.0-00001-g41e062c"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.15.0 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
# CONFIG_NO_HZ_FULL_ALL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_EXTLOG=m
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIE_ECRC=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT is not set

#
# PCI host controller drivers
#
# CONFIG_VMD is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_PROTO_DCCP=y
CONFIG_NF_NAT_PROTO_UDPLITE=y
CONFIG_NF_NAT_PROTO_SCTP=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=m
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
CONFIG_NFT_EXTHDR=m
CONFIG_NFT_META=m
# CONFIG_NFT_RT is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
# CONFIG_NFT_SET_RBTREE is not set
# CONFIG_NFT_SET_HASH is not set
# CONFIG_NFT_SET_BITMAP is not set
CONFIG_NFT_COUNTER=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_CONNTRACK_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
CONFIG_NF_TABLES_IPV4=m
CONFIG_NFT_CHAIN_ROUTE_IPV4=m
# CONFIG_NFT_REJECT_IPV4 is not set
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NFT_CHAIN_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_CONNTRACK_IPV6=m
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TABLES_IPV6=m
CONFIG_NFT_CHAIN_ROUTE_IPV6=m
# CONFIG_NFT_REJECT_IPV6 is not set
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
CONFIG_NFT_CHAIN_NAT_IPV6=m
# CONFIG_NF_NAT_MASQUERADE_IPV6 is not set
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
# CONFIG_IP6_NF_NAT is not set
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
# CONFIG_NF_LOG_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# CONFIG_NET_DCCPPROBE is not set
CONFIG_IP_SCTP=m
CONFIG_NET_SCTPPROBE=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
# CONFIG_NET_TCPPROBE is not set
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_LEDS is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
# CONFIG_MAC80211_RC_MINSTREL_VHT is not set
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_MQ_DEFAULT is not set
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_FM10K is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
CONFIG_SKY2_DEBUG=y
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=m
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
# CONFIG_CAPI_EICON is not set
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
# CONFIG_GIGASET_I4L is not set
# CONFIG_GIGASET_DUMMYLL is not set
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_TILT_POLLED is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PROC_INTERFACE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_TPM=m
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=m
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RTSX_PCI=m
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_LIRC=m
CONFIG_IR_LIRC_CODEC=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
# CONFIG_RC_LOOPBACK is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_VIDEOBUF_DVB=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_CORE=m
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_FRIIO=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set
# CONFIG_VIDEO_ZORAN is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_AS102_FE is not set
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_VGEM=m
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_VGASTATE is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
# CONFIG_SND_OPL4_LIB_SEQ is not set
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
CONFIG_SND_SYNTH_EMUX=m
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MASS_STORAGE=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_IRDA is not set
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_CRYPTO_SKEIN is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
# CONFIG_DELL_SMBIOS_WMI is not set
# CONFIG_DELL_SMBIOS_SMM is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_WMI is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_PVPANIC=y
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_MLX_CPLD_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set

#
# FSI support
#
# CONFIG_FSI is not set
CONFIG_PM_OPP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_ZLIB_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set

#
# Runtime Testing
#
CONFIG_LKDTM=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_TEST_FIND_BIT is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP_CORE is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA1_MB=m
CONFIG_CRYPTO_SHA256_MB=m
CONFIG_CRYPTO_SHA512_MB=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SALSA20_X86_64=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

--slirspzpiurloqnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='netperf'
	export testcase='netperf'
	export category='benchmark'
	export disable_latency_stats=1
	export set_nic_irq_affinity=1
	export ip='ipv4'
	export runtime=300
	export nr_threads=8
	export cluster='cs-localhost'
	export job_origin='/lkp/lkp/.src-20180216-165625/allot/cyclic:linux-devel:devel-hourly/lkp-u410/netperf.yaml'
	export queue='bisect'
	export testbox='lkp-u410'
	export tbox_group='lkp-u410'
	export submit_id='5a877a480b9a930b8f4a8d3f'
	export job_file='/lkp/scheduled/lkp-u410/netperf-ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance-debian-x86_64-2016-08-31.cgz-41e062cd2eca8ad3f98159b87fb6cd4409ec8e68-20180217-2959-ldseif-0.yaml'
	export id='003433cd2f3ad006794ff5367800dd6a34949c01'
	export model='Ivy Bridge'
	export nr_cpu=4
	export memory='4G'
	export nr_hdd_partitions=0
	export hdd_partitions=
	export netconsole_port=6674
	export brand='Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz'
	export commit='41e062cd2eca8ad3f98159b87fb6cd4409ec8e68'
	export kconfig='x86_64-rhel-7.2'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2016-08-31.cgz'
	export enqueue_time='2018-02-17 08:41:45 +0800'
	export _id='5a877a480b9a930b8f4a8d3f'
	export _rt='/result/netperf/ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance/lkp-u410/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68'
	export user='lkp'
	export head_commit='830f42b21c4d0d354caca7d35434fc6df4bda363'
	export base_commit='7928b2cbe55b2a410a0f5c1f154610059c57b1b2'
	export branch='linux-devel/devel-hourly-2018021614'
	export result_root='/result/netperf/ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance/lkp-u410/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/0'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-x86_64-2016-08-31.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/scheduled/lkp-u410/netperf-ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance-debian-x86_64-2016-08-31.cgz-41e062cd2eca8ad3f98159b87fb6cd4409ec8e68-20180217-2959-ldseif-0.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.2
branch=linux-devel/devel-hourly-2018021614
commit=41e062cd2eca8ad3f98159b87fb6cd4409ec8e68
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/vmlinuz-4.15.0-00001-g41e062c
max_uptime=1500
RESULT_ROOT=/result/netperf/ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance/lkp-u410/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/0
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2016-08-31.cgz/lkp_2017-12-14.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/netperf_2018-01-02.cgz,/osimage/pkg/debian-x86_64-2016-08-31.cgz/netperf-x86_64_2017-04-27.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/mpstat_2017-12-25.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/turbostat_2016-11-15.cgz,/osimage/pkg/debian-x86_64-2016-08-31.cgz/turbostat-x86_64-d5256b2_2017-06-20.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/perf_2018-01-01.cgz,/osimage/pkg/debian-x86_64-2016-08-31.cgz/perf-x86_64-30a7acd57389_2018-01-01.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/hw_2016-11-15.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/cluster_2016-11-24.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export kernel='/pkg/linux/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/vmlinuz-4.15.0-00001-g41e062c'
	export dequeue_time='2018-02-17 08:57:04 +0800'
	export node_roles='server client'
	export job_initrd='/lkp/scheduled/lkp-u410/netperf-ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance-debian-x86_64-2016-08-31.cgz-41e062cd2eca8ad3f98159b87fb6cd4409ec8e68-20180217-2959-ldseif-0.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor $LKP_SRC/monitors/wrapper latency_stats
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	if role server
	then
		start_daemon $LKP_SRC/daemon/netserver
	fi

	if role client
	then
		run_test test='TCP_SENDFILE' $LKP_SRC/tests/wrapper netperf
	fi
}

extract_stats()
{
	$LKP_SRC/stats/wrapper netperf
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	$LKP_SRC/stats/wrapper latency_stats
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time netperf.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--slirspzpiurloqnr
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--slirspzpiurloqnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/netperf.yaml
suite: netperf
testcase: netperf
category: benchmark

# upto 90% CPU cycles may be used by latency stats
disable_latency_stats: 1
set_nic_irq_affinity: 1
ip: ipv4
runtime: 300s
nr_threads: 200%
cluster: cs-localhost
if role server:
  netserver: 
if role client:
  netperf:
    test: TCP_SENDFILE
job_origin: "/lkp/lkp/.src-20180216-165625/allot/cyclic:linux-devel:devel-hourly/lkp-u410/netperf.yaml"

#! queue options
queue: bisect
testbox: lkp-u410
tbox_group: lkp-u410
submit_id: 5a877a480b9a930b8f4a8d3f
job_file: "/lkp/scheduled/lkp-u410/netperf-ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance-debian-x86_64-2016-08-31.cgz-41e062cd2eca8ad3f98159b87fb6cd4409ec8e68-20180217-2959-ldseif-0.yaml"
id: 003433cd2f3ad006794ff5367800dd6a34949c01

#! hosts/lkp-u410
model: Ivy Bridge
nr_cpu: 4
memory: 4G
nr_hdd_partitions: 0
hdd_partitions: 
netconsole_port: 6674
brand: Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz

#! include/category/benchmark
kmsg: 
boot-time: 
iostat: 
heartbeat: 
vmstat: 
numa-numastat: 
numa-vmstat: 
numa-meminfo: 
proc-vmstat: 
proc-stat: 
meminfo: 
slabinfo: 
interrupts: 
lock_stat: 
latency_stats: 
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
turbostat: 
sched_debug: 
perf-stat: 
mpstat: 
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: 41e062cd2eca8ad3f98159b87fb6cd4409ec8e68

#! default params
kconfig: x86_64-rhel-7.2
compiler: gcc-7
rootfs: debian-x86_64-2016-08-31.cgz
enqueue_time: 2018-02-17 08:41:45.133393038 +08:00
_id: 5a877a480b9a930b8f4a8d3f
_rt: "/result/netperf/ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance/lkp-u410/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68"

#! schedule options
user: lkp
head_commit: 830f42b21c4d0d354caca7d35434fc6df4bda363
base_commit: 7928b2cbe55b2a410a0f5c1f154610059c57b1b2
branch: linux-devel/devel-hourly-2018021614
result_root: "/result/netperf/ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance/lkp-u410/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/0"
LKP_SERVER: inn
max_uptime: 1500
initrd: "/osimage/debian/debian-x86_64-2016-08-31.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/scheduled/lkp-u410/netperf-ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance-debian-x86_64-2016-08-31.cgz-41e062cd2eca8ad3f98159b87fb6cd4409ec8e68-20180217-2959-ldseif-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.2
- branch=linux-devel/devel-hourly-2018021614
- commit=41e062cd2eca8ad3f98159b87fb6cd4409ec8e68
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/vmlinuz-4.15.0-00001-g41e062c
- max_uptime=1500
- RESULT_ROOT=/result/netperf/ipv4-300s-200%-cs-localhost-TCP_SENDFILE-performance/lkp-u410/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/0
- LKP_SERVER=inn
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2016-08-31.cgz/lkp_2017-12-14.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/netperf_2018-01-02.cgz,/osimage/pkg/debian-x86_64-2016-08-31.cgz/netperf-x86_64_2017-04-27.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/mpstat_2017-12-25.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/turbostat_2016-11-15.cgz,/osimage/pkg/debian-x86_64-2016-08-31.cgz/turbostat-x86_64-d5256b2_2017-06-20.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/perf_2018-01-01.cgz,/osimage/pkg/debian-x86_64-2016-08-31.cgz/perf-x86_64-30a7acd57389_2018-01-01.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/hw_2016-11-15.cgz,/osimage/deps/debian-x86_64-2016-08-31.cgz/cluster_2016-11-24.cgz"
lkp_initrd: "/lkp/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20180216-165625/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.2/gcc-7/41e062cd2eca8ad3f98159b87fb6cd4409ec8e68/vmlinuz-4.15.0-00001-g41e062c"
dequeue_time: 2018-02-17 08:57:04.910583206 +08:00

#! /lkp/lkp/.src-20180216-224223/include/site/inn
job_state: running

--slirspzpiurloqnr--
