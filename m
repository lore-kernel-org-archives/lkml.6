Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B0AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20D220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20D220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeLIWZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:25:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34940 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbeLIVzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:16 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002ie-KC; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003LN-WE; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Simon Vincent" <simon.vincent@xsilon.com>,
        "Alexander Aring" <alex.aring@gmail.com>,
        "Marcel Holtmann" <marcel@holtmann.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.255547713@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 102/328] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Vincent <simon.vincent@xsilon.com>

commit f19f4f9525cf32f97341fac20ce66392e86a1b67 upstream.

The 6lowpan ipv6 header compression was causing problems for other interfaces
that expected a ipv6 header to still be in place, as we were replacing the
ipv6 header with a compressed version. This happened if you sent a packet to a
multicast address as the packet would be output on 802.15.4, ethernet, and also
be sent to the loopback interface. The skb data was shared between these
interfaces so all interfaces ended up with a compressed ipv6 header.

The solution is to ensure that before we do any header compression we are not
sharing the skb or skb data with any other interface. If we are then we must
take a copy of the skb and skb data before modifying the ipv6 header.
The only place we can copy the skb is inside the xmit function so we don't
leave dangling references to skb.

This patch moves all the header compression to inside the xmit function. Very
little code has been changed it has mostly been moved from lowpan_header_create
to lowpan_xmit. At the top of the xmit function we now check if the skb is
shared and if so copy it. In lowpan_header_create all we do now is store the
source and destination addresses for use later when we compress the header.

Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ieee802154/6lowpan_rtnl.c | 125 ++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 36 deletions(-)

--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -71,6 +71,21 @@ struct lowpan_dev_record {
 	struct list_head list;
 };
 
+/* don't save pan id, it's intra pan */
+struct lowpan_addr {
+	u8 mode;
+	union {
+		/* IPv6 needs big endian here */
+		__be64 extended_addr;
+		__be16 short_addr;
+	} u;
+};
+
+struct lowpan_addr_info {
+	struct lowpan_addr daddr;
+	struct lowpan_addr saddr;
+};
+
 static inline struct
 lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
 {
@@ -84,6 +99,14 @@ static inline void lowpan_address_flip(u
 		(dest)[IEEE802154_ADDR_LEN - i - 1] = (src)[i];
 }
 
+static inline struct
+lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
+{
+	WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct lowpan_addr_info));
+	return (struct lowpan_addr_info *)(skb->data -
+			sizeof(struct lowpan_addr_info));
+}
+
 static int lowpan_header_create(struct sk_buff *skb,
 			   struct net_device *dev,
 			   unsigned short type, const void *_daddr,
@@ -91,8 +114,7 @@ static int lowpan_header_create(struct s
 {
 	const u8 *saddr = _saddr;
 	const u8 *daddr = _daddr;
-	struct ieee802154_addr sa, da;
-	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
+	struct lowpan_addr_info *info;
 
 	/* TODO:
 	 * if this package isn't ipv6 one, where should it be routed?
@@ -106,41 +128,17 @@ static int lowpan_header_create(struct s
 	raw_dump_inline(__func__, "saddr", (unsigned char *)saddr, 8);
 	raw_dump_inline(__func__, "daddr", (unsigned char *)daddr, 8);
 
-	lowpan_header_compress(skb, dev, type, daddr, saddr, len);
-
-	/* NOTE1: I'm still unsure about the fact that compression and WPAN
-	 * header are created here and not later in the xmit. So wait for
-	 * an opinion of net maintainers.
-	 */
-	/* NOTE2: to be absolutely correct, we must derive PANid information
-	 * from MAC subif of the 'dev' and 'real_dev' network devices, but
-	 * this isn't implemented in mainline yet, so currently we assign 0xff
-	 */
-	cb->type = IEEE802154_FC_TYPE_DATA;
+	info = lowpan_skb_priv(skb);
 
-	/* prepare wpan address data */
-	sa.mode = IEEE802154_ADDR_LONG;
-	sa.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
-	sa.extended_addr = ieee802154_devaddr_from_raw(saddr);
+	/* TODO: Currently we only support extended_addr */
+	info->daddr.mode = IEEE802154_ADDR_LONG;
+	memcpy(&info->daddr.u.extended_addr, daddr,
+	       sizeof(info->daddr.u.extended_addr));
+	info->saddr.mode = IEEE802154_ADDR_LONG;
+	memcpy(&info->saddr.u.extended_addr, saddr,
+	       sizeof(info->daddr.u.extended_addr));
 
-	/* intra-PAN communications */
-	da.pan_id = sa.pan_id;
-
-	/* if the destination address is the broadcast address, use the
-	 * corresponding short address
-	 */
-	if (lowpan_is_addr_broadcast(daddr)) {
-		da.mode = IEEE802154_ADDR_SHORT;
-		da.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
-	} else {
-		da.mode = IEEE802154_ADDR_LONG;
-		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
-	}
-
-	cb->ackreq = !lowpan_is_addr_broadcast(daddr);
-
-	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
-			type, (void *)&da, (void *)&sa, 0);
+	return 0;
 }
 
 static int lowpan_give_skb_to_devices(struct sk_buff *skb,
@@ -338,13 +336,68 @@ err:
 	return rc;
 }
 
+static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ieee802154_addr sa, da;
+	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
+	struct lowpan_addr_info info;
+	void *daddr, *saddr;
+
+	memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
+
+	/* TODO: Currently we only support extended_addr */
+	daddr = &info.daddr.u.extended_addr;
+	saddr = &info.saddr.u.extended_addr;
+
+	lowpan_header_compress(skb, dev, ETH_P_IPV6, daddr, saddr, skb->len);
+
+	cb->type = IEEE802154_FC_TYPE_DATA;
+
+	/* prepare wpan address data */
+	sa.mode = IEEE802154_ADDR_LONG;
+	sa.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
+	sa.extended_addr = ieee802154_devaddr_from_raw(saddr);
+
+	/* intra-PAN communications */
+	da.pan_id = sa.pan_id;
+
+	/* if the destination address is the broadcast address, use the
+	 * corresponding short address
+	 */
+	if (lowpan_is_addr_broadcast((const u8 *)daddr)) {
+		da.mode = IEEE802154_ADDR_SHORT;
+		da.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
+		cb->ackreq = false;
+	} else {
+		da.mode = IEEE802154_ADDR_LONG;
+		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
+		cb->ackreq = true;
+	}
+
+	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
+			ETH_P_IPV6, (void *)&da, (void *)&sa, 0);
+}
+
 static netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee802154_hdr wpan_hdr;
-	int max_single;
+	int max_single, ret;
 
 	pr_debug("package xmit\n");
 
+	/* We must take a copy of the skb before we modify/replace the ipv6
+	 * header as the header could be used elsewhere
+	 */
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_XMIT_DROP;
+
+	ret = lowpan_header(skb, dev);
+	if (ret < 0) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
 	if (ieee802154_hdr_peek(skb, &wpan_hdr) < 0) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;

