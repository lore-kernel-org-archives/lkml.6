Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF25C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 07:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A55420843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 07:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A55420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeIAMAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:00:07 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:52041 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIAMAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:00:07 -0400
Received: by mail-io0-f199.google.com with SMTP id w23-v6so12560021iob.18
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 00:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fsuODK9n2cufi08lumraot4kCNCyNvxlqqkUg1gewRc=;
        b=E6fz2HWWN5FNeQ4c0Z08TtZX8vIIaZRifyg1MtGCkmAF2CyyqDIsRdxM9P01psyS8l
         VMOzn+98D1rN9hvw3z0pY1xinicyYhpmVeiPA0zvN1gy3kxGVnqQ0AMmCq51pHH/V4uv
         +U42fb5UpMULmL8YQYnNmzG6ELmBlWB5/yqBI73hBRpLMcWbpzwrQSVbSflbjo0w7kb2
         qnIGhcExkPt/78PR6jkG8cre6J3SqJLXf39TlBUQ0ltWmed/vqO9KPqp6DYn8UYnmX97
         ekEIIbWODigHfOsbkYl2LCaNM2fjFZrfyHRrVoP3FIf2tNvsdAlHFoTztwmYMXoH0F5L
         /IQg==
X-Gm-Message-State: APzg51CizrC+i5ZYXHbyH4UqSYbB5VJFowkTEpQI+utYkR12dgjfnPZM
        hDQLQ/gHDFuEhxvWW2wwfwZwgGmut/WRgoROBRK6XXR8+S04
X-Google-Smtp-Source: ANB0VdZ9Nw0jjPHNbWXULjjtprM/AXpU2wXeI7oE6Uie76491DjNF5WRtR0DUdHE2EF3yncDnsa+Kj3RKia0FKvvccSB/PeD4nBi
MIME-Version: 1.0
X-Received: by 2002:a6b:c305:: with SMTP id t5-v6mr8015769iof.115.1535788142136;
 Sat, 01 Sep 2018 00:49:02 -0700 (PDT)
Date:   Sat, 01 Sep 2018 00:49:02 -0700
In-Reply-To: <00000000000008e7340574ab473a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a99aef0574ca8a7b@google.com>
Subject: Re: possible deadlock in __might_fault (3)
From:   syzbot <syzbot+6884a790570df1022b2d@syzkaller.appspotmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        keescook@chromium.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mawilcox@microsoft.com, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, zaitcev@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    a880148cb2af Add linux-next specific files for 20180831
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b6013e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a059d319ef7d83f6
dashboard link: https://syzkaller.appspot.com/bug?extid=6884a790570df1022b2d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ecaa46400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f60151400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6884a790570df1022b2d@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc1-next-20180831+ #53 Not tainted
------------------------------------------------------
syz-executor560/5342 is trying to acquire lock:
00000000d0c295b6 (&mm->mmap_sem){++++}, at: __might_fault+0xfb/0x1e0  
mm/memory.c:4577

but task is already holding lock:
000000000e449f78 (&rp->fetch_lock){+.+.}, at: mon_bin_get_event+0x3f/0x460  
drivers/usb/mon/mon_bin.c:747

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&rp->fetch_lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x171/0x1700 kernel/locking/mutex.c:1073
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
        mon_bin_vma_fault+0xdc/0x4a0 drivers/usb/mon/mon_bin.c:1237
        __do_fault+0xee/0x450 mm/memory.c:3240
        do_cow_fault mm/memory.c:3681 [inline]
        do_fault mm/memory.c:3754 [inline]
        handle_pte_fault mm/memory.c:3983 [inline]
        __handle_mm_fault+0x13c6/0x4350 mm/memory.c:4107
        handle_mm_fault+0x53e/0xc80 mm/memory.c:4144
        faultin_page mm/gup.c:518 [inline]
        __get_user_pages+0x823/0x1b50 mm/gup.c:718
        populate_vma_page_range+0x2db/0x3d0 mm/gup.c:1222
        __mm_populate+0x286/0x4d0 mm/gup.c:1270
        mm_populate include/linux/mm.h:2307 [inline]
        vm_mmap_pgoff+0x27f/0x2c0 mm/util.c:362
        ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&mm->mmap_sem){++++}:
        lock_acquire+0x1e4/0x4f0 kernel/locking/lockdep.c:3901
        __might_fault+0x155/0x1e0 mm/memory.c:4578
        _copy_to_user+0x30/0x110 lib/usercopy.c:25
        copy_to_user include/linux/uaccess.h:155 [inline]
        mon_bin_get_event+0x116/0x460 drivers/usb/mon/mon_bin.c:756
        mon_bin_ioctl+0x459/0xe80 drivers/usb/mon/mon_bin.c:1068
        vfs_ioctl fs/ioctl.c:46 [inline]
        file_ioctl fs/ioctl.c:501 [inline]
        do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
        __do_sys_ioctl fs/ioctl.c:709 [inline]
        __se_sys_ioctl fs/ioctl.c:707 [inline]
        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&rp->fetch_lock);
                                lock(&mm->mmap_sem);
                                lock(&rp->fetch_lock);
   lock(&mm->mmap_sem);

  *** DEADLOCK ***

1 lock held by syz-executor560/5342:
  #0: 000000000e449f78 (&rp->fetch_lock){+.+.}, at:  
mon_bin_get_event+0x3f/0x460 drivers/usb/mon/mon_bin.c:747

stack backtrace:
CPU: 0 PID: 5342 Comm: syz-executor560 Not tainted  
4.19.0-rc1-next-20180831+ #53
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
  _copy_to_user+0x30/0x110 lib/usercopy.c:25
  copy_to_user include/linux/uaccess.h:155 [inline]
  mon_bin_get_event+0x116/0x460 drivers/usb/mon/mon_bin.c:756
  mon_bin_ioctl+0x459/0xe80 drivers/usb/mon/mon_bin.c:1068
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a139
Code: e8 6c b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa6f2498da8 EFLAGS: 00000293 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc68 RCX: 000000000044a139
RDX: 0000000020000000 RSI: 000000004018920a RDI: 0000000000000005
RBP: 00000000006dbc60 R08: 00007fa6f2499700 R09: 0000000000000000
R10: 00007fa6f2499700 R11: 0000000000000293 R12: 00000000006dbc6c
R13: 6273752f7665642f R14: 7375622f7665642f R15: 00000000006dbd4c

