Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F915C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81E32070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oaKOXsSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbfACOEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:04:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48130 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731776AbfACOEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:04:06 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x03E3wnr093762;
        Thu, 3 Jan 2019 08:03:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546524238;
        bh=BE5xeiIKa1f2ONJa6Ur6QmrZdSKST/4IjJW8utp7PtM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oaKOXsSrBy26Deh9o2Y1AqKvadRQ44Kp9AcpJH/o0rKfxkCvFkuAlPv7NuDjAjTfc
         VlYrTVwmgLBBx92IRnF6nZ2ptmjt5uMEolkLXkpOlP6m4pLCqFYXERGatCyl5brGLg
         VAY+HGxnEVhoJhQ4sLh/fCh5GhqdW8xJqJPVvEUw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x03E3wvg018780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 08:03:58 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 3
 Jan 2019 08:03:58 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 3 Jan 2019 08:03:58 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x03E3rlN021111;
        Thu, 3 Jan 2019 08:03:56 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: ti: davinci-mcasp: Move context save/restore to runtime_pm callbacks
Date:   Thu, 3 Jan 2019 16:05:50 +0200
Message-ID: <20190103140552.29809-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103140552.29809-1-peter.ujfalusi@ti.com>
References: <20190103140552.29809-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

McASP can loose it's context when runtime_pm is disabled.
Save and restore the context when suspending and resuming the device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 136 +++++++++++++++++------------------
 1 file changed, 64 insertions(+), 72 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index ee9ab58d4d0c..a6a470a76900 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -108,7 +108,7 @@ struct davinci_mcasp {
 	/* Used for comstraint setting on the second stream */
 	u32	channels;
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 	struct davinci_mcasp_context context;
 #endif
 
@@ -1486,74 +1486,6 @@ static int davinci_mcasp_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
-{
-	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
-	struct davinci_mcasp_context *context = &mcasp->context;
-	u32 reg;
-	int i;
-
-	context->pm_state = pm_runtime_active(mcasp->dev);
-	if (!context->pm_state)
-		pm_runtime_get_sync(mcasp->dev);
-
-	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
-		context->config_regs[i] = mcasp_get_reg(mcasp, context_regs[i]);
-
-	if (mcasp->txnumevt) {
-		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-		context->afifo_regs[0] = mcasp_get_reg(mcasp, reg);
-	}
-	if (mcasp->rxnumevt) {
-		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
-		context->afifo_regs[1] = mcasp_get_reg(mcasp, reg);
-	}
-
-	for (i = 0; i < mcasp->num_serializer; i++)
-		context->xrsr_regs[i] = mcasp_get_reg(mcasp,
-						DAVINCI_MCASP_XRSRCTL_REG(i));
-
-	pm_runtime_put_sync(mcasp->dev);
-
-	return 0;
-}
-
-static int davinci_mcasp_resume(struct snd_soc_dai *dai)
-{
-	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
-	struct davinci_mcasp_context *context = &mcasp->context;
-	u32 reg;
-	int i;
-
-	pm_runtime_get_sync(mcasp->dev);
-
-	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
-		mcasp_set_reg(mcasp, context_regs[i], context->config_regs[i]);
-
-	if (mcasp->txnumevt) {
-		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-		mcasp_set_reg(mcasp, reg, context->afifo_regs[0]);
-	}
-	if (mcasp->rxnumevt) {
-		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
-		mcasp_set_reg(mcasp, reg, context->afifo_regs[1]);
-	}
-
-	for (i = 0; i < mcasp->num_serializer; i++)
-		mcasp_set_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
-			      context->xrsr_regs[i]);
-
-	if (!context->pm_state)
-		pm_runtime_put_sync(mcasp->dev);
-
-	return 0;
-}
-#else
-#define davinci_mcasp_suspend NULL
-#define davinci_mcasp_resume NULL
-#endif
-
 #define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_192000
 
 #define DAVINCI_MCASP_PCM_FMTS (SNDRV_PCM_FMTBIT_S8 | \
@@ -1571,8 +1503,6 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
 		.name		= "davinci-mcasp.0",
 		.probe		= davinci_mcasp_dai_probe,
-		.suspend	= davinci_mcasp_suspend,
-		.resume		= davinci_mcasp_resume,
 		.playback	= {
 			.channels_min	= 1,
 			.channels_max	= 32 * 16,
@@ -1976,7 +1906,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	mcasp->num_serializer = pdata->num_serializer;
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 	mcasp->context.xrsr_regs = devm_kcalloc(&pdev->dev,
 					mcasp->num_serializer, sizeof(u32),
 					GFP_KERNEL);
@@ -2180,11 +2110,73 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int davinci_mcasp_runtime_suspend(struct device *dev)
+{
+	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
+	struct davinci_mcasp_context *context = &mcasp->context;
+	u32 reg;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
+		context->config_regs[i] = mcasp_get_reg(mcasp, context_regs[i]);
+
+	if (mcasp->txnumevt) {
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+		context->afifo_regs[0] = mcasp_get_reg(mcasp, reg);
+	}
+	if (mcasp->rxnumevt) {
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+		context->afifo_regs[1] = mcasp_get_reg(mcasp, reg);
+	}
+
+	for (i = 0; i < mcasp->num_serializer; i++)
+		context->xrsr_regs[i] = mcasp_get_reg(mcasp,
+						DAVINCI_MCASP_XRSRCTL_REG(i));
+
+	return 0;
+}
+
+static int davinci_mcasp_runtime_resume(struct device *dev)
+{
+	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
+	struct davinci_mcasp_context *context = &mcasp->context;
+	u32 reg;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
+		mcasp_set_reg(mcasp, context_regs[i], context->config_regs[i]);
+
+	if (mcasp->txnumevt) {
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+		mcasp_set_reg(mcasp, reg, context->afifo_regs[0]);
+	}
+	if (mcasp->rxnumevt) {
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+		mcasp_set_reg(mcasp, reg, context->afifo_regs[1]);
+	}
+
+	for (i = 0; i < mcasp->num_serializer; i++)
+		mcasp_set_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+			      context->xrsr_regs[i]);
+
+	return 0;
+}
+
+#endif
+
+static const struct dev_pm_ops davinci_mcasp_pm_ops = {
+	SET_RUNTIME_PM_OPS(davinci_mcasp_runtime_suspend,
+			   davinci_mcasp_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver davinci_mcasp_driver = {
 	.probe		= davinci_mcasp_probe,
 	.remove		= davinci_mcasp_remove,
 	.driver		= {
 		.name	= "davinci-mcasp",
+		.pm     = &davinci_mcasp_pm_ops,
 		.of_match_table = mcasp_dt_ids,
 	},
 };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

