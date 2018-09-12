Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E170FC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BB920880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BB920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeILO0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:26:32 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:59987 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeILO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:26:32 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85b98dae540c-904bf; Wed, 12 Sep 2018 17:22:45 +0800 (CST)
X-RM-TRANSID: 2ee85b98dae540c-904bf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.240])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15b98dae4c31-63e5c;
        Wed, 12 Sep 2018 17:22:45 +0800 (CST)
X-RM-TRANSID: 2ee15b98dae4c31-63e5c
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc:     Jiri Benc <jbenc@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v2,net-next 1/2] ip_gre: fix parsing gre header in ipgre_err
Date:   Wed, 12 Sep 2018 17:21:21 +0800
Message-Id: <1536744082-3568-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gre_parse_header stops parsing when csum_err is encountered, which means
tpi->key is undefined and ip_tunnel_lookup will return NULL improperly.

This patch introduce a NULL pointer as csum_err parameter. Even when
csum_err is encountered, it won't return error and continue parsing gre
header as expected.

Fixes: 9f57c67c379d ("gre: Remove support for sharing GRE protocol hook.")
Reported-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv4/gre_demux.c | 2 +-
 net/ipv4/ip_gre.c    | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/gre_demux.c b/net/ipv4/gre_demux.c
index b798862..679a527 100644
--- a/net/ipv4/gre_demux.c
+++ b/net/ipv4/gre_demux.c
@@ -86,7 +86,7 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 	options = (__be32 *)(greh + 1);
 	if (greh->flags & GRE_CSUM) {
-		if (skb_checksum_simple_validate(skb)) {
+		if (csum_err && skb_checksum_simple_validate(skb)) {
 			*csum_err = true;
 			return -EINVAL;
 		}
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 8cce0e9..c3385a8 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -232,13 +232,10 @@ static void gre_err(struct sk_buff *skb, u32 info)
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
 	struct tnl_ptk_info tpi;
-	bool csum_err = false;
 
-	if (gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IP),
-			     iph->ihl * 4) < 0) {
-		if (!csum_err)		/* ignore csum errors. */
-			return;
-	}
+	if (gre_parse_header(skb, &tpi, NULL, htons(ETH_P_IP),
+			     iph->ihl * 4) < 0)
+		return;
 
 	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED) {
 		ipv4_update_pmtu(skb, dev_net(skb->dev), info,
-- 
1.8.3.1



