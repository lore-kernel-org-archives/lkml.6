Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBC7C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A333421785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A333421785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeHMFpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:45:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbeHMFpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:45:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB84B401C96A;
        Mon, 13 Aug 2018 03:05:37 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 139D92156712;
        Mon, 13 Aug 2018 03:05:33 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jbrouer@redhat.com,
        mst@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next 4/5] macvlan: basic XDP support
Date:   Mon, 13 Aug 2018 11:05:12 +0800
Message-Id: <1534129513-4845-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1534129513-4845-1-git-send-email-jasowang@redhat.com>
References: <1534129513-4845-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 03:05:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 03:05:37 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to implementing basic XDP support for macvlan. The
implementation was split into two parts:

1) XDP rx handler of underlay device:

We will register an XDP rx handler (macvlan_handle_xdp) to under layer
device. In this handler, we will the following cases to go for slow
path (XDP_RX_HANDLER_PASS):

- The packet is a multicast packet.
- A vlan is source mode
- Destination mac address does not match any vlan

If none of the above cases were true, it means we could go for XDP
path directly. We will change the dev and return
RX_XDP_HANDLER_ANOTHER.

2) If we find a destination vlan, we will try to run XDP prog.

If XDP prog return XDP_PASS, we will call xdp_do_pass() to pass it to
up layer XDP rx handler. This is needed for e.g macvtap to work. If
XDP_RX_HANDLER_FALLBACK is returned, we will build skb and call
netif_rx() to finish the receiving. Otherwise just return the result
to lower device. For XDP_TX, we will build skb and try XDP generic
transmission routine for simplicity. This could be optimized on top.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/macvlan.c      | 173 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/if_macvlan.h |   1 +
 2 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index b7c814d..42b747c 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -34,6 +34,7 @@
 #include <net/rtnetlink.h>
 #include <net/xfrm.h>
 #include <linux/netpoll.h>
+#include <linux/bpf.h>
 
 #define MACVLAN_HASH_BITS	8
 #define MACVLAN_HASH_SIZE	(1<<MACVLAN_HASH_BITS)
@@ -436,6 +437,122 @@ static void macvlan_forward_source(struct sk_buff *skb,
 	}
 }
 
+struct sk_buff *macvlan_xdp_build_skb(struct net_device *dev,
+				      struct xdp_buff *xdp)
+{
+	int len;
+	int buflen = xdp->data_end - xdp->data_hard_start;
+	int headroom = xdp->data - xdp->data_hard_start;
+	struct sk_buff *skb;
+
+	len = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) + headroom +
+	      SKB_DATA_ALIGN(buflen);
+
+	skb = build_skb(xdp->data_hard_start, len);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	__skb_put(skb, xdp->data_end - xdp->data);
+
+	skb->protocol = eth_type_trans(skb, dev);
+	skb->dev = dev;
+
+	return skb;
+}
+
+static rx_xdp_handler_result_t macvlan_receive_xdp(struct net_device *dev,
+						   struct xdp_buff *xdp)
+{
+	struct macvlan_dev *vlan = netdev_priv(dev);
+	struct bpf_prog *xdp_prog;
+	struct sk_buff *skb;
+	u32 act = XDP_PASS;
+	rx_xdp_handler_result_t ret;
+	int err;
+
+	rcu_read_lock();
+	xdp_prog = rcu_dereference(vlan->xdp_prog);
+
+	if (xdp_prog)
+		act = bpf_prog_run_xdp(xdp_prog, xdp);
+
+	switch (act) {
+	case XDP_PASS:
+		ret = xdp_do_pass(xdp);
+		if (ret != RX_XDP_HANDLER_FALLBACK) {
+			rcu_read_unlock();
+			return ret;
+		}
+		skb = macvlan_xdp_build_skb(dev, xdp);
+		if (!skb) {
+			act = XDP_DROP;
+			break;
+		}
+		rcu_read_unlock();
+		netif_rx(skb);
+		macvlan_count_rx(vlan, skb->len, true, false);
+		goto out;
+	case XDP_TX:
+		skb = macvlan_xdp_build_skb(dev, xdp);
+		if (!skb) {
+			act = XDP_DROP;
+			break;
+		}
+		generic_xdp_tx(skb, xdp_prog);
+		break;
+	case XDP_REDIRECT:
+		err = xdp_do_redirect(dev, xdp, xdp_prog);
+		xdp_do_flush_map();
+		if (err)
+			act = XDP_DROP;
+		break;
+	case XDP_DROP:
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(act);
+		break;
+	}
+
+	rcu_read_unlock();
+out:
+	if (act == XDP_DROP)
+		return RX_XDP_HANDLER_DROP;
+
+	return RX_XDP_HANDLER_CONSUMED;
+}
+
+/* called under rcu_read_lock() from XDP handler */
+static rx_xdp_handler_result_t macvlan_handle_xdp(struct net_device *dev,
+						  struct xdp_buff *xdp)
+{
+	const struct ethhdr *eth = (const struct ethhdr *)xdp->data;
+	struct macvlan_port *port;
+	struct macvlan_dev *vlan;
+
+	if (is_multicast_ether_addr(eth->h_dest))
+		return RX_XDP_HANDLER_FALLBACK;
+
+	port = macvlan_port_get_rcu(dev);
+	if (port->source_count)
+		return RX_XDP_HANDLER_FALLBACK;
+
+	if (macvlan_passthru(port))
+		vlan = list_first_or_null_rcu(&port->vlans,
+					      struct macvlan_dev, list);
+	else
+		vlan = macvlan_hash_lookup(port, eth->h_dest);
+
+	if (!vlan)
+		return RX_XDP_HANDLER_FALLBACK;
+
+	dev = vlan->dev;
+	if (unlikely(!(dev->flags & IFF_UP)))
+		return RX_XDP_HANDLER_DROP;
+
+	return macvlan_receive_xdp(dev, xdp);
+}
+
 /* called under rcu_read_lock() from netif_receive_skb */
 static rx_handler_result_t macvlan_handle_frame(struct sk_buff **pskb)
 {
@@ -1089,6 +1206,44 @@ static int macvlan_dev_get_iflink(const struct net_device *dev)
 	return vlan->lowerdev->ifindex;
 }
 
+static int macvlan_xdp_set(struct net_device *dev, struct bpf_prog *prog,
+			   struct netlink_ext_ack *extack)
+{
+	struct macvlan_dev *vlan = netdev_priv(dev);
+	struct bpf_prog *old_prog = rtnl_dereference(vlan->xdp_prog);
+
+	rcu_assign_pointer(vlan->xdp_prog, prog);
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	return 0;
+}
+
+static u32 macvlan_xdp_query(struct net_device *dev)
+{
+	struct macvlan_dev *vlan = netdev_priv(dev);
+	const struct bpf_prog *xdp_prog = rtnl_dereference(vlan->xdp_prog);
+
+	if (xdp_prog)
+		return xdp_prog->aux->id;
+
+	return 0;
+}
+
+static int macvlan_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return macvlan_xdp_set(dev, xdp->prog, xdp->extack);
+	case XDP_QUERY_PROG:
+		xdp->prog_id = macvlan_xdp_query(dev);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct ethtool_ops macvlan_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= macvlan_ethtool_get_link_ksettings,
@@ -1121,6 +1276,7 @@ static const struct net_device_ops macvlan_netdev_ops = {
 #endif
 	.ndo_get_iflink		= macvlan_dev_get_iflink,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_bpf		= macvlan_xdp,
 };
 
 void macvlan_common_setup(struct net_device *dev)
@@ -1173,10 +1329,20 @@ static int macvlan_port_create(struct net_device *dev)
 	INIT_WORK(&port->bc_work, macvlan_process_broadcast);
 
 	err = netdev_rx_handler_register(dev, macvlan_handle_frame, port);
-	if (err)
+	if (err) {
 		kfree(port);
-	else
-		dev->priv_flags |= IFF_MACVLAN_PORT;
+		goto out;
+	}
+
+	err = netdev_rx_xdp_handler_register(dev, macvlan_handle_xdp);
+	if (err) {
+		netdev_rx_handler_unregister(dev);
+		kfree(port);
+		goto out;
+	}
+
+	dev->priv_flags |= IFF_MACVLAN_PORT;
+out:
 	return err;
 }
 
@@ -1187,6 +1353,7 @@ static void macvlan_port_destroy(struct net_device *dev)
 
 	dev->priv_flags &= ~IFF_MACVLAN_PORT;
 	netdev_rx_handler_unregister(dev);
+	netdev_rx_xdp_handler_unregister(dev);
 
 	/* After this point, no packet can schedule bc_work anymore,
 	 * but we need to cancel it and purge left skbs if any.
diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
index 2e55e4c..7c7059b 100644
--- a/include/linux/if_macvlan.h
+++ b/include/linux/if_macvlan.h
@@ -34,6 +34,7 @@ struct macvlan_dev {
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	struct netpoll		*netpoll;
 #endif
+	struct bpf_prog __rcu   *xdp_prog;
 };
 
 static inline void macvlan_count_rx(const struct macvlan_dev *vlan,
-- 
2.7.4

