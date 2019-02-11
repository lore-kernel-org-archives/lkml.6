Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C7AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B6F20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896678;
	bh=lEdXr3+0CJeCfzVo5aHLS7YilbvA5bZFUaRO8xLYbKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=THbcgnAQ2xXnDXCV0PISwwohdIKmk0A29/OjRrUEubWc/X5VoKVjzWWHLOYpIVSKr
	 /LsyVRbM8jG3R/pSOpujJwxZhgrZcTTTC3tsg/moGA7SvBwVhraZNma9nGjUqgOjMF
	 1jSvhui9PxurpqDYmGb89EK8hAg424MMjwhZAURE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbfBKOvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387801AbfBKOvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:51:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D9BC20700;
        Mon, 11 Feb 2019 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896672;
        bh=lEdXr3+0CJeCfzVo5aHLS7YilbvA5bZFUaRO8xLYbKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOXhYn9qpic7cpKkuK6qvl1OOAjlvzBG9Wxrqn3vLIVYqBemu9KBl5cKktn7ZvMP8
         tXgnMwqxmU/u6U0kUgB3ZZarHG8RYbQZG8pXPUfOM7gKXj8/dbQFc/fMOvv5UZ7zL0
         JK3M+e5mLxbHTaQRp0Uj+OG7XtT6MfBJTYiu0vtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 263/313] net: dsa: Fix lockdep false positive splat
Date:   Mon, 11 Feb 2019 15:19:03 +0100
Message-Id: <20190211141910.881671314@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit c8101f7729daee251f4f6505f9d135ec08e1342f ]

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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/master.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/dsa/master.c
+++ b/net/dsa/master.c
@@ -158,6 +158,8 @@ static void dsa_master_ethtool_teardown(
 	cpu_dp->orig_ethtool_ops = NULL;
 }
 
+static struct lock_class_key dsa_master_addr_list_lock_key;
+
 int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 {
 	/* If we use a tagging format that doesn't have an ethertype
@@ -167,6 +169,8 @@ int dsa_master_setup(struct net_device *
 	wmb();
 
 	dev->dsa_ptr = cpu_dp;
+	lockdep_set_class(&dev->addr_list_lock,
+			  &dsa_master_addr_list_lock_key);
 
 	return dsa_master_ethtool_setup(dev);
 }


