Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E49FC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D822151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QvlSzwqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D822151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeHUSmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:42:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38588 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeHUSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:42:36 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.co.uk>, od@zcrc.me,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] mmc: jz4740: Add support for the JZ4725B
Date:   Tue, 21 Aug 2018 17:21:51 +0200
Message-Id: <20180821152151.32113-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534864918; bh=mOj7i8hpdhvziJ4Nch4lFNp8St97A2OZIyTvcwY5PCI=; h=From:To:Cc:Subject:Date:Message-Id; b=QvlSzwqBCG3vDifuUaVsNEIL7ZDVGQ1JJliHZPj+q2EIUHgrsPwMIlfk5CaCedwcdaRCL3sCJtxztAUJDBvofSZ4nE3t7EVs0nkB3fuoHbI1dj6YEPfzhJ4rVpQ4Zq13RUuZlgm+rXteHCuHM1Lh+M/H4tNXeN5yM08gvzymRHA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JZ4725B is the first JZ SoC version that introduced a 32-bit IMASK
register, not the JZ4750.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/mmc/jz4740.txt | 1 +
 drivers/mmc/host/jz4740_mmc.c                    | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/jz4740.txt b/Documentation/devicetree/bindings/mmc/jz4740.txt
index 7cd8c432d7c8..8a6f87f13114 100644
--- a/Documentation/devicetree/bindings/mmc/jz4740.txt
+++ b/Documentation/devicetree/bindings/mmc/jz4740.txt
@@ -7,6 +7,7 @@ described in mmc.txt.
 Required properties:
 - compatible: Should be one of the following:
   - "ingenic,jz4740-mmc" for the JZ4740
+  - "ingenic,jz4725b-mmc" for the JZ4725B
   - "ingenic,jz4780-mmc" for the JZ4780
 - reg: Should contain the MMC controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the MMC controller.
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 993386c9ea50..0c1efd5100b7 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -115,7 +115,7 @@
 
 enum jz4740_mmc_version {
 	JZ_MMC_JZ4740,
-	JZ_MMC_JZ4750,
+	JZ_MMC_JZ4725B,
 	JZ_MMC_JZ4780,
 };
 
@@ -176,7 +176,7 @@ struct jz4740_mmc_host {
 static void jz4740_mmc_write_irq_mask(struct jz4740_mmc_host *host,
 				      uint32_t val)
 {
-	if (host->version >= JZ_MMC_JZ4750)
+	if (host->version >= JZ_MMC_JZ4725B)
 		return writel(val, host->base + JZ_REG_MMC_IMASK);
 	else
 		return writew(val, host->base + JZ_REG_MMC_IMASK);
@@ -1012,6 +1012,7 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 
 static const struct of_device_id jz4740_mmc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
+	{ .compatible = "ingenic,jz4725b-mmc", .data = (void *)JZ_MMC_JZ4725B },
 	{ .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
 	{},
 };
-- 
2.11.0

