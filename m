Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1279F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lth4dyGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1279F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeK1SbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:31:16 -0500
Received: from m12-11.163.com ([220.181.12.11]:37673 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeK1SbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=0evaRUq/nKOncJk2cM
        DbzNc1vvxAMQ1qEDMmFiVl9Q4=; b=lth4dyGpSfI1KixRe2YgN3OAHBAQzZwr3u
        aHOpgilKXPTYcHP5NCMNc1916d4s0Z66jy2ugP2t62CR6ohRn/vZyuxmnpj+Od1O
        D22Ug+6tVftTUrwNIOfoth9XdLB3Lqvn9QOJq0jgXb4Vs7HRHjcakyToKYyqpsFy
        EJ0ERyfd8=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp7 (Coremail) with SMTP id C8CowAA3Do8PRP5bllpLCQ--.43558S3;
        Wed, 28 Nov 2018 15:30:29 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] net: hisilicon: remove unexpected free_netdev
Date:   Wed, 28 Nov 2018 15:30:24 +0800
Message-Id: <1543390224-923-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowAA3Do8PRP5bllpLCQ--.43558S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrur18Ar45KryfWFWkZr45GFg_yoW3twb_Kr
        109Fs7Crs5tFyYkw45ArWDZ3y09F1qgw1rZF43K39xJa47AryUXw1kur4kAr1DWw43Zasx
        GrsrWF4Sy3y2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0F4iUUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiNhUNclWBcXEprAAAsN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The net device ndev is freed via free_netdev when failing to register
the device. The control flow then jumps to the error handling code
block. ndev is used and freed again. Resulting in a use-after-free bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index be268dc..f9a4e76 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -915,10 +915,8 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	}
 
 	ret = register_netdev(ndev);
-	if (ret) {
-		free_netdev(ndev);
+	if (ret)
 		goto alloc_fail;
-	}
 
 	return 0;
 
-- 
2.7.4


