Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF33C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AA92086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YAYM3mHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AA92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeK1UHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:07:23 -0500
Received: from m12-16.163.com ([220.181.12.16]:52473 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbeK1UHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=NB6s/+V5cIqzeFNbhZ
        h4CQ5aEFBxxXAHiaDRAdx3YKI=; b=YAYM3mHKD4PLabk3UJHKIfxRuudTfJiL1U
        zbjZwUlhYp3Jv58d15xxHDEW+BXS5bNcKqSTfvHPBK1WDc172woL4liTJ5NZOEBw
        mtzWKEeBbbBUo3Egekz9QbEZn8L6d0zb+eAtOteWjMkyWsq65vuAmNaE/G1h6yYB
        EmOyUYQdU=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp12 (Coremail) with SMTP id EMCowAD3yaiGWv5beShcAQ--.20921S3;
        Wed, 28 Nov 2018 17:06:21 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH V2] amd-xgbe: set skb to NULL after freeing it
Date:   Wed, 28 Nov 2018 17:06:15 +0800
Message-Id: <1543395975-25339-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowAD3yaiGWv5beShcAQ--.20921S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1DKw13CF1xGrWDXrW7twb_yoW8JF47pa
        yUWryxJw1ktr42qa18Ja1IvF15ta1ktFW5Kr95u3WrZ3Z0yry2vrykK34jkFWjkFWkGa1a
        qr47urs3W3ZxJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j17K3UUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQ0NclaD0V8ykwAAsZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer skb is freed via dev_kfree_skb in a loop. After freeing skb, 
the value of packet_count is updated via packet_count++. If packet_count
happens to equal the upper bound budget, the loop will be broken and skb 
may be assigned to rdata->state.skb. Resulting that rdata->state.skb may
point to a freed memory chunk. To fix this, the patch sets skb to NULL 
after dev_kfree_skb(skb).

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
V2: correct the commit log
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 0cc911f..ac6b82d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2754,6 +2754,7 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
 				netif_err(pdata, rx_err, netdev,
 					  "error in received packet\n");
 			dev_kfree_skb(skb);
+			skb = NULL;
 			goto next_packet;
 		}
 
@@ -2806,6 +2807,7 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
 			netif_err(pdata, rx_err, netdev,
 				  "packet length exceeds configured MTU\n");
 			dev_kfree_skb(skb);
+			skb = NULL;
 			goto next_packet;
 		}
 
-- 
2.7.4


