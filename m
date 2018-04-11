Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeDKFrD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:47:03 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:40730 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeDKFrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:47:02 -0400
X-Google-Smtp-Source: AIpwx4/hPcVfoasE327BinMtpxokfcgUYyX3+nGPHkI9zDYAomXCuJIEjgeeRcOw9upR8hVdEAwf3Lxl7Zea8CVTGJyFmYa+yu4e
MIME-Version: 1.0
Date: Tue, 10 Apr 2018 22:47:01 -0700
In-Reply-To: <001a113e8e9c15014705695813be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001127905698c2b00@google.com>
Subject: Re: KMSAN: uninit-value in tipc_subscrb_rcv_cb
From: syzbot <syzbot+75e6e042c5bbf691fc82@syzkaller.appspotmail.com>
To: davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on  
https://github.com/google/kmsan.git/master commit
35ff515e4bda2646f6c881d33951c306ea9c282a (Tue Apr 10 08:59:43 2018 +0000)
Merge pull request #11 from parkerduckworth/readme
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=75e6e042c5bbf691fc82

So far this crash happened 3 times on  
https://github.com/google/kmsan.git/master.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6676653019234304
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5693411524870144
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5043527943716864
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6627248707860932248
compiler: clang version 7.0.0 (trunk 329391)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+75e6e042c5bbf691fc82@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

==================================================================
BUG: KMSAN: uninit-value in htohl net/tipc/subscr.c:66 [inline]
BUG: KMSAN: uninit-value in tipc_subscrb_rcv_cb+0x418/0xe80  
net/tipc/subscr.c:339
CPU: 0 PID: 19 Comm: kworker/u4:1 Not tainted 4.16.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: tipc_rcv tipc_recv_work
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
  htohl net/tipc/subscr.c:66 [inline]
  tipc_subscrb_rcv_cb+0x418/0xe80 net/tipc/subscr.c:339
  tipc_receive_from_sock+0x64c/0x800 net/tipc/server.c:271
  tipc_recv_work+0xd8/0x1f0 net/tipc/server.c:618
  process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2113
  worker_thread+0x113c/0x24f0 kernel/workqueue.c:2247
  kthread+0x539/0x720 kernel/kthread.c:239
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:406

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmem_cache_alloc+0xaab/0xb90 mm/slub.c:2756
  tipc_receive_from_sock+0x15c/0x800 net/tipc/server.c:253
  tipc_recv_work+0xd8/0x1f0 net/tipc/server.c:618
  process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2113
  worker_thread+0x113c/0x24f0 kernel/workqueue.c:2247
  kthread+0x539/0x720 kernel/kthread.c:239
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:406
==================================================================
