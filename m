Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D918ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4984120C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4984120C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbeGQNzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:55:49 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:37781 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731420AbeGQNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:55:42 -0400
Received: by mail-it0-f70.google.com with SMTP id r10-v6so1099542itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 06:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JmXs5qYNGLxXo6oiAJw8C0EUmUN71ePfF8luDl/jWgQ=;
        b=GzUWVDCK8zzE0S+LZ7tzXeEtba4Nywan3jeEfcVuBb16h8wHdbv44cwHOA0EpfzFpv
         q+Iqc2ScNlb7TQBDhqgw0TD+dywmdjL4yF/Tjb32epGoH6v+o5xiDm3dkF8vvN/RSEHG
         F8Du6to9SyvULCDPt5t+zvO4C5woPyWwLHExg+CP/E9YSbmCBGYSk8HnbOMa4pdS0fMq
         O0XOe3RDhTE+LIpWBTYdQmZi/J3DfAZ6yoC5cPb6l9jRMkcUo4wod4IL8ITta6GIlIha
         LEvax/NoD9/GhAgfnz9XzJG+hqso7ZxI6CYTaFr96m/niJilC47K5zyiZvV5PUMOxeUo
         /d2w==
X-Gm-Message-State: AOUpUlFRfU+Kcd58+TapReDpLLiI3+Y4x43CPyY5vcKFIWCJ40jTZmar
        0YwRwdcBtMawzjouDYnmZ+EtDrbckAz2AM3hFyqtJ3h3MnQm
X-Google-Smtp-Source: AAOMgpewwmeKK5LetLlKK0Wj5v+D9HnHk7wHXZjYxhHwb9xr9x+xJunJronE3PAZ28A+cuOtluzB2R566jaoSP2CfTxYCpG3IU+p
MIME-Version: 1.0
X-Received: by 2002:a24:7acf:: with SMTP id a198-v6mr709615itc.14.1531833782557;
 Tue, 17 Jul 2018 06:23:02 -0700 (PDT)
Date:   Tue, 17 Jul 2018 06:23:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076e6dc057131d87c@google.com>
Subject: KMSAN: kernel-infoleak in put_cmsg
From:   syzbot <syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    123906095e30 kmsan: introduce kmsan_interrupt_enter()/kmsa..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=166dafa0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
dashboard link: https://syzkaller.appspot.com/bug?extid=9adb4b567003cac781f0
compiler:       clang version 7.0.0 (trunk 334104)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=164e4ab0400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a41e40400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: kernel-infoleak in copy_to_user include/linux/uaccess.h:184  
[inline]
BUG: KMSAN: kernel-infoleak in put_cmsg+0x5ef/0x860 net/core/scm.c:242
CPU: 0 PID: 4501 Comm: syz-executor128 Not tainted 4.17.0+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1125
  kmsan_internal_check_memory+0x138/0x1f0 mm/kmsan/kmsan.c:1219
  kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1261
  copy_to_user include/linux/uaccess.h:184 [inline]
  put_cmsg+0x5ef/0x860 net/core/scm.c:242
  ip6_datagram_recv_specific_ctl+0x1cf3/0x1eb0 net/ipv6/datagram.c:719
  ip6_datagram_recv_ctl+0x41c/0x450 net/ipv6/datagram.c:733
  rawv6_recvmsg+0x10fb/0x1460 net/ipv6/raw.c:521
  sock_common_recvmsg+0x173/0x280 net/core/sock.c:3023
  sock_recvmsg_nosec net/socket.c:802 [inline]
  sock_recvmsg+0x1d6/0x230 net/socket.c:809
  ___sys_recvmsg+0x3fe/0x810 net/socket.c:2279
  __sys_recvmsg net/socket.c:2328 [inline]
  __do_sys_recvmsg net/socket.c:2338 [inline]
  __se_sys_recvmsg net/socket.c:2335 [inline]
  __x64_sys_recvmsg+0x325/0x460 net/socket.c:2335
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4456b9
RSP: 002b:00007f5ce4b16da8 EFLAGS: 00000297 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 00000000004456b9
RDX: 0000000000000000 RSI: 00000000200004c0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dac20
R13: 0000000020000500 R14: 0100000000000000 R15: 0000000000000001

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:282 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:297 [inline]
  kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:689
  __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:464
  ip6_datagram_recv_specific_ctl+0x1c3e/0x1eb0 net/ipv6/datagram.c:713
  ip6_datagram_recv_ctl+0x41c/0x450 net/ipv6/datagram.c:733
  rawv6_recvmsg+0x10fb/0x1460 net/ipv6/raw.c:521
  sock_common_recvmsg+0x173/0x280 net/core/sock.c:3023
  sock_recvmsg_nosec net/socket.c:802 [inline]
  sock_recvmsg+0x1d6/0x230 net/socket.c:809
  ___sys_recvmsg+0x3fe/0x810 net/socket.c:2279
  __sys_recvmsg net/socket.c:2328 [inline]
  __do_sys_recvmsg net/socket.c:2338 [inline]
  __se_sys_recvmsg net/socket.c:2335 [inline]
  __x64_sys_recvmsg+0x325/0x460 net/socket.c:2335
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:282 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:192
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:318
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan.c:325
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2753 [inline]
  __kmalloc_node_track_caller+0xb35/0x11b0 mm/slub.c:4395
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cb/0x9e0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:988 [inline]
  __ip6_append_data+0x364d/0x4fb0 net/ipv6/ip6_output.c:1434
  ip6_append_data+0x40e/0x6b0 net/ipv6/ip6_output.c:1597
  rawv6_sendmsg+0x2756/0x4fc0 net/ipv6/raw.c:928
  inet_sendmsg+0x3fc/0x760 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg net/socket.c:639 [inline]
  ___sys_sendmsg+0xec8/0x1320 net/socket.c:2117
  __sys_sendmsg net/socket.c:2155 [inline]
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x331/0x460 net/socket.c:2162
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Bytes 2-3 of 24 are uninitialized
Memory access starts at ffff8801bde1f8a8
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
