Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F6C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196D32077B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498126;
	bh=DDvg8cwB/nrY1/y+TkFUE6r3UbnxBgrdNq/b5/UvBTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vGVT/r+w6sZWi/vM7NalBtoCoHzK7pkJTsSsWFpY2MG8Zi3Yyhry1s6MfcY4XlL2V
	 eOnka8RwCJnVKnRx7eqf5jBAlsB4euixzexP4ZryRhgUVb5020egTmW4CfpVU54uGB
	 vWVM5Hivz1f20lp4SZDiZKI72VoO+j+N1hgNO6Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfBRNzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387432AbfBRNzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:55:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41A8B2077B;
        Mon, 18 Feb 2019 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498120;
        bh=DDvg8cwB/nrY1/y+TkFUE6r3UbnxBgrdNq/b5/UvBTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fI1jtnszlG7VnR90qrOwFDmmdyhGCeB7ACxdTF/oR6AVD8kQuEstHpbjl53AZ276x
         dQc/ThBGvrr3yeqtmz5d2cecxwpBuXU3g5EZjfo6MGYsd0zi0MPwEHUnCEOvZFFdDX
         /aCCSrH5p1qQ81rToUpiWDhAdnZ7AEa4oxEcY1t0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Axtens <dja@axtens.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 22/62] net: create skb_gso_validate_mac_len()
Date:   Mon, 18 Feb 2019 14:43:28 +0100
Message-Id: <20190218133507.858947854@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 2b16f048729bf35e6c28a40cbfad07239f9dcd90 upstream

If you take a GSO skb, and split it into packets, will the MAC
length (L2 + L3 + L4 headers + payload) of those packets be small
enough to fit within a given length?

Move skb_gso_mac_seglen() to skbuff.h with other related functions
like skb_gso_network_seglen() so we can use it, and then create
skb_gso_validate_mac_len to do the full calculation.

Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[jwang: cherry pick for CVE-2018-1000026]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h | 16 +++++++++++
 net/core/skbuff.c      | 63 +++++++++++++++++++++++++++++++++---------
 net/sched/sch_tbf.c    | 10 -------
 3 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39c2570ddcf6..50a4a5968f3a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3317,6 +3317,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen);
 void skb_scrub_packet(struct sk_buff *skb, bool xnet);
 unsigned int skb_gso_transport_seglen(const struct sk_buff *skb);
 bool skb_gso_validate_mtu(const struct sk_buff *skb, unsigned int mtu);
+bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len);
 struct sk_buff *skb_segment(struct sk_buff *skb, netdev_features_t features);
 struct sk_buff *skb_vlan_untag(struct sk_buff *skb);
 int skb_ensure_writable(struct sk_buff *skb, int write_len);
@@ -4087,6 +4088,21 @@ static inline unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
 	return hdr_len + skb_gso_transport_seglen(skb);
 }
 
+/**
+ * skb_gso_mac_seglen - Return length of individual segments of a gso packet
+ *
+ * @skb: GSO skb
+ *
+ * skb_gso_mac_seglen is used to determine the real size of the
+ * individual segments, including MAC/L2, Layer3 (IP, IPv6) and L4
+ * headers (TCP/UDP).
+ */
+static inline unsigned int skb_gso_mac_seglen(const struct sk_buff *skb)
+{
+	unsigned int hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
+	return hdr_len + skb_gso_transport_seglen(skb);
+}
+
 /* Local Checksum Offload.
  * Compute outer checksum based on the assumption that the
  * inner checksum will be offloaded later.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 873032d1a083..6dbd2c54b2c9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4930,37 +4930,74 @@ unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
 EXPORT_SYMBOL_GPL(skb_gso_transport_seglen);
 
 /**
- * skb_gso_validate_mtu - Return in case such skb fits a given MTU
+ * skb_gso_size_check - check the skb size, considering GSO_BY_FRAGS
  *
- * @skb: GSO skb
- * @mtu: MTU to validate against
+ * There are a couple of instances where we have a GSO skb, and we
+ * want to determine what size it would be after it is segmented.
  *
- * skb_gso_validate_mtu validates if a given skb will fit a wanted MTU
- * once split.
+ * We might want to check:
+ * -    L3+L4+payload size (e.g. IP forwarding)
+ * - L2+L3+L4+payload size (e.g. sanity check before passing to driver)
+ *
+ * This is a helper to do that correctly considering GSO_BY_FRAGS.
+ *
+ * @seg_len: The segmented length (from skb_gso_*_seglen). In the
+ *           GSO_BY_FRAGS case this will be [header sizes + GSO_BY_FRAGS].
+ *
+ * @max_len: The maximum permissible length.
+ *
+ * Returns true if the segmented length <= max length.
  */
-bool skb_gso_validate_mtu(const struct sk_buff *skb, unsigned int mtu)
-{
+static inline bool skb_gso_size_check(const struct sk_buff *skb,
+				      unsigned int seg_len,
+				      unsigned int max_len) {
 	const struct skb_shared_info *shinfo = skb_shinfo(skb);
 	const struct sk_buff *iter;
-	unsigned int hlen;
-
-	hlen = skb_gso_network_seglen(skb);
 
 	if (shinfo->gso_size != GSO_BY_FRAGS)
-		return hlen <= mtu;
+		return seg_len <= max_len;
 
 	/* Undo this so we can re-use header sizes */
-	hlen -= GSO_BY_FRAGS;
+	seg_len -= GSO_BY_FRAGS;
 
 	skb_walk_frags(skb, iter) {
-		if (hlen + skb_headlen(iter) > mtu)
+		if (seg_len + skb_headlen(iter) > max_len)
 			return false;
 	}
 
 	return true;
 }
+
+/**
+ * skb_gso_validate_mtu - Return in case such skb fits a given MTU
+ *
+ * @skb: GSO skb
+ * @mtu: MTU to validate against
+ *
+ * skb_gso_validate_mtu validates if a given skb will fit a wanted MTU
+ * once split.
+ */
+bool skb_gso_validate_mtu(const struct sk_buff *skb, unsigned int mtu)
+{
+	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
+}
 EXPORT_SYMBOL_GPL(skb_gso_validate_mtu);
 
+/**
+ * skb_gso_validate_mac_len - Will a split GSO skb fit in a given length?
+ *
+ * @skb: GSO skb
+ * @len: length to validate against
+ *
+ * skb_gso_validate_mac_len validates if a given skb will fit a wanted
+ * length once split, including L2, L3 and L4 headers and the payload.
+ */
+bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
+{
+	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
+}
+EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
+
 static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 {
 	int mac_len;
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index b36ecb58aa6e..107cc76b6e24 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -142,16 +142,6 @@ static u64 psched_ns_t2l(const struct psched_ratecfg *r,
 	return len;
 }
 
-/*
- * Return length of individual segments of a gso packet,
- * including all headers (MAC, IP, TCP/UDP)
- */
-static unsigned int skb_gso_mac_seglen(const struct sk_buff *skb)
-{
-	unsigned int hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
-	return hdr_len + skb_gso_transport_seglen(skb);
-}
-
 /* GSO packet is too big, segment it so that tbf can transmit
  * each segment in time
  */
-- 
2.19.1



