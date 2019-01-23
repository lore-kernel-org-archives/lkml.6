Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248E320449
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfAWP7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:59:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42243 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfAWP7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:59:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 20CA42084E; Wed, 23 Jan 2019 16:59:14 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id CF820209BE;
        Wed, 23 Jan 2019 16:58:55 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next 07/10] net: macsec: hardware offloading infrastructure
Date:   Wed, 23 Jan 2019 16:56:35 +0100
Message-Id: <20190123155638.13852-8-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123155638.13852-1-antoine.tenart@bootlin.com>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the MACsec hardware offloading infrastructure.

The main idea here is to re-use the logic and data structures of the
software MACsec implementation. This allows not to duplicate definitions
and structure storing the same kind of information. It also allows to
use a unified genlink interface for both MACsec implementations (so that
the same userspace tool, `ip macsec`, is used with the same arguments).
The MACsec offloading support cannot be disabled if an interface
supports it at the moment.

The MACsec configuration is passed to device drivers supporting it
through macsec_hw_offload() which is called (indirectly) from the MACsec
genl helpers. This function calls the macsec() ops of PHY and Ethernet
drivers in two steps: a preparation one, and a commit one. The first
step is allowed to fail and should be used to check if a provided
configuration is compatible with the features provided by a MACsec
engine, while the second step is not allowed to fail and should only be
used to enable a given MACsec configuration. Two extra calls are made:
when a virtual MACsec interface is created and when it is deleted, so
that the hardware driver can stay in sync.

The Rx and TX handlers are modified to take in account the special case
were the MACsec transformation happens in the hardware, whether in a PHY
or in a MAC, as the packets seen by the networking stack on both the
physical and MACsec virtual interface are exactly the same. This leads
to some limitations: the hardware and software implementations can't be
used on the same physical interface, as the policies would be impossible
to fulfill (such as strict validation of the frames). Also only a single
virtual MACsec interface can be attached to a physical port supporting
hardware offloading as it would be impossible to guess onto which
interface a given packet should go (for ingress traffic).

Another limitation as of now is that the counters and statistics are not
reported back from the hardware to the software MACsec implementation.
This isn't an issue when using offloaded MACsec transformations, but it
should be added in the future so that the MACsec state can be reported
to the user (which would also improve the debug).

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/macsec.c | 296 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 283 insertions(+), 13 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index c3a138dd4386..3dfcc92cf83c 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -16,6 +16,7 @@
 #include <net/genetlink.h>
 #include <net/sock.h>
 #include <net/gro_cells.h>
+#include <linux/phy.h>
 
 #include <net/macsec.h>
 #include <uapi/linux/if_macsec.h>
@@ -319,6 +320,25 @@ static void macsec_set_shortlen(struct macsec_eth_header *h, size_t data_len)
 		h->short_length = data_len;
 }
 
+/* Checks if underlying layers implement MACsec offloading functions */
+static inline bool macsec_hw_offload_capable(struct macsec_dev *dev)
+{
+	struct phy_device *phydev;
+
+	if (!dev || !dev->real_dev)
+		return false;
+
+	phydev = dev->real_dev->phydev;
+
+	if (phydev && phydev->drv && phydev->drv->macsec)
+		return true;
+	if (dev->real_dev->features & NETIF_F_HW_MACSEC &&
+	    dev->real_dev->netdev_ops->ndo_macsec)
+		return true;
+
+	return false;
+}
+
 /* validate MACsec packet according to IEEE 802.1AE-2006 9.12 */
 static bool macsec_validate_skb(struct sk_buff *skb, u16 icv_len)
 {
@@ -867,8 +887,10 @@ static struct macsec_rx_sc *find_rx_sc_rtnl(struct macsec_secy *secy, sci_t sci)
 	return NULL;
 }
 
-static void handle_not_macsec(struct sk_buff *skb)
+static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 {
+	/* Deliver to the uncontrolled port by default */
+	enum rx_handler_result ret = RX_HANDLER_PASS;
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
 
@@ -883,7 +905,8 @@ static void handle_not_macsec(struct sk_buff *skb)
 		struct sk_buff *nskb;
 		struct pcpu_secy_stats *secy_stats = this_cpu_ptr(macsec->stats);
 
-		if (macsec->secy.validate_frames == MACSEC_VALIDATE_STRICT) {
+		if (!macsec_hw_offload_capable(macsec) &&
+		    macsec->secy.validate_frames == MACSEC_VALIDATE_STRICT) {
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoTag++;
 			u64_stats_update_end(&secy_stats->syncp);
@@ -902,9 +925,17 @@ static void handle_not_macsec(struct sk_buff *skb)
 			secy_stats->stats.InPktsUntagged++;
 			u64_stats_update_end(&secy_stats->syncp);
 		}
+
+		if (netif_running(macsec->secy.netdev) &&
+		    macsec_hw_offload_capable(macsec)) {
+			ret = RX_HANDLER_EXACT;
+			goto out;
+		}
 	}
 
+out:
 	rcu_read_unlock();
+	return ret;
 }
 
 static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
@@ -929,12 +960,8 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		goto drop_direct;
 
 	hdr = macsec_ethhdr(skb);
-	if (hdr->eth.h_proto != htons(ETH_P_MACSEC)) {
-		handle_not_macsec(skb);
-
-		/* and deliver to the uncontrolled port */
-		return RX_HANDLER_PASS;
-	}
+	if (hdr->eth.h_proto != htons(ETH_P_MACSEC))
+		return handle_not_macsec(skb);
 
 	skb = skb_unshare(skb, GFP_ATOMIC);
 	if (!skb) {
@@ -1440,6 +1467,137 @@ static const struct nla_policy macsec_genl_sa_policy[NUM_MACSEC_SA_ATTR] = {
 				 .len = MACSEC_MAX_KEY_LEN, },
 };
 
+static int macsec_hw_offload(struct net_device *net,
+			     struct netdev_macsec *macsec)
+{
+	struct macsec_dev *dev = netdev_priv(net);
+	int ret;
+
+	/* Phase I: prepare. The drive should fail here if there are going to be
+	 * issues in the commit phase.
+	 *
+	 * If supported the PHY implementation is called, otherwise the MAC one
+	 * is used.
+	 *
+	 * Phase II: commit. This step cannot fail.
+	 */
+	macsec->prepare = true;
+
+	if (dev->real_dev->phydev) {
+		ret = phy_macsec(dev->real_dev->phydev, macsec);
+		if (ret == -EOPNOTSUPP)
+			goto try_netdev_macsec;
+		if (ret)
+			return ret;
+
+		macsec->prepare = false;
+		ret = phy_macsec(dev->real_dev->phydev, macsec);
+		if (unlikely(ret))
+			goto offload_failed;
+
+		return 0;
+	}
+
+try_netdev_macsec:
+	if (dev->real_dev->netdev_ops->ndo_macsec) {
+		ret = dev->real_dev->netdev_ops->ndo_macsec(net, macsec);
+		if (ret)
+			return ret;
+
+		macsec->prepare = false;
+		ret = dev->real_dev->netdev_ops->ndo_macsec(net, macsec);
+		if (unlikely(ret))
+			goto offload_failed;
+	}
+
+	return 0;
+
+offload_failed:
+	/* This should never happen: commit is not allowed to fail */
+	WARN(1, "MACsec offloading commit failed (%d)\n", ret);
+	return ret;
+}
+
+static int macsec_hw_offload_secy(struct net_device *net,
+				  enum netdev_macsec_command command,
+				  struct macsec_secy *secy)
+{
+	struct macsec_dev *dev = netdev_priv(net);
+	struct netdev_macsec macsec;
+
+	if (!macsec_hw_offload_capable(dev))
+		return 0;
+
+	memset(&macsec, 0, sizeof(macsec));
+	macsec.command = command;
+	macsec.secy = secy;
+
+	return macsec_hw_offload(net, &macsec);
+}
+
+static int macsec_hw_offload_rxsc(struct net_device *net,
+				  enum netdev_macsec_command command,
+				  struct macsec_rx_sc *rx_sc)
+{
+	struct macsec_dev *dev = netdev_priv(net);
+	struct netdev_macsec macsec;
+
+	if (!macsec_hw_offload_capable(dev))
+		return 0;
+
+	memset(&macsec, 0, sizeof(macsec));
+	macsec.command = command;
+	macsec.rx_sc = rx_sc;
+
+	return macsec_hw_offload(net, &macsec);
+}
+
+static int macsec_hw_offload_rxsa(struct net_device *net,
+				  enum netdev_macsec_command command,
+				  struct macsec_rx_sa *rx_sa,
+				  unsigned char assoc_num, u8 *key)
+{
+	struct macsec_secy *secy = &macsec_priv(net)->secy;
+	struct macsec_dev *dev = netdev_priv(net);
+	struct netdev_macsec macsec;
+
+	if (!macsec_hw_offload_capable(dev))
+		return 0;
+
+	memset(&macsec, 0, sizeof(macsec));
+	macsec.command = command;
+	macsec.sa.assoc_num = assoc_num;
+	macsec.sa.rx_sa = rx_sa;
+
+	if (key)
+		memcpy(macsec.sa.key, key, secy->key_len);
+
+	return macsec_hw_offload(net, &macsec);
+}
+
+static int macsec_hw_offload_txsa(struct net_device *net,
+				  enum netdev_macsec_command command,
+				  struct macsec_tx_sa *tx_sa,
+				  unsigned char assoc_num, u8 *key)
+{
+	struct macsec_secy *secy = &macsec_priv(net)->secy;
+	struct macsec_dev *dev = netdev_priv(net);
+	struct netdev_macsec macsec;
+
+	if (!macsec_hw_offload_capable(dev))
+		return 0;
+
+	memset(&macsec, 0, sizeof(macsec));
+	macsec.command = command;
+	macsec.sa.assoc_num = assoc_num;
+	macsec.sa.tx_sa = tx_sa;
+
+	if (key)
+		memcpy(macsec.sa.key, key, secy->key_len);
+
+	return macsec_hw_offload(net, &macsec);
+}
+
 static int parse_sa_config(struct nlattr **attrs, struct nlattr **tb_sa)
 {
 	if (!attrs[MACSEC_ATTR_SA_CONFIG])
@@ -1561,6 +1719,15 @@ static int macsec_add_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 	nla_memcpy(rx_sa->key.id, tb_sa[MACSEC_SA_ATTR_KEYID], MACSEC_KEYID_LEN);
 	rx_sa->sc = rx_sc;
+
+	err = macsec_hw_offload_rxsa(dev, MACSEC_ADD_RXSA, rx_sa, assoc_num,
+				     nla_data(tb_sa[MACSEC_SA_ATTR_KEY]));
+	if (err) {
+		kfree(rx_sa);
+		rtnl_unlock();
+		return err;
+	}
+
 	rcu_assign_pointer(rx_sc->sa[assoc_num], rx_sa);
 
 	rtnl_unlock();
@@ -1717,6 +1884,15 @@ static int macsec_add_txsa(struct sk_buff *skb, struct genl_info *info)
 	if (assoc_num == tx_sc->encoding_sa && tx_sa->active)
 		secy->operational = true;
 
+	err = macsec_hw_offload_txsa(dev, MACSEC_ADD_TXSA, tx_sa, assoc_num,
+				     nla_data(tb_sa[MACSEC_SA_ATTR_KEY]));
+	if (err) {
+		secy->operational = false;
+		kfree(tx_sa);
+		rtnl_unlock();
+		return err;
+	}
+
 	rcu_assign_pointer(tx_sc->sa[assoc_num], tx_sa);
 
 	rtnl_unlock();
@@ -1734,6 +1910,7 @@ static int macsec_del_rxsa(struct sk_buff *skb, struct genl_info *info)
 	u8 assoc_num;
 	struct nlattr *tb_rxsc[MACSEC_RXSC_ATTR_MAX + 1];
 	struct nlattr *tb_sa[MACSEC_SA_ATTR_MAX + 1];
+	int ret;
 
 	if (!attrs[MACSEC_ATTR_IFINDEX])
 		return -EINVAL;
@@ -1757,6 +1934,13 @@ static int macsec_del_rxsa(struct sk_buff *skb, struct genl_info *info)
 		return -EBUSY;
 	}
 
+	ret = macsec_hw_offload_rxsa(dev, MACSEC_DEL_RXSA, rx_sa, assoc_num,
+				     NULL);
+	if (ret) {
+		rtnl_unlock();
+		return ret;
+	}
+
 	RCU_INIT_POINTER(rx_sc->sa[assoc_num], NULL);
 	clear_rx_sa(rx_sa);
 
@@ -1773,6 +1957,7 @@ static int macsec_del_rxsc(struct sk_buff *skb, struct genl_info *info)
 	struct macsec_rx_sc *rx_sc;
 	sci_t sci;
 	struct nlattr *tb_rxsc[MACSEC_RXSC_ATTR_MAX + 1];
+	int ret;
 
 	if (!attrs[MACSEC_ATTR_IFINDEX])
 		return -EINVAL;
@@ -1799,6 +1984,15 @@ static int macsec_del_rxsc(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
+	ret = macsec_hw_offload_rxsc(dev, MACSEC_DEL_RXSC, rx_sc);
+	if (ret) {
+		/* Revert del_rx_sc() */
+		if (rx_sc->active)
+			secy->n_rx_sc++;
+		rtnl_unlock();
+		return ret;
+	}
+
 	free_rx_sc(rx_sc);
 	rtnl_unlock();
 
@@ -1814,6 +2008,7 @@ static int macsec_del_txsa(struct sk_buff *skb, struct genl_info *info)
 	struct macsec_tx_sa *tx_sa;
 	u8 assoc_num;
 	struct nlattr *tb_sa[MACSEC_SA_ATTR_MAX + 1];
+	int ret;
 
 	if (!attrs[MACSEC_ATTR_IFINDEX])
 		return -EINVAL;
@@ -1834,6 +2029,13 @@ static int macsec_del_txsa(struct sk_buff *skb, struct genl_info *info)
 		return -EBUSY;
 	}
 
+	ret = macsec_hw_offload_txsa(dev, MACSEC_DEL_TXSA, tx_sa, assoc_num,
+				     NULL);
+	if (ret) {
+		rtnl_unlock();
+		return ret;
+	}
+
 	RCU_INIT_POINTER(tx_sc->sa[assoc_num], NULL);
 	clear_tx_sa(tx_sa);
 
@@ -1872,6 +2074,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 	struct macsec_tx_sa *tx_sa;
 	u8 assoc_num;
 	struct nlattr *tb_sa[MACSEC_SA_ATTR_MAX + 1];
+	int ret;
 
 	if (!attrs[MACSEC_ATTR_IFINDEX])
 		return -EINVAL;
@@ -1902,9 +2105,16 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 	if (assoc_num == tx_sc->encoding_sa)
 		secy->operational = tx_sa->active;
 
+	ret = macsec_hw_offload_txsa(dev, MACSEC_UPD_TXSA, tx_sa, assoc_num,
+				     NULL);
+	if (ret) {
+		tx_sa->active = !tx_sa->active;
+		secy->operational = tx_sa->active;
+	}
+
 	rtnl_unlock();
 
-	return 0;
+	return ret;
 }
 
 static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
@@ -1917,6 +2127,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 	u8 assoc_num;
 	struct nlattr *tb_rxsc[MACSEC_RXSC_ATTR_MAX + 1];
 	struct nlattr *tb_sa[MACSEC_SA_ATTR_MAX + 1];
+	int ret;
 
 	if (!attrs[MACSEC_ATTR_IFINDEX])
 		return -EINVAL;
@@ -1947,8 +2158,13 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 	if (tb_sa[MACSEC_SA_ATTR_ACTIVE])
 		rx_sa->active = nla_get_u8(tb_sa[MACSEC_SA_ATTR_ACTIVE]);
 
+	ret = macsec_hw_offload_rxsa(dev, MACSEC_UPD_RXSA, rx_sa, assoc_num,
+				     NULL);
+	if (ret)
+		rx_sa->active = !rx_sa->active;
+
 	rtnl_unlock();
-	return 0;
+	return ret;
 }
 
 static int macsec_upd_rxsc(struct sk_buff *skb, struct genl_info *info)
@@ -2545,11 +2761,15 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 {
 	struct macsec_dev *macsec = netdev_priv(dev);
 	struct macsec_secy *secy = &macsec->secy;
+	struct macsec_tx_sc *tx_sc = &secy->tx_sc;
 	struct pcpu_secy_stats *secy_stats;
+	struct macsec_tx_sa *tx_sa;
 	int ret, len;
 
+	tx_sa = macsec_txsa_get(tx_sc->sa[tx_sc->encoding_sa]);
+
 	/* 10.5 */
-	if (!secy->protect_frames) {
+	if (!secy->protect_frames || macsec_hw_offload_capable(macsec)) {
 		secy_stats = this_cpu_ptr(macsec->stats);
 		u64_stats_update_begin(&secy_stats->syncp);
 		secy_stats->stats.OutPktsUntagged++;
@@ -2662,6 +2882,15 @@ static int macsec_dev_open(struct net_device *dev)
 			goto clear_allmulti;
 	}
 
+	if (macsec_hw_offload_capable(macsec)) {
+		struct netdev_macsec ms;
+
+		memset(&ms, 0, sizeof(ms));
+		ms.command = MACSEC_DEV_OPEN;
+
+		macsec_hw_offload(dev, &ms);
+	}
+
 	if (netif_carrier_ok(real_dev))
 		netif_carrier_on(dev);
 
@@ -2682,6 +2911,15 @@ static int macsec_dev_stop(struct net_device *dev)
 
 	netif_carrier_off(dev);
 
+	if (macsec_hw_offload_capable(macsec)) {
+		struct netdev_macsec ms;
+
+		memset(&ms, 0, sizeof(ms));
+		ms.command = MACSEC_DEV_STOP;
+
+		macsec_hw_offload(dev, &ms);
+	}
+
 	dev_mc_unsync(real_dev, dev);
 	dev_uc_unsync(real_dev, dev);
 
@@ -2921,6 +3159,9 @@ static int macsec_changelink(struct net_device *dev, struct nlattr *tb[],
 			     struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
 {
+	struct macsec_dev *macsec = macsec_priv(dev);
+	int ret;
+
 	if (!data)
 		return 0;
 
@@ -2930,7 +3171,11 @@ static int macsec_changelink(struct net_device *dev, struct nlattr *tb[],
 	    data[IFLA_MACSEC_PORT])
 		return -EINVAL;
 
-	return macsec_changelink_common(dev, data);
+	ret = macsec_changelink_common(dev, data);
+	if (ret)
+		return ret;
+
+	return macsec_hw_offload_secy(dev, MACSEC_UPD_SECY, &macsec->secy);
 }
 
 static void macsec_del_dev(struct macsec_dev *macsec)
@@ -2973,6 +3218,7 @@ static void macsec_dellink(struct net_device *dev, struct list_head *head)
 	struct net_device *real_dev = macsec->real_dev;
 	struct macsec_rxh_data *rxd = macsec_data_rtnl(real_dev);
 
+	macsec_hw_offload_secy(dev, MACSEC_DEL_SECY, &macsec->secy);
 	macsec_common_dellink(dev, head);
 
 	if (list_empty(&rxd->secys)) {
@@ -3068,7 +3314,8 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 			  struct netlink_ext_ack *extack)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
-	struct net_device *real_dev;
+	struct net_device *real_dev, *loop_dev;
+	struct net *loop_net;
 	int err;
 	sci_t sci;
 	u8 icv_len = DEFAULT_ICV_LEN;
@@ -3080,6 +3327,25 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 	if (!real_dev)
 		return -ENODEV;
 
+	for_each_net(loop_net) {
+		for_each_netdev(loop_net, loop_dev) {
+			struct macsec_dev *priv;
+
+			if (!netif_is_macsec(loop_dev))
+				continue;
+
+			priv = macsec_priv(loop_dev);
+
+			/* A limitation of the MACsec h/w offloading is only a
+			 * single MACsec interface can be created for a given
+			 * real interface.
+			 */
+			if (macsec_hw_offload_capable(priv) &&
+			    priv->real_dev == real_dev)
+				return -EBUSY;
+		}
+	}
+
 	dev->priv_flags |= IFF_MACSEC;
 
 	macsec->real_dev = real_dev;
@@ -3137,6 +3403,10 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 	if (err < 0)
 		goto del_dev;
 
+	err = macsec_hw_offload_secy(dev, MACSEC_ADD_SECY, &macsec->secy);
+	if (err)
+		goto del_dev;
+
 	netif_stacked_transfer_operstate(real_dev, dev);
 	linkwatch_fire_event(dev);
 
-- 
2.20.1

