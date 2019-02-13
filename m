Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4943EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C262086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404768AbfBMR4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:56:07 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:43323 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391418AbfBMR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:56:06 -0500
Received: by mail-it1-f198.google.com with SMTP id i186so4316793ite.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pTdYDjNhPS6KywDIRH7EPnd0wwC67zRuR3eps0gfOhU=;
        b=Lqtg2+L5BhpfKLrCdQbUcouDTNiswObrz8xN8R1McUK9nervcdrSdvrvuvII7pz9Kf
         ywdeosfJh5f9uSK8zJM/JoxX6ek/iZ+U4xixlWZLd+fhfFgkYu7D4VuVNQs/uPQ3eQGF
         /zxXNFwYuiEhxy6xsTtr7PZVrua1GBqdnXFkk7YtiWNNqOdghuJlYhDf8JAeCSZTYo/8
         PhnI5+esZwP7LyYbBBNoivUbiLsJy//cfT1U0xNaBgZ5GqpCHzl5dXZbL+Rm8pc91Fqe
         sgmRyGenjVQaRrLqfZpMtWZ3RdAjy4aAQOO1splsKKRob5gYngbSv1JvSGVAjCTy1Ue7
         CIWA==
X-Gm-Message-State: AHQUAuYLpaw8plkyl+FmcW0NHaDy9+nwzYHEulT/2hRs2UJ8HWZeATTv
        cVJun3tbs7R4eN+z2cxYHgOXSxs7pvQtql5evaoP+RKSAXFr
X-Google-Smtp-Source: AHgI3IYqvU6n9KOcgLHSWDTmMDhGoqodjdF3UEErTpIsrchL9aCzztZJFZMSGILwQ5XtoeT5G8qHjzmr0NBZst1fDlQIqXHhovXa
MIME-Version: 1.0
X-Received: by 2002:a24:24e:: with SMTP id 75mr1055800itu.0.1550080564639;
 Wed, 13 Feb 2019 09:56:04 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:56:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dc0290581ca413e@google.com>
Subject: WARNING: locking bug in try_to_grab_pending
From:   syzbot <syzbot+2b713236b28823cd4dff@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6663cf821c13 flow_offload: Fix flow action infrastructure
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15927de4c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8572a6e4661225f4
dashboard link: https://syzkaller.appspot.com/bug?extid=2b713236b28823cd4dff
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e932a8c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2b713236b28823cd4dff@syzkaller.appspotmail.com

Started in network mode
Own node identity 7f000001, cluster identity 4711
Enabled bearer <udp:syz0>, priority 10
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
WARNING: CPU: 1 PID: 3476 at kernel/locking/lockdep.c:3315  
__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 3476 Comm: kworker/1:2 Not tainted 5.0.0-rc5+ #59
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue:  addrconf_dad_work (ipv6_addrconf)
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
Code: 8b 1d e9 c7 05 08 45 85 db 0f 85 d6 f4 ff ff 48 c7 c6 a0 a4 6b 87 48  
c7 c7 00 79 6b 87 44 89 9c 24 98 00 00 00 e8 3f 2f ec ff <0f> 0b 44 8b 9c  
24 98 00 00 00 e9 af f4 ff ff 8b 3d 5c 7a fe 08 85
RSP: 0018:ffff88809b5478b0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 00000000005e00a8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815a8f66 RDI: ffffed10136a8f08
RBP: ffff88809b547a78 R08: ffff88809b58e680 R09: fffffbfff1133341
R10: fffffbfff1133340 R11: ffffffff88999a03 R12: ffff88809b58efb8
R13: ffff88809b58efc2 R14: 00000000005e00a8 R15: ffff88809b58e680
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  try_to_grab_pending+0x129/0x710 kernel/workqueue.c:1259
  __cancel_work kernel/workqueue.c:3115 [inline]
  cancel_delayed_work+0x82/0x2d0 kernel/workqueue.c:3144
  addrconf_del_dad_work+0x1c/0x50 net/ipv6/addrconf.c:312
  addrconf_dad_stop+0x129/0x2e0 net/ipv6/addrconf.c:2040
  addrconf_dad_begin net/ipv6/addrconf.c:3973 [inline]
  addrconf_dad_work+0xdbf/0x1150 net/ipv6/addrconf.c:4062
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
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
