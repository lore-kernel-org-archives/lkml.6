Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E047CC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFEF21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="ERzX9Ip2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404087AbeLUPP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:15:29 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:38538 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbeLUPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:15:27 -0500
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1545405325; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Ug0rn2mSzhSVcrGieA3FkgIo5XxIlnOYm88mAmvaqM=;
        b=ERzX9Ip2wBAG5swHUCW1S3a0D6S03rnvU7eGSgIln1inOySbx9/TU4zkmQQOc7QCvwhfrr
        KeeuT7QjscTuRGbnKatA/GtcrLnpHxDeeK//PV+pKpeFYihiYtBMsr9SR5hpgxx7U9zMS0
        aTFybqh/kGKvf4Uf0QAruhKaDy+foT1jeJrN+IBflYCONsqPy7FMj+FJT0ULz9LWtFLI2G
        1iXm+qT+IDqoY0qVNaHXWPkyy/IST2nIAJ6KWc8vtpq0V6wnz/+zenQTxzkqkJopVIf7K4
        jsqRqxb44WqVvfCQ2keN7MCuFvkie+pAG8lo8LIG3vXC3k3vsQDvxKFbrzY4hg==
To:     netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next 2/4] bridge: simplify ip_mc_check_igmp() and ipv6_mc_check_mld() internals
Date:   Fri, 21 Dec 2018 16:15:09 +0100
Message-Id: <20181221151511.14923-3-linus.luessing@c0d3.blue>
In-Reply-To: <20181221151511.14923-1-linus.luessing@c0d3.blue>
References: <20181221151511.14923-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue;
        s=2018; t=1545405325; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Ug0rn2mSzhSVcrGieA3FkgIo5XxIlnOYm88mAmvaqM=;
        b=Fsk8qqiunvQb1ossgd24mhQEtTBmeCjVjUWWq3FhEKK1M76EnS+SA6wjZ9Koy/9qHPAxwc
        LR1c69JiRyaQVo2B0it10W0QFj5LnLyn6BC7s+xAWEoLOzjUgwMyHoGjMaR3IGelbn3alc
        IbYDYl4efKrR5j85RR0iZCmv+mS/iOZZyrxqN6uXaUw23APu0c6Jf2/gNkFe6C9Lszqm3L
        JbTCjCviUFYOO5Cj64WmTc0CD0w82ikeUVJi5fSu6p7nt+LWLT/Uy/l1ztNSrvhw6d13Qe
        8pj5Zh5iWXJpY0DMgE35C67Ejp7UWjjc7RlggmmMRViINWXFEHHdWEiKjzpFKA==
ARC-Seal: i=1; s=2018; d=c0d3.blue; t=1545405325; a=rsa-sha256; cv=none;
        b=ADuV+wM0WvcgtMBYHYYBcYb7r2H8kxmx/2AgCYShaGxrlqnQ7dNb80FROl4+7p7MOsIsAr
        07r9XZV+5n7QZeRXIigMQ2OckXR144CSQFKGOCV7m1Bsr8HPz/7KvpLh4wK8zAnrD/S4Tt
        Lm8YpsiBFNBhpW6qnFeHvBT83RkmeZSqL2Ro0bhuY1/iEeyEO34OHZAEKdPvW/hxn5xAKC
        pG4UTkors0p9UTn5hSbt1+S6ciZvjueMeyuZByQq76m//r8vHrOxhfW//ByZn+YpX65k3c
        EAc4pF8XYyajmXY1J7uqNGZkG2VHCDvU1aFSq6s1pA3ZwMlnof+2XAREZVnm/w==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch the internal use of the skb_trimmed is reduced to
the ICMPv6/IGMP checksum verification. And for the length checks
the newly introduced helper functions are used instead of calculating
and checking with skb->len directly.

These changes should hopefully make it easier to verify that length
checks are performed properly.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/ipv4/igmp.c        | 51 ++++++++++++++++++-----------------------
 net/ipv6/mcast_snoop.c | 62 ++++++++++++++++++++++++--------------------------
 2 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b1f6d93282d7..a40e48ded10d 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1493,22 +1493,22 @@ static int ip_mc_check_igmp_reportv3(struct sk_buff *skb)
 
 	len += sizeof(struct igmpv3_report);
 
-	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
+	return ip_mc_may_pull(skb, len) ? 0 : -EINVAL;
 }
 
 static int ip_mc_check_igmp_query(struct sk_buff *skb)
 {
-	unsigned int len = skb_transport_offset(skb);
-
-	len += sizeof(struct igmphdr);
-	if (skb->len < len)
-		return -EINVAL;
+	unsigned int transport_len = ip_transport_len(skb);
+	unsigned int len;
 
 	/* IGMPv{1,2}? */
-	if (skb->len != len) {
+	if (transport_len != sizeof(struct igmphdr)) {
 		/* or IGMPv3? */
-		len += sizeof(struct igmpv3_query) - sizeof(struct igmphdr);
-		if (skb->len < len || !pskb_may_pull(skb, len))
+		if (transport_len < sizeof(struct igmpv3_query))
+			return -EINVAL;
+
+		len = skb_transport_offset(skb) + sizeof(struct igmpv3_query);
+		if (!ip_mc_may_pull(skb, len))
 			return -EINVAL;
 	}
 
@@ -1544,35 +1544,24 @@ static inline __sum16 ip_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_simple_validate(skb);
 }
 
-static int __ip_mc_check_igmp(struct sk_buff *skb)
-
+static int ip_mc_check_igmp_csum(struct sk_buff *skb)
 {
-	struct sk_buff *skb_chk;
-	unsigned int transport_len;
 	unsigned int len = skb_transport_offset(skb) + sizeof(struct igmphdr);
-	int ret = -EINVAL;
+	unsigned int transport_len = ip_transport_len(skb);
+	struct sk_buff *skb_chk;
 
-	transport_len = ntohs(ip_hdr(skb)->tot_len) - ip_hdrlen(skb);
+	if (!ip_mc_may_pull(skb, len))
+		return -EINVAL;
 
 	skb_chk = skb_checksum_trimmed(skb, transport_len,
 				       ip_mc_validate_checksum);
 	if (!skb_chk)
-		goto err;
+		return -EINVAL;
 
-	if (!pskb_may_pull(skb_chk, len))
-		goto err;
-
-	ret = ip_mc_check_igmp_msg(skb_chk);
-	if (ret)
-		goto err;
-
-	ret = 0;
-
-err:
-	if (skb_chk && skb_chk != skb)
+	if (skb_chk != skb)
 		kfree_skb(skb_chk);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -1600,7 +1589,11 @@ int ip_mc_check_igmp(struct sk_buff *skb)
 	if (ip_hdr(skb)->protocol != IPPROTO_IGMP)
 		return -ENOMSG;
 
-	return __ip_mc_check_igmp(skb);
+	ret = ip_mc_check_igmp_csum(skb);
+	if (ret < 0)
+		return ret;
+
+	return ip_mc_check_igmp_msg(skb);
 }
 EXPORT_SYMBOL(ip_mc_check_igmp);
 
diff --git a/net/ipv6/mcast_snoop.c b/net/ipv6/mcast_snoop.c
index 1a917dc80d5e..a72ddfc40eb3 100644
--- a/net/ipv6/mcast_snoop.c
+++ b/net/ipv6/mcast_snoop.c
@@ -77,27 +77,27 @@ static int ipv6_mc_check_mld_reportv2(struct sk_buff *skb)
 
 	len += sizeof(struct mld2_report);
 
-	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
+	return ipv6_mc_may_pull(skb, len) ? 0 : -EINVAL;
 }
 
 static int ipv6_mc_check_mld_query(struct sk_buff *skb)
 {
+	unsigned int transport_len = ipv6_transport_len(skb);
 	struct mld_msg *mld;
-	unsigned int len = skb_transport_offset(skb);
+	unsigned int len;
 
 	/* RFC2710+RFC3810 (MLDv1+MLDv2) require link-local source addresses */
 	if (!(ipv6_addr_type(&ipv6_hdr(skb)->saddr) & IPV6_ADDR_LINKLOCAL))
 		return -EINVAL;
 
-	len += sizeof(struct mld_msg);
-	if (skb->len < len)
-		return -EINVAL;
-
 	/* MLDv1? */
-	if (skb->len != len) {
+	if (transport_len != sizeof(struct mld_msg)) {
 		/* or MLDv2? */
-		len += sizeof(struct mld2_query) - sizeof(struct mld_msg);
-		if (skb->len < len || !pskb_may_pull(skb, len))
+		if (transport_len < sizeof(struct mld2_query))
+			return -EINVAL;
+
+		len = skb_transport_offset(skb) + sizeof(struct mld2_query);
+		if (!ipv6_mc_may_pull(skb, len))
 			return -EINVAL;
 	}
 
@@ -115,7 +115,13 @@ static int ipv6_mc_check_mld_query(struct sk_buff *skb)
 
 static int ipv6_mc_check_mld_msg(struct sk_buff *skb)
 {
-	struct mld_msg *mld = (struct mld_msg *)skb_transport_header(skb);
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct mld_msg);
+	struct mld_msg *mld;
+
+	if (!ipv6_mc_may_pull(skb, len))
+		return -EINVAL;
+
+	mld = (struct mld_msg *)skb_transport_header(skb);
 
 	switch (mld->mld_type) {
 	case ICMPV6_MGM_REDUCTION:
@@ -136,36 +142,24 @@ static inline __sum16 ipv6_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo);
 }
 
-static int __ipv6_mc_check_mld(struct sk_buff *skb)
-
+static int ipv6_mc_check_icmpv6(struct sk_buff *skb)
 {
-	struct sk_buff *skb_chk = NULL;
-	unsigned int transport_len;
-	unsigned int len = skb_transport_offset(skb) + sizeof(struct mld_msg);
-	int ret = -EINVAL;
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct icmp6hdr);
+	unsigned int transport_len = ipv6_transport_len(skb);
+	struct sk_buff *skb_chk;
 
-	transport_len = ntohs(ipv6_hdr(skb)->payload_len);
-	transport_len -= skb_transport_offset(skb) - sizeof(struct ipv6hdr);
+	if (!ipv6_mc_may_pull(skb, len))
+		return -EINVAL;
 
 	skb_chk = skb_checksum_trimmed(skb, transport_len,
 				       ipv6_mc_validate_checksum);
 	if (!skb_chk)
-		goto err;
+		return -EINVAL;
 
-	if (!pskb_may_pull(skb_chk, len))
-		goto err;
-
-	ret = ipv6_mc_check_mld_msg(skb_chk);
-	if (ret)
-		goto err;
-
-	ret = 0;
-
-err:
-	if (skb_chk && skb_chk != skb)
+	if (skb_chk != skb)
 		kfree_skb(skb_chk);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -195,6 +189,10 @@ int ipv6_mc_check_mld(struct sk_buff *skb)
 	if (ret < 0)
 		return ret;
 
-	return __ipv6_mc_check_mld(skb);
+	ret = ipv6_mc_check_icmpv6(skb);
+	if (ret < 0)
+		return ret;
+
+	return ipv6_mc_check_mld_msg(skb);
 }
 EXPORT_SYMBOL(ipv6_mc_check_mld);
-- 
2.11.0

