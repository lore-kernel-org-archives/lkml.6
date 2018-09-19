Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDC92150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDC92150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbeISQQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:16:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731319AbeISQQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:16:08 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C9CDCE5805A99;
        Wed, 19 Sep 2018 18:38:47 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 18:38:44 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] net: core: Use FIELD_SIZEOF directly instead of reimplementing its function
Date:   Wed, 19 Sep 2018 18:26:19 +0800
Message-ID: <1537352781-48532-4-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1537352781-48532-1-git-send-email-zhongjiang@huawei.com>
References: <1537352781-48532-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIELD_SIZEOF is defined as a macro to calculate the specified value. Therefore,
We prefer to use the macro rather than calculating its value.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/core/flow_dissector.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 5c5dd74..aeac884 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -423,8 +423,8 @@ __be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
 	offset += sizeof(struct gre_base_hdr);
 
 	if (hdr->flags & GRE_CSUM)
-		offset += sizeof(((struct gre_full_hdr *) 0)->csum) +
-			  sizeof(((struct gre_full_hdr *) 0)->reserved1);
+		offset += FIELD_SIZEOF(struct gre_full_hdr, csum) +
+			  FIELD_SIZEOF(struct gre_full_hdr, reserved1);
 
 	if (hdr->flags & GRE_KEY) {
 		const __be32 *keyid;
@@ -446,11 +446,11 @@ __be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
 			else
 				key_keyid->keyid = *keyid & GRE_PPTP_KEY_MASK;
 		}
-		offset += sizeof(((struct gre_full_hdr *) 0)->key);
+		offset += FIELD_SIZEOF(struct gre_full_hdr, key);
 	}
 
 	if (hdr->flags & GRE_SEQ)
-		offset += sizeof(((struct pptp_gre_header *) 0)->seq);
+		offset += FIELD_SIZEOF(struct pptp_gre_header, seq);
 
 	if (gre_ver == 0) {
 		if (*p_proto == htons(ETH_P_TEB)) {
@@ -477,7 +477,7 @@ __be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
 		u8 *ppp_hdr;
 
 		if (hdr->flags & GRE_ACK)
-			offset += sizeof(((struct pptp_gre_header *) 0)->ack);
+			offset += FIELD_SIZEOF(struct pptp_gre_header, ack);
 
 		ppp_hdr = __skb_header_pointer(skb, *p_nhoff + offset,
 					       sizeof(_ppp_hdr),
-- 
1.7.12.4

