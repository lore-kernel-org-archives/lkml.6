Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C0EC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 04:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472DF20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 04:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472DF20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeINJjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 05:39:52 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:22700 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeINJjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 05:39:52 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75b9b389a7f5-be8e2; Fri, 14 Sep 2018 12:27:07 +0800 (CST)
X-RM-TRANSID: 2ee75b9b389a7f5-be8e2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.240])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25b9b38995c9-e03d9;
        Fri, 14 Sep 2018 12:27:07 +0800 (CST)
X-RM-TRANSID: 2ee25b9b38995c9-e03d9
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc:     Jiri Benc <jbenc@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v3,net-next 2/2] ip6_gre: simplify gre header parsing in ip6gre_err
Date:   Fri, 14 Sep 2018 12:26:48 +0800
Message-Id: <1536899208-2958-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536899208-2958-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1536899208-2958-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as ip_gre, use gre_parse_header to parse gre header in gre error
handler code.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv6/ip6_gre.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index e493b04..515adbd 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -427,35 +427,17 @@ static void ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		       u8 type, u8 code, int offset, __be32 info)
 {
 	struct net *net = dev_net(skb->dev);
-	const struct gre_base_hdr *greh;
 	const struct ipv6hdr *ipv6h;
-	int grehlen = sizeof(*greh);
+	struct tnl_ptk_info tpi;
 	struct ip6_tnl *t;
-	int key_off = 0;
-	__be16 flags;
-	__be32 key;
 
-	if (!pskb_may_pull(skb, offset + grehlen))
-		return;
-	greh = (const struct gre_base_hdr *)(skb->data + offset);
-	flags = greh->flags;
-	if (flags & (GRE_VERSION | GRE_ROUTING))
+	if (gre_parse_header(skb, &tpi, NULL, htons(ETH_P_IPV6),
+			     offset) < 0)
 		return;
-	if (flags & GRE_CSUM)
-		grehlen += 4;
-	if (flags & GRE_KEY) {
-		key_off = grehlen + offset;
-		grehlen += 4;
-	}
 
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



