Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C38DC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FB021550
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FB021550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJUBII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 21:08:08 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:39192 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeJUBII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 21:08:08 -0400
Received: by mail-it1-f199.google.com with SMTP id h62-v6so7463907itb.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 09:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ojpH9oMfYQ4iiiHMHw50s0UkoIVrfgWzsgjz6vlIsnA=;
        b=dZeF1QxQtHtgGzo8OLqR/aBU5U/gv94AAPtYkwhVlE6p8YOeHBtprctqiqqb8f7tJr
         i2tL7YIjC4+ZvttljEyYmcCuUBinjpj+/F5F3/bnBp+ocDWIMVMHVZ9aiReLaeyc6njc
         cQE8WJG7juMksFwVDzBjURqRaWctVA1l1Ictd1ciwl5SIxbXJ/MA5BEUpM1VPDYtcf/2
         Mhq3OcdgMEttSGI9BDPDzkvsqWYBlCRiSzRxlxGvz2XONSDU+OujErX06efYykrrmSxl
         FMG2JNGEFIoZsjZbYfvLKpkdn09DWuBVITuT3jAQW8hdh4+cYiwfcbJEZmQRgj2cjtv8
         wL8Q==
X-Gm-Message-State: AGRZ1gJ9eeE2D5hmFIyaDPbf8nNx+i+QX5LLGJr0cW/gNWNfAW72+jgg
        6dIEEJ+LWPZ8emno9f4malXrMPzQhEUZ9ZbVq4h5btEXh49n
X-Google-Smtp-Source: AJdET5cLoqFhJSoZmGorPqzTKccY+mg7jWwCHuV63D6x2i6S6OKn4Np+vQgkeDfy5EtJUBCeaJ0TkwgFQrIioq75JniCDSAzycRp
MIME-Version: 1.0
X-Received: by 2002:a6b:3946:: with SMTP id g67-v6mr7054794ioa.20.1540054622928;
 Sat, 20 Oct 2018 09:57:02 -0700 (PDT)
Date:   Sat, 20 Oct 2018 09:57:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc23740578abe82c@google.com>
Subject: KASAN: use-after-free Read in kvm_put_kvm
From:   syzbot <syzbot+f87f60bb6f13f39b54e3@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d808b5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
dashboard link: https://syzkaller.appspot.com/bug?extid=f87f60bb6f13f39b54e3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cf2f5e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1036dcce400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f87f60bb6f13f39b54e3@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
==================================================================
BUG: KASAN: use-after-free in kvm_iodevice_destructor  
include/kvm/iodev.h:72 [inline]
BUG: KASAN: use-after-free in kvm_io_bus_destroy  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:3401 [inline]
BUG: KASAN: use-after-free in kvm_destroy_vm  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:740 [inline]
BUG: KASAN: use-after-free in kvm_put_kvm+0xd7c/0xff0  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:770
Read of size 8 at addr ffff8801cd479910 by task syz-executor822/5583

CPU: 0 PID: 5583 Comm: syz-executor822 Not tainted  
4.19.0-rc8-next-20181019+ #98
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  kvm_iodevice_destructor include/kvm/iodev.h:72 [inline]
  kvm_io_bus_destroy arch/x86/kvm/../../../virt/kvm/kvm_main.c:3401 [inline]
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:740 [inline]
  kvm_put_kvm+0xd7c/0xff0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:770
  kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:781
  __fput+0x3bc/0xa70 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad1/0x26d0 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  __do_sys_exit_group kernel/exit.c:981 [inline]
  __se_sys_exit_group kernel/exit.c:979 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43ecf8
Code: Bad RIP value.
RSP: 002b:00007ffdc564f908 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ecf8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be5a8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 5583:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  kvm_vm_ioctl_register_coalesced_mmio+0xe8/0x4f0  
arch/x86/kvm/../../../virt/kvm/coalesced_mmio.c:147
  kvm_vm_ioctl+0x594/0x1d60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3014
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5583:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  coalesced_mmio_destructor+0x1ad/0x2a0  
arch/x86/kvm/../../../virt/kvm/coalesced_mmio.c:99
  kvm_iodevice_destructor include/kvm/iodev.h:73 [inline]
  kvm_vm_ioctl_unregister_coalesced_mmio+0x263/0x330  
arch/x86/kvm/../../../virt/kvm/coalesced_mmio.c:184
  kvm_vm_ioctl+0x6bc/0x1d60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3023
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801cd479900
  which belongs to the cache kmalloc-64 of size 64
The buggy address is located 16 bytes inside of
  64-byte region [ffff8801cd479900, ffff8801cd479940)
The buggy address belongs to the page:
page:ffffea0007351e40 count:1 mapcount:0 mapping:ffff8801da800340 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea000736b488 ffffea000736d808 ffff8801da800340
raw: 0000000000000000 ffff8801cd479000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801cd479800: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
  ffff8801cd479880: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
> ffff8801cd479900: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                          ^
  ffff8801cd479980: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
  ffff8801cd479a00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
