Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228CAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E782A20855
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbeL2AlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 19:41:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:42848 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeL2AlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 19:41:05 -0500
Received: by mail-it1-f198.google.com with SMTP id g7so26775171itg.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 16:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ccmquVeqcBKtWF0Rq4M0ehdIJy/Og6ezpqhC3FSj9XU=;
        b=cRiSD0wu+gOeDpz8vQPoBjOzxIh2yFCydGez4EvWkRwnZL1FQTi/fxCQEbqkIDULh3
         patKOOFrd7jPrJvpwFgHkR+KOfkDpY+DTdiuSe3vJuaMYQmTTrmgDo49MIoaGBwnjBeT
         Tr6TezxwF7ORnSkNkqQNW3QrK6mXbtb1niXhV4nSs5Ln5VLbg6GIxJ8B3M6TPnH7w9pV
         76LmD55ZDAhyC1cXmVp8sJjoHhETAaFTabmXW5plsD6U/jtH/OLRVLxt+eBUQ8zvOboV
         4Ew3mNIGtj2cyhrzIKodiqamW8SM0Ydc3MnbR8Aojau3MS0jx2l1i4Q/UTkTL6TYKsu0
         Oc3g==
X-Gm-Message-State: AJcUukcpIN6f765kWviV0+NwlEkfJu0DiZGfzqJzDeqnsbWsSIYx+FxL
        7mC47sYM3KmlRrhra7B0NQnn/66quJnSYruwnXRyWMWClIdj
X-Google-Smtp-Source: ALg8bN4r1ZH4ARK9yoo6ocE4filD46u5Sh62lR5tGbx9Qi5jBB94obS0nClBTqizaE80adrW4xWZaY3uMZfEs2DdXpgiTGK6PJyR
MIME-Version: 1.0
X-Received: by 2002:a6b:8e83:: with SMTP id q125mr27648689iod.9.1546044064435;
 Fri, 28 Dec 2018 16:41:04 -0800 (PST)
Date:   Fri, 28 Dec 2018 16:41:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000449587057e1e6f8b@google.com>
Subject: WARNING in __might_sleep (2)
From:   syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fe28cb58bcb Linux 4.20
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16211a3b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d581260bae0899a
dashboard link: https://syzkaller.appspot.com/bug?extid=c244af085a0159d22879
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1617cd8b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f5089b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c244af085a0159d22879@syzkaller.appspotmail.com

audit: type=1800 audit(1545700018.193:29): pid=7508 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rc.local" dev="sda1" ino=2432 res=0
------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at  
[<000000004df58f46>] n_hdlc_tty_read+0x301/0x7f0 drivers/tty/n_hdlc.c:589
WARNING: CPU: 0 PID: 7659 at kernel/sched/core.c:6099  
__might_sleep+0x13d/0x190 kernel/sched/core.c:6094
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7659 Comm: syz-executor111 Not tainted 4.20.0 #387
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__might_sleep+0x13d/0x190 kernel/sched/core.c:6094
Code: 65 48 8b 1c 25 40 ee 01 00 48 8d 7b 10 48 89 fe 48 c1 ee 03 80 3c 06  
00 75 2b 48 8b 73 10 48 c7 c7 40 e0 2a 88 e8 43 27 f3 ff <0f> 0b e9 43 ff  
ff ff e8 f7 7c 6c 00 e9 26 ff ff ff e8 ed 7c 6c 00
RSP: 0018:ffff8881b8db7948 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8881b8cae6c0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8164e045 RDI: 0000000000000005
RBP: ffff8881b8db7978 R08: ffff8881b8cae6c0 R09: 0000000000000007
R10: 0000000000000000 R11: ffff8881b8cae6c0 R12: ffffffff8860b220
R13: 0000000000000019 R14: 0000000000000000 R15: ffff8881b8cae6c0
  __might_fault+0xc6/0x1e0 mm/memory.c:4357
  _copy_to_user+0x30/0x110 lib/usercopy.c:25
  copy_to_user include/linux/uaccess.h:155 [inline]
  n_hdlc_tty_read+0x5c1/0x7f0 drivers/tty/n_hdlc.c:600
  tty_read+0x194/0x2a0 drivers/tty/tty_io.c:866
  __vfs_read+0x117/0x9b0 fs/read_write.c:416
  vfs_read+0x17f/0x3c0 fs/read_write.c:452
  ksys_read+0x101/0x260 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440099
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeeb4e9ec8 EFLAGS: 00000207 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440099
RDX: 0000000000000057 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000207 R12: 0000000000401920
R13: 00000000004019b0 R14: 0000000000000000 R15: 0000000000000000
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
