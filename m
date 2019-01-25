Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB911C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAA02184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MvEvVyJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAYLHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:07:16 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18481 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfAYLHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:07:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4aedc80000>; Fri, 25 Jan 2019 03:06:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 03:07:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 03:07:14 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 11:07:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 25 Jan 2019 11:07:05 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4aedd7000b>; Fri, 25 Jan 2019 03:07:05 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <rlokhande@nvidia.com>, <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date:   Fri, 25 Jan 2019 16:36:58 +0530
Message-ID: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548414409; bh=MDAG5TTQSQoxoNkqZTSpJc/migEvG4qyHq8zSSR/CcM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=MvEvVyJMEfTjBN5ozKGcy18ybSl6MPF4grQzv0dR736nDBlkC+1WDJSsNbVayROuP
         U9E5bCRf3pAj/Xii2/GnHZfc2MEk2vh7bf2TZWgeK5x+NYYHRfnpp/Bh6i4Rb+vJuG
         BhitJDwXXhWcbLtZdY9Gq52g20tEpCEOCNTURRKrEd+fIjGX4UxeGUCEu9dtJ/EiBG
         y5/DOWM1jt2EYNG6GWB9feDvT/TrhYTuLtCgqGlSCqGARciDldPdX/9iZIeDgvRvf9
         Xew+cK6qD3QrmUcvz9CdzI6qJL4zX8sEKe9yYoDAUctCd0hcMIXCZjSJ+aj+2QlCIX
         iSnCXnDogJtkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
will not be ON. This could cause issue during probe, where hda init
setup is done. This patch enables clocks unconditionally during probe.

Along with above, follwoing changes are done.
  * enable runtime PM before exiting from probe work. This helps to avoid
    usage of pm_runtime_get_sync/pm_runtime_put() in probe work.
  * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
  * runtime PM callbacks moved out of CONFIG_PM check

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index c8d18dc..ba6175f 100644
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
@@ -551,9 +549,9 @@ static int hda_tegra_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, card);
 
-	pm_runtime_enable(hda->dev);
-	if (!azx_has_pm_runtime(chip))
-		pm_runtime_forbid(hda->dev);
+	err = hda_tegra_enable_clocks(hda);
+	if (err)
+		goto out_free;
 
 	schedule_work(&hda->probe_work);
 
@@ -571,7 +569,6 @@ static void hda_tegra_probe_work(struct work_struct *work)
 	struct platform_device *pdev = to_platform_device(hda->dev);
 	int err;
 
-	pm_runtime_get_sync(hda->dev);
 	err = hda_tegra_first_init(chip, pdev);
 	if (err < 0)
 		goto out_free;
@@ -592,8 +589,15 @@ static void hda_tegra_probe_work(struct work_struct *work)
 	chip->running = 1;
 	snd_hda_set_power_save(&chip->bus, power_save * 1000);
 
+	/* set device state as active */
+	if (pm_runtime_set_active(hda->dev) < 0)
+		goto out_free;
+	/* enable runtime PM */
+	pm_runtime_enable(hda->dev);
+	if (!azx_has_pm_runtime(chip))
+		pm_runtime_forbid(hda->dev);
+
  out_free:
-	pm_runtime_put(hda->dev);
 	return; /* no error return from async probe */
 }
 
@@ -603,6 +607,10 @@ static int hda_tegra_remove(struct platform_device *pdev)
 
 	ret = snd_card_free(dev_get_drvdata(&pdev->dev));
 	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev)) {
+		hda_tegra_runtime_suspend(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+	}
 
 	return ret;
 }
-- 
2.7.4

