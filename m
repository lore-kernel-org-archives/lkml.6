Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Z05CCto9GVvtRQAAmS7hNA
	; Thu, 07 Jun 2018 14:15:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 420BF608BF; Thu,  7 Jun 2018 14:15:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A39A36063F;
	Thu,  7 Jun 2018 14:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A39A36063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeFGONv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:13:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39538 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933162AbeFGOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:39 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbJ-0005Zo-9I; Thu, 07 Jun 2018 15:09:17 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003IX-04; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ido Schimmel" <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Petr Machata" <petrm@mellanox.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.179404494@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 393/410] ip_tunnel: Emit events for post-register MTU
 changes
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

commit f6cc9c054e77b9a28d4594bcc201697edb21dfd2 upstream.

For tunnels created with IFLA_MTU, MTU of the netdevice is set by
rtnl_create_link() (called from rtnl_newlink()) before the device is
registered. However without IFLA_MTU that's not done.

rtnl_newlink() proceeds by calling struct rtnl_link_ops.newlink, which
via ip_tunnel_newlink() calls register_netdevice(), and that emits
NETDEV_REGISTER. Thus any listeners that inspect the netdevice get the
MTU of 0.

After ip_tunnel_newlink() corrects the MTU after registering the
netdevice, but since there's no event, the listeners don't get to know
about the MTU until something else happens--such as a NETDEV_UP event.
That's not ideal.

So instead of setting the MTU directly, go through dev_set_mtu(), which
takes care of distributing the necessary NETDEV_PRECHANGEMTU and
NETDEV_CHANGEMTU events.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: Resolve conflict with commit 24fc79798b8d
 "ip_tunnel: Clamp MTU to bounds on new link", referring to commit
 5568cdc368c3 "ip_tunnel: Resolve ipsec merge conflict properly."]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -405,17 +405,26 @@ static struct ip_tunnel *ip_tunnel_creat
 {
 	struct ip_tunnel *nt;
 	struct net_device *dev;
+	int mtu;
+	int err;
 
 	BUG_ON(!itn->fb_tunnel_dev);
 	dev = __ip_tunnel_create(net, itn->fb_tunnel_dev->rtnl_link_ops, parms);
 	if (IS_ERR(dev))
 		return ERR_CAST(dev);
 
-	dev->mtu = ip_tunnel_bind_dev(dev);
+	mtu = ip_tunnel_bind_dev(dev);
+	err = dev_set_mtu(dev, mtu);
+	if (err)
+		goto err_dev_set_mtu;
 
 	nt = netdev_priv(dev);
 	ip_tunnel_add(itn, nt);
 	return nt;
+
+err_dev_set_mtu:
+	unregister_netdevice(dev);
+	return ERR_PTR(err);
 }
 
 int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
@@ -962,7 +971,7 @@ int ip_tunnel_newlink(struct net_device
 	nt->parms = *p;
 	err = register_netdevice(dev);
 	if (err)
-		goto out;
+		goto err_register_netdevice;
 
 	if (dev->type == ARPHRD_ETHER && !tb[IFLA_ADDRESS])
 		eth_hw_addr_random(dev);
@@ -971,15 +980,20 @@ int ip_tunnel_newlink(struct net_device
 	if (tb[IFLA_MTU]) {
 		unsigned int max = 0xfff8 - dev->hard_header_len - nt->hlen;
 
-		dev->mtu = clamp(dev->mtu, (unsigned int)ETH_MIN_MTU,
-				 (unsigned int)(max - sizeof(struct iphdr)));
-	} else {
-		dev->mtu = mtu;
+		mtu = clamp(dev->mtu, (unsigned int)ETH_MIN_MTU,
+			    (unsigned int)(max - sizeof(struct iphdr)));
 	}
 
+	err = dev_set_mtu(dev, mtu);
+	if (err)
+		goto err_dev_set_mtu;
+
 	ip_tunnel_add(itn, nt);
+	return 0;
 
-out:
+err_dev_set_mtu:
+	unregister_netdevice(dev);
+err_register_netdevice:
 	return err;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_newlink);
