Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41442C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E18D2082C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfBBRxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:53:42 -0500
Received: from foss.arm.com ([217.140.101.70]:42874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfBBRxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:53:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73AA6A78;
        Sat,  2 Feb 2019 09:53:41 -0800 (PST)
Received: from why.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0B1A3F589;
        Sat,  2 Feb 2019 09:53:39 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] net: dsa: Fix lockdep false positive splat
Date:   Sat,  2 Feb 2019 17:53:29 +0000
Message-Id: <20190202175329.5969-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating a macvtap on a DSA-backed interface results in the following
splat when lockdep is enabled:

[   19.638080] IPv6: ADDRCONF(NETDEV_CHANGE): lan0: link becomes ready
[   23.041198] device lan0 entered promiscuous mode
[   23.043445] device eth0 entered promiscuous mode
[   23.049255]
[   23.049557] ============================================
[   23.055021] WARNING: possible recursive locking detected
[   23.060490] 5.0.0-rc3-00013-g56c857a1b8d3 #118 Not tainted
[   23.066132] --------------------------------------------
[   23.071598] ip/2861 is trying to acquire lock:
[   23.076171] 00000000f61990cb (_xmit_ETHER){+...}, at: dev_set_rx_mode+0x1c/0x38
[   23.083693]
[   23.083693] but task is already holding lock:
[   23.089696] 00000000ecf0c3b4 (_xmit_ETHER){+...}, at: dev_uc_add+0x24/0x70
[   23.096774]
[   23.096774] other info that might help us debug this:
[   23.103494]  Possible unsafe locking scenario:
[   23.103494]
[   23.109584]        CPU0
[   23.112093]        ----
[   23.114601]   lock(_xmit_ETHER);
[   23.117917]   lock(_xmit_ETHER);
[   23.121233]
[   23.121233]  *** DEADLOCK ***
[   23.121233]
[   23.127325]  May be due to missing lock nesting notation
[   23.127325]
[   23.134315] 2 locks held by ip/2861:
[   23.137987]  #0: 000000003b766c72 (rtnl_mutex){+.+.}, at: rtnetlink_rcv_msg+0x338/0x4e0
[   23.146231]  #1: 00000000ecf0c3b4 (_xmit_ETHER){+...}, at: dev_uc_add+0x24/0x70
[   23.153757]
[   23.153757] stack backtrace:
[   23.158243] CPU: 0 PID: 2861 Comm: ip Not tainted 5.0.0-rc3-00013-g56c857a1b8d3 #118
[   23.166212] Hardware name: Globalscale Marvell ESPRESSOBin Board (DT)
[   23.172843] Call trace:
[   23.175358]  dump_backtrace+0x0/0x188
[   23.179116]  show_stack+0x14/0x20
[   23.182524]  dump_stack+0xb4/0xec
[   23.185928]  __lock_acquire+0x123c/0x1860
[   23.190048]  lock_acquire+0xc8/0x248
[   23.193724]  _raw_spin_lock_bh+0x40/0x58
[   23.197755]  dev_set_rx_mode+0x1c/0x38
[   23.201607]  dev_set_promiscuity+0x3c/0x50
[   23.205820]  dsa_slave_change_rx_flags+0x5c/0x70
[   23.210567]  __dev_set_promiscuity+0x148/0x1e0
[   23.215136]  __dev_set_rx_mode+0x74/0x98
[   23.219167]  dev_uc_add+0x54/0x70
[   23.222575]  macvlan_open+0x170/0x1d0
[   23.226336]  __dev_open+0xe0/0x160
[   23.229830]  __dev_change_flags+0x16c/0x1b8
[   23.234132]  dev_change_flags+0x20/0x60
[   23.238074]  do_setlink+0x2d0/0xc50
[   23.241658]  __rtnl_newlink+0x5f8/0x6e8
[   23.245601]  rtnl_newlink+0x50/0x78
[   23.249184]  rtnetlink_rcv_msg+0x360/0x4e0
[   23.253397]  netlink_rcv_skb+0xe8/0x130
[   23.257338]  rtnetlink_rcv+0x14/0x20
[   23.261012]  netlink_unicast+0x190/0x210
[   23.265043]  netlink_sendmsg+0x288/0x350
[   23.269075]  sock_sendmsg+0x18/0x30
[   23.272659]  ___sys_sendmsg+0x29c/0x2c8
[   23.276602]  __sys_sendmsg+0x60/0xb8
[   23.280276]  __arm64_sys_sendmsg+0x1c/0x28
[   23.284488]  el0_svc_common+0xd8/0x138
[   23.288340]  el0_svc_handler+0x24/0x80
[   23.292192]  el0_svc+0x8/0xc

This looks fairly harmless (no actual deadlock occurs), and is
fixed in a similar way to c6894dec8ea9 ("bridge: fix lockdep
addr_list_lock false positive splat") by putting the addr_list_lock
in its own lockdep class.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 net/dsa/master.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/dsa/master.c b/net/dsa/master.c
index 71bb15f491c8..54f5551fb799 100644
--- a/net/dsa/master.c
+++ b/net/dsa/master.c
@@ -205,6 +205,8 @@ static void dsa_master_reset_mtu(struct net_device *dev)
 	rtnl_unlock();
 }
 
+static struct lock_class_key dsa_master_addr_list_lock_key;
+
 int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 {
 	int ret;
@@ -218,6 +220,8 @@ int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 	wmb();
 
 	dev->dsa_ptr = cpu_dp;
+	lockdep_set_class(&dev->addr_list_lock,
+			  &dsa_master_addr_list_lock_key);
 
 	ret = dsa_master_ethtool_setup(dev);
 	if (ret)
-- 
2.20.1

