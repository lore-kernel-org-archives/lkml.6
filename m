Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F69AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B887F2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498406;
	bh=UH5K8+w9oDMTbfCetY4n1EPfMsiTDSpHpLo6fZkD0fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YjYSQNrdVgBd+bhMTSVctOKHtesyBiYMe8wv72GHC/kFfuDHj0Cl74HYChYpaG2bv
	 mbE4C1KnUtJv8PyfP61XHWKwsX7RfIlEgT28C+guSGD8MkqxHRe0owv0dTGX93rL26
	 ltEGKWLkuurLtgdRgDoc6x0xy+QywtC18JEFkiPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbfBROAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732972AbfBRN76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0490D2173C;
        Mon, 18 Feb 2019 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498397;
        bh=UH5K8+w9oDMTbfCetY4n1EPfMsiTDSpHpLo6fZkD0fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbwmdyWKEK4QnSZpwbomqA7BK363VrrXPfBMc8KqzaJDWUmz1Iv9S2WX0HjIM5cQ1
         d6BC4yaEM40wvz1l4mrscEkxZuIr3O8fDAta+cfSeYQg3TSJQUHybpEqsdsornemz7
         pxP3egzcj4d0vNJCjiJOOniuwGAw4Q6aEZwQB/eI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 56/58] netfilter: nf_tables: fix mismatch in big-endian system
Date:   Mon, 18 Feb 2019 14:44:17 +0100
Message-Id: <20190218133512.705739103@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

From: Liping Zhang <zlpnobody@gmail.com>

commit 10596608c4d62cb8c1c2b806debcbd32fe657e71 upstream.

Currently, there are two different methods to store an u16 integer to
the u32 data register. For example:
  u32 *dest = &regs->data[priv->dreg];
  1. *dest = 0; *(u16 *) dest = val_u16;
  2. *dest = val_u16;

For method 1, the u16 value will be stored like this, either in
big-endian or little-endian system:
  0          15           31
  +-+-+-+-+-+-+-+-+-+-+-+-+
  |   Value   |     0     |
  +-+-+-+-+-+-+-+-+-+-+-+-+

For method 2, in little-endian system, the u16 value will be the same
as listed above. But in big-endian system, the u16 value will be stored
like this:
  0          15           31
  +-+-+-+-+-+-+-+-+-+-+-+-+
  |     0     |   Value   |
  +-+-+-+-+-+-+-+-+-+-+-+-+

So later we use "memcmp(&regs->data[priv->sreg], data, 2);" to do
compare in nft_cmp, nft_lookup expr ..., method 2 will get the wrong
result in big-endian system, as 0~15 bits will always be zero.

For the similar reason, when loading an u16 value from the u32 data
register, we should use "*(u16 *) sreg;" instead of "(u16)*sreg;",
the 2nd method will get the wrong value in the big-endian system.

So introduce some wrapper functions to store/load an u8 or u16
integer to/from the u32 data register, and use them in the right
place.

Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/netfilter/nf_tables.h   |   29 ++++++++++++++++++++++++
 net/ipv4/netfilter/nft_masq_ipv4.c  |    8 +++---
 net/ipv4/netfilter/nft_redir_ipv4.c |    8 +++---
 net/ipv6/netfilter/nft_masq_ipv6.c  |    8 +++---
 net/ipv6/netfilter/nft_redir_ipv6.c |    8 +++---
 net/netfilter/nft_ct.c              |   10 ++++----
 net/netfilter/nft_meta.c            |   42 ++++++++++++++++++------------------
 net/netfilter/nft_nat.c             |    8 +++---
 8 files changed, 76 insertions(+), 45 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -87,6 +87,35 @@ struct nft_regs {
 	};
 };
 
+/* Store/load an u16 or u8 integer to/from the u32 data register.
+ *
+ * Note, when using concatenations, register allocation happens at 32-bit
+ * level. So for store instruction, pad the rest part with zero to avoid
+ * garbage values.
+ */
+
+static inline void nft_reg_store16(u32 *dreg, u16 val)
+{
+	*dreg = 0;
+	*(u16 *)dreg = val;
+}
+
+static inline void nft_reg_store8(u32 *dreg, u8 val)
+{
+	*dreg = 0;
+	*(u8 *)dreg = val;
+}
+
+static inline u16 nft_reg_load16(u32 *sreg)
+{
+	return *(u16 *)sreg;
+}
+
+static inline u8 nft_reg_load8(u32 *sreg)
+{
+	return *(u8 *)sreg;
+}
+
 static inline void nft_data_copy(u32 *dst, const struct nft_data *src,
 				 unsigned int len)
 {
--- a/net/ipv4/netfilter/nft_masq_ipv4.c
+++ b/net/ipv4/netfilter/nft_masq_ipv4.c
@@ -26,10 +26,10 @@ static void nft_masq_ipv4_eval(const str
 	memset(&range, 0, sizeof(range));
 	range.flags = priv->flags;
 	if (priv->sreg_proto_min) {
-		range.min_proto.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_min];
-		range.max_proto.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_max];
+		range.min_proto.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_min]);
+		range.max_proto.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_max]);
 	}
 	regs->verdict.code = nf_nat_masquerade_ipv4(pkt->skb, pkt->hook,
 						    &range, pkt->out);
--- a/net/ipv4/netfilter/nft_redir_ipv4.c
+++ b/net/ipv4/netfilter/nft_redir_ipv4.c
@@ -26,10 +26,10 @@ static void nft_redir_ipv4_eval(const st
 
 	memset(&mr, 0, sizeof(mr));
 	if (priv->sreg_proto_min) {
-		mr.range[0].min.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_min];
-		mr.range[0].max.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_max];
+		mr.range[0].min.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_min]);
+		mr.range[0].max.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_max]);
 		mr.range[0].flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
--- a/net/ipv6/netfilter/nft_masq_ipv6.c
+++ b/net/ipv6/netfilter/nft_masq_ipv6.c
@@ -27,10 +27,10 @@ static void nft_masq_ipv6_eval(const str
 	memset(&range, 0, sizeof(range));
 	range.flags = priv->flags;
 	if (priv->sreg_proto_min) {
-		range.min_proto.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_min];
-		range.max_proto.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_max];
+		range.min_proto.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_min]);
+		range.max_proto.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_max]);
 	}
 	regs->verdict.code = nf_nat_masquerade_ipv6(pkt->skb, &range, pkt->out);
 }
--- a/net/ipv6/netfilter/nft_redir_ipv6.c
+++ b/net/ipv6/netfilter/nft_redir_ipv6.c
@@ -26,10 +26,10 @@ static void nft_redir_ipv6_eval(const st
 
 	memset(&range, 0, sizeof(range));
 	if (priv->sreg_proto_min) {
-		range.min_proto.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_min],
-		range.max_proto.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_max],
+		range.min_proto.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_min]);
+		range.max_proto.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_max]);
 		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -77,7 +77,7 @@ static void nft_ct_get_eval(const struct
 
 	switch (priv->key) {
 	case NFT_CT_DIRECTION:
-		*dest = CTINFO2DIR(ctinfo);
+		nft_reg_store8(dest, CTINFO2DIR(ctinfo));
 		return;
 	case NFT_CT_STATUS:
 		*dest = ct->status;
@@ -129,10 +129,10 @@ static void nft_ct_get_eval(const struct
 		return;
 	}
 	case NFT_CT_L3PROTOCOL:
-		*dest = nf_ct_l3num(ct);
+		nft_reg_store8(dest, nf_ct_l3num(ct));
 		return;
 	case NFT_CT_PROTOCOL:
-		*dest = nf_ct_protonum(ct);
+		nft_reg_store8(dest, nf_ct_protonum(ct));
 		return;
 	default:
 		break;
@@ -149,10 +149,10 @@ static void nft_ct_get_eval(const struct
 		       nf_ct_l3num(ct) == NFPROTO_IPV4 ? 4 : 16);
 		return;
 	case NFT_CT_PROTO_SRC:
-		*dest = (__force __u16)tuple->src.u.all;
+		nft_reg_store16(dest, (__force u16)tuple->src.u.all);
 		return;
 	case NFT_CT_PROTO_DST:
-		*dest = (__force __u16)tuple->dst.u.all;
+		nft_reg_store16(dest, (__force u16)tuple->dst.u.all);
 		return;
 	default:
 		break;
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -45,16 +45,15 @@ void nft_meta_get_eval(const struct nft_
 		*dest = skb->len;
 		break;
 	case NFT_META_PROTOCOL:
-		*dest = 0;
-		*(__be16 *)dest = skb->protocol;
+		nft_reg_store16(dest, (__force u16)skb->protocol);
 		break;
 	case NFT_META_NFPROTO:
-		*dest = pkt->pf;
+		nft_reg_store8(dest, pkt->pf);
 		break;
 	case NFT_META_L4PROTO:
 		if (!pkt->tprot_set)
 			goto err;
-		*dest = pkt->tprot;
+		nft_reg_store8(dest, pkt->tprot);
 		break;
 	case NFT_META_PRIORITY:
 		*dest = skb->priority;
@@ -85,14 +84,12 @@ void nft_meta_get_eval(const struct nft_
 	case NFT_META_IIFTYPE:
 		if (in == NULL)
 			goto err;
-		*dest = 0;
-		*(u16 *)dest = in->type;
+		nft_reg_store16(dest, in->type);
 		break;
 	case NFT_META_OIFTYPE:
 		if (out == NULL)
 			goto err;
-		*dest = 0;
-		*(u16 *)dest = out->type;
+		nft_reg_store16(dest, out->type);
 		break;
 	case NFT_META_SKUID:
 		sk = skb_to_full_sk(skb);
@@ -142,22 +139,22 @@ void nft_meta_get_eval(const struct nft_
 #endif
 	case NFT_META_PKTTYPE:
 		if (skb->pkt_type != PACKET_LOOPBACK) {
-			*dest = skb->pkt_type;
+			nft_reg_store8(dest, skb->pkt_type);
 			break;
 		}
 
 		switch (pkt->pf) {
 		case NFPROTO_IPV4:
 			if (ipv4_is_multicast(ip_hdr(skb)->daddr))
-				*dest = PACKET_MULTICAST;
+				nft_reg_store8(dest, PACKET_MULTICAST);
 			else
-				*dest = PACKET_BROADCAST;
+				nft_reg_store8(dest, PACKET_BROADCAST);
 			break;
 		case NFPROTO_IPV6:
 			if (ipv6_hdr(skb)->daddr.s6_addr[0] == 0xFF)
-				*dest = PACKET_MULTICAST;
+				nft_reg_store8(dest, PACKET_MULTICAST);
 			else
-				*dest = PACKET_BROADCAST;
+				nft_reg_store8(dest, PACKET_BROADCAST);
 			break;
 		case NFPROTO_NETDEV:
 			switch (skb->protocol) {
@@ -171,14 +168,14 @@ void nft_meta_get_eval(const struct nft_
 					goto err;
 
 				if (ipv4_is_multicast(iph->daddr))
-					*dest = PACKET_MULTICAST;
+					nft_reg_store8(dest, PACKET_MULTICAST);
 				else
-					*dest = PACKET_BROADCAST;
+					nft_reg_store8(dest, PACKET_BROADCAST);
 
 				break;
 			}
 			case htons(ETH_P_IPV6):
-				*dest = PACKET_MULTICAST;
+				nft_reg_store8(dest, PACKET_MULTICAST);
 				break;
 			default:
 				WARN_ON_ONCE(1);
@@ -233,7 +230,9 @@ void nft_meta_set_eval(const struct nft_
 {
 	const struct nft_meta *meta = nft_expr_priv(expr);
 	struct sk_buff *skb = pkt->skb;
-	u32 value = regs->data[meta->sreg];
+	u32 *sreg = &regs->data[meta->sreg];
+	u32 value = *sreg;
+	u8 pkt_type;
 
 	switch (meta->key) {
 	case NFT_META_MARK:
@@ -243,9 +242,12 @@ void nft_meta_set_eval(const struct nft_
 		skb->priority = value;
 		break;
 	case NFT_META_PKTTYPE:
-		if (skb->pkt_type != value &&
-		    skb_pkt_type_ok(value) && skb_pkt_type_ok(skb->pkt_type))
-			skb->pkt_type = value;
+		pkt_type = nft_reg_load8(sreg);
+
+		if (skb->pkt_type != pkt_type &&
+		    skb_pkt_type_ok(pkt_type) &&
+		    skb_pkt_type_ok(skb->pkt_type))
+			skb->pkt_type = pkt_type;
 		break;
 	case NFT_META_NFTRACE:
 		skb->nf_trace = !!value;
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -65,10 +65,10 @@ static void nft_nat_eval(const struct nf
 	}
 
 	if (priv->sreg_proto_min) {
-		range.min_proto.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_min];
-		range.max_proto.all =
-			*(__be16 *)&regs->data[priv->sreg_proto_max];
+		range.min_proto.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_min]);
+		range.max_proto.all = (__force __be16)nft_reg_load16(
+			&regs->data[priv->sreg_proto_max]);
 		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 


