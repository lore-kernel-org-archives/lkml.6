Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeD3HxW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:53:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41357 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeD3HxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:53:20 -0400
X-Google-Smtp-Source: AB8JxZoiGjJULsfYJHbf03C4P3NaA1h2vlhLnqcv/Yxs9bDNl/JZWZGqBOKP5lFw4UBl4ctGDQTl2Q==
Date: Mon, 30 Apr 2018 16:53:14 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: KASAN: use-after-free in loopback_active_get
Message-ID: <20180430075310.GA1070@dragonet.kaist.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report the crash:
KASAN: use-after-free in loopback_active_get

This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this report.
Our analysis shows that the race occurs when invoking two syscalls concurrently,
ioctl$SNDRV_CTL_IOCTL_ELEM_READ and syz_open_dev$audion.

kernel config:
https://kiwi.cs.purdue.ed/static/race-fuzzer/KASAN_use-after-free_in_loopback_active_get.config

Analysis:

When there is a race between sound/drivers/aloop.c:895
(loopback_active_get) and sound/drivers/aloop.c:678 (free_cable), the
retrieved cable pointer in loopback_active_get() may point to the
freed memory region. When loopback_active_get() dereferences this
pointer, use-after-free occurs.

Possible CPU execution:

CPU0						CPU1
loopback_active_get()                           free_cable()
----                                            ----
struct loopback_cable *cable = ...
                                                loopback->cables[substream->number][dev] = NULL;
                                                kfree(cable);
cable->running <-- Use-after-free


Call Sequence:
CPU0
loopback_active_get
  snd_ctl_elem_read
    snd_ctl_elem_read_user
      snd_ctl_ioctl

CPU1
free_cable
  loopback_close
    snd_pcm_release_substream
      snd_pcm_release_substream
        snd_pcm_oss_release_file
          snd_pcm_oss_release_file
            snd_pcm_oss_release


We observed that snd_pcm_oss_release() is called during the open("/dev/audio1")
syscall. In our configuration, the function do_dentry_open() returns -EINVAL
since below if statement is evaluated as true.
if ((f->f_flags & O_DIRECT)
	(!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO))
Therefore, fput() is called and snd_pcm_oss_release() is called as a pending
work before returning to the user space. But we suspect that the insufficient
locking between snd_ctl_ioctl() and snd_pcm_oss_release(), not the vfs_layer,
is the cause of the crash.

--------
Read of size 4 at addr ffff88023aa4899c by task syz-executor0/27703

CPU: 0 PID: 27703 Comm: syz-executor0 Not tainted 4.17.0-rc1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x182/0x24c lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load4+0x78/0x80 mm/kasan/kasan.c:698
 loopback_active_get+0x71/0xb0 sound/drivers/aloop.c:900
 snd_ctl_elem_read+0x14e/0x190 sound/core/control.c:896
 snd_ctl_elem_read_user sound/core/control.c:914 [inline]
 snd_ctl_ioctl+0xaf7/0xce0 sound/core/control.c:1560
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:500 [inline]
 do_vfs_ioctl+0x179/0xf40 fs/ioctl.c:684
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
 __do_sys_ioctl fs/ioctl.c:708 [inline]
 __se_sys_ioctl fs/ioctl.c:706 [inline]
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:706
 do_syscall_64+0x17a/0x530 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x453bc9
RSP: 002b:00007fc5fba5eaf8 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000708020 RCX: 0000000000453bc9
RDX: 0000000020003b38 RSI: 00000000c4c85512 RDI: 0000000000000005
RBP: 00000000000025a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: 00000000004aed78
R13: 00000000ffffffff R14: 0000000000000005 R15: 00000000c4c85512

Allocated by task 27704:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
 kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
 kmalloc include/linux/slab.h:512 [inline]
 kzalloc include/linux/slab.h:701 [inline]
 loopback_open+0x4d2/0x720 sound/drivers/aloop.c:704
 snd_pcm_open_substream+0x174/0x250 sound/core/pcm_native.c:2391
 snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2423 [inline]
 snd_pcm_oss_open+0x799/0xfc0 sound/core/oss/pcm_oss.c:2505
 soundcore_open+0x2db/0x3e0 sound/sound_core.c:597
 chrdev_open+0x1c6/0x450 fs/char_dev.c:417
 do_dentry_open+0x520/0x7c0 fs/open.c:784
 vfs_open+0xc5/0x120 fs/open.c:906
 do_last fs/namei.c:3365 [inline]
 path_openat+0x1133/0x31a0 fs/namei.c:3501
 do_filp_open+0x15a/0x1e0 fs/namei.c:3535
 do_sys_open+0x464/0x540 fs/open.c:1093
 __do_sys_open fs/open.c:1111 [inline]
 __se_sys_open fs/open.c:1106 [inline]
 __x64_sys_open+0x4c/0x60 fs/open.c:1106
 do_syscall_64+0x17a/0x530 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 27704:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 __cache_free mm/slab.c:3498 [inline]
 kfree+0xd9/0x260 mm/slab.c:3813
 free_cable+0x148/0x160 sound/drivers/aloop.c:679
 loopback_close+0x63/0x80 sound/drivers/aloop.c:766
 snd_pcm_release_substream.part.46+0x10e/0x1b0 sound/core/pcm_native.c:2357
 snd_pcm_release_substream+0x49/0x60 sound/core/pcm_native.c:2349
 snd_pcm_oss_release_file.part.23+0x50/0x70 sound/core/oss/pcm_oss.c:2382
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2377 [inline]
 snd_pcm_oss_release+0xa9/0x160 sound/core/oss/pcm_oss.c:2562
 __fput+0x246/0x4f0 fs/file_table.c:209
 ____fput+0x15/0x20 fs/file_table.c:243
 task_work_run+0x1b6/0x220 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:191 [inline]
 exit_to_usermode_loop+0x28d/0x290 arch/x86/entry/common.c:166
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
 do_syscall_64+0x51a/0x530 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88023aa48900
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 156 bytes inside of
 192-byte region [ffff88023aa48900, ffff88023aa489c0)
The buggy address belongs to the page:
page:ffffea0008ea9200 count:1 mapcount:0 mapping:ffff88023aa48000 index:0x0
flags: 0x6fffc0000000100(slab)
raw: 06fffc0000000100 ffff88023aa48000 0000000000000000 0000000100000010
raw: ffffea0008eceb60 ffffea0008d95960 ffff8800b6800040 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88023aa48880: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88023aa48900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88023aa48980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                            ^
 ffff88023aa48a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88023aa48a80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
