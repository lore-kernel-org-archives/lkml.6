Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E65C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129CA20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129CA20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeIJMNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:13:42 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:38271 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIJMNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:13:42 -0400
Received: by mail-it0-f71.google.com with SMTP id h5-v6so37730463itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lTvpGf3K71lAcA1WDNKL+m4F2O7jW1SG75mfVOWM9wo=;
        b=FUuBLYOrnV/ay6dKOLBGwxixVQyKEnOznZpk87DwMQldzh4pKKnISoqC3/tYNxLkUo
         7mpKm2p/RMNvdcLmbUkrylNWdZYwxuD7P2dBvHnlU16z4MtaGj/VB51wj5pHW+E/m10+
         22CpYjjfEyCyAjTassmAgJuPa+Y/Fvk2Ud3k99/cOiw0BJsa1FXOKzT8GMf5gFDp080E
         vWS1hVEsKoyFy8y9chsT5QG9Lwt4UU/b94A27JkEND2cearO94z8rZUHzRE+VYzpCNNU
         yvEGWzxN6ZDALi0NeCIUQWKY9qzhGHwI2OEO1R9oouXGlYi/6diyTx48GyPO+ScX92o9
         Ua8w==
X-Gm-Message-State: APzg51CxdxnDkYtS/BXvBtU2q7RhN674NWbN1HP8F9kqUUHkTU2j2+VR
        zZ+dy02Uiyavf9WBw+TUiJghqHxb0UpwZ9wb6CBqsSDJVDo3
X-Google-Smtp-Source: ANB0VdZ1zLjKUdEUzNsw5uaDSuUdblsl6JtoNi/C6TKUbH7LZDKQEP+dDbAja5KZJHUWCIvWLV/4FjUVnC86wkN8BQsSAC/FT1r7
MIME-Version: 1.0
X-Received: by 2002:a6b:da12:: with SMTP id x18-v6mr16090593iob.28.1536564064119;
 Mon, 10 Sep 2018 00:21:04 -0700 (PDT)
Date:   Mon, 10 Sep 2018 00:21:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037743205757f33ac@google.com>
Subject: WARNING: refcount bug in kobject_get
From:   syzbot <syzbot+b74b8b6e712f33454561@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a5682765a2e Merge branch 'x86-urgent-for-linus' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ebecda400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=b74b8b6e712f33454561
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d982da400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10433266400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b74b8b6e712f33454561@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 1 PID: 5475 at lib/refcount.c:153  
refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 5475 Comm: syz-executor799 Not tainted 4.19.0-rc2+ #133
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
Code: 1d 43 80 91 06 31 ff 89 de e8 8f 8b ef fd 84 db 75 df e8 b6 8a ef fd  
48 c7 c7 a0 81 44 88 c6 05 23 80 91 06 01 e8 03 75 b9 fd <0f> 0b eb c3 0f  
1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
RSP: 0018:ffff8801b9c07640 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8164f955 RDI: 0000000000000005
RBP: ffff8801b9c07648 R08: ffff8801c1e70680 R09: ffffed003b5e4fe8
R10: ffffed003b5e4fe8 R11: ffff8801daf27f47 R12: 0000000000000001
R13: ffff8801d8d9df20 R14: ffff8801d70bf940 R15: 0000000000000001
  kref_get include/linux/kref.h:47 [inline]
  kobject_get+0x66/0xc0 lib/kobject.c:613
  kset_get include/linux/kobject.h:213 [inline]
  kobj_kset_join lib/kobject.c:186 [inline]
  kobject_add_internal+0x178/0xb60 lib/kobject.c:238
  kobject_add_varg lib/kobject.c:382 [inline]
  kobject_add+0x13f/0x1b0 lib/kobject.c:426
  class_dir_create_and_add drivers/base/core.c:1554 [inline]
  get_device_parent.isra.27+0x367/0x5a0 drivers/base/core.c:1609
  device_add+0x30d/0x17f0 drivers/base/core.c:1865
  hci_register_dev+0x3e6/0xb80 net/bluetooth/hci_core.c:3196
  __vhci_create_device+0x2c1/0x580 drivers/bluetooth/hci_vhci.c:139
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2de/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1807 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f3aca9
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ff80ae8c EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000200000c0
RDX: 0000000000000002 RSI: 00000000ff80afd4 RDI: 00000000ff80afdc
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
