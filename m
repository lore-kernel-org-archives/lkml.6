Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5175BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2DB20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2DB20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeKTIEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:04:40 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:35799 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731020AbeKTIEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:04:39 -0500
Received: by mail-io1-f70.google.com with SMTP id n12-v6so32288900ioh.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BtYGSDO4B1hZmVN2oLANc7KOz+6cCS6gl1gTy5bwZuo=;
        b=f/vANNMaqqDLJKmWrnUDsN4eIQfnumUQY9HzfyP5cKZVeyGjmj8O6uGPqoCRqx6cFu
         DRKwhn640glYtw8KfWxlXanMAcFAysiAmNM9/gtEX0tYyYi6G1EliJyDMotcKb0V2A93
         smzj7Gwzu0uQ/YHgMAi5p5Rfy/QORABy19RGPBc3iMfLc+yr251TYMqfLiiNoOqBCHc1
         cBB5ANVgWyUVBty/oIMgrjLKRtFKlgUJNdCTlNFLsauHmLU+dzRcxxN4EcySGpQG2n4n
         a0uWDf08BfPiy0yTH4pa7yBniKQKmKqtmEnbnkAZ7C9roo2jP8kLkKGPtFW7speR/hXa
         wNdw==
X-Gm-Message-State: AA+aEWaklzQB8tbxuqM1TD2gh+APEvQANQ8kmhq4LKtKcMRidgwIk6Ls
        q2+EPlw6jTaQJUa78PoMRWZxs/1iDPXw5TIMRpfSZLSfZrE1
X-Google-Smtp-Source: AFSGD/WDeRMqC06XkOgAMYzmmuU3l2bZhuTewJPgcaPNus9SJIsWAJpxkttc3UyUq2NYQMBZvu81gl1VsR6tYlTkjERqphnRvCNU
MIME-Version: 1.0
X-Received: by 2002:a6b:7f08:: with SMTP id l8mr13038797ioq.6.1542663542677;
 Mon, 19 Nov 2018 13:39:02 -0800 (PST)
Date:   Mon, 19 Nov 2018 13:39:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007829c8057b0b58ed@google.com>
Subject: KASAN: use-after-free Read in tick_sched_handle (3)
From:   syzbot <syzbot+999bca54de2ee169c021@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bae4e109837b mlxsw: spectrum: Expose discard counters via ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11b5e77b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=999bca54de2ee169c021
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b7d093400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1487a225400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+999bca54de2ee169c021@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
kasan: CONFIG_KASAN_INLINE enabled
BUG: KASAN: use-after-free in tick_sched_handle+0x16c/0x180  
kernel/time/tick-sched.c:164
Read of size 8 at addr ffff8881c0895a30 by task syz-executor949/6058
kasan: GPF could be caused by NULL-ptr deref or user memory access

CPU: 0 PID: 6058 Comm: syz-executor949 Not tainted 4.20.0-rc2+ #303
general protection fault: 0000 [#1] PREEMPT SMP KASAN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
CPU: 1 PID: 2938 Comm: kworker/1:2 Not tainted 4.20.0-rc2+ #303
Call Trace:
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
  <IRQ>
Workqueue: ipv6_addrconf addrconf_dad_work
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
RIP: 0010:sk_fullsock include/net/sock.h:2402 [inline]
RIP: 0010:skb_set_owner_w+0xb4/0x320 net/core/sock.c:1842
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 30 02 00 00 49 8d 7c 24 12 4c 89  
63 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 cd 01 00 00
RSP: 0018:ffff8881cb9274a8 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffff8881c2cf4bc0 RCX: ffffffff86273988
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
RDX: 000000000000000e RSI: ffffffff8625bddf RDI: 0000000000000074
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
RBP: ffff8881cb9274d0 R08: ffff8881cb98e280 R09: ffffed103701800c
R10: ffffed103701800c R11: ffff8881b80c0063 R12: 0000000000000062
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
R13: ffff8881c2cf4bd8 R14: ffff8881c2cf4c20 R15: 0000000000000020
  tick_sched_handle+0x16c/0x180 kernel/time/tick-sched.c:164
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
CR2: 00007fff57a32ff8 CR3: 00000001cb905000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ndisc_alloc_skb+0x284/0x340 net/ipv6/ndisc.c:419
  ndisc_send_ns+0x194/0x8e0 net/ipv6/ndisc.c:609
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
  addrconf_dad_work+0xbf2/0x1310 net/ipv6/addrconf.c:4077
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:804
  </IRQ>

Allocated by task 3230256160:
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
BUG: unable to handle kernel paging request at ffffffff8caa3e08
---[ end trace 6c1017c956f17b9c ]---
PGD 946d067 P4D 946d067 PUD 946e063 PMD 0
Thread overran stack, or stack corrupted
Oops: 0000 [#2] PREEMPT SMP KASAN
RIP: 0010:sk_fullsock include/net/sock.h:2402 [inline]
RIP: 0010:skb_set_owner_w+0xb4/0x320 net/core/sock.c:1842
CPU: 0 PID: 6058 Comm: syz-executor949 Tainted: G      D            
4.20.0-rc2+ #303
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
Code: 89 e8 44 96 1c fe e9 87 fd ff ff e8 8a b0 a2 fd 90 90 90 90 90 90 90  
90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 00  
fa ad 8b 8b 47 0c 48 83 c7 18 c7 46 10 00 00 00 00
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 30 02 00 00 49 8d 7c 24 12 4c 89  
63 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 cd 01 00 00
RSP: 0018:ffff8881dae07a38 EFLAGS: 00010006
RAX: 00000000001f8881 RBX: ffff8881c089cb84 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8881dae07a40 RDI: 0000000000003ff0
RBP: ffff8881dae07a68 R08: ffff8881c1da0080 R09: ffffed103b5c3ef8
R10: ffffed103b5c3ef8 R11: ffff8881dae1f7c7 R12: ffffea0007022400
RSP: 0018:ffff8881cb9274a8 EFLAGS: 00010203
R13: ffff8881c0894b80 R14: ffff8881da802380 R15: ffff8881c089cb80
FS:  000000000137f880(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8caa3e08 CR3: 00000001c3bee000 CR4: 00000000001406f0
RAX: dffffc0000000000 RBX: ffff8881c2cf4bc0 RCX: ffffffff86273988
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
RDX: 000000000000000e RSI: ffffffff8625bddf RDI: 0000000000000074
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  describe_object mm/kasan/report.c:243 [inline]
  print_address_description.cold.7+0x15b/0x1ff mm/kasan/report.c:263
RBP: ffff8881cb9274d0 R08: ffff8881cb98e280 R09: ffffed103701800c
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
R10: ffffed103701800c R11: ffff8881b80c0063 R12: 0000000000000062
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  tick_sched_handle+0x16c/0x180 kernel/time/tick-sched.c:164
R13: ffff8881c2cf4bd8 R14: ffff8881c2cf4c20 R15: 0000000000000020
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001cb905000 CR4: 00000000001406e0
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
