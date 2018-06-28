Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE72C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890832736E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="tgpzQTBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890832736E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965901AbeF1Mqj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:46:39 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:36231 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965788AbeF1Mqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530189997; x=1561725997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kEFx0Nf6J4J9XhqwRpgnGzLrnp6MlJNY7N9FPdJ/mj8=;
  b=tgpzQTBfa9dpLuLl5qOudaA/mkIdl+1KUF6gSz581Jf0okjQ8wWgEJdh
   dlumycVRiCMZ7N7oVMY6dU0ja2LXRJAxlJb73NnZSrjP8DFWqgEsoE491
   NFuA5DDl1O2Tfd1L/1++ADoKR+gx+LmPfc5VC3B60q3pVRv0Co1gGL3xY
   c=;
X-IronPort-AV: E=Sophos;i="5.51,283,1526342400"; 
   d="scan'208";a="740115556"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jun 2018 12:46:34 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5SCkVww048699
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 Jun 2018 12:46:33 GMT
Received: from EX13D02EUB003.ant.amazon.com (10.43.166.172) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:33 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02EUB003.ant.amazon.com (10.43.166.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:32 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.28.85.80) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 12:46:30 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "Simon Horman" <simon.horman@netronome.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Tom Herbert" <tom@quantonium.net>,
        Michal Kubecek <mkubecek@suse.cz>,
        "Sven Eckelmann" <sven.eckelmann@openmesh.com>,
        WANG Cong <xiyou.wangcong@gmail.com>, <netdev@vger.kernel.org>
Subject: [less-CONFIG_NET v2 2/8] net: reorder flow_dissector
Date:   Thu, 28 Jun 2018 14:45:30 +0200
Message-ID: <1530189936-25780-3-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
References: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
 <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 53f96e4..76d0b23 100644
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
 		   const struct flow_keys_basic *keys, int hlen)
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

