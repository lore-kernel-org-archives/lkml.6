Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D0C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625DA20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="js944n+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfAUHWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:22:33 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:41870 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfAUHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:22:14 -0500
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1548052011; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Ug0rn2mSzhSVcrGieA3FkgIo5XxIlnOYm88mAmvaqM=;
        b=js944n+WqMhWr/dEynGrcjg1419CNANvn0M5QcxQuV7Kdfh+5wG04dwZf3/C5Pe5z4K6Ua
        LoKa42tvW9kcYQbq4R0T3Oy10B6u0rsJq2SCt2GAGCf7V20M1927gP46z6iFWNb1a781Ld
        /uIjcnAzu/EZAmYGuNLVSmSbFd2McDVw8J7skCBiLDvKYd5QKECzI2bS8kiqwf3S7afZ4w
        11CLpxMJU0jNGjyTpIwrRx/QWDZJAbUZEUIbtLSMSQi0sQZd949e9MhCG3zUs5EyEl714H
        JgP5D7cCpVnvAlKlLOP5TFnHsQSjBy1DSpoI8DdcdYLjtHg4SiPBbusoceq85A==
To:     netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v2 2/4] bridge: simplify ip_mc_check_igmp() and ipv6_mc_check_mld() internals
Date:   Mon, 21 Jan 2019 07:26:26 +0100
Message-Id: <20190121062628.2710-3-linus.luessing@c0d3.blue>
In-Reply-To: <20190121062628.2710-1-linus.luessing@c0d3.blue>
References: <20190121062628.2710-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue;
        s=2018; t=1548052011; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Ug0rn2mSzhSVcrGieA3FkgIo5XxIlnOYm88mAmvaqM=;
        b=PJ/OgstX7EDqF36fuqchB9RaVHuUOvJZXd1XqLaoiNssxNMTfYPH811oZv//ykf27NAvcU
        uk8dCvZ3lQ+vuJ9eB61j+XJ6TKk8mrU8taAhlu69uihXqV0o5rZgXObzfGA2BkMkLAcZIm
        dqn3kJhHgYV+kX/3SmmwI0khC00+I4gF5A+oWljjgj8WpLc+xGvhbCYi56LUuro1G3zoGd
        Soz7uwfeieKCvZRhjJlt4PMG9DwICAA1QC0vl7hVv7ojpZxv+UJSn/lZCmz82geArwxnPr
        HjUkL3jgyfvuwPNSopx3ruvWNunS2/iZY8vaw999+fRc8TdllYjCph32I4+zsA==
ARC-Seal: i=1; s=2018; d=c0d3.blue; t=1548052011; a=rsa-sha256; cv=none;
        b=rwlzPaHSIRkyfob3LFULwu3MHk2LGUCOPofY24V2WqGk7aYAKGiqN2OssmkU+QTRgGN4+z
        fEmvVlbzJjHOqEgts5L2+1oBw+/29wn94/RjejqAbNhzaVaA8YtU5FW1ueHPj5uEr1cf/4
        E3BWHISQb7bTduOUB/kNo1pRUtcNYe4HHfLwoROqDB9B/3ofQQzist1Ldo0qbt5tPWff5q
        yu8kFennwA/u4z54ZiTwh27p8rQjT8gRJZDGaO63Mc6bR4JJjY0i4IPw93HbJd+TxfmHgp
        ovsG89fb+aYQollQBt7wYBFnmZMwpn63Yt0Qf/EmCCdnoh670CpqnyQxCn/3Pg==
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

