Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3887C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E1C26ACA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E1C26ACA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965196AbeFZMzM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:55:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:65459 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965141AbeFZMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:55:08 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5QCsRd0005734;
        Tue, 26 Jun 2018 14:54:33 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jumuy8bvv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Jun 2018 14:54:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EBDB638;
        Tue, 26 Jun 2018 12:54:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE72B2A30;
        Tue, 26 Jun 2018 12:54:32 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 26 Jun
 2018 14:54:32 +0200
Received: from localhost (10.201.23.65) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 26 Jun 2018 14:54:32
 +0200
From:   Lionel Debieve <lionel.debieve@st.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 3/3] crypto: stm32/crc - Add power management support
Date:   Tue, 26 Jun 2018 14:52:46 +0200
Message-ID: <1530017566-14779-4-git-send-email-lionel.debieve@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530017566-14779-1-git-send-email-lionel.debieve@st.com>
References: <1530017566-14779-1-git-send-email-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding pm and pm_runtime support to STM32 CRC.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/crypto/stm32/stm32_crc32.c | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/crypto/stm32/stm32_crc32.c b/drivers/crypto/stm32/stm32_crc32.c
index 8f09b84..04ba5e1 100644
--- a/drivers/crypto/stm32/stm32_crc32.c
+++ b/drivers/crypto/stm32/stm32_crc32.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <crypto/internal/hash.h>
 
@@ -32,6 +33,8 @@
 #define POLY_CRC32              0xEDB88320
 #define POLY_CRC32C             0x82F63B78
 
+#define CRC_AUTOSUSPEND_DELAY	50
+
 struct stm32_crc {
 	struct list_head list;
 	struct device    *dev;
@@ -106,6 +109,8 @@ static int stm32_crc_init(struct shash_desc *desc)
 	}
 	spin_unlock_bh(&crc_list.lock);
 
+	pm_runtime_get_sync(ctx->crc->dev);
+
 	/* Reset, set key, poly and configure in bit reverse mode */
 	writel_relaxed(bitrev32(mctx->key), ctx->crc->regs + CRC_INIT);
 	writel_relaxed(bitrev32(mctx->poly), ctx->crc->regs + CRC_POL);
@@ -115,6 +120,9 @@ static int stm32_crc_init(struct shash_desc *desc)
 	ctx->partial = readl_relaxed(ctx->crc->regs + CRC_DR);
 	ctx->crc->nb_pending_bytes = 0;
 
+	pm_runtime_mark_last_busy(ctx->crc->dev);
+	pm_runtime_put_autosuspend(ctx->crc->dev);
+
 	return 0;
 }
 
@@ -126,6 +134,8 @@ static int stm32_crc_update(struct shash_desc *desc, const u8 *d8,
 	u32 *d32;
 	unsigned int i;
 
+	pm_runtime_get_sync(crc->dev);
+
 	if (unlikely(crc->nb_pending_bytes)) {
 		while (crc->nb_pending_bytes != sizeof(u32) && length) {
 			/* Fill in pending data */
@@ -149,6 +159,9 @@ static int stm32_crc_update(struct shash_desc *desc, const u8 *d8,
 	/* Store partial result */
 	ctx->partial = readl_relaxed(crc->regs + CRC_DR);
 
+	pm_runtime_mark_last_busy(crc->dev);
+	pm_runtime_put_autosuspend(crc->dev);
+
 	/* Check for pending data (non 32 bits) */
 	length &= 3;
 	if (likely(!length))
@@ -272,6 +285,13 @@ static int stm32_crc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_set_autosuspend_delay(dev, CRC_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	platform_set_drvdata(pdev, crc);
 
 	spin_lock(&crc_list.lock);
@@ -287,12 +307,18 @@ static int stm32_crc_probe(struct platform_device *pdev)
 
 	dev_info(dev, "Initialized\n");
 
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
 
 static int stm32_crc_remove(struct platform_device *pdev)
 {
 	struct stm32_crc *crc = platform_get_drvdata(pdev);
+	int ret = pm_runtime_get_sync(crc->dev);
+
+	if (ret < 0)
+		return ret;
 
 	spin_lock(&crc_list.lock);
 	list_del(&crc->list);
@@ -300,11 +326,46 @@ static int stm32_crc_remove(struct platform_device *pdev)
 
 	crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
 
+	pm_runtime_disable(crc->dev);
+	pm_runtime_put_noidle(crc->dev);
+
 	clk_disable_unprepare(crc->clk);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int stm32_crc_runtime_suspend(struct device *dev)
+{
+	struct stm32_crc *crc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(crc->clk);
+
+	return 0;
+}
+
+static int stm32_crc_runtime_resume(struct device *dev)
+{
+	struct stm32_crc *crc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(crc->clk);
+	if (ret) {
+		dev_err(crc->dev, "Failed to prepare_enable clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops stm32_crc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(stm32_crc_runtime_suspend,
+			   stm32_crc_runtime_resume, NULL)
+};
+
 static const struct of_device_id stm32_dt_ids[] = {
 	{ .compatible = "st,stm32f7-crc", },
 	{},
@@ -316,6 +377,7 @@ static struct platform_driver stm32_crc_driver = {
 	.remove = stm32_crc_remove,
 	.driver = {
 		.name           = DRIVER_NAME,
+		.pm		= &stm32_crc_pm_ops,
 		.of_match_table = stm32_dt_ids,
 	},
 };
-- 
2.7.4

