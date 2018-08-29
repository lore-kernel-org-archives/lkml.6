Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40A4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0C420659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IYv2rOB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0C420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeH3Bb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:31:57 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52464 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeH3Bb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:31:56 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 02/18] dmaengine: dma-jz4780: Return error if not probed from DT
Date:   Wed, 29 Aug 2018 23:32:44 +0200
Message-Id: <20180829213300.22829-3-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578387; bh=PNd48fB1tNSfs9eaRrl14SKjrUVfpS2KU5/99En1wT8=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IYv2rOB/lmeHQQLYep5MhYD2m7GBU+3RVtoSNIQH8rabOmNyuce89Z4SC5XuKprGoY7/8I2eybhqtP8ReaT18C4Ykc56mx1AdyuyNyC4kzY9dE8+zZoIpb3Z9NS8uTKjVMUVTBO7fNbIxP6lTqIrEZdYBEkniC/FECYjPwdkysY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver calls clk_get() with the clock name set to NULL, which means
that the driver could only work when probed from devicetree. From now
on, we explicitly require the driver to be probed from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---

Notes:
     v2: New patch
    
     v3: No change
    
     v4: No change
    
     v5: No change

 drivers/dma/dma-jz4780.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 85820a2d69d4..987899610b46 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -761,6 +761,11 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, ret;
 
+	if (!dev->of_node) {
+		dev_err(dev, "This driver must be probed from devicetree\n");
+		return -EINVAL;
+	}
+
 	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
 	if (!jzdma)
 		return -ENOMEM;
-- 
2.11.0

