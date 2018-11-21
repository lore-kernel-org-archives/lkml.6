Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00900C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1B6206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMDIopTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1B6206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbeKVFnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387893AbeKVFnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 048CD21527;
        Wed, 21 Nov 2018 19:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827258;
        bh=N0ymD+yXfOsdJKjlKk1iTwNnm3SCbNSpfkUUsz+8nvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMDIopTuHu1bJuJkxFDZwGtiWn7jgntHE02B1PnKzwpSNDJxYtACtHunyk8SRas+j
         cB2LtNpzUZjOG2FVfIxvOFzjOMmOLrqpp5yvnytt8cMrt843StddpYMXbnPr8iAA9s
         kz/REa1E3mQ4tJAu/F+969PM6aylodZ0t8ScwmuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Tranchetti <stranche@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 33/42] net: qualcomm: rmnet: Fix incorrect assignment of real_dev
Date:   Wed, 21 Nov 2018 20:06:09 +0100
Message-Id: <20181121183149.399499213@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -234,7 +234,7 @@ int rmnet_vnd_newlink(u8 id, struct net_
 		      struct net_device *real_dev,
 		      struct rmnet_endpoint *ep)
 {
-	struct rmnet_priv *priv;
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
 	int rc;
 
 	if (ep->egress_dev)
@@ -247,6 +247,8 @@ int rmnet_vnd_newlink(u8 id, struct net_
 	rmnet_dev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	rmnet_dev->hw_features |= NETIF_F_SG;
 
+	priv->real_dev = real_dev;
+
 	rc = register_netdevice(rmnet_dev);
 	if (!rc) {
 		ep->egress_dev = rmnet_dev;
@@ -255,9 +257,7 @@ int rmnet_vnd_newlink(u8 id, struct net_
 
 		rmnet_dev->rtnl_link_ops = &rmnet_link_ops;
 
-		priv = netdev_priv(rmnet_dev);
 		priv->mux_id = id;
-		priv->real_dev = real_dev;
 
 		netdev_dbg(rmnet_dev, "rmnet dev created\n");
 	}


