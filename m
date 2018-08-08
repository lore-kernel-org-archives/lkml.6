Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE97C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF9B21A8E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF9B21A8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbeHIAAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:00:36 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:47637 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeHIAAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:00:36 -0400
Received: by mail-io0-f200.google.com with SMTP id l25-v6so2768454iog.14
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nl4+L8sb8Vk/LPIqdgPplDCGKckn+3OSrwB+t+mjjiI=;
        b=rseRoVeEGA78T62mbtrX7MdryxVKCqiCMolQ5W8Aqv2hy5zOhXg5SAPgnTdHWG7Lh0
         VxC9oWhMtdRucHzMqqWiNO5PJ+Nj/OZfhhnD9Q11LeJynEsvDid45hXP1/OSudWkl7P9
         l8OzJokEYygfoxiV65NvN9GUVh9oN4Z799aYbFPQe/MDPyYYI44TESZbQOcXjq3Pvk/e
         XXFl/gCqfodwQkCdYuuuLl+KGgFz9PhH/7iWHNSVyyVCkOvRML7MFv3XIpL3Thm01aM/
         95IkR5tDjPTklydOxAjdY3V7a/OSFjY+SYHdXuPvoene8pYD7+mKMMh93do0adA/lqyv
         luxA==
X-Gm-Message-State: AOUpUlF4Z4r+gA0n4N7OMp0KA83IKpTkBAUxQV90lLFcgi1hbtwY3g9A
        kizh99SyCwPCY5wDzKvycOhfqRpKnZCRzGzid2D2YqVw+xne
X-Google-Smtp-Source: AA+uWPw0AZyQN61/e2J+ce2FrCgoZvyc5kYW/9UNkpWglsw2HKFXNpN4daSAyLVIcHVy1EXZ9EPpGMouewrpKoL+XX2LJgfgqInl
MIME-Version: 1.0
X-Received: by 2002:a24:5f51:: with SMTP id r78-v6mr455337itb.6.1533764342748;
 Wed, 08 Aug 2018 14:39:02 -0700 (PDT)
Date:   Wed, 08 Aug 2018 14:39:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1a1ff0572f35616@google.com>
Subject: possible deadlock in team_vlan_rx_add_vid
From:   syzbot <syzbot+bd051aba086537515cdb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0b5b1f9a78b5 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1514a09c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=bd051aba086537515cdb
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16b10a54400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bd051aba086537515cdb@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0

============================================
WARNING: possible recursive locking detected
4.18.0-rc7+ #176 Not tainted
--------------------------------------------
syz-executor4/6391 is trying to acquire lock:
(____ptrval____) (&team->lock){+.+.}, at: team_vlan_rx_add_vid+0x3b/0x1e0  
drivers/net/team/team.c:1868

but task is already holding lock:
(____ptrval____) (&team->lock){+.+.}, at: team_add_slave+0xdb/0x1c30  
drivers/net/team/team.c:1947

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&team->lock);
   lock(&team->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

2 locks held by syz-executor4/6391:
  #0: (____ptrval____) (rtnl_mutex){+.+.}, at: rtnl_lock  
net/core/rtnetlink.c:77 [inline]
  #0: (____ptrval____) (rtnl_mutex){+.+.}, at: rtnetlink_rcv_msg+0x412/0xc30  
net/core/rtnetlink.c:4662
  #1: (____ptrval____) (&team->lock){+.+.}, at: team_add_slave+0xdb/0x1c30  
drivers/net/team/team.c:1947

stack backtrace:
CPU: 1 PID: 6391 Comm: syz-executor4 Not tainted 4.18.0-rc7+ #176
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_deadlock_bug kernel/locking/lockdep.c:1765 [inline]
  check_deadlock kernel/locking/lockdep.c:1809 [inline]
  validate_chain kernel/locking/lockdep.c:2405 [inline]
  __lock_acquire.cold.64+0x1fb/0x486 kernel/locking/lockdep.c:3435
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __mutex_lock_common kernel/locking/mutex.c:757 [inline]
  __mutex_lock+0x176/0x1820 kernel/locking/mutex.c:894
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:909
  team_vlan_rx_add_vid+0x3b/0x1e0 drivers/net/team/team.c:1868
  vlan_add_rx_filter_info+0x14a/0x1d0 net/8021q/vlan_core.c:210
  __vlan_vid_add net/8021q/vlan_core.c:278 [inline]
  vlan_vid_add+0x63e/0x9d0 net/8021q/vlan_core.c:308
  vlan_device_event.cold.12+0x2a/0x2f net/8021q/vlan.c:381
  notifier_call_chain+0x180/0x390 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1735
  call_netdevice_notifiers net/core/dev.c:1753 [inline]
  dev_open+0x173/0x1b0 net/core/dev.c:1433
  team_port_add drivers/net/team/team.c:1219 [inline]
  team_add_slave+0xa8b/0x1c30 drivers/net/team/team.c:1948
  do_set_master+0x1c9/0x220 net/core/rtnetlink.c:2248
  do_setlink+0xba4/0x3e10 net/core/rtnetlink.c:2382
  rtnl_setlink+0x2a9/0x400 net/core/rtnetlink.c:2636
  rtnetlink_rcv_msg+0x46e/0xc30 net/core/rtnetlink.c:4665
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2455
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4683
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfd0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:642 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:652
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2126
  __sys_sendmsg+0x11d/0x290 net/socket.c:2164
  __do_sys_sendmsg net/socket.c:2173 [inline]
  __se_sys_sendmsg net/socket.c:2171 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2171
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456b29
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9706bf8c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9706bf96d4 RCX: 0000000000456b29
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d3548 R14: 00000000004c8227 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
