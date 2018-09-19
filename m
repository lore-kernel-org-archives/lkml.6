Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CBFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1342150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1342150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbeISXb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:31:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58490 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731366AbeISXb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:31:26 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C667C20763; Wed, 19 Sep 2018 19:52:23 +0200 (CEST)
Received: from localhost (unknown [15.65.243.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 029A4204AE;
        Wed, 19 Sep 2018 19:52:22 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: ds1685: use rtc_add_group
Date:   Wed, 19 Sep 2018 19:52:11 +0200
Message-Id: <20180919175211.25150-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919175211.25150-1-alexandre.belloni@bootlin.com>
References: <20180919175211.25150-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rtc_add_group to add the sysfs group in a race free manner.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 1f85e46b7888..b0723025ac31 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -995,7 +995,6 @@ static int ds1685_nvram_write(void *priv, unsigned int pos, void *val,
 /* ----------------------------------------------------------------------- */
 /* SysFS interface */
 
-#ifdef CONFIG_SYSFS
 /**
  * ds1685_rtc_sysfs_battery_show - sysfs file for main battery status.
  * @dev: pointer to device structure.
@@ -1079,37 +1078,6 @@ ds1685_rtc_sysfs_misc_grp = {
 	.attrs = ds1685_rtc_sysfs_misc_attrs,
 };
 
-/**
- * ds1685_rtc_sysfs_register - register sysfs files.
- * @dev: pointer to device structure.
- */
-static int
-ds1685_rtc_sysfs_register(struct device *dev)
-{
-	int ret = 0;
-
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_misc_grp);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-/**
- * ds1685_rtc_sysfs_unregister - unregister sysfs files.
- * @dev: pointer to device structure.
- */
-static int
-ds1685_rtc_sysfs_unregister(struct device *dev)
-{
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_misc_grp);
-
-	return 0;
-}
-#endif /* CONFIG_SYSFS */
-
-
-
 /* ----------------------------------------------------------------------- */
 /* Driver Probe/Removal */
 
@@ -1390,11 +1358,9 @@ ds1685_rtc_probe(struct platform_device *pdev)
 	/* Setup complete. */
 	ds1685_rtc_switch_to_bank0(rtc);
 
-#ifdef CONFIG_SYSFS
-	ret = ds1685_rtc_sysfs_register(&pdev->dev);
+	ret = rtc_add_group(rtc_dev, &ds1685_rtc_sysfs_misc_grp);
 	if (ret)
 		return ret;
-#endif
 
 	rtc_dev->nvram_old_abi = true;
 	nvmem_cfg.priv = rtc;
@@ -1414,10 +1380,6 @@ ds1685_rtc_remove(struct platform_device *pdev)
 {
 	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
 
-#ifdef CONFIG_SYSFS
-	ds1685_rtc_sysfs_unregister(&pdev->dev);
-#endif
-
 	/* Read Ctrl B and clear PIE/AIE/UIE. */
 	rtc->write(rtc, RTC_CTRL_B,
 		   (rtc->read(rtc, RTC_CTRL_B) &
-- 
2.19.0

