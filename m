Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A442C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45398223B5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45398223B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeHJKuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:50:52 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:37774 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeHJKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:50:51 -0400
Received: by mail-io0-f198.google.com with SMTP id s3-v6so3177250iop.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jJzcs9KJR2lhJoEgUOmfALCXsaD9RghouSbfA6xmV6A=;
        b=YoiZpwO/RmHox5DW9TRZnvXb3ud3fCJ0bbsueFJBBHhaYlCdmMFWSP4LREVVxf4LBa
         bKsQI9GLOTWEokO4JYIzYngklOU8a0XwHvJgF5L61N/5dFcR2kLIuAQ3vR9WNJc3kxgl
         damBwgKvqvnnUtZLUHDd5Y0ALqk+DCn3Uqz0V1fYfM6ggsCMOer2jpIrcwrxOgS5n25S
         rKHh6fq/G5gWVhvASCuXqVwFBMB/rLW0UfhaNKizoCWWTOhv+bK/+p2WUuiPE48E8cpJ
         CqtMiyHWoIhIqW5H8bF4Le5ZM7J0+mIEZHeadX155NmKQ1bbZcG7YtKCz38g2Bc+D/sv
         Kzug==
X-Gm-Message-State: AOUpUlFlgwahHIRRtjSQMf+obfbLuIfAUu716l0jF9u0WR8Db2TvMi0Q
        hovN+9Hk9TXePmuTCKgOcXLOA5c2up98x1CpnB+VsQSgQCnq
X-Google-Smtp-Source: AA+uWPyP1IeooIzvhC/0cTH1j0I3PeBEqC9SapWJQyhNyzB+pFKOZ8Au7IASzHYoRhyhrMz0BNstuYKrGpujJnrCwxETA1g0tHbh
MIME-Version: 1.0
X-Received: by 2002:a24:43cb:: with SMTP id s194-v6mr745288itb.3.1533889322033;
 Fri, 10 Aug 2018 01:22:02 -0700 (PDT)
Date:   Fri, 10 Aug 2018 01:22:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a2fdf0573107004@google.com>
Subject: BUG: corrupted list in p9_write_work
From:   syzbot <syzbot+1788bd5d4e051da6ec08@syzkaller.appspotmail.com>
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

HEAD commit:    116b181bb646 Add linux-next specific files for 20180803
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1333a3e0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4f38be7c2c519d5
dashboard link: https://syzkaller.appspot.com/bug?extid=1788bd5d4e051da6ec08
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1788bd5d4e051da6ec08@syzkaller.appspotmail.com

list_add corruption. prev->next should be next (ffff8801c2aad370), but was  
ffff8801c2aad380. (prev=ffff8801b1a15ad8).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:28!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 1879 Comm: kworker/0:2 Not tainted 4.18.0-rc7-next-20180803+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_write_work
RIP: 0010:__list_add_valid.cold.0+0x23/0x25 lib/list_debug.c:26
Code: e8 4f ce 56 fe eb 97 48 89 d9 48 c7 c7 e0 9a 3a 87 e8 32 87 fe fd 0f  
0b 48 89 f1 48 c7 c7 a0 9b 3a 87 48 89 de e8 1e 87 fe fd <0f> 0b 4c 89 e2  
48 89 de 48 c7 c7 e0 9c 3a 87 e8 0a 87 fe fd 0f 0b
RSP: 0018:ffff8801ce447590 EFLAGS: 00010282
RAX: 0000000000000075 RBX: ffff8801c2aad370 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816366f1 RDI: 0000000000000001
RBP: ffff8801ce4475a8 R08: ffff8801ce43a500 R09: ffffed003b604fd0
R10: ffffed003b604fd0 R11: ffff8801db027e87 R12: ffff8801b1a15ad8
R13: ffff8801b1a15ad8 R14: ffff8801c2aad3c4 R15: ffff8801b1a15ad8
FS:  0000000000000000(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31525000 CR3: 00000001b53b4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  list_move_tail include/linux/list.h:183 [inline]
  p9_write_work+0x34e/0xd50 net/9p/trans_fd.c:470
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace fb8b29d28d8f9975 ]---
RIP: 0010:__list_add_valid.cold.0+0x23/0x25 lib/list_debug.c:26
Code: e8 4f ce 56 fe eb 97 48 89 d9 48 c7 c7 e0 9a 3a 87 e8 32 87 fe fd 0f  
0b 48 89 f1 48 c7 c7 a0 9b 3a 87 48 89 de e8 1e 87 fe fd <0f> 0b 4c 89 e2  
48 89 de 48 c7 c7 e0 9c 3a 87 e8 0a 87 fe fd 0f 0b
RSP: 0018:ffff8801ce447590 EFLAGS: 00010282
RAX: 0000000000000075 RBX: ffff8801c2aad370 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816366f1 RDI: 0000000000000001
RBP: ffff8801ce4475a8 R08: ffff8801ce43a500 R09: ffffed003b604fd0
R10: ffffed003b604fd0 R11: ffff8801db027e87 R12: ffff8801b1a15ad8
R13: ffff8801b1a15ad8 R14: ffff8801c2aad3c4 R15: ffff8801b1a15ad8
FS:  0000000000000000(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31525000 CR3: 00000001b53b4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
