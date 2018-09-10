Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BACC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BB120833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BB120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeIJTOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:14:39 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:43621 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeIJTOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:14:39 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95b967d9e735-5f260; Mon, 10 Sep 2018 22:20:15 +0800 (CST)
X-RM-TRANSID: 2ee95b967d9e735-5f260
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.240])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55b967d9ef60-e6d59;
        Mon, 10 Sep 2018 22:20:15 +0800 (CST)
X-RM-TRANSID: 2ee55b967d9ef60-e6d59
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        William Tu <u9012063@gmail.com>
Subject: [PATCH 2/2] erspan: fix error handling for erspan tunnel
Date:   Mon, 10 Sep 2018 22:19:48 +0800
Message-Id: <1536589188-27550-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536589188-27550-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1536589188-27550-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When processing icmp unreachable message for erspan tunnel, tunnel id
should be erspan_net_id instead of ipgre_net_id.

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv4/ip_gre.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 85a714d..8cce0e9 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -178,6 +178,9 @@ static void ipgre_err(struct sk_buff *skb, u32 info,
 
 	if (tpi->proto == htons(ETH_P_TEB))
 		itn = net_generic(net, gre_tap_net_id);
+	else if (tpi->proto == htons(ETH_P_ERSPAN) ||
+		 tpi->proto == htons(ETH_P_ERSPAN2))
+		itn = net_generic(net, erspan_net_id);
 	else
 		itn = net_generic(net, ipgre_net_id);
 
-- 
1.8.3.1



