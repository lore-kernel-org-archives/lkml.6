Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeEKFZa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 01:25:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42035 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbeEKFZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 01:25:29 -0400
X-Google-Smtp-Source: AB8JxZoha+7JKgqKMAjS0xSeUkzUZZf5lfom6PCksooxrg9vUbARTiTxZYBW3gUI+8ElR7UnmjySJQ==
Date: Fri, 11 May 2018 14:25:22 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org, parav@mellanox.com,
        danielj@mellanox.com, swise@opengridcomputing.com, monis@mellanox.com
Cc: inux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: KASAN: use-after-free Read in cma_cancel_operation
Message-ID: <20180511052519.GA14824@dragonet.kaist.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report the crash: KASAN: use-after-free Read in cma_cancel_operation

Note that this bug is previously reported by syzkaller.
https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b
Nonetheless, this bug has not fixed yet, and we hope that this report and our
analysis, which gets help by the RaceFuzzer's feature, will helpful to fix the
crash.

This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report. Our analysis shows that the race occurs when invoking two
syscalls concurrently, write$rdma_cm and write$rdma_cm.


Analysis:
We think the concurrent execution of rdma_destroy_id() causes the crash.
The first execution of rdma_destroy_id() calls kfree(id_priv), and the
second execution of rdma_destry_id() dereferences the id_priv in
cma_cancel_listens(). Therefore use-after-free read occurs.
We observed that rdma_destroy_id() is called during the write$rdma_cm
syscall. After returing from vfs_write(), fput() is called and
ucma_close() is called as a pending work before returing to the user
space.


Thread interleaving:
CPU0 (rdma_destory_id)					CPU1 (rdma_destroy_id)
=====							=====
kfree(id_priv->id.route.path_rec);
put_net(id_priv->id.route.addr.dev_addr.net);
kfree(id_priv);
							id_priv = container_of(id, struct rdma_id_private, id);
							state = cma_exch(id_priv, RDMA_CM_DESTROYING);
							cma_cancel_operation(id_priv, state);

							(in cma_cancel_listens)
							list_del(&id_priv->list);

Call Sequence:
Both CPU0 and CPU1
=====
ucma_close
	rdma_destroy_id


==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0x5c/0xc0 lib/list_debug.c:54
Read of size 8 at addr ffff8801e86deca0 by task syz-executor0/3524

CPU: 1 PID: 3524 Comm: syz-executor0 Not tainted 4.17.0-rc1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x166/0x21c lib/dump_stack.c:113
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23f/0x360 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load8+0x54/0x90 mm/kasan/kasan.c:699
 __list_del_entry_valid+0x5c/0xc0 lib/list_debug.c:54
 __list_del_entry include/linux/list.h:117 [inline]
 list_del include/linux/list.h:125 [inline]
 cma_cancel_listens drivers/infiniband/core/cma.c:1527 [inline]
 cma_cancel_operation+0x2d2/0x750 drivers/infiniband/core/cma.c:1555
 rdma_destroy_id+0xe9/0x760 drivers/infiniband/core/cma.c:1619
 ucma_close+0x9f/0x1c0 drivers/infiniband/core/ucma.c:1743
 __fput+0x22c/0x450 fs/file_table.c:209
 ____fput+0x15/0x20 fs/file_table.c:243
 task_work_run+0x152/0x1b0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x1387/0x1860 kernel/exit.c:865
 do_group_exit+0xfb/0x220 kernel/exit.c:968
 get_signal+0x5b7/0xf70 kernel/signal.c:2469
 do_signal+0x94/0xde0 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop+0x1eb/0x270 arch/x86/entry/common.c:162
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
 do_syscall_64+0x473/0x4a0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4563f9
RSP: 002b:00007fdd885d9ba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000072bfc8 RCX: 00000000004563f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bfc8
RBP: 00007fdd885d9bd0 R08: 0000000000000000 R09: 000000000072bfa0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fdd885d9c50 R14: 0000000000000000 R15: 00007fdd885da700

Allocated by task 3521:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xae/0xe0 mm/kasan/kasan.c:553
 kmem_cache_alloc_trace+0x136/0x740 mm/slab.c:3620
 kmalloc include/linux/slab.h:512 [inline]
 kzalloc include/linux/slab.h:701 [inline]
 __rdma_create_id+0xc5/0x450 drivers/infiniband/core/cma.c:751
 ucma_create_id+0x219/0x510 drivers/infiniband/core/ucma.c:485
 ucma_write+0x1d6/0x260 drivers/infiniband/core/ucma.c:1664
 __vfs_write+0xdd/0x480 fs/read_write.c:485
 vfs_write+0x12d/0x2d0 fs/read_write.c:549
 ksys_write+0xca/0x190 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x43/0x50 fs/read_write.c:607
 do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3524:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 __cache_free mm/slab.c:3498 [inline]
 kfree+0xd9/0x260 mm/slab.c:3813
 rdma_destroy_id+0x605/0x760 drivers/infiniband/core/cma.c:1650
 ucma_close+0x9f/0x1c0 drivers/infiniband/core/ucma.c:1743
 __fput+0x22c/0x450 fs/file_table.c:209
 ____fput+0x15/0x20 fs/file_table.c:243
 task_work_run+0x152/0x1b0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x1387/0x1860 kernel/exit.c:865
 do_group_exit+0xfb/0x220 kernel/exit.c:968
 get_signal+0x5b7/0xf70 kernel/signal.c:2469
 do_signal+0x94/0xde0 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop+0x1eb/0x270 arch/x86/entry/common.c:162
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
 do_syscall_64+0x473/0x4a0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801e86deac0
 which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 480 bytes inside of
 2048-byte region [ffff8801e86deac0, ffff8801e86df2c0)
The buggy address belongs to the page:
page:ffffea0007a1b780 count:1 mapcount:0 mapping:ffff8801e86de240 index:0xffff8801e86de240 compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801e86de240 ffff8801e86de240 0000000100000002
raw: ffffea0007ac8b20 ffffea0007701ba0 ffff8801f6800c40 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8801e86deb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8801e86dec00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8801e86dec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff8801e86ded00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8801e86ded80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

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
