Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96551ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453202098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453202098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeJRXIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:08:30 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:43135 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeJRXIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:08:30 -0400
Received: by mail-io1-f72.google.com with SMTP id y6-v6so28052114ioc.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Sn78PmQailEYeH05nnoniebTvdAjFu3thsNFMKM5RNc=;
        b=eeQabQ/HaD/wrdC+6Ht7laU18QeQNcl6H0WSmPBW7vVzo2FoeRkIh7UyXhhKpxNkia
         K1ZF36Jr7Ul/5n3iDi9mL3Rrm4y0bZwj21twhdXx9ZoilpMwUpkg0Z7sUN5PDhm34YQL
         Ytmmlc5GJ6kCDsy6+hWvYqtNuE69KHVN25acgTXIe+MAF6psNaXnLxJdHoKu8fyPJ4QC
         gmzqnZlKXREyklc6bRfO6aR/5sohwZf1K8yVGvSnVQfcyLTceIizZYaUVSVEV60pYF6U
         q4UpH2xA4xaAeLJxyk0p4t+s0uTCnNrFAf0YaCR/FITFPuFHxNoYYbpJytQnGjQOc8yV
         h5+w==
X-Gm-Message-State: ABuFfoiILgPjrpWJhC5dQ9+ZK4r0tbIeJ6vLsjgpXP9ywHQaTy9OMyV+
        ZVlT9kTQmthokhmYh11nY3Z8rQ0PSE9z/eYWWrvybODrzOOP
X-Google-Smtp-Source: ACcGV625jAQtZyZaFneXOr7bOaQaFWi9GCyfugY44uNqp+wmw7RNLRosUmMNzDMzzBW14x94qyI251EEQDsKPL/pES2bweeVVWPz
MIME-Version: 1.0
X-Received: by 2002:a24:10cd:: with SMTP id 196-v6mr468154ity.21.1539875223279;
 Thu, 18 Oct 2018 08:07:03 -0700 (PDT)
Date:   Thu, 18 Oct 2018 08:07:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aea5d505788223ff@google.com>
Subject: KMSAN: kernel-infoleak in _copy_to_iter (3)
From:   syzbot <syzbot+057458894bc8cada4dee@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    22ec98c3e38f kmsan: unpoison pt_regs in do_nmi()
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=16eeedd6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f3dcd8312e87223
dashboard link: https://syzkaller.appspot.com/bug?extid=057458894bc8cada4dee
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11daa385400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102890f6400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+057458894bc8cada4dee@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: kernel-infoleak in copyout lib/iov_iter.c:140 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x471/0x2640 lib/iov_iter.c:571
CPU: 0 PID: 6126 Comm: syz-executor340 Not tainted 4.19.0-rc7+ #69
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x306/0x460 lib/dump_stack.c:113
  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
  kmsan_internal_check_memory+0x374/0x460 mm/kmsan/kmsan.c:997
  kmsan_copy_to_user+0x89/0xe0 mm/kmsan/kmsan_hooks.c:552
  copyout lib/iov_iter.c:140 [inline]
  _copy_to_iter+0x471/0x2640 lib/iov_iter.c:571
  copy_to_iter include/linux/uio.h:106 [inline]
  skb_copy_datagram_iter+0x4c3/0x1040 net/core/datagram.c:431
  skb_copy_datagram_msg include/linux/skbuff.h:3279 [inline]
  tipc_recvmsg+0xd12/0x1c20 net/tipc/socket.c:1739
  sock_recvmsg_nosec net/socket.c:794 [inline]
  sock_recvmsg net/socket.c:801 [inline]
  sock_read_iter+0x45a/0x4e0 net/socket.c:878
  call_read_iter include/linux/fs.h:1802 [inline]
  new_sync_read fs/read_write.c:406 [inline]
  __vfs_read+0x874/0xb00 fs/read_write.c:418
  vfs_read+0x36f/0x6a0 fs/read_write.c:452
  ksys_read fs/read_write.c:578 [inline]
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read+0x183/0x370 fs/read_write.c:586
  __x64_sys_read+0x4a/0x70 fs/read_write.c:586
  do_syscall_64+0xbe/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x445629
Code: e8 6c b6 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb1d321cdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000006dac28 RCX: 0000000000445629
RDX: 00000000000000f7 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac2c
R13: 00007fff668b970f R14: 00007fb1d321d9c0 R15: 00000000006dad2c

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:270 [inline]
  kmsan_internal_chain_origin+0x136/0x240 mm/kmsan/kmsan.c:572
  kmsan_memcpy_origins+0x13d/0x1b0 mm/kmsan/kmsan.c:396
  __msan_memcpy+0xcf/0x150 mm/kmsan/kmsan_instr.c:286
  tipc_group_create_event+0x672/0xb90 net/tipc/group.c:689
  tipc_group_proto_rcv+0x26a5/0x38f0 net/tipc/group.c:769
  tipc_sk_proto_rcv net/tipc/socket.c:1947 [inline]
  tipc_sk_filter_rcv+0x2948/0x3a40 net/tipc/socket.c:2113
  tipc_sk_enqueue net/tipc/socket.c:2194 [inline]
  tipc_sk_rcv+0xcbe/0x2b10 net/tipc/socket.c:2238
  tipc_node_xmit+0x2f1/0xa00 net/tipc/node.c:1361
  tipc_node_xmit_skb net/tipc/node.c:1410 [inline]
  tipc_node_distr_xmit+0x40d/0x680 net/tipc/node.c:1425
  tipc_sk_rcv+0x1e52/0x2b10 net/tipc/socket.c:2242
  tipc_topsrv_kern_evt net/tipc/topsrv.c:618 [inline]
  tipc_conn_send_to_sock net/tipc/topsrv.c:291 [inline]
  tipc_conn_send_work+0x82e/0xe20 net/tipc/topsrv.c:311
  process_one_work+0x19c4/0x24f0 kernel/workqueue.c:2153
  worker_thread+0x206d/0x2b30 kernel/workqueue.c:2296
  kthread+0x59c/0x5d0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

Local variable description: ----evt.sroa.11@tipc_group_create_event
Variable was created at:
  tipc_group_create_event+0xbf/0xb90 net/tipc/group.c:664
  tipc_group_proto_rcv+0x26a5/0x38f0 net/tipc/group.c:769

Bytes 32-47 of 48 are uninitialized
Memory access of size 48 starts at ffff8801beafd0bc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
