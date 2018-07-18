Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E01ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A362C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="BXwORPYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A362C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeGRS7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:59:52 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39496 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGRS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:59:51 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 02/17] dmaengine: dma-jz4780: Return error if not probed from DT
Date:   Wed, 18 Jul 2018 20:20:08 +0200
Message-Id: <20180718182023.8182-3-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938045; bh=Mj06wx96BqJqsNzQyX6qLzsRhLEMkGTkmupGf5oWocw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BXwORPYG4oLtE/W+VzWA7TeULYbybh2hgouYG8F6QyzPukJ6WRjDIHeXktWQ/GL2+/a9g0CAXjQA8rPEcHHXnzNHHU9TZNdyMj/NxkrPlRBtzcZh5e79YgVNev2VxUKJUt0KfbjnZ/KLMvmqc8fHtJNm9QbDTWpH2o8k0PgZtY8=
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
 drivers/dma/dma-jz4780.c | 5 +++++
 1 file changed, 5 insertions(+)

 v2: New patch

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

