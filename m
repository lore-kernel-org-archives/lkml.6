Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A20C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21B421479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789006;
	bh=vgfJmKGE8L7f4+kn8Edt+q6wR/oRI9De36nVEAu0K8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7uVBlZNXBCd6qHBEGREgpZMad+j80nWHbg2lAjlxq2WNuIawbSdJJiNXdz3ky0R+
	 WVExyl4qWx0YRznNZf9vibF6ACcjvYTOGQ4QepDReSf7z1etS0oaxmM2GXv4oa10Rt
	 YVSbiO2wO8TyiiLmlwzrc5e20e15yZB5ugPKYocY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21B421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbeLNMDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729773AbeLNMDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D382146F;
        Fri, 14 Dec 2018 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789001;
        bh=vgfJmKGE8L7f4+kn8Edt+q6wR/oRI9De36nVEAu0K8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p82Lm1TdwSvTvRZGbMFaf9abMYNIiLRDnHzv7yeo2gy76H4Ic+Q+vYpWl3aysUrb6
         LhrkTpfSuvmQC07hxHeJd9siCiMW6OLTlYanSWyYvhhh2KHmNocSpk8Ij0kwOVJZj0
         R1B1ak0y7/29Rfeho9dM0jCne1ia0UNeQasKE3Ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 056/142] spi: omap2-mcspi: Add missing suspend and resume calls
Date:   Fri, 14 Dec 2018 12:59:01 +0100
Message-Id: <20181214115749.307329891@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



