Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2099C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C45120839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C45120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeH3Wee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:34:34 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:52678 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeH3Wec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:34:32 -0400
Received: by mail-io0-f199.google.com with SMTP id q20-v6so8431609iod.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 11:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zOHXeHWZ2VfFwFzuhN7DO0F/08mVk78jM8m5nU16mcM=;
        b=OtQXbK959usppjoJDFgubliELcxfgHA33VbnRHeZ+pX5Qbm5aWgruVdCqbHo9bXaKQ
         5Jrf/1SPgiQcC0hhUBqq+uU27/HW3Ua3uRDlKyQ1DAWfj0VqVMU52LT76h40qFviRxvd
         Z+X6vayEc51mxvwxhuZqrRo0h+J7jPVp17IQyMyqCoJNUH/BFn8cysYa+NUe6prdHozo
         yrGc0dpaK7S8tnD4HQND5ADNmvXLyGZXGhrTgAn2BV4aEFXmEbg6C9cvz9nKTwhxdVwx
         /1hfV8xtb2rWGenLXhR2sxCkbkLHD6dretiCy1wQs7qcK+SaBvD41qojlckCpIJYXr8F
         JqMg==
X-Gm-Message-State: APzg51CpTGptjcShLqsLPwlVJ1DHlILqENywn+Y5DheC639Y5GGDmzaU
        V29P3nuQyf7Ovhi88gE+x4JbGjvUaWIgkUHU8P4IfXsDfENz
X-Google-Smtp-Source: ANB0VdYcIGuAPwqeAim4GnUuJ4FQiV126gdqHGZzqr9G7BMXGoEGEbvfTRfbo+f18uLfDWGUPagQwIcBZOMoWvIeBvLWwk4DLQKX
MIME-Version: 1.0
X-Received: by 2002:a6b:984d:: with SMTP id a74-v6mr5250349ioe.84.1535653863544;
 Thu, 30 Aug 2018 11:31:03 -0700 (PDT)
Date:   Thu, 30 Aug 2018 11:31:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008e7340574ab473a@google.com>
Subject: possible deadlock in __might_fault (3)
From:   syzbot <syzbot+6884a790570df1022b2d@syzkaller.appspotmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        keescook@chromium.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, zaitcev@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    58c3f14f86c9 Merge tag 'riscv-for-linus-4.19-rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13795092400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=6884a790570df1022b2d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6884a790570df1022b2d@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc1+ #118 Not tainted
------------------------------------------------------
syz-executor7/25985 is trying to acquire lock:
00000000bd99782f (&mm->mmap_sem){++++}, at: __might_fault+0xfb/0x1e0  
mm/memory.c:4577

but task is already holding lock:
00000000a8e804bc (&rp->fetch_lock){+.+.}, at: mon_bin_fetch+0x37/0x340  
drivers/usb/mon/mon_bin.c:909

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&rp->fetch_lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x171/0x1700 kernel/locking/mutex.c:1073
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
        mon_bin_vma_fault+0xdc/0x4a0 drivers/usb/mon/mon_bin.c:1237
        __do_fault+0xee/0x450 mm/memory.c:3240
        do_read_fault mm/memory.c:3652 [inline]
        do_fault mm/memory.c:3752 [inline]
        handle_pte_fault mm/memory.c:3983 [inline]
        __handle_mm_fault+0x2b4a/0x4350 mm/memory.c:4107
        handle_mm_fault+0x53e/0xc80 mm/memory.c:4144
        faultin_page mm/gup.c:518 [inline]
        __get_user_pages+0x823/0x1b50 mm/gup.c:718
        populate_vma_page_range+0x2db/0x3d0 mm/gup.c:1222
        __mm_populate+0x286/0x4d0 mm/gup.c:1270
        mm_populate include/linux/mm.h:2307 [inline]
        vm_mmap_pgoff+0x27f/0x2c0 mm/util.c:362
        ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
        __do_sys_mmap_pgoff mm/mmap.c:1596 [inline]
        __se_sys_mmap_pgoff mm/mmap.c:1592 [inline]
        __ia32_sys_mmap_pgoff+0xdd/0x1a0 mm/mmap.c:1592
        do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
        do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

-> #0 (&mm->mmap_sem){++++}:
        lock_acquire+0x1e4/0x4f0 kernel/locking/lockdep.c:3901
        __might_fault+0x155/0x1e0 mm/memory.c:4578
        mon_bin_fetch+0x26f/0x340 drivers/usb/mon/mon_bin.c:928
        mon_bin_compat_ioctl+0x232/0x560 drivers/usb/mon/mon_bin.c:1170
        __do_compat_sys_ioctl fs/compat_ioctl.c:1419 [inline]
        __se_compat_sys_ioctl fs/compat_ioctl.c:1365 [inline]
        __ia32_compat_sys_ioctl+0x221/0x640 fs/compat_ioctl.c:1365
        do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
        do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
        entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

other info that might help us debug this:

  Possible unsafe locking scenario:

TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
        CPU0                    CPU1
        ----                    ----
   lock(&rp->fetch_lock);
                                lock(&mm->mmap_sem);
                                lock(&rp->fetch_lock);
   lock(&mm->mmap_sem);
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.

  *** DEADLOCK ***

1 lock held by syz-executor7/25985:
  #0: 00000000a8e804bc (&rp->fetch_lock){+.+.}, at: mon_bin_fetch+0x37/0x340  
drivers/usb/mon/mon_bin.c:909

stack backtrace:
CPU: 1 PID: 25985 Comm: syz-executor7 Not tainted 4.19.0-rc1+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.34.cold.55+0x1bd/0x27d  
kernel/locking/lockdep.c:1222
  check_prev_add kernel/locking/lockdep.c:1862 [inline]
  check_prevs_add kernel/locking/lockdep.c:1975 [inline]
  validate_chain kernel/locking/lockdep.c:2416 [inline]
  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3412
  lock_acquire+0x1e4/0x4f0 kernel/locking/lockdep.c:3901
  __might_fault+0x155/0x1e0 mm/memory.c:4578
  mon_bin_fetch+0x26f/0x340 drivers/usb/mon/mon_bin.c:928
  mon_bin_compat_ioctl+0x232/0x560 drivers/usb/mon/mon_bin.c:1170
  __do_compat_sys_ioctl fs/compat_ioctl.c:1419 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:1365 [inline]
  __ia32_compat_sys_ioctl+0x221/0x640 fs/compat_ioctl.c:1365
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f2aca9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5f260cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000c00c9207
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge0 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge0 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge0 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge0 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge0 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge0 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge0 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge0 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state
bridge0: port 2(bridge_slave_1) entered disabled state
bridge0: port 1(bridge_slave_0) entered disabled state


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
