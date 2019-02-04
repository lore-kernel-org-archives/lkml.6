Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,WEIRD_PORT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B53C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E277217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276983;
	bh=TGTJLpxGFQZ+oowNUDI7U7EFGArpBaqJNaIySF3mP0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QueG3Z1FvUdBSu5b3zm+NmeFrijYQLUqpXK8ZZkWhrcm05B6TwDubAHkpJbrS6iDy
	 HVI1VR/oYVZdV14cARBR+JouJTowh08EjT4DxlXalwsBFw9bNVL2Aw0xvrw69ap+km
	 uhiKhMTshO+GKtMXtbxyQAkS6gH/xkDSNUhJDnSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfBDKnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:43:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbfBDKm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:42:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7042075B;
        Mon,  4 Feb 2019 10:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276977;
        bh=TGTJLpxGFQZ+oowNUDI7U7EFGArpBaqJNaIySF3mP0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6MUnigE7KWORclorlGSVzqpOI1TFd8ktMe/02CsHRubdkQgVSBrwhlVw0jhn8vXV
         IIZyrf6oXcksnxEdRJeMIE2YjmBUY0xT5scdj5peXGVdCZVyZ5qEVwRgcEtWxbodqS
         W4ElCqRlo/56kDeCIxGaMQUksdgUOuuoqoyv9JGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>,
        David Ahern <dsa@cumulusnetworks.com>,
        Florian Westphal <fw@strlen.de>,
        Martynas Pumputis <m@lambda.lt>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 12/30] ipvlan, l3mdev: fix broken l3s mode wrt local routes
Date:   Mon,  4 Feb 2019 11:36:50 +0100
Message-Id: <20190204103607.503854833@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103605.271746870@linuxfoundation.org>
References: <20190204103605.271746870@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit d5256083f62e2720f75bb3c5a928a0afe47d6bc3 ]

While implementing ipvlan l3 and l3s mode for kubernetes CNI plugin,
I ran into the issue that while l3 mode is working fine, l3s mode
does not have any connectivity to kube-apiserver and hence all pods
end up in Error state as well. The ipvlan master device sits on
top of a bond device and hostns traffic to kube-apiserver (also running
in hostns) is DNATed from 10.152.183.1:443 to 139.178.29.207:37573
where the latter is the address of the bond0. While in l3 mode, a
curl to https://10.152.183.1:443 or to https://139.178.29.207:37573
works fine from hostns, neither of them do in case of l3s. In the
latter only a curl to https://127.0.0.1:37573 appeared to work where
for local addresses of bond0 I saw kernel suddenly starting to emit
ARP requests to query HW address of bond0 which remained unanswered
and neighbor entries in INCOMPLETE state. These ARP requests only
happen while in l3s.

Debugging this further, I found the issue is that l3s mode is piggy-
backing on l3 master device, and in this case local routes are using
l3mdev_master_dev_rcu(dev) instead of net->loopback_dev as per commit
f5a0aab84b74 ("net: ipv4: dst for local input routes should use l3mdev
if relevant") and 5f02ce24c269 ("net: l3mdev: Allow the l3mdev to be
a loopback"). I found that reverting them back into using the
net->loopback_dev fixed ipvlan l3s connectivity and got everything
working for the CNI.

Now judging from 4fbae7d83c98 ("ipvlan: Introduce l3s mode") and the
l3mdev paper in [0] the only sole reason why ipvlan l3s is relying
on l3 master device is to get the l3mdev_ip_rcv() receive hook for
setting the dst entry of the input route without adding its own
ipvlan specific hacks into the receive path, however, any l3 domain
semantics beyond just that are breaking l3s operation. Note that
ipvlan also has the ability to dynamically switch its internal
operation from l3 to l3s for all ports via ipvlan_set_port_mode()
at runtime. In any case, l3 vs l3s soley distinguishes itself by
'de-confusing' netfilter through switching skb->dev to ipvlan slave
device late in NF_INET_LOCAL_IN before handing the skb to L4.

Minimal fix taken here is to add a IFF_L3MDEV_RX_HANDLER flag which,
if set from ipvlan setup, gets us only the wanted l3mdev_l3_rcv() hook
without any additional l3mdev semantics on top. This should also have
minimal impact since dev->priv_flags is already hot in cache. With
this set, l3s mode is working fine and I also get things like
masquerading pod traffic on the ipvlan master properly working.

  [0] https://netdevconf.org/1.2/papers/ahern-what-is-l3mdev-paper.pdf

Fixes: f5a0aab84b74 ("net: ipv4: dst for local input routes should use l3mdev if relevant")
Fixes: 5f02ce24c269 ("net: l3mdev: Allow the l3mdev to be a loopback")
Fixes: 4fbae7d83c98 ("ipvlan: Introduce l3s mode")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mahesh Bandewar <maheshb@google.com>
Cc: David Ahern <dsa@cumulusnetworks.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Martynas Pumputis <m@lambda.lt>
Acked-by: David Ahern <dsa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ipvlan/ipvlan_main.c |    6 +++---
 include/linux/netdevice.h        |    8 ++++++++
 include/net/l3mdev.h             |    3 ++-
 3 files changed, 13 insertions(+), 4 deletions(-)

--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -85,12 +85,12 @@ static int ipvlan_set_port_mode(struct i
 			err = ipvlan_register_nf_hook();
 			if (!err) {
 				mdev->l3mdev_ops = &ipvl_l3mdev_ops;
-				mdev->priv_flags |= IFF_L3MDEV_MASTER;
+				mdev->priv_flags |= IFF_L3MDEV_RX_HANDLER;
 			} else
 				goto fail;
 		} else if (port->mode == IPVLAN_MODE_L3S) {
 			/* Old mode was L3S */
-			mdev->priv_flags &= ~IFF_L3MDEV_MASTER;
+			mdev->priv_flags &= ~IFF_L3MDEV_RX_HANDLER;
 			ipvlan_unregister_nf_hook();
 			mdev->l3mdev_ops = NULL;
 		}
@@ -158,7 +158,7 @@ static void ipvlan_port_destroy(struct n
 
 	dev->priv_flags &= ~IFF_IPVLAN_MASTER;
 	if (port->mode == IPVLAN_MODE_L3S) {
-		dev->priv_flags &= ~IFF_L3MDEV_MASTER;
+		dev->priv_flags &= ~IFF_L3MDEV_RX_HANDLER;
 		ipvlan_unregister_nf_hook();
 		dev->l3mdev_ops = NULL;
 	}
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1368,6 +1368,7 @@ struct net_device_ops {
  * @IFF_PHONY_HEADROOM: the headroom value is controlled by an external
  *	entity (i.e. the master device for bridged veth)
  * @IFF_MACSEC: device is a MACsec device
+ * @IFF_L3MDEV_RX_HANDLER: only invoke the rx handler of L3 master device
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1398,6 +1399,7 @@ enum netdev_priv_flags {
 	IFF_RXFH_CONFIGURED		= 1<<25,
 	IFF_PHONY_HEADROOM		= 1<<26,
 	IFF_MACSEC			= 1<<27,
+	IFF_L3MDEV_RX_HANDLER		= 1<<28,
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -1427,6 +1429,7 @@ enum netdev_priv_flags {
 #define IFF_TEAM			IFF_TEAM
 #define IFF_RXFH_CONFIGURED		IFF_RXFH_CONFIGURED
 #define IFF_MACSEC			IFF_MACSEC
+#define IFF_L3MDEV_RX_HANDLER		IFF_L3MDEV_RX_HANDLER
 
 /**
  *	struct net_device - The DEVICE structure.
@@ -4244,6 +4247,11 @@ static inline bool netif_supports_nofcs(
 	return dev->priv_flags & IFF_SUPP_NOFCS;
 }
 
+static inline bool netif_has_l3_rx_handler(const struct net_device *dev)
+{
+	return dev->priv_flags & IFF_L3MDEV_RX_HANDLER;
+}
+
 static inline bool netif_is_l3_master(const struct net_device *dev)
 {
 	return dev->priv_flags & IFF_L3MDEV_MASTER;
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -142,7 +142,8 @@ struct sk_buff *l3mdev_l3_rcv(struct sk_
 
 	if (netif_is_l3_slave(skb->dev))
 		master = netdev_master_upper_dev_get_rcu(skb->dev);
-	else if (netif_is_l3_master(skb->dev))
+	else if (netif_is_l3_master(skb->dev) ||
+		 netif_has_l3_rx_handler(skb->dev))
 		master = skb->dev;
 
 	if (master && master->l3mdev_ops->l3mdev_l3_rcv)


