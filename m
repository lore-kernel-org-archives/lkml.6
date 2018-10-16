Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131C6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91462098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0aRHuq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91462098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeJQBJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeJQBJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20B021476;
        Tue, 16 Oct 2018 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710271;
        bh=EPQrF7z+k/nGKvWdkPbnpGtIqWtq7tdNOCp4jD9ndT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0aRHuq9HdeLeC7rQTEmI61M+7l9t+BNnKYizIZXqjMJ3niSsC+6+3lxvmgnNHgKC
         YUFaJ7phTynTaxA6pI1yE9Z1zMpDsG3Fz+01qOR4gC2+TsuDM311bGJx7+hurwSyrT
         tepdehlKc9gYtb+EN2Vmqkhp2MTdPpZd7HF9mg/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 023/109] team: Forbid enslaving team device to itself
Date:   Tue, 16 Oct 2018 19:04:51 +0200
Message-Id: <20181016170526.360273145@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 471b83bd8bbe4e89743683ef8ecb78f7029d8288 ]

team's ndo_add_slave() acquires 'team->lock' and later tries to open the
newly enslaved device via dev_open(). This emits a 'NETDEV_UP' event
that causes the VLAN driver to add VLAN 0 on the team device. team's
ndo_vlan_rx_add_vid() will also try to acquire 'team->lock' and
deadlock.

Fix this by checking early at the enslavement function that a team
device is not being enslaved to itself.

A similar check was added to the bond driver in commit 09a89c219baf
("bonding: disallow enslaving a bond to itself").

WARNING: possible recursive locking detected
4.18.0-rc7+ #176 Not tainted
--------------------------------------------
syz-executor4/6391 is trying to acquire lock:
(____ptrval____) (&team->lock){+.+.}, at: team_vlan_rx_add_vid+0x3b/0x1e0 drivers/net/team/team.c:1868

but task is already holding lock:
(____ptrval____) (&team->lock){+.+.}, at: team_add_slave+0xdb/0x1c30 drivers/net/team/team.c:1947

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&team->lock);
  lock(&team->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor4/6391:
 #0: (____ptrval____) (rtnl_mutex){+.+.}, at: rtnl_lock net/core/rtnetlink.c:77 [inline]
 #0: (____ptrval____) (rtnl_mutex){+.+.}, at: rtnetlink_rcv_msg+0x412/0xc30 net/core/rtnetlink.c:4662
 #1: (____ptrval____) (&team->lock){+.+.}, at: team_add_slave+0xdb/0x1c30 drivers/net/team/team.c:1947

stack backtrace:
CPU: 1 PID: 6391 Comm: syz-executor4 Not tainted 4.18.0-rc7+ #176
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
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
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9706bf8c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9706bf96d4 RCX: 0000000000456b29
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d3548 R14: 00000000004c8227 R15: 0000000000000000

Fixes: 87002b03baab ("net: introduce vlan_vid_[add/del] and use them instead of direct [add/kill]_vid ndo calls")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-and-tested-by: syzbot+bd051aba086537515cdb@syzkaller.appspotmail.com
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1165,6 +1165,11 @@ static int team_port_add(struct team *te
 		return -EBUSY;
 	}
 
+	if (dev == port_dev) {
+		netdev_err(dev, "Cannot enslave team device to itself\n");
+		return -EINVAL;
+	}
+
 	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
 	    vlan_uses_dev(dev)) {
 		netdev_err(dev, "Device %s is VLAN challenged and team device has VLAN set up\n",


