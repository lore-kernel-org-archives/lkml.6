Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25497C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61CE26876
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61CE26876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeF0Dwp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:52:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932084AbeF0Dwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:52:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2D49F9605C8DF;
        Wed, 27 Jun 2018 11:52:28 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Wed, 27 Jun 2018
 11:52:21 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 1/1] esp6: fix memleak on error path in esp6_input
Date:   Wed, 27 Jun 2018 11:49:28 +0800
Message-ID: <1530071368-15156-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ought to be an omission in e6194923237 ("esp: Fix memleaks on error
paths."). The memleak on error path in esp6_input is similar to esp_input
of esp4.

Fixes: e6194923237 ("esp: Fix memleaks on error paths.")
Fixes: 3f29770723f ("ipsec: check return value of skb_to_sgvec always")

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 net/ipv6/esp6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 97513f3..88a7579 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -669,8 +669,10 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)

 	sg_init_table(sg, nfrags);
 	ret = skb_to_sgvec(skb, sg, 0, skb->len);
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0)) {
+		kfree(tmp);
 		goto out;
+	}

 	skb->ip_summed = CHECKSUM_NONE;

--
1.8.3


