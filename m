Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA32C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82432173D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82432173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeHNJFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:05:45 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:46052 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbeHNJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:05:45 -0400
Received: by mail-io0-f199.google.com with SMTP id l24-v6so15693493ioj.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 23:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=m7atFQTMFzL5Fh6C2aGF2D999E7bogv0i5/cNBB6/x0=;
        b=ACQx6sQ1Oib3jGfNsr7EVTFVSUUtYFYuTaAKXT57qT4z1dFZJIV4tG5p62fPtiLIBc
         tf514OD8ZEr/izLwp6yo9QKmx2zFji5xJ+b0h2Eu1n+7Gx4j8oiHlS3DLlEWs4zJHmGi
         5j387kAoFsphqp00OFn6RCtrIR7XyCvci6l62YewWzHsoZehhH+Yt2oQPweaEUekxTeD
         UnxzBnn3KoVP3Bs1R7eDQgwKDiOJ1/74Wjamc36KpvE8fFWqf80/p5kHA2IfWi/PdFsQ
         yBmUERnJnPL6y2dJKMLRNC7ZFIS28PtC0z3z6yKpU7DWrH110zQox4kccne9Ju7ElHvJ
         r6gw==
X-Gm-Message-State: AOUpUlHf3TxdGpGX69qXbQoxt5f4e19Iy0n5dLRAVV5F0tBFkkv4T6W3
        gCd/ar198qaGHmEZmPbBt6bfR9jXpFEouCYnRwff0m5R9RCK
X-Google-Smtp-Source: AA+uWPxrc8pOCL4hBgWcffR879Df+iuXXhRKM8zCjl0DTlzKMNRcCguX5tosUXF2TJEIig1t11yJ0+dl30PN/DYp8hmn1Bx1rfL4
MIME-Version: 1.0
X-Received: by 2002:a24:5c8f:: with SMTP id q137-v6mr7482726itb.38.1534227602705;
 Mon, 13 Aug 2018 23:20:02 -0700 (PDT)
Date:   Mon, 13 Aug 2018 23:20:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043975f05735f33f0@google.com>
Subject: possible deadlock in rhashtable_lookup_insert_fast
From:   syzbot <syzbot+b66a5a554991a8ed027c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        keescook@chromium.org, ktkhai@virtuozzo.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pombredanne@nexb.com, stephen@networkplumber.org,
        syzkaller-bugs@googlegroups.com, tom@herbertland.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    36d2f761b5aa cxgb4: update 1.20.8.0 as the latest firmware..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=134b323c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbf55ebfa6bfd517
dashboard link: https://syzkaller.appspot.com/bug?extid=b66a5a554991a8ed027c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=103285f0400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12859d72400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b66a5a554991a8ed027c@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
netlink: 'syz-executor077': attribute type 8 has an invalid length.

============================================
WARNING: possible recursive locking detected
4.18.0-rc8+ #179 Not tainted
--------------------------------------------
syz-executor077/4391 is trying to acquire lock:
(____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: spin_lock_bh  
include/linux/spinlock.h:315 [inline]
(____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: __rhashtable_insert_fast  
include/linux/rhashtable.h:596 [inline]
(____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at:  
rhashtable_lookup_insert_fast.constprop.26+0x436/0x13a0  
include/linux/rhashtable.h:784

but task is already holding lock:
(____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: spin_lock  
include/linux/spinlock.h:310 [inline]
(____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: ila_add_mapping  
net/ipv6/ila/ila_xlat.c:233 [inline]
(____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at:  
ila_xlat_nl_cmd_add_mapping+0x6bb/0x17e0 net/ipv6/ila/ila_xlat.c:355

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&(&tlocks[i])->rlock);
   lock(&(&tlocks[i])->rlock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

3 locks held by syz-executor077/4391:
  #0: (____ptrval____) (cb_lock){++++}, at: genl_rcv+0x19/0x40  
net/netlink/genetlink.c:636
  #1: (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: spin_lock  
include/linux/spinlock.h:310 [inline]
  #1: (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at: ila_add_mapping  
net/ipv6/ila/ila_xlat.c:233 [inline]
  #1: (____ptrval____) (&(&tlocks[i])->rlock){+.+.}, at:  
ila_xlat_nl_cmd_add_mapping+0x6bb/0x17e0 net/ipv6/ila/ila_xlat.c:355
  #2: (____ptrval____) (rcu_read_lock){....}, at: __rhashtable_insert_fast  
include/linux/rhashtable.h:579 [inline]
  #2: (____ptrval____) (rcu_read_lock){....}, at:  
rhashtable_lookup_insert_fast.constprop.26+0x1d7/0x13a0  
include/linux/rhashtable.h:784

stack backtrace:
CPU: 1 PID: 4391 Comm: syz-executor077 Not tainted 4.18.0-rc8+ #179
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_deadlock_bug kernel/locking/lockdep.c:1765 [inline]
  check_deadlock kernel/locking/lockdep.c:1809 [inline]
  validate_chain kernel/locking/lockdep.c:2405 [inline]
  __lock_acquire.cold.65+0x1fb/0x486 kernel/locking/lockdep.c:3435
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:315 [inline]
  __rhashtable_insert_fast include/linux/rhashtable.h:596 [inline]
  rhashtable_lookup_insert_fast.constprop.26+0x436/0x13a0  
include/linux/rhashtable.h:784
  ila_add_mapping net/ipv6/ila/ila_xlat.c:240 [inline]
  ila_xlat_nl_cmd_add_mapping+0xafe/0x17e0 net/ipv6/ila/ila_xlat.c:355
  genl_family_rcv_msg+0x8a3/0x1140 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:640 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:650
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2133
  __sys_sendmsg+0x11d/0x290 net/socket.c:2171
  __do_sys_sendmsg net/socket.c:2180 [inline]
  __se_sys_sendmsg net/socket.c:2178 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2178
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4400e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd14495758 EFLAG


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
