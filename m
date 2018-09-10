Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6522EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5895520870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5895520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeIJTOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:14:40 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:8199 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeIJTOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:14:40 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35b967d9aae2-5ed14; Mon, 10 Sep 2018 22:20:10 +0800 (CST)
X-RM-TRANSID: 2ee35b967d9aae2-5ed14
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.240])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95b967d98a76-e5c3b;
        Mon, 10 Sep 2018 22:20:09 +0800 (CST)
X-RM-TRANSID: 2ee95b967d98a76-e5c3b
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        William Tu <u9012063@gmail.com>
Subject: [PATCH 1/2] erspan: return PACKET_REJECT when the appropriate tunnel is not found
Date:   Mon, 10 Sep 2018 22:19:47 +0800
Message-Id: <1536589188-27550-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If erspan tunnel hasn't been established, we'd better send icmp port
unreachable message after receive erspan packets.

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv4/ip_gre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index ae714ae..85a714d 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -328,6 +328,8 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 		return PACKET_RCVD;
 	}
+	return PACKET_REJECT;
+
 drop:
 	kfree_skb(skb);
 	return PACKET_RCVD;
-- 
1.8.3.1



