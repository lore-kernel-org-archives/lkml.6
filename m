Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB75C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198DD20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198DD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeIDCXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:23:12 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:49910 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeIDCXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:23:12 -0400
Received: by mail-io0-f199.google.com with SMTP id k9-v6so1426882iob.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 15:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1xHhcEIfF37k4TrJ4D4QhDjhSHJp8HbJw1yyZWauXUQ=;
        b=JzgVUef/4hER3cw7FuaeP6r0P3zkQdc8x/tfU3XDz04QJF+S/+gWtmuAH6S6dSqhlZ
         sgHSKEYOlItefNXaa9OSVhbIjIGnUZkq6dO0Hx3yFOUljOvknUqblGVQGaEdRBIfmsR7
         jDXLYaw3DfZP7DSSVl1lsLWn3yl7J9291CsBi8OIDpEQL+SEm4HZV/xX1SOEPr2mmzVJ
         0oenuYqU3gEtielmVqyc4auFHyj1Ag5ohW5YnlcFPRlcXNMEo8r6PGGWEA0rE//YEWi/
         Ku2ccY84NK/K8D4tDV2cu13Gio8dFzoDdxjbh7HSQm7T3p2hacrWaWSHik5+BrruQi4/
         rTVg==
X-Gm-Message-State: APzg51A4hzygMoHCXtDtyg/G0cweiRw01OSsbR8m8E7q+XZ615OXnFF/
        uC37xAwhKBo1525q1D74+ZewBGxun91eEei/f+lghPA48Blm
X-Google-Smtp-Source: ANB0VdZB/LUH5JW5uMdgYRS8gsV9UoHWDr91u0XY5j4UJUsruQQ/hO6Fl5joAw9R0YTaKXv6DfZo8t5ll/eUgxbaM3Z9hhEbncuw
MIME-Version: 1.0
X-Received: by 2002:a6b:c9ce:: with SMTP id z197-v6mr12221428iof.13.1536012063523;
 Mon, 03 Sep 2018 15:01:03 -0700 (PDT)
Date:   Mon, 03 Sep 2018 15:01:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ad6030574fead2e@google.com>
Subject: possible deadlock in mon_bin_vma_fault
From:   syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        keescook@chromium.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, zaitcev@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    58c3f14f86c9 Merge tag 'riscv-for-linus-4.19-rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fc6f0e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=56f9673bb4cdcbeb0e92
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dca13e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cbe492400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com

vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0

======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc1+ #215 Not tainted
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
------------------------------------------------------
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
syz-executor605/4648 is trying to acquire lock:
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
00000000a9171a30 (&rp->fetch_lock){+.+.}, at: mon_bin_vma_fault+0xdc/0x4a0  
drivers/usb/mon/mon_bin.c:1237

but task is already holding lock:
0000000069e9aac4 (&mm->mmap_sem){++++}, at: __mm_populate+0x31a/0x4d0  
mm/gup.c:1250
vhci_hcd: default hub control req: 0000 v0000 i0000 l0

which lock already depends on the new lock.

vhci_hcd: default hub control req: 0000 v0000 i0000 l0

the existing dependency chain (in reverse order) is:
vhci_hcd: default hub control req: 0000 v0000 i0000 l0

-> #1 (&mm->mmap_sem){++++}:
        __might_fault+0x155/0x1e0 mm/memory.c:4578
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        _copy_to_user+0x30/0x110 lib/usercopy.c:25
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        copy_to_user include/linux/uaccess.h:155 [inline]
        mon_bin_read+0x334/0x650 drivers/usb/mon/mon_bin.c:825
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        __vfs_read+0x117/0x9b0 fs/read_write.c:416
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        vfs_read+0x17f/0x3c0 fs/read_write.c:452
        ksys_read+0x101/0x260 fs/read_write.c:578
        __do_sys_read fs/read_write.c:588 [inline]
        __se_sys_read fs/read_write.c:586 [inline]
        __x64_sys_read+0x73/0xb0 fs/read_write.c:586
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe
vhci_hcd: default hub control req: 0000 v0000 i0000 l0

-> #0 (&rp->fetch_lock){+.+.}:
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        lock_acquire+0x1e4/0x4f0 kernel/locking/lockdep.c:3901
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x171/0x1700 kernel/locking/mutex.c:1073
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        mon_bin_vma_fault+0xdc/0x4a0 drivers/usb/mon/mon_bin.c:1237
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        __do_fault+0xee/0x450 mm/memory.c:3240
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        do_read_fault mm/memory.c:3652 [inline]
        do_fault mm/memory.c:3752 [inline]
        handle_pte_fault mm/memory.c:3983 [inline]
        __handle_mm_fault+0x2b4a/0x4350 mm/memory.c:4107
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        handle_mm_fault+0x53e/0xc80 mm/memory.c:4144
        faultin_page mm/gup.c:518 [inline]
        __get_user_pages+0x823/0x1b50 mm/gup.c:718
        populate_vma_page_range+0x2db/0x3d0 mm/gup.c:1222
        __mm_populate+0x286/0x4d0 mm/gup.c:1270
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        mm_populate include/linux/mm.h:2307 [inline]
        vm_mmap_pgoff+0x27f/0x2c0 mm/util.c:362
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  Possible unsafe locking scenario:

vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        CPU0                    CPU1
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
        ----                    ----
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
   lock(&mm->mmap_sem);
                                lock(&rp->fetch_lock);
                                lock(&mm->mmap_sem);
   lock(&rp->fetch_lock);
vhci_hcd: default hub control req: 0000 v0000 i0000 l0

  *** DEADLOCK ***

vhci_hcd: default hub control req: 0000 v0000 i0000 l0
1 lock held by syz-executor605/4648:
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  #0: 0000000069e9aac4 (&mm->mmap_sem){++++}, at: __mm_populate+0x31a/0x4d0  
mm/gup.c:1250
vhci_hcd: default hub control req: 0000 v0000 i0000 l0

stack backtrace:
CPU: 1 PID: 4648 Comm: syz-executor605 Not tainted 4.19.0-rc1+ #215
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
Call Trace:
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  print_circular_bug.isra.34.cold.55+0x1bd/0x27d  
kernel/locking/lockdep.c:1222
  check_prev_add kernel/locking/lockdep.c:1862 [inline]
  check_prevs_add kernel/locking/lockdep.c:1975 [inline]
  validate_chain kernel/locking/lockdep.c:2416 [inline]
  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3412
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  lock_acquire+0x1e4/0x4f0 kernel/locking/lockdep.c:3901
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0x171/0x1700 kernel/locking/mutex.c:1073
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  mon_bin_vma_fault+0xdc/0x4a0 drivers/usb/mon/mon_bin.c:1237
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  __do_fault+0xee/0x450 mm/memory.c:3240
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  do_read_fault mm/memory.c:3652 [inline]
  do_fault mm/memory.c:3752 [inline]
  handle_pte_fault mm/memory.c:3983 [inline]
  __handle_mm_fault+0x2b4a/0x4350 mm/memory.c:4107
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  handle_mm_fault+0x53e/0xc80 mm/memory.c:4144
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  faultin_page mm/gup.c:518 [inline]
  __get_user_pages+0x823/0x1b50 mm/gup.c:718
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  populate_vma_page_range+0x2db/0x3d0 mm/gup.c:1222
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  __mm_populate+0x286/0x4d0 mm/gup.c:1270
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  mm_populate include/linux/mm.h:2307 [inline]
  vm_mmap_pgoff+0x27f/0x2c0 mm/util.c:362
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
RIP: 0033:0x444c09
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
RSP: 002b:00007ffc31ed6738 EFLAGS: 00000216 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444c09
RDX: 0000000001fffffd RSI: 0000000000400000 RDI: 0000000020a05000
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
R10: 0000000000008011 R11: 0000000000000216 R12: 0000000000401ec0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
R13: 0000000000401f50 R14: 0000000000000000 R15: 0000000000000000
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0
vhci_hcd: default hub control req: 0000 v0000 i0000 l0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
