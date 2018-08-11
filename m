Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E62C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FBC21986
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FBC21986
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeHKLde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 07:33:34 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:58144 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbeHKLde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 07:33:34 -0400
Received: by mail-it0-f71.google.com with SMTP id e6-v6so4106897itc.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 02:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4SSNiMoGvpjw741qPowh7+TsCkqXWfqrhf8m2tJA9I4=;
        b=sGCgt93iLv7c2HS6k4LKCM1q8FL+WoQKQOMRE73bljhSh2bGwlGN497c0j3l5FPJMs
         xjOzXSyae0MTDRvfBqv8pyQsdFhc2AseJGiml1Rojuy5R0hE32YyM5vQjpQ67Zv5CPvZ
         nZObjqD0cyXMN2u1+EMk+y4Fpzgv0x2pPOJ8ChHIqDrNJzq7fTpU0ktkNtNt2irGY9+7
         qLPJQMcFYdsb0cUUAoWtcpaWvuAaHEhdeA4rgWYGf/o+zS0oUp10jiwPpGjBZ7YGr0/U
         W1rf+YfY+JcB8eYn8ZBeeILxKgIOc5h1IpI2zMN+gKpMggBbXtNhbRK3EvouNZLvpqHS
         ivyw==
X-Gm-Message-State: AOUpUlFX5bg56vafb/qA0QJi9nCBq1hAsleroXLtmr839ljdka7MKHps
        Nd55i5m7wG2vZYdmQ2518j9+pWQtyatalwxUrl85R84QEhBd
X-Google-Smtp-Source: AA+uWPyq1iwXx4wdQ+qjYYNBpXiycFFBmY5tHVBefsUBpFsBkGxd3xzwtarQO64DlFHJwApuWoysJXstaIJuQY13BR4Ng+FdhjfE
MIME-Version: 1.0
X-Received: by 2002:a24:56ce:: with SMTP id o197-v6mr2735798itb.32.1533978002653;
 Sat, 11 Aug 2018 02:00:02 -0700 (PDT)
Date:   Sat, 11 Aug 2018 02:00:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f10c530573251563@google.com>
Subject: BUG: corrupted list in end_requests
From:   syzbot <syzbot+0d2dc8aade663e725664@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1236568ee3cb Merge tag 'gpio-v4.18-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bf0c9c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
dashboard link: https://syzkaller.appspot.com/bug?extid=0d2dc8aade663e725664
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0d2dc8aade663e725664@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffff8801ae811e00, but was  
ffff8801b5477738
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 17968 Comm: syz-executor0 Not tainted 4.18.0-rc8+ #180
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x58 lib/list_debug.c:51
Code: 68 3a 87 e8 36 92 02 fe 0f 0b 48 89 de 48 c7 c7 e0 69 3a 87 e8 25 92  
02 fe 0f 0b 48 89 de 48 c7 c7 80 69 3a 87 e8 14 92 02 fe <0f> 0b 90 90 90  
90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57
RSP: 0018:ffff8801b5477490 EFLAGS: 00010282
RAX: 0000000000000054 RBX: ffff8801ae811e00 RCX: ffffc90002e24000
RDX: 0000000000000000 RSI: ffffffff81632481 RDI: 0000000000000001
RBP: ffff8801b54774a8 R08: ffff88019a1760c0 R09: ffffed003b604fc0
R10: ffffed003b604fc0 R11: ffff8801db027e07 R12: ffff8801ae811e00
R13: ffff8801b5477738 R14: ffff8801ae811e00 R15: dffffc0000000000
FS:  00007f8f17566700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000704071 CR3: 00000001ac63b000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  end_requests+0x180/0x460 fs/fuse/dev.c:2044
  fuse_abort_conn+0xf9c/0x1580 fs/fuse/dev.c:2138
  fuse_put_super+0x123/0x440 fs/fuse/inode.c:396
  generic_shutdown_super+0x1bf/0x530 fs/super.c:453
  kill_anon_super+0x3c/0x50 fs/super.c:1046
  fuse_kill_sb_anon+0x90/0xb0 fs/fuse/inode.c:1223
  deactivate_locked_super+0x97/0x100 fs/super.c:326
  deactivate_super+0x193/0x1c0 fs/super.c:357
  cleanup_mnt+0xbf/0x160 fs/namespace.c:1174
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1181
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456cb9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8f17565c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f8f175666d4 RCX: 0000000000456cb9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00000000009301e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d6360 R14: 00000000004c9ab8 R15: 0000000000000002
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 060c5491c93d7527 ]---
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x58 lib/list_debug.c:51
Code: 68 3a 87 e8 36 92 02 fe 0f 0b 48 89 de 48 c7 c7 e0 69 3a 87 e8 25 92  
02 fe 0f 0b 48 89 de 48 c7 c7 80 69 3a 87 e8 14 92 02 fe <0f> 0b 90 90 90  
90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57
RSP: 0018:ffff8801b5477490 EFLAGS: 00010282
RAX: 0000000000000054 RBX: ffff8801ae811e00 RCX: ffffc90002e24000
RDX: 0000000000000000 RSI: ffffffff81632481 RDI: 0000000000000001
RBP: ffff8801b54774a8 R08: ffff88019a1760c0 R09: ffffed003b604fc0
R10: ffffed003b604fc0 R11: ffff8801db027e07 R12: ffff8801ae811e00
R13: ffff8801b5477738 R14: ffff8801ae811e00 R15: dffffc0000000000
FS:  00007f8f17566700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000704071 CR3: 00000001ac63b000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
