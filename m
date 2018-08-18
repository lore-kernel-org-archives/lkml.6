Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B103C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAC9217BB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAC9217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeHRRwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:52:12 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10417 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:52:12 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5b7830b1c1a-4c506; Sat, 18 Aug 2018 22:44:05 +0800 (CST)
X-RM-TRANSID: 2eec5b7830b1c1a-4c506
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.240])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45b7830b4741-b6e71;
        Sat, 18 Aug 2018 22:44:05 +0800 (CST)
X-RM-TRANSID: 2ee45b7830b4741-b6e71
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH] ip6_vti: simplify stats handling in vti6_xmit
Date:   Sat, 18 Aug 2018 22:43:48 +0800
Message-Id: <1534603428-30425-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as ip_vti, use iptunnel_xmit_stats to updates stats in tunnel xmit
code path.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv6/ip6_vti.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index c72ae3a..65d4a80 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -503,17 +503,9 @@ static bool vti6_state_check(const struct xfrm_state *x,
 	skb->dev = skb_dst(skb)->dev;
 
 	err = dst_output(t->net, skb->sk, skb);
-	if (net_xmit_eval(err) == 0) {
-		struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
-
-		u64_stats_update_begin(&tstats->syncp);
-		tstats->tx_bytes += pkt_len;
-		tstats->tx_packets++;
-		u64_stats_update_end(&tstats->syncp);
-	} else {
-		stats->tx_errors++;
-		stats->tx_aborted_errors++;
-	}
+	if (net_xmit_eval(err) == 0)
+		err = pkt_len;
+	iptunnel_xmit_stats(dev, err);
 
 	return 0;
 tx_err_link_failure:
-- 
1.8.3.1



