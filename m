Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeEQNp4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:45:56 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46578 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbeEQNpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:45:54 -0400
X-Google-Smtp-Source: AB8JxZqfQXRx2VFYVSYxjr+cOGBVVo+4oc9EUAWAHqLjXTtjB5s7vkNuHWHk7R4yqB2BhBfyoQ1L4A==
Date: Thu, 17 May 2018 22:45:48 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: KASAN: use-after-free Read in vhost_chr_write_iter
Message-ID: <20180517134544.GA20646@dragonet.kaist.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report the crash: KASAN: use-after-free Read in vhost_chr_write_iter

This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report. Our analysis shows that the race occurs when invoking two
syscalls concurrently, write$vnet and ioctl$VHOST_RESET_OWNER.


Analysis:
We think the concurrent execution of vhost_process_iotlb_msg() and
vhost_dev_cleanup() causes the crash.
Both of functions can run concurrently (please see call sequence below),
and possibly, there is a race on dev->iotlb.
If the switch occurs right after vhost_dev_cleanup() frees
dev->iotlb, vhost_process_iotlb_msg() still sees the non-null value and it
keep executing without returning -EFAULT. Consequently, use-after-free
occures


Thread interleaving:
CPU0 (vhost_process_iotlb_msg)				CPU1 (vhost_dev_cleanup)
(In the case of both VHOST_IOTLB_UPDATE and
VHOST_IOTLB_INVALIDATE)
=====							=====
							vhost_umem_clean(dev->iotlb);
if (!dev->iotlb) {
	        ret = -EFAULT;
		        break;
}
							dev->iotlb = NULL;


Call Sequence:
CPU0
=====
vhost_net_chr_write_iter
	vhost_chr_write_iter
		vhost_process_iotlb_msg

CPU1
=====
vhost_net_ioctl
	vhost_net_reset_owner
		vhost_dev_reset_owner
			vhost_dev_cleanup


==================================================================
BUG: KASAN: use-after-free in vhost_umem_interval_tree_iter_first drivers/vhost/vhost.c:52 [inline]
BUG: KASAN: use-after-free in vhost_del_umem_range drivers/vhost/vhost.c:936 [inline]
BUG: KASAN: use-after-free in vhost_process_iotlb_msg drivers/vhost/vhost.c:1010 [inline]
BUG: KASAN: use-after-free in vhost_chr_write_iter+0x44e/0xcd0 drivers/vhost/vhost.c:1037
Read of size 8 at addr ffff8801d9d7bc00 by task syz-executor0/4997

CPU: 0 PID: 4997 Comm: syz-executor0 Not tainted 4.17.0-rc1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x166/0x21c lib/dump_stack.c:113
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23f/0x360 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load8+0x54/0x90 mm/kasan/kasan.c:699
 vhost_umem_interval_tree_iter_first drivers/vhost/vhost.c:52 [inline]
 vhost_del_umem_range drivers/vhost/vhost.c:936 [inline]
 vhost_process_iotlb_msg drivers/vhost/vhost.c:1010 [inline]
 vhost_chr_write_iter+0x44e/0xcd0 drivers/vhost/vhost.c:1037
 vhost_net_chr_write_iter+0x38/0x40 drivers/vhost/net.c:1380
 call_write_iter include/linux/fs.h:1784 [inline]
 new_sync_write fs/read_write.c:474 [inline]
 __vfs_write+0x355/0x480 fs/read_write.c:487
 vfs_write+0x12d/0x2d0 fs/read_write.c:549
 ksys_write+0xca/0x190 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x43/0x50 fs/read_write.c:607
 do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4563f9
RSP: 002b:00007f4da7ce9b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000072bee0 RCX: 00000000004563f9
RDX: 0000000000000068 RSI: 00000000200006c0 RDI: 0000000000000015
RBP: 0000000000000729 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4da7cea6d4
R13: 00000000ffffffff R14: 00000000006ffc78 R15: 0000000000000000

Allocated by task 4997:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xae/0xe0 mm/kasan/kasan.c:553
 __do_kmalloc_node mm/slab.c:3682 [inline]
 __kmalloc_node+0x47/0x70 mm/slab.c:3689
 kmalloc_node include/linux/slab.h:554 [inline]
 kvmalloc_node+0x99/0xd0 mm/util.c:421
 kvmalloc include/linux/mm.h:550 [inline]
 kvzalloc include/linux/mm.h:558 [inline]
 vhost_umem_alloc+0x72/0x120 drivers/vhost/vhost.c:1260
 vhost_init_device_iotlb+0x1e/0x160 drivers/vhost/vhost.c:1548
 vhost_net_set_features drivers/vhost/net.c:1273 [inline]
 vhost_net_ioctl+0x849/0x1040 drivers/vhost/net.c:1338
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x145/0xd00 fs/ioctl.c:686
 ksys_ioctl+0x94/0xb0 fs/ioctl.c:701
 __do_sys_ioctl fs/ioctl.c:708 [inline]
 __se_sys_ioctl fs/ioctl.c:706 [inline]
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:706
 do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5000:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 __cache_free mm/slab.c:3498 [inline]
 kfree+0xd9/0x260 mm/slab.c:3813
 kvfree+0x36/0x60 mm/util.c:440
 vhost_umem_clean+0x82/0xa0 drivers/vhost/vhost.c:587
 vhost_dev_cleanup+0x5f3/0xa50 drivers/vhost/vhost.c:629
 vhost_dev_reset_owner+0x82/0x170 drivers/vhost/vhost.c:542
 vhost_net_reset_owner drivers/vhost/net.c:1238 [inline]
 vhost_net_ioctl+0x7e1/0x1040 drivers/vhost/net.c:1340
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x145/0xd00 fs/ioctl.c:686
 ksys_ioctl+0x94/0xb0 fs/ioctl.c:701
 __do_sys_ioctl fs/ioctl.c:708 [inline]
 __se_sys_ioctl fs/ioctl.c:706 [inline]
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:706
 do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d9d7bc00
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 64-byte region [ffff8801d9d7bc00, ffff8801d9d7bc40)
The buggy address belongs to the page:
page:ffffea0007675ec0 count:1 mapcount:0 mapping:ffff8801d9d7b000 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801d9d7b000 0000000000000000 0000000100000020
raw: ffffea000768df60 ffffea0007b58ee0 ffff8801f6800340 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8801d9d7bb00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8801d9d7bb80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff8801d9d7bc00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff8801d9d7bc80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8801d9d7bd00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
