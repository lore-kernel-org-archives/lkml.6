Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9E2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ABB20892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48ABB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbeKPT3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:29:32 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:56950 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeKPT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:29:32 -0500
Received: by mail-it1-f199.google.com with SMTP id m123-v6so27146862ite.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 01:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kXyf9AchiyGtnI4o8zC+4AsIczTTbdI87aRWLSOFYRk=;
        b=NIN04OWz/uH9oHlxNHOcQH/zhvTTf7H3mSfn3e/82IJqoU3gJ1HHe1FSax0+sD+M08
         oc/lov/8yNjKaQTiy/e3mhOVpHI+FvvP6Qcqf8aN8xSOJ2WAc3QYM8ZqXDdHR6Vpgtxk
         7js9QJepR1Vb/jbiIGTIV3pPYGLRcMY+JFU/5iEO+X05XTOQ+odRMt35Mi9Tw7xpyf7h
         /aLZjuSz1edxhKUOOQ782sVOrYW1SSZxKkoxWxFwz5tThaeE1/RvSCYIBOpqv14ro+rt
         nIxmfHZTBjylTK5pAFRjbFna+0mbqWV03kBja5ya7MPpvuOM7z2MsnkzSDEeufxGU/dz
         dCog==
X-Gm-Message-State: AGRZ1gJ0u0I9hS/mLt8zxCToLp8mtN/uMCzjB2r2Fqe5S03ktOd2bGV9
        xMgMT9VHSXKeZQLJT9P4lAG+8kPb9xN9EJ8LTvNmlfUCgCWO
X-Google-Smtp-Source: AJdET5e2+Wakv6Jj+LkT8NIXv0PCL+p3H6NcwZ4IVLMxPVpN7T0yNQZ4u54yZnpgZk8mXKdDiEJsjUt6r6v3FxMl88X8xb6NCCBN
MIME-Version: 1.0
X-Received: by 2002:a02:57c4:: with SMTP id b65-v6mr2951509jad.15.1542359883291;
 Fri, 16 Nov 2018 01:18:03 -0800 (PST)
Date:   Fri, 16 Nov 2018 01:18:03 -0800
In-Reply-To: <0000000000007dedf00576dd53eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5bd34057ac4a4a1@google.com>
Subject: Re: possible deadlock in acct_pin_kill
From:   syzbot <syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, oleg@redhat.com, paulmck@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    da5322e65940 Merge tag 'selinux-pr-20181115' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10152c5d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=2a73a6ea9507b7112141
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12298533400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ff545d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com

overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.

======================================================
WARNING: possible circular locking dependency detected
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
4.20.0-rc2+ #115 Not tainted
------------------------------------------------------
syz-executor033/6031 is trying to acquire lock:
00000000220c74d2 (&acct->lock#2){+.+.}, at: acct_pin_kill+0x26/0x100  
kernel/acct.c:173

but task is already holding lock:
000000009fcf7a69 (sb_writers#3){.+.+}, at: sb_start_write  
include/linux/fs.h:1597 [inline]
000000009fcf7a69 (sb_writers#3){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#3){.+.+}:
        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36  
[inline]
        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
        __sb_start_write+0x214/0x370 fs/super.c:1387
        file_start_write include/linux/fs.h:2810 [inline]
        ovl_write_iter+0x9a7/0xd10 fs/overlayfs/file.c:243
        call_write_iter include/linux/fs.h:1857 [inline]
        new_sync_write fs/read_write.c:474 [inline]
        __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
        __kernel_write+0x10c/0x370 fs/read_write.c:506
        do_acct_process+0x1144/0x1660 kernel/acct.c:520
        slow_acct_process kernel/acct.c:579 [inline]
        acct_process+0x6b1/0x875 kernel/acct.c:605
        do_exit+0x1b89/0x26d0 kernel/exit.c:857
        do_group_exit+0x177/0x440 kernel/exit.c:970
        get_signal+0x8b0/0x1980 kernel/signal.c:2517
        do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
        exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
        prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
        syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
        do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_key[depth]){+.+.}:
        down_write+0x8a/0x130 kernel/locking/rwsem.c:70
        inode_lock include/linux/fs.h:757 [inline]
        ovl_write_iter+0x151/0xd10 fs/overlayfs/file.c:231
overlayfs: filesystem on './file0' not supported as upperdir
        call_write_iter include/linux/fs.h:1857 [inline]
        new_sync_write fs/read_write.c:474 [inline]
        __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
        __kernel_write+0x10c/0x370 fs/read_write.c:506
        do_acct_process+0x1144/0x1660 kernel/acct.c:520
        slow_acct_process kernel/acct.c:579 [inline]
        acct_process+0x6b1/0x875 kernel/acct.c:605
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
        do_exit+0x1b89/0x26d0 kernel/exit.c:857
        do_group_exit+0x177/0x440 kernel/exit.c:970
        get_signal+0x8b0/0x1980 kernel/signal.c:2517
        do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
        exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
        prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
        syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
        do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
        entry_SYSCALL_64_after_hwframe+0x49/0xbe
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.

-> #0 (&acct->lock#2){+.+.}:
overlayfs: filesystem on './file0' not supported as upperdir
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        acct_pin_kill+0x26/0x100 kernel/acct.c:173
        pin_kill+0x29d/0xab0 fs/fs_pin.c:50
        acct_on+0x665/0x940 kernel/acct.c:254
        __do_sys_acct kernel/acct.c:286 [inline]
        __se_sys_acct kernel/acct.c:273 [inline]
        __x64_sys_acct+0xc2/0x1f0 kernel/acct.c:273
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &acct->lock#2 --> &ovl_i_mutex_key[depth] --> sb_writers#3

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(sb_writers#3);
                                lock(&ovl_i_mutex_key[depth]);
                                lock(sb_writers#3);
   lock(&acct->lock#2);

  *** DEADLOCK ***

2 locks held by syz-executor033/6031:
  #0: 0000000058444ea9 (acct_on_mutex){+.+.}, at: __do_sys_acct  
kernel/acct.c:285 [inline]
  #0: 0000000058444ea9 (acct_on_mutex){+.+.}, at: __se_sys_acct  
kernel/acct.c:273 [inline]
  #0: 0000000058444ea9 (acct_on_mutex){+.+.}, at: __x64_sys_acct+0xba/0x1f0  
kernel/acct.c:273
  #1: 000000009fcf7a69 (sb_writers#3){.+.+}, at: sb_start_write  
include/linux/fs.h:1597 [inline]
  #1: 000000009fcf7a69 (sb_writers#3){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360

stack backtrace:
CPU: 1 PID: 6031 Comm: syz-executor033 Not tainted 4.20.0-rc2+ #115
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_circular_bug.isra.35.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  acct_pin_kill+0x26/0x100 kernel/acct.c:173
  pin_kill+0x29d/0xab0 fs/fs_pin.c:50
  acct_on+0x665/0x940 kernel/acct.c:254
  __do_sys_acct kernel/acct.c:286 [inline]
  __se_sys_acct kernel/acct.c:273 [inline]
  __x64_sys_acct+0xc2/0x1f0 kernel/acct.c:273
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4466f9
Code: e8 cc e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f468be84da8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a3
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 00000000004466f9
RDX: 00000000004466f9 RSI: 00000000004466f9 RDI: 0000000020000040
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000006dbc3c
R13: 0030656c69662f2e R14: 0079616c7265766f R15: 0000000000000001
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
kobject: 'regulatory.0' (0000000007a1250c): kobject_uevent_env
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
kobject: 'regulatory.0' (0000000007a1250c): fill_kobj_path: path  
= '/devices/platform/regulatory.0'
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: failed to resolve './file1': -2
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: failed to resolve './file1': -2
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: failed to resolve './file1': -2
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
Process accounting resumed
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusive upperdir protection.
Process accounting resumed
overlayfs: upperdir is in-use by another mount, mount with '-o index=off'  
to override exclusiv
