Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3BEC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0242086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0242086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbeGIPJF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:09:05 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:41846 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeGIPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:09:02 -0400
Received: by mail-io0-f199.google.com with SMTP id p12-v6so2479309iog.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3rvXrhyLPnzJd+bo/hbvJEHHHMgYazfNpdNvs3mhiMU=;
        b=C8389HJSL6Vux+FyeML+y7a2RPWLO8/B7bfwEfVz1Q7wjnfklGaPjHWemE/A8owuh0
         BmdckwgCDGpFvplL9qovOIy54MQbWkEXF1HMAJJ24gUd6Z3q7pVexsB7SqX+BeVQcd2A
         oh2VjAg1oRRHXlB1UA2EQq1ccTl13g5X6zxx0NWSEICE+CYibFThyqRcpembzwxw3yQU
         kJFyeWmCH+rqk6usJeef4Tttg1j/Y+KYEhMhB+UmoDNBYoS+pelfPomhGmPkvywqBWXU
         8vFLMBzF/CM1eQ5xDa4tCMK3ECTCvcWdN9Zyj0gXT9ZvNhypVYO3y2eacEsagTxI9ClP
         3vKw==
X-Gm-Message-State: APt69E3LabB4hGhhOt0hg4OBthQ8O6wglABhCcgpi/vOPSzMxrjDtPBQ
        HKNk92Wz2yFBsq+8toBtyc0H+uIp41VBJWFdWOX+kOsre0FA
X-Google-Smtp-Source: AAOMgpc+NNCo4OA4qQNqZesLiFOYyR5bl81JQDEHSL/rDIT8/mILZ+Qj99FG0lYgm6a9rKx+FtzKz8TGHFm7N/kv5q+XjHb6mZgO
MIME-Version: 1.0
X-Received: by 2002:a02:3509:: with SMTP id k9-v6mr9426257jaa.35.1531148941799;
 Mon, 09 Jul 2018 08:09:01 -0700 (PDT)
Date:   Mon, 09 Jul 2018 08:09:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c63a4305709264a6@google.com>
Subject: BUG: corrupted list in p9_fd_cancel
From:   syzbot <syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1e4b044d2251 Linux 4.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156196a4400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=735d926e9d1317c3310c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12344f34400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1695badc400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com

list_del corruption, ffff8801aa15b2a8->next is LIST_POISON1  
(dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:47!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 5039 Comm: syz-executor122 Not tainted 4.18.0-rc4+ #41
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
Code: 02 fe 0f 0b 4c 89 e2 48 89 de 48 c7 c7 a0 65 1a 88 e8 4a 6e 02 fe 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 40 65 1a 88 e8 36 6e 02 fe <0f> 0b 48 89 de  
48 c7 c7 60 66 1a 88 e8 25 6e 02 fe 0f 0b 48 89 de
RSP: 0018:ffff8801cfeef180 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff8801aa15b2a8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: ffff8801cfeef198 R08: ffff8801aac8e600 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: dead000000000200
R13: dead000000000100 R14: ffff8801aa15b2a8 R15: ffff8801aa15b2b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:00000000f7fe9b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001d8066000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  p9_fd_cancel+0x104/0x360 net/9p/trans_fd.c:690
  p9_client_rpc+0xf1f/0x1400 net/9p/client.c:800
  p9_client_version net/9p/client.c:976 [inline]
  p9_client_create+0xd09/0x16c9 net/9p/client.c:1069
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  __do_compat_sys_mount fs/compat.c:125 [inline]
  __se_compat_sys_mount fs/compat.c:92 [inline]
  __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fedcb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7fe91ec EFLAGS: 00000286 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000020002d00
RDX: 0000000020002d40 RSI: 0000000000200000 RDI: 0000000020002d80
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 240dd2352208d421 ]---
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
Code: 02 fe 0f 0b 4c 89 e2 48 89 de 48 c7 c7 a0 65 1a 88 e8 4a 6e 02 fe 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 40 65 1a 88 e8 36 6e 02 fe <0f> 0b 48 89 de  
48 c7 c7 60 66 1a 88 e8 25 6e 02 fe 0f 0b 48 89 de
RSP: 0018:ffff8801cfeef180 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff8801aa15b2a8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: ffff8801cfeef198 R08: ffff8801aac8e600 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: dead000000000200
R13: dead000000000100 R14: ffff8801aa15b2a8 R15: ffff8801aa15b2b0
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:00000000f7fe9b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001d8066000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
