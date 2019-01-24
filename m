Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEA7C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09C721872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A4CvDhkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfAXRhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:37:08 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8374 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfAXRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:37:07 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c49f7af0000>; Thu, 24 Jan 2019 09:36:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 24 Jan 2019 09:37:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 09:37:05 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 17:37:05 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 17:37:05 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c49f7be0003>; Thu, 24 Jan 2019 09:37:05 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <rlokhande@nvidia.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] ALSA: hda/tegra: enable clock during probe
Date:   Thu, 24 Jan 2019 23:06:43 +0530
Message-ID: <1548351403-1875-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548351407; bh=eCn3sPZKweKcCsTMnaIc0CN9y7SXVR86k2I72w26XAM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=A4CvDhkYwAN/qmf84nTe8GQmLDn6lCl7tjm8g8Tzq8f6BzYg7yxbBMDx+SjcOvQas
         B7fnZ+p7Rn0QRGfWQQML1k3aZAjSetSCNS1X6AcdN8/Q7idrCOGjYrexFGqqCNhOon
         a1N9wxu2djaYFIqymXraJshpzPokle5NT4HTpyjhx6LjDsALjLoKxsDleNl72sbQHE
         SkUhL9yGu57hrozCWN0IH5855X+DmT26zLUwCuskduEIJOFdOMPWmjHzt0cdTed5I/
         oLOdDj9xxGh3DLBegqZvUs5YTweFrPPfN8ufUEP9oru7kDInoHZY/0Px+6fLXJSFqd
         qg6NVyYchBw0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
will not be ON. This could cause issue during probe, where hda init
setup is done. This patch checks whether runtime PM is enabled or not.
If disabled, clocks are enabled in probe() and disabled in remove()

This patch does following minor changes as cleanup,
  * return code check for pm_runtime_get_sync() to take care of failure
    and exit gracefully.
  * In remove path runtime PM is disabled before calling snd_card_free().
  * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
  * runtime PM callbacks moved out of CONFIG_PM check

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index c8d18dc..155c2f5 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -219,7 +219,6 @@ static int hda_tegra_enable_clocks(struct hda_tegra *data)
 	return rc;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static void hda_tegra_disable_clocks(struct hda_tegra *data)
 {
 	clk_disable_unprepare(data->hda2hdmi_clk);
@@ -227,6 +226,7 @@ static void hda_tegra_disable_clocks(struct hda_tegra *data)
 	clk_disable_unprepare(data->hda_clk);
 }
 
+#ifdef CONFIG_PM_SLEEP
 /*
  * power management
  */
@@ -257,7 +257,6 @@ static int hda_tegra_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int hda_tegra_runtime_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
@@ -283,7 +282,7 @@ static int hda_tegra_runtime_resume(struct device *dev)
 	int rc;
 
 	rc = hda_tegra_enable_clocks(hda);
-	if (rc != 0)
+	if (rc)
 		return rc;
 	if (chip && chip->running) {
 		hda_tegra_init(hda);
@@ -292,7 +291,6 @@ static int hda_tegra_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops hda_tegra_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(hda_tegra_suspend, hda_tegra_resume)
@@ -555,6 +553,13 @@ static int hda_tegra_probe(struct platform_device *pdev)
 	if (!azx_has_pm_runtime(chip))
 		pm_runtime_forbid(hda->dev);
 
+	/* explicit resume if runtime PM is disabled */
+	if (!pm_runtime_enabled(hda->dev)) {
+		err = hda_tegra_runtime_resume(hda->dev);
+		if (err)
+			goto out_free;
+	}
+
 	schedule_work(&hda->probe_work);
 
 	return 0;
@@ -571,7 +576,14 @@ static void hda_tegra_probe_work(struct work_struct *work)
 	struct platform_device *pdev = to_platform_device(hda->dev);
 	int err;
 
-	pm_runtime_get_sync(hda->dev);
+	err = pm_runtime_get_sync(hda->dev);
+	if (err < 0) {
+		dev_err(hda->dev,
+			"failed in pm_runtime_get_syc with err = %d\n",
+			err);
+		return;
+	}
+
 	err = hda_tegra_first_init(chip, pdev);
 	if (err < 0)
 		goto out_free;
@@ -599,12 +611,13 @@ static void hda_tegra_probe_work(struct work_struct *work)
 
 static int hda_tegra_remove(struct platform_device *pdev)
 {
-	int ret;
-
-	ret = snd_card_free(dev_get_drvdata(&pdev->dev));
 	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev)) {
+		hda_tegra_runtime_suspend(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+	}
 
-	return ret;
+	return snd_card_free(dev_get_drvdata(&pdev->dev));
 }
 
 static void hda_tegra_shutdown(struct platform_device *pdev)
-- 
2.7.4

