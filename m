Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A86C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33ED322511
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGkW2VLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33ED322511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbeKOI1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbeKOI12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:28 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51BDD22528;
        Wed, 14 Nov 2018 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234145;
        bh=n3bXEiOnbSGwjuoSEajstyAvThvgoTqFnTZJTc0WWfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGkW2VLsThBoA49Ga8vZei+53VWxdmLz9ViJPg1uZEjH3Wc/cK1wiOlBMfOePsWYo
         ltCvwNQkT4kTwEeYLbnNforrcOjTpUg956guP8EVXVYic7LKSY/lkwtGdyC3ylIJGm
         w7i53a12+h8Y5HlJ7T7srhFqe78B6EkeG/gB2n/c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Sean Tranchetti <stranche@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 70/73] net: qualcomm: rmnet: Fix incorrect assignment of real_dev
Date:   Wed, 14 Nov 2018 17:22:04 -0500
Message-Id: <20181114222207.98701-70-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit d02854dc1999ed3e7fd79ec700c64ac23ac0c458 ]

A null dereference was observed when a sysctl was being set
from userspace and rmnet was stuck trying to complete some actions
in the NETDEV_REGISTER callback. This is because the real_dev is set
only after the device registration handler completes.

sysctl call stack -

<6> Unable to handle kernel NULL pointer dereference at
    virtual address 00000108
<2> pc : rmnet_vnd_get_iflink+0x1c/0x28
<2> lr : dev_get_iflink+0x2c/0x40
<2>  rmnet_vnd_get_iflink+0x1c/0x28
<2>  inet6_fill_ifinfo+0x15c/0x234
<2>  inet6_ifinfo_notify+0x68/0xd4
<2>  ndisc_ifinfo_sysctl_change+0x1b8/0x234
<2>  proc_sys_call_handler+0xac/0x100
<2>  proc_sys_write+0x3c/0x4c
<2>  __vfs_write+0x54/0x14c
<2>  vfs_write+0xcc/0x188
<2>  SyS_write+0x60/0xc0
<2>  el0_svc_naked+0x34/0x38

device register call stack -

<2>  notifier_call_chain+0x84/0xbc
<2>  raw_notifier_call_chain+0x38/0x48
<2>  call_netdevice_notifiers_info+0x40/0x70
<2>  call_netdevice_notifiers+0x38/0x60
<2>  register_netdevice+0x29c/0x3d8
<2>  rmnet_vnd_newlink+0x68/0xe8
<2>  rmnet_newlink+0xa0/0x160
<2>  rtnl_newlink+0x57c/0x6c8
<2>  rtnetlink_rcv_msg+0x1dc/0x328
<2>  netlink_rcv_skb+0xac/0x118
<2>  rtnetlink_rcv+0x24/0x30
<2>  netlink_unicast+0x158/0x1f0
<2>  netlink_sendmsg+0x32c/0x338
<2>  sock_sendmsg+0x44/0x60
<2>  SyS_sendto+0x150/0x1ac
<2>  el0_svc_naked+0x34/0x38

Fixes: b752eff5be24 ("net: qualcomm: rmnet: Implement ndo_get_iflink")
Signed-off-by: Sean Tranchetti <stranche@codeaurora.org>
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 0afc3d335d56..d11c16aeb19a 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -234,7 +234,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 		      struct net_device *real_dev,
 		      struct rmnet_endpoint *ep)
 {
-	struct rmnet_priv *priv;
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
 	int rc;
 
 	if (ep->egress_dev)
@@ -247,6 +247,8 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 	rmnet_dev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	rmnet_dev->hw_features |= NETIF_F_SG;
 
+	priv->real_dev = real_dev;
+
 	rc = register_netdevice(rmnet_dev);
 	if (!rc) {
 		ep->egress_dev = rmnet_dev;
@@ -255,9 +257,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 
 		rmnet_dev->rtnl_link_ops = &rmnet_link_ops;
 
-		priv = netdev_priv(rmnet_dev);
 		priv->mux_id = id;
-		priv->real_dev = real_dev;
 
 		netdev_dbg(rmnet_dev, "rmnet dev created\n");
 	}
-- 
2.17.1

