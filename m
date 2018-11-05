Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BFFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B285A2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B285A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeKETQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:16:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:33222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbeKETQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:16:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CB6DAEA6;
        Mon,  5 Nov 2018 09:57:30 +0000 (UTC)
Subject: Re: [LKP] [Btrfs] 7cc93f268e:
 WARNING:at_fs/btrfs/transaction.c:#cleanup_transaction[btrfs]
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Andrew Nelson <andrew.s.nelson@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
References: <20181105055019.GV24195@shao2-debian>
From:   Filipe Manana <fdmanana@suse.com>
Message-ID: <3e9dce47-e843-4a22-5b73-394405e75035@suse.com>
Date:   Mon, 5 Nov 2018 09:57:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181105055019.GV24195@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/2018 05:50, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 7cc93f268e0ea46570963aa6e09c44abe3732efe ("Btrfs: fix deadlock on tree root leaf when finding free extent")
> https://github.com/0day-ci/linux UPDATE-20181023-032539/fdmanana-kernel-org/Btrfs-fix-deadlock-on-tree-root-leaf-when-finding-free-extent/20181022-173541

Hi,

You are testing an earlier version of the patch that introduced -ENOSPC
errors.

Commit 7cc93f268e0ea46570963aa6e09c44abe3732efe doesn't exist anymore
and got replaced by commit 931e9658e7b52b9e8aacf30e6d7dbfc57b7c67be (the
latest version of the patch without the -ENOSPC regression).

thanks

> 
> in testcase: xfstests
> with following parameters:
> 
> 	disk: 6HDD
> 	fs: btrfs
> 	test: btrfs-group1
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu qemu64,+ssse3 -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +--------------------------------------------------------------------------------------+-------+------------+
> |                                                                                      | v4.19 | 7cc93f268e |
> +--------------------------------------------------------------------------------------+-------+------------+
> | boot_successes                                                                       | 5027  | 6          |
> | boot_failures                                                                        | 1199  | 29         |
> | WARNING:stack_recursion                                                              | 772   |            |
> | WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x                      | 687   |            |
> | cpu_clock_throttled                                                                  | 83    |            |
> | WARNING:at#for_ip_interrupt_entry/0x                                                 | 96    |            |
> | WARNING:at_ip_xfs_inode_item_format/0x                                               | 2     |            |
> | WARNING:at_ip_fsnotify/0x                                                            | 82    |            |
> | WARNING:at_ip__slab_free/0x                                                          | 17    |            |
> | WARNING:at_ip__mutex_lock/0x                                                         | 3     |            |
> | WARNING:at_ip_perf_event_mmap_output/0x                                              | 2     |            |
> | WARNING:at_ip_native_sched_clock/0x                                                  | 5     |            |
> | WARNING:at_ip_ip_finish_output2/0x                                                   | 3     |            |
> | WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank[drm]                    | 20    |            |
> | RIP:drm_wait_one_vblank[drm]                                                         | 20    |            |
> | WARNING:at_ip___perf_sw_event/0x                                                     | 4     |            |
> | PANIC:double_fault                                                                   | 1     |            |
> | WARNING:stack_going_in_the_wrong_direction?ip=double_fault/0x                        | 1     |            |
> | RIP:error_entry                                                                      | 1     |            |
> | stack_segment:#[##]                                                                  | 2     |            |
> | RIP:kmem_cache_alloc                                                                 | 2     |            |
> | Kernel_panic-not_syncing:Fatal_exception                                             | 4     | 3          |
> | general_protection_fault:#[##]                                                       | 1     |            |
> | RIP:__rb_erase_color                                                                 | 1     |            |
> | WARNING:at_ip_do_sys_poll/0x                                                         | 3     |            |
> | WARNING:at_ip__netif_receive_skb_core/0x                                             | 1     |            |
> | WARNING:at_ip__x64_sys_io_submit/0x                                                  | 2     |            |
> | WARNING:at_ip_generic_make_request/0x                                                | 1     |            |
> | WARNING:at_ip_smp_call_function_single/0x                                            | 5     |            |
> | WARNING:at_ip_do_filp_open/0x                                                        | 1     |            |
> | WARNING:DIRECTORY_MODE_IS_ENABLED.SOME_ERROR_INJECTIONS_MIGHT_NOT_WORK               | 2     |            |
> | BUG:kernel_hang_in_test_stage                                                        | 23    | 2          |
> | BUG:soft_lockup-CPU##stuck_for#s                                                     | 60    |            |
> | RIP:simple_write_begin                                                               | 1     |            |
> | Kernel_panic-not_syncing:softlockup:hung_tasks                                       | 60    |            |
> | BUG:kernel_timeout_in_test_stage                                                     | 3     |            |
> | Assertion_failed                                                                     | 10    |            |
> | WARNING:at_fs/xfs/xfs_message.c:#assfail[xfs]                                        | 10    |            |
> | RIP:assfail[xfs]                                                                     | 10    |            |
> | WARNING:at_include/linux/quotaops.h:#dquot_disable                                   | 1     |            |
> | RIP:dquot_disable                                                                    | 1     |            |
> | BUG:unable_to_handle_kernel                                                          | 1     | 3          |
> | Oops:#[##]                                                                           | 1     | 3          |
> | RIP:raid#_sse21_gen_syndrome[raid#_pq]                                               | 1     | 3          |
> | RIP:e1000_xmit_frame                                                                 | 23    |            |
> | RIP:_raw_spin_unlock_irqrestore                                                      | 19    |            |
> | RIP:__do_softirq                                                                     | 7     |            |
> | RIP:native_safe_halt                                                                 | 51    |            |
> | RIP:smp_call_function_single                                                         | 11    |            |
> | RIP:e1000_watchdog                                                                   | 3     |            |
> | BUG:kernel_reboot-without-warning_in_test_stage                                      | 2     |            |
> | RIP:smp_call_function_many                                                           | 1     |            |
> | RIP:e1000_clean                                                                      | 7     |            |
> | RIP:_cond_resched                                                                    | 1     |            |
> | RIP:e1000_alloc_rx_buffers                                                           | 2     |            |
> | RIP:native_queued_spin_lock_slowpath                                                 | 1     |            |
> | WARNING:at_net/sched/sch_generic.c:#dev_watchdog                                     | 50    |            |
> | RIP:dev_watchdog                                                                     | 50    |            |
> | watchdog:BUG:soft_lockBUG:kernel_hang_in_test_stage                                  | 1     |            |
> | RIP:__pollwait                                                                       | 1     |            |
> | INFO:rcu_sched_detected_stalls_on_CPUs/tasks                                         | 1     |            |
> | RIP:page_remove_rmap                                                                 | 1     |            |
> | WARNING:at_fs/btrfs/disk-io.c:#btrfs_free_fs_root[btrfs]                             | 2     |            |
> | RIP:btrfs_free_fs_root[btrfs]                                                        | 2     |            |
> | WARNING:at_fs/btrfs/extent-tree.c:#btrfs_put_block_group[btrfs]                      | 6     |            |
> | RIP:btrfs_put_block_group[btrfs]                                                     | 6     |            |
> | WARNING:at_fs/btrfs/extent-tree.c:#btrfs_free_block_groups[btrfs]                    | 6     |            |
> | RIP:btrfs_free_block_groups[btrfs]                                                   | 6     |            |
> | RIP:xfs_trans_committed_bulk[xfs]                                                    | 2     |            |
> | WARNING:at_fs/iomap.c:#iomap_dio_actor                                               | 1     |            |
> | RIP:iomap_dio_actor                                                                  | 1     |            |
> | WARNING:at_arch/x86/kernel/stacktrace.c:#save_stack_trace_user                       | 20    |            |
> | RIP:save_stack_trace_user                                                            | 20    |            |
> | RIP:finish_task_switch                                                               | 2     |            |
> | WARNING:at_kernel/trace/ring_buffer.c:#rb_set_head_page                              | 7     |            |
> | RIP:rb_set_head_page                                                                 | 7     |            |
> | BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h                       | 40    |            |
> | invoked_oom-killer:gfp_mask=0x                                                       | 120   |            |
> | Mem-Info                                                                             | 120   | 1          |
> | Out_of_memory:Kill_process                                                           | 50    |            |
> | Out_of_memory_and_no_killable_processes                                              | 66    |            |
> | Kernel_panic-not_syncing:System_is_deadlocked_on_memory                              | 66    |            |
> | WARNING:at_net/wireless/ibss.c:#__cfg80211_ibss_joined[cfg80211]                     | 5     |            |
> | RIP:__cfg80211_ibss_joined[cfg80211]                                                 | 5     |            |
> | RIP:copy_user_generic_unrolled                                                       | 4     |            |
> | WARNING:at_drivers/net/wireless/mac80211_hwsim.c:#mac80211_hwsim_tx[mac80211_hwsim]  | 2     |            |
> | RIP:mac80211_hwsim_tx[mac80211_hwsim]                                                | 2     |            |
> | RIP:profile_graph_entry                                                              | 1     |            |
> | WARNING:at_drivers/net/wireless/mac80211_hwsim.c:#mac80211_hwsim_roc[mac80211_hwsim] | 2     |            |
> | RIP:mac80211_hwsim_roc[mac80211_hwsim]                                               | 2     |            |
> | RIP:copy_user_enhanced_fast_string                                                   | 1     |            |
> | RIP:kvm_sched_clock_read                                                             | 1     |            |
> | WARNING:at_kernel/tracepoint.c:#tracepoint_probe_unregister                          | 1     |            |
> | RIP:tracepoint_probe_unregister                                                      | 1     |            |
> | RIP:__put_user_4                                                                     | 4     |            |
> | RIP:native_write_msr                                                                 | 6     |            |
> | RIP:tracing_generic_entry_update                                                     | 1     |            |
> | RIP:trace_clock_local                                                                | 1     |            |
> | RIP:do_syscall_64                                                                    | 1     |            |
> | WARNING:at_kernel/trace/trace.c:#trace_buffered_event_disable                        | 2     |            |
> | RIP:trace_buffered_event_disable                                                     | 2     |            |
> | WARNING:at_kernel/trace/ftrace.c:#ftrace_bug                                         | 1     |            |
> | RIP:ftrace_bug                                                                       | 1     |            |
> | RIP:ftrace_push_return_trace                                                         | 1     |            |
> | BUG:kernel_in_stage                                                                  | 16    |            |
> | End_of_test:RCU_HOTPLUG                                                              | 22    |            |
> | WARNING:at_net/mac80211/tx.c:#__ieee80211_csa_update_counter[mac80211]               | 2     |            |
> | RIP:__ieee80211_csa_update_counter[mac80211]                                         | 2     |            |
> | RIP:console_unlock                                                                   | 2     |            |
> | RIP:exit_to_usermode_loop                                                            | 1     |            |
> | BUG:kernel_hang_in_boot_stage                                                        | 1     |            |
> | WARNING:at_fs/btrfs/transaction.c:#cleanup_transaction[btrfs]                        | 0     | 23         |
> | RIP:cleanup_transaction[btrfs]                                                       | 0     | 23         |
> +--------------------------------------------------------------------------------------+-------+------------+
> 
> 
> 
> [ 1332.863174] WARNING: CPU: 0 PID: 1189 at fs/btrfs/transaction.c:1846 cleanup_transaction+0x20d/0x2f0 [btrfs]
> [ 1332.866072] Modules linked in: btrfs xor zstd_decompress zstd_compress xxhash raid6_pq dm_flakey dm_mod sr_mod cdrom sg ppdev snd_pcm ata_generic pata_acpi snd_timer snd soundcore serio_raw pcspkr ata_piix i2c_piix4 libata floppy parport_pc parport ip_tables [last unloaded: xor]
> [ 1332.872009] CPU: 0 PID: 1189 Comm: umount Not tainted 4.19.0-00001-g7cc93f2 #1
> [ 1332.873963] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [ 1332.876213] RIP: 0010:cleanup_transaction+0x20d/0x2f0 [btrfs]
> [ 1332.877678] Code: 59 de bf e1 48 8b 03 48 85 c0 75 e8 65 ff 0d 1a 0a e1 5f e9 59 ff ff ff 89 ce 48 c7 c7 28 20 2a a0 89 4c 24 04 e8 a3 86 e8 e0 <0f> 0b 8b 4c 24 04 e9 73 fe ff ff 48 8b bd 08 03 00 00 be 03 00 00
> [ 1332.882362] RSP: 0018:ffffc90003717d10 EFLAGS: 00010286
> [ 1332.883732] RAX: 0000000000000000 RBX: ffff88007c227800 RCX: 0000000000000000
> [ 1332.885496] RDX: ffff88013fc1ef40 RSI: ffff88013fc16898 RDI: ffff88013fc16898
> [ 1332.887229] RBP: ffff88007a9c0000 R08: 0000000000000000 R09: 0000000000000a2b
> [ 1332.888995] R10: ffff88007c2272a8 R11: ffffffff82f88fcd R12: ffff8800bb699410
> [ 1332.890733] R13: ffff88007c227800 R14: 00000000ffffffe4 R15: ffff88007a9cc900
> [ 1332.894990] FS:  00007f9457f672c0(0000) GS:ffff88013fc00000(0000) knlGS:0000000000000000
> [ 1332.897140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1332.902712] CR2: 000055c8f6d83168 CR3: 000000007bc48000 CR4: 00000000000006f0
> [ 1332.904474] Call Trace:
> [ 1332.905317]  ? finish_wait+0x80/0x80
> [ 1332.906376]  btrfs_commit_transaction+0x8de/0x940 [btrfs]
> [ 1332.907791]  ? start_transaction+0x9d/0x3d0 [btrfs]
> [ 1332.909132]  close_ctree+0x2bc/0x300 [btrfs]
> [ 1332.910300]  generic_shutdown_super+0x6c/0x120
> [ 1332.911526]  kill_anon_super+0xe/0x30
> [ 1332.912607]  btrfs_kill_super+0x13/0x100 [btrfs]
> [ 1332.913849]  deactivate_locked_super+0x3f/0x70
> [ 1332.915085]  cleanup_mnt+0x3b/0x80
> [ 1332.916082]  task_work_run+0xa3/0xe0
> [ 1332.917110]  exit_to_usermode_loop+0xd3/0xe0
> [ 1332.918297]  do_syscall_64+0x16c/0x180
> [ 1332.919370]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1332.920697] RIP: 0033:0x7f945784bb37
> [ 1332.921753] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 31 03 2b 00 f7 d8 64 89 01 48
> [ 1332.926295] RSP: 002b:00007ffd5931fb98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [ 1332.928344] RAX: 0000000000000000 RBX: 000055c8f6d79080 RCX: 00007f945784bb37
> [ 1332.930087] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055c8f6d7c7d0
> [ 1332.931850] RBP: 000055c8f6d7c7d0 R08: 00007f9457afcb88 R09: 0000000000000020
> [ 1332.933600] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007f9457d4de64
> [ 1332.935369] R13: 0000000000000000 R14: 000055c8f6d79260 R15: 00007ffd5931fe20
> [ 1332.937120] ---[ end trace ae2f8cd767d9d315 ]---
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 
