Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E02C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FDA2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FDA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIJNSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:18:18 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:58091 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbeIJNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:18:17 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85b962a71b4c-55b0a; Mon, 10 Sep 2018 16:25:22 +0800 (CST)
X-RM-TRANSID: 2ee85b962a71b4c-55b0a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.240])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35b962a71a7f-d225e;
        Mon, 10 Sep 2018 16:25:22 +0800 (CST)
X-RM-TRANSID: 2ee35b962a71a7f-d225e
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH] ip6_gre: simplify gre header parsing in ip6gre_err
Date:   Mon, 10 Sep 2018 16:25:09 +0800
Message-Id: <1536567909-25089-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as ip_gre, use gre_parse_header to parse gre header in gre error
handler code.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv6/ip6_gre.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 18a3794..505d891 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -427,35 +427,20 @@ static void ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		       u8 type, u8 code, int offset, __be32 info)
 {
 	struct net *net = dev_net(skb->dev);
-	const struct gre_base_hdr *greh;
 	const struct ipv6hdr *ipv6h;
-	int grehlen = sizeof(*greh);
+	struct tnl_ptk_info tpi;
+	bool csum_err = false;
 	struct ip6_tnl *t;
-	int key_off = 0;
-	__be16 flags;
-	__be32 key;
 
-	if (!pskb_may_pull(skb, offset + grehlen))
-		return;
-	greh = (const struct gre_base_hdr *)(skb->data + offset);
-	flags = greh->flags;
-	if (flags & (GRE_VERSION | GRE_ROUTING))
-		return;
-	if (flags & GRE_CSUM)
-		grehlen += 4;
-	if (flags & GRE_KEY) {
-		key_off = grehlen + offset;
-		grehlen += 4;
+	if (gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IPV6),
+			     offset) < 0) {
+		if (!csum_err)		/* ignore csum errors. */
+			return;
 	}
 
-	if (!pskb_may_pull(skb, offset + grehlen))
-		return;
 	ipv6h = (const struct ipv6hdr *)skb->data;
-	greh = (const struct gre_base_hdr *)(skb->data + offset);
-	key = key_off ? *(__be32 *)(skb->data + key_off) : 0;
-
 	t = ip6gre_tunnel_lookup(skb->dev, &ipv6h->daddr, &ipv6h->saddr,
-				 key, greh->protocol);
+				 tpi.key, tpi.proto);
 	if (!t)
 		return;
 
-- 
1.8.3.1



