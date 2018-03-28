Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbeC1F3u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 01:29:50 -0400
Received: from xppmailspam11.itap.purdue.edu ([128.210.1.215]:38931 "EHLO
        xppmailspam11.itap.purdue.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751008AbeC1F3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 01:29:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.48,369,1517893200";
   d="scan'208";a="97292933"
X-Google-Smtp-Source: AIpwx4//FsEKYzomK2wjtg/eNzV0uJWB0nKjxgl+O3SrD+kyp9OwxDc14ruybv18y5fbpBkmFqyPNs79IeOlbkpFu0I=
MIME-Version: 1.0
From: Byoungyoung Lee <byoungyoung@purdue.edu>
Date: Wed, 28 Mar 2018 01:19:45 -0400
X-Gmail-Original-Message-ID: <CAG5TwLMyYtN19OFh=hxJ6bE_GRtoy-SkpK4K5jbfmQJV587mRw@mail.gmail.com>
Message-ID: <CAG5TwLMyYtN19OFh=hxJ6bE_GRtoy-SkpK4K5jbfmQJV587mRw@mail.gmail.com>
Subject: WARNING in refcount_dec
To: linux-kernel@vger.kernel.org
Cc: DaeLyong Jeong <threeearcat@gmail.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Byoungyoung Lee <byoungyoung@purdue.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report the crash: WARNING in refcount_dec

This crash has been found in v4.16-rc3 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report. Our analysis shows that the race occurs when invoking two
syscalls concurrently, (setsockopt$packet_int) and
(setsockopt$packet_rx_ring).

C repro code : https://kiwi.cs.purdue.edu/static/race-fuzzer/repro-refcount_dec.c
kernel config: https://kiwi.cs.purdue.edu/static/race-fuzzer/kernel-config-v4.16-rc3

---------------------------------------
[  305.838560] refcount_t: decrement hit 0; leaking memory.
[  305.839669] WARNING: CPU: 0 PID: 3867 at
/home/blee/project/race-fuzzer/kernels/kernel_v4.16-rc3/lib/refcount.c:228
refcount_dec+0x62/0x70
[  305.841441] Modules linked in:
[  305.841883] CPU: 0 PID: 3867 Comm: repro.exe Not tainted 4.16.0-rc3 #1
[  305.842803] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
[  305.844345] RIP: 0010:refcount_dec+0x62/0x70
[  305.845005] RSP: 0018:ffff880224d374f8 EFLAGS: 00010286
[  305.845802] RAX: 000000000000002c RBX: 0000000000000000 RCX: ffffffff81538991
[  305.846768] RDX: 0000000000000000 RSI: ffffffff813cd761 RDI: 0000000000000005
[  305.847748] RBP: ffff880224d37500 R08: ffff88023169a440 R09: 0000000000000000
[  305.848748] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88023473ad40
[  305.849738] R13: ffff88023473b368 R14: 0000000000000001 R15: 0000000000000000
[  305.850733] FS:  0000000000c6e940(0000) GS:ffff8800b8a00000(0000)
knlGS:0000000000000000
[  305.851837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  305.852652] CR2: 00007fb120571db8 CR3: 0000000005422000 CR4: 00000000000006f0
[  305.853619] Call Trace:
[  305.854086]  __unregister_prot_hook+0x15f/0x1d0
[  305.854722]  packet_release+0x77a/0x7a0
[  305.855335]  ? mark_held_locks+0x25/0xb0
[  305.855883]  ? packet_lookup_frame+0x110/0x110
[  305.856576]  ? __lock_is_held+0x39/0xc0
[  305.857109]  ? note_gp_changes+0x300/0x300
[  305.857745]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[  305.858548]  ? locks_remove_file+0x31b/0x420
[  305.859138]  ? fcntl_setlk+0xad0/0xad0
[  305.859743]  ? trace_event_raw_event_sched_switch+0x320/0x320
[  305.860534]  ? fsnotify_first_mark+0x2c0/0x2c0
[  305.861234]  sock_release+0x53/0xe0
[  305.861711]  ? sock_alloc_file+0x2c0/0x2c0
[  305.862334]  sock_close+0x16/0x20
[  305.862801]  __fput+0x246/0x4e0
[  305.863310]  ? fput+0x130/0x130
[  305.863743]  ? trace_event_raw_event_sched_switch+0x320/0x320
[  305.864604]  ____fput+0x15/0x20
[  305.865046]  task_work_run+0x1a5/0x200
[  305.865636]  ? kmem_cache_free+0x25c/0x2d0
[  305.866194]  ? task_work_cancel+0x1a0/0x1a0
[  305.866829]  ? switch_task_namespaces+0x9e/0xb0
[  305.867458]  do_exit+0xacf/0x10d0
[  305.868023]  ? mm_update_next_owner+0x650/0x650
[  305.868642]  ? __pv_queued_spin_lock_slowpath+0xbf0/0xbf0
[  305.869427]  ? trace_hardirqs_on_caller+0x136/0x2a0
[  305.870102]  ? trace_hardirqs_on+0xd/0x10
[  305.870701]  ? wake_up_new_task+0x41c/0x650
[  305.871324]  ? to_ratio+0x20/0x20
[  305.871816]  ? lock_release+0x530/0x530
[  305.872341]  ? trace_event_raw_event_sched_switch+0x320/0x320
[  305.873161]  ? match_held_lock+0x7e/0x360
[  305.873777]  ? trace_hardirqs_off+0x10/0x10
[  305.874359]  ? put_pid+0x111/0x140
[  305.874897]  ? task_active_pid_ns+0x70/0x70
[  305.875500]  ? find_held_lock+0xca/0xf0
[  305.876118]  ? do_group_exit+0x1f9/0x260
[  305.876650]  ? lock_downgrade+0x380/0x380
[  305.877297]  ? task_clear_jobctl_pending+0xb5/0xd0
[  305.877951]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  305.878725]  ? do_raw_spin_unlock+0x112/0x1a0
[  305.879309]  ? do_raw_spin_trylock+0x100/0x100
[  305.879969]  ? mark_held_locks+0x25/0xb0
[  305.880505]  ? force_sig+0x30/0x30
[  305.881054]  ? _raw_spin_unlock_irq+0x27/0x50
[  305.881671]  ? trace_hardirqs_on_caller+0x136/0x2a0
[  305.882412]  do_group_exit+0xfb/0x260
[  305.882945]  ? SyS_exit+0x30/0x30
[  305.883442]  ? find_mergeable_anon_vma+0x90/0x90
[  305.884103]  ? SyS_read+0x1c0/0x1c0
[  305.884785]  ? mark_held_locks+0x25/0xb0
[  305.885503]  ? do_syscall_64+0xb2/0x5d0
[  305.886093]  ? do_group_exit+0x260/0x260
[  305.886741]  SyS_exit_group+0x1d/0x20
[  305.887255]  do_syscall_64+0x209/0x5d0
[  305.887888]  ? syscall_return_slowpath+0x3e0/0x3e0
[  305.888611]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  305.889420]  ? syscall_return_slowpath+0x260/0x3e0
[  305.890188]  ? mark_held_locks+0x25/0xb0
[  305.890724]  ? entry_SYSCALL_64_after_hwframe+0x52/0xb7
[  305.891556]  ? trace_hardirqs_off_caller+0xb5/0x120
[  305.892265]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  305.892939]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[  305.893676] RIP: 0033:0x44d989
[  305.894100] RSP: 002b:00000000007fff38 EFLAGS: 00000202 ORIG_RAX:
00000000000000e7
[  305.895158] RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000044d989
[  305.896174] RDX: 00007fb120d739c0 RSI: 00007fb120572700 RDI: 0000000000000001
[  305.897161] RBP: 00000000007fff60 R08: 00007fb120572700 R09: 0000000000000000
[  305.898128] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  305.899464] R13: 000000000040d270 R14: 000000000040d300 R15: 0000000000000000
[  305.900823] Code: b6 1d 81 9a ef 03 31 ff 89 de e8 ca a3 67 ff 84
db 75 df e8 f1 a2 67 ff 48 c7 c7 60 8f 83 84 c6 05 61 9a ef 03 01 e8
ee 5f 49 ff <0f> 0b eb c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41
57 49
[  305.904324] ---[ end trace 360c084b02d93021 ]---
[  305.919117] ------------[ cut here ]------------
[  305.920120] refcount_t: underflow; use-after-free.
[  305.921335] WARNING: CPU: 0 PID: 3867 at
/home/blee/project/race-fuzzer/kernels/kernel_v4.16-rc3/lib/refcount.c:187
refcount_sub_and_test+0x1ec/0x200
[  305.923927] Modules linked in:
[  305.924611] CPU: 0 PID: 3867 Comm: repro.exe Tainted: G        W
    4.16.0-rc3 #1
[  305.925987] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
[  305.928119] RIP: 0010:refcount_sub_and_test+0x1ec/0x200
[  305.929124] RSP: 0018:ffff880224d374a0 EFLAGS: 00010282
[  305.930161] RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffffffff813c9644
[  305.931504] RDX: 0000000000000000 RSI: ffffffff813cd761 RDI: ffff880224d37018
[  305.932942] RBP: ffff880224d37538 R08: ffff88023169a440 R09: 0000000000000000
[  305.934365] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffff
[  305.935734] R13: ffff88023473adc0 R14: 0000000000000001 R15: 1ffff100449a6e96
[  305.937114] FS:  0000000000c6e940(0000) GS:ffff8800b8a00000(0000)
knlGS:0000000000000000
[  305.938668] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  305.939768] CR2: 00007fb120571db8 CR3: 0000000005422000 CR4: 00000000000006f0
[  305.941212] Call Trace:
[  305.941689]  ? refcount_inc+0x70/0x70
[  305.942216]  ? skb_dequeue+0xa5/0xc0
[  305.942713]  refcount_dec_and_test+0x1a/0x20
[  305.943295]  packet_release+0x702/0x7a0
[  305.943816]  ? mark_held_locks+0x25/0xb0
[  305.944378]  ? packet_lookup_frame+0x110/0x110
[  305.945021]  ? __lock_is_held+0x39/0xc0
[  305.945561]  ? note_gp_changes+0x300/0x300
[  305.946132]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[  305.946866]  ? locks_remove_file+0x31b/0x420
[  305.947464]  ? fcntl_setlk+0xad0/0xad0
[  305.948000]  ? trace_event_raw_event_sched_switch+0x320/0x320
[  305.948781]  ? fsnotify_first_mark+0x2c0/0x2c0
[  305.949386]  sock_release+0x53/0xe0
[  305.949866]  ? sock_alloc_file+0x2c0/0x2c0
[  305.950437]  sock_close+0x16/0x20
[  305.950906]  __fput+0x246/0x4e0
[  305.951360]  ? fput+0x130/0x130
[  305.951807]  ? trace_event_raw_event_sched_switch+0x320/0x320
[  305.952620]  ____fput+0x15/0x20
[  305.953071]  task_work_run+0x1a5/0x200
[  305.953585]  ? kmem_cache_free+0x25c/0x2d0
[  305.954143]  ? task_work_cancel+0x1a0/0x1a0
[  305.954714]  ? switch_task_namespaces+0x9e/0xb0
[  305.955334]  do_exit+0xacf/0x10d0
[  305.955801]  ? mm_update_next_owner+0x650/0x650
[  305.956431]  ? __pv_queued_spin_lock_slowpath+0xbf0/0xbf0
[  305.957157]  ? trace_hardirqs_on_caller+0x136/0x2a0
[  305.957811]  ? trace_hardirqs_on+0xd/0x10
[  305.958360]  ? wake_up_new_task+0x41c/0x650
[  305.958937]  ? to_ratio+0x20/0x20
[  305.959391]  ? lock_release+0x530/0x530
[  305.959924]  ? trace_event_raw_event_sched_switch+0x320/0x320
[  305.960693]  ? match_held_lock+0x7e/0x360
[  305.961244]  ? trace_hardirqs_off+0x10/0x10
[  305.961810]  ? put_pid+0x111/0x140
[  305.962277]  ? task_active_pid_ns+0x70/0x70
[  305.962862]  ? find_held_lock+0xca/0xf0
[  305.963396]  ? do_group_exit+0x1f9/0x260
[  305.963933]  ? lock_downgrade+0x380/0x380
[  305.964508]  ? task_clear_jobctl_pending+0xb5/0xd0
[  305.965147]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  305.965871]  ? do_raw_spin_unlock+0x112/0x1a0
[  305.966459]  ? do_raw_spin_trylock+0x100/0x100
[  305.967060]  ? mark_held_locks+0x25/0xb0
[  305.967592]  ? force_sig+0x30/0x30
[  305.968135]  ? _raw_spin_unlock_irq+0x27/0x50
[  305.968741]  ? trace_hardirqs_on_caller+0x136/0x2a0
[  305.969470]  do_group_exit+0xfb/0x260
[  305.969987]  ? SyS_exit+0x30/0x30
[  305.970505]  ? find_mergeable_anon_vma+0x90/0x90
[  305.971126]  ? SyS_read+0x1c0/0x1c0
[  305.971718]  ? mark_held_locks+0x25/0xb0
[  305.972259]  ? do_syscall_64+0xb2/0x5d0
[  305.972843]  ? do_group_exit+0x260/0x260
[  305.973374]  SyS_exit_group+0x1d/0x20
[  305.973932]  do_syscall_64+0x209/0x5d0
[  305.974452]  ? syscall_return_slowpath+0x3e0/0x3e0
[  305.975149]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  305.975941]  ? syscall_return_slowpath+0x260/0x3e0
[  305.976669]  ? mark_held_locks+0x25/0xb0
[  305.977206]  ? entry_SYSCALL_64_after_hwframe+0x52/0xb7
[  305.977978]  ? trace_hardirqs_off_caller+0xb5/0x120
[  305.978690]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  305.979381]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[  305.980114] RIP: 0033:0x44d989
[  305.980531] RSP: 002b:00000000007fff38 EFLAGS: 00000202 ORIG_RAX:
00000000000000e7
[  305.981664] RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000044d989
[  305.982655] RDX: 00007fb120d739c0 RSI: 00007fb120572700 RDI: 0000000000000001
[  305.983654] RBP: 00000000007fff60 R08: 00007fb120572700 R09: 0000000000000000
[  305.984656] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  305.985707] R13: 000000000040d270 R14: 000000000040d300 R15: 0000000000000000
[  305.986724] Code: b6 1d 18 9b ef 03 31 ff 89 de e8 60 a4 67 ff 84
db 75 1a e8 87 a3 67 ff 48 c7 c7 00 8f 83 84 c6 05 f8 9a ef 03 01 e8
84 60 49 ff <0f> 0b 31 db e9 2b ff ff ff 66 66 2e 0f 1f 84 00 00 00 00
00 55
[  305.990106] ---[ end trace 360c084b02d93022 ]---
[  305.998636] IPVS: ftp: loaded support on port[0] = 21
---------------------------------------

= About RaceFuzzer

RaceFuzzer is a customized version of Syzkaller, specifically tailored
to find race condition bugs in the Linux kernel. While we leverage
many different technique, the notable feature of RaceFuzzer is in
leveraging a custom hypervisor (QEMU/KVM) to interleave the
scheduling. In particular, we modified the hypervisor to intentionally
stall a per-core execution, which is similar to supporting per-core
breakpoint functionality. This allows RaceFuzzer to force the kernel
to deterministically trigger racy condition (which may rarely happen
in practice due to randomness in scheduling).

RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
repro's scheduling synchronization should be performed at the user
space, its reproducibility is limited (reproduction may take from 1
second to 10 minutes (or even more), depending on a bug). This is
because, while RaceFuzzer precisely interleaves the scheduling at the
kernel's instruction level when finding this bug, C repro cannot fully
utilize such a feature. Please disregard all code related to
"should_hypercall" in the C repro, as this is only for our debugging
purposes using our own hypervisor.
