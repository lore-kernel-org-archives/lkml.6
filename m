Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFC6C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F7820851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/aE1uXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F7820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeLEJiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbeLEJiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:02 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A157920850;
        Wed,  5 Dec 2018 09:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002681;
        bh=Nbnv89cfIfgAyUO3zUsVW2bwU3G1cMs5dR0gbHrPWjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/aE1uXmAJR+YleG4OW3kj41bxjtPWbpJtP8sM6jpkJT1CYQAqe81S0tRAL2Bzx0R
         7bWg/ubgjFQXT7kjH7yPjjVHbpxVf6yf0JJd7exmMSsyFmaLjejHe1z5Z7qyH+zGNg
         4aL0pTT+plAu0Cu+D0NF2zmj8UVaG+QfniKwao0g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 037/123] spi: omap2-mcspi: Add missing suspend and resume calls
Date:   Wed,  5 Dec 2018 04:34:29 -0500
Message-Id: <20181205093555.5386-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 91b9deefedf4c35a01027ce38bed7299605026a3 ]

I've been wondering still about omap2-mcspi related suspend and resume
flakeyness and looks like we're missing calls to spi_master_suspend()
and spi_master_resume(). Adding those and using pm_runtime_force_suspend()
and pm_runtime_force_resume() makes things work for suspend and resume
and allows us to stop using noirq suspend and resume.

And while at it, let's use SET_SYSTEM_SLEEP_PM_OPS to simplify things
further.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 37 +++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 508c61c669e7..e2be7da74343 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1455,13 +1455,26 @@ static int omap2_mcspi_remove(struct platform_device *pdev)
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:omap2_mcspi");
 
-#ifdef	CONFIG_SUSPEND
-static int omap2_mcspi_suspend_noirq(struct device *dev)
+static int __maybe_unused omap2_mcspi_suspend(struct device *dev)
 {
-	return pinctrl_pm_select_sleep_state(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
+	int error;
+
+	error = pinctrl_pm_select_sleep_state(dev);
+	if (error)
+		dev_warn(mcspi->dev, "%s: failed to set pins: %i\n",
+			 __func__, error);
+
+	error = spi_master_suspend(master);
+	if (error)
+		dev_warn(mcspi->dev, "%s: master suspend failed: %i\n",
+			 __func__, error);
+
+	return pm_runtime_force_suspend(dev);
 }
 
-static int omap2_mcspi_resume_noirq(struct device *dev)
+static int __maybe_unused omap2_mcspi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
@@ -1472,17 +1485,17 @@ static int omap2_mcspi_resume_noirq(struct device *dev)
 		dev_warn(mcspi->dev, "%s: failed to set pins: %i\n",
 			 __func__, error);
 
-	return 0;
-}
+	error = spi_master_resume(master);
+	if (error)
+		dev_warn(mcspi->dev, "%s: master resume failed: %i\n",
+			 __func__, error);
 
-#else
-#define omap2_mcspi_suspend_noirq	NULL
-#define omap2_mcspi_resume_noirq	NULL
-#endif
+	return pm_runtime_force_resume(dev);
+}
 
 static const struct dev_pm_ops omap2_mcspi_pm_ops = {
-	.suspend_noirq = omap2_mcspi_suspend_noirq,
-	.resume_noirq = omap2_mcspi_resume_noirq,
+	SET_SYSTEM_SLEEP_PM_OPS(omap2_mcspi_suspend,
+				omap2_mcspi_resume)
 	.runtime_resume	= omap_mcspi_runtime_resume,
 };
 
-- 
2.17.1

