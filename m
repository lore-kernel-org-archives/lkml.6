Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="VJ7Nd3Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BCB9607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeFFNyP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:54:15 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:18484 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbeFFNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:54:10 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520899200";
   d="scan'208";a="744768010"
From: Norbert Manthey <nmanthey@amazon.de>
CC: Norbert Manthey <nmanthey@amazon.de>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <simon.horman@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Tom Herbert <tom@quantonium.net>,
        John Crispin <john@phrozen.org>,
        Eric Dumazet <edumazet@google.com>,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        "WANG Cong" <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [less-CONFIG_NET 2/7] net: reorder flow_dissector
Date: Wed, 6 Jun 2018 15:53:21 +0200
Message-ID: <1528293206-24298-2-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
References: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
 <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit reorders the definitions, such that in the next step we
can easily cut the file into a commonly used part, as well as a part
that is only required in case CONFIG_NET is used.

This is part of the effort to split CONFIG_SECCOMP_FILTER and
CONFIG_NET.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 net/core/flow_dissector.c | 206 +++++++++++++++++++++++-----------------------
 1 file changed, 103 insertions(+), 103 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index d29f09b..70e0679 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1085,36 +1085,6 @@ static inline size_t flow_keys_hash_length(const struct flow_keys *flow)
 	return (sizeof(*flow) - diff) / sizeof(u32);
 }
 
-__be32 flow_get_u32_src(const struct flow_keys *flow)
-{
-	switch (flow->control.addr_type) {
-	case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
-		return flow->addrs.v4addrs.src;
-	case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
-		return (__force __be32)ipv6_addr_hash(
-			&flow->addrs.v6addrs.src);
-	case FLOW_DISSECTOR_KEY_TIPC:
-		return flow->addrs.tipckey.key;
-	default:
-		return 0;
-	}
-}
-EXPORT_SYMBOL(flow_get_u32_src);
-
-__be32 flow_get_u32_dst(const struct flow_keys *flow)
-{
-	switch (flow->control.addr_type) {
-	case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
-		return flow->addrs.v4addrs.dst;
-	case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
-		return (__force __be32)ipv6_addr_hash(
-			&flow->addrs.v6addrs.dst);
-	default:
-		return 0;
-	}
-}
-EXPORT_SYMBOL(flow_get_u32_dst);
-
 static inline void __flow_hash_consistentify(struct flow_keys *keys)
 {
 	int addr_diff, i;
@@ -1162,49 +1132,6 @@ static inline u32 __flow_hash_from_keys(struct flow_keys *keys, u32 keyval)
 	return hash;
 }
 
-u32 flow_hash_from_keys(struct flow_keys *keys)
-{
-	__flow_hash_secret_init();
-	return __flow_hash_from_keys(keys, hashrnd);
-}
-EXPORT_SYMBOL(flow_hash_from_keys);
-
-static inline u32 ___skb_get_hash(const struct sk_buff *skb,
-				  struct flow_keys *keys, u32 keyval)
-{
-	skb_flow_dissect_flow_keys(skb, keys,
-				   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
-
-	return __flow_hash_from_keys(keys, keyval);
-}
-
-struct _flow_keys_digest_data {
-	__be16	n_proto;
-	u8	ip_proto;
-	u8	padding;
-	__be32	ports;
-	__be32	src;
-	__be32	dst;
-};
-
-void make_flow_keys_digest(struct flow_keys_digest *digest,
-			   const struct flow_keys *flow)
-{
-	struct _flow_keys_digest_data *data =
-	    (struct _flow_keys_digest_data *)digest;
-
-	BUILD_BUG_ON(sizeof(*data) > sizeof(*digest));
-
-	memset(digest, 0, sizeof(*digest));
-
-	data->n_proto = flow->basic.n_proto;
-	data->ip_proto = flow->basic.ip_proto;
-	data->ports = flow->ports.ports;
-	data->src = flow->addrs.v4addrs.src;
-	data->dst = flow->addrs.v4addrs.dst;
-}
-EXPORT_SYMBOL(make_flow_keys_digest);
-
 static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
 
 u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
@@ -1222,36 +1149,6 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric);
 
-/**
- * __skb_get_hash: calculate a flow hash
- * @skb: sk_buff to calculate flow hash from
- *
- * This function calculates a flow hash based on src/dst addresses
- * and src/dst port numbers.  Sets hash in skb to non-zero hash value
- * on success, zero indicates no valid hash.  Also, sets l4_hash in skb
- * if hash is a canonical 4-tuple hash over transport ports.
- */
-void __skb_get_hash(struct sk_buff *skb)
-{
-	struct flow_keys keys;
-	u32 hash;
-
-	__flow_hash_secret_init();
-
-	hash = ___skb_get_hash(skb, &keys, hashrnd);
-
-	__skb_set_sw_hash(skb, hash, flow_keys_have_l4(&keys));
-}
-EXPORT_SYMBOL(__skb_get_hash);
-
-__u32 skb_get_hash_perturb(const struct sk_buff *skb, u32 perturb)
-{
-	struct flow_keys keys;
-
-	return ___skb_get_hash(skb, &keys, perturb);
-}
-EXPORT_SYMBOL(skb_get_hash_perturb);
-
 u32 __skb_get_poff(const struct sk_buff *skb, void *data,
 		   const struct flow_keys *keys, int hlen)
 {
@@ -1322,6 +1219,109 @@ u32 skb_get_poff(const struct sk_buff *skb)
 	return __skb_get_poff(skb, skb->data, &keys, skb_headlen(skb));
 }
 
+__be32 flow_get_u32_src(const struct flow_keys *flow)
+{
+	switch (flow->control.addr_type) {
+	case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
+		return flow->addrs.v4addrs.src;
+	case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
+		return (__force __be32)ipv6_addr_hash(
+			&flow->addrs.v6addrs.src);
+	case FLOW_DISSECTOR_KEY_TIPC:
+		return flow->addrs.tipckey.key;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL(flow_get_u32_src);
+
+__be32 flow_get_u32_dst(const struct flow_keys *flow)
+{
+	switch (flow->control.addr_type) {
+	case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
+		return flow->addrs.v4addrs.dst;
+	case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
+		return (__force __be32)ipv6_addr_hash(
+			&flow->addrs.v6addrs.dst);
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL(flow_get_u32_dst);
+
+u32 flow_hash_from_keys(struct flow_keys *keys)
+{
+	__flow_hash_secret_init();
+	return __flow_hash_from_keys(keys, hashrnd);
+}
+EXPORT_SYMBOL(flow_hash_from_keys);
+
+static inline u32 ___skb_get_hash(const struct sk_buff *skb,
+				  struct flow_keys *keys, u32 keyval)
+{
+	skb_flow_dissect_flow_keys(skb, keys,
+				   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+
+	return __flow_hash_from_keys(keys, keyval);
+}
+
+struct _flow_keys_digest_data {
+	__be16	n_proto;
+	u8	ip_proto;
+	u8	padding;
+	__be32	ports;
+	__be32	src;
+	__be32	dst;
+};
+
+void make_flow_keys_digest(struct flow_keys_digest *digest,
+			   const struct flow_keys *flow)
+{
+	struct _flow_keys_digest_data *data =
+	    (struct _flow_keys_digest_data *)digest;
+
+	BUILD_BUG_ON(sizeof(*data) > sizeof(*digest));
+
+	memset(digest, 0, sizeof(*digest));
+
+	data->n_proto = flow->basic.n_proto;
+	data->ip_proto = flow->basic.ip_proto;
+	data->ports = flow->ports.ports;
+	data->src = flow->addrs.v4addrs.src;
+	data->dst = flow->addrs.v4addrs.dst;
+}
+EXPORT_SYMBOL(make_flow_keys_digest);
+
+/**
+ * __skb_get_hash: calculate a flow hash
+ * @skb: sk_buff to calculate flow hash from
+ *
+ * This function calculates a flow hash based on src/dst addresses
+ * and src/dst port numbers.  Sets hash in skb to non-zero hash value
+ * on success, zero indicates no valid hash.  Also, sets l4_hash in skb
+ * if hash is a canonical 4-tuple hash over transport ports.
+ */
+void __skb_get_hash(struct sk_buff *skb)
+{
+	struct flow_keys keys;
+	u32 hash;
+
+	__flow_hash_secret_init();
+
+	hash = ___skb_get_hash(skb, &keys, hashrnd);
+
+	__skb_set_sw_hash(skb, hash, flow_keys_have_l4(&keys));
+}
+EXPORT_SYMBOL(__skb_get_hash);
+
+__u32 skb_get_hash_perturb(const struct sk_buff *skb, u32 perturb)
+{
+	struct flow_keys keys;
+
+	return ___skb_get_hash(skb, &keys, perturb);
+}
+EXPORT_SYMBOL(skb_get_hash_perturb);
+
 __u32 __get_hash_from_flowi6(const struct flowi6 *fl6, struct flow_keys *keys)
 {
 	memset(keys, 0, sizeof(*keys));
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
