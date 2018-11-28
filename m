Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0821C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A213C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m4w0rPHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A213C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeK1TLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:11:05 -0500
Received: from m12-12.163.com ([220.181.12.12]:36587 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbeK1TLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=fGF0EvfL4BG/ZpF0fV
        QPS/2dUAjOs42csNN5iZYV9vo=; b=m4w0rPHgWuYYba/eOuK8dw2gR8ko4A6Qt3
        fHbthUCWNflNHXLcAXsQoW84ibVaZ3u0vjlt931eYFN7FH6T81kux4zs5MuwHaDQ
        69/MbgZnaFHwrSN6yJ7PJA4/yhVzDUi2qVtjo5KqB2IpAEJE2qP8nbQQRonsQhFM
        4I1Q/8WO4=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp8 (Coremail) with SMTP id DMCowACnUkFITf5b_eBhCQ--.28506S3;
        Wed, 28 Nov 2018 16:09:47 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] amd-xgbe: set skb to NULL after freeing it
Date:   Wed, 28 Nov 2018 16:09:45 +0800
Message-Id: <1543392585-17962-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowACnUkFITf5b_eBhCQ--.28506S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr47KFy7ur1rCFy8Kr1fXrb_yoWDZFXE9r
        yrXa1Uta1DCF1Y9r4YkFsxAryqkw4DurWkXa1Sy3yYy3srJFnxX39Yvrn7Wrn3Ca10yFZ8
        GF13KayFy34jgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8Q_-JUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQsNclaD0V6JOAAAsO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer skb is freed via dev_kfree_skb in a loop. skb may be used
again in the next iteration, resulting in a use-after-free bug. To fix
this, the patch set skb to NULL after dev_kfree_skb(skb).

Signed-off-by: Pan Bian <bianpan2016@163.com>
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


