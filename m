Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B288C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D129E20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D129E20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJaBiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:38:25 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45355 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727429AbeJaBiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:38:24 -0400
X-IronPort-AV: E=Sophos;i="5.54,445,1534802400"; 
   d="scan'208";a="353503605"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Oct 2018 17:44:09 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Markus Mayer <mmayer@broadcom.com>
Cc:     kernel-janitors@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: broadcom: use devm_thermal_zone_of_sensor_register
Date:   Tue, 30 Oct 2018 17:08:51 +0100
Message-Id: <1540915731-22312-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using devm_thermal_zone_of_sensor_register allows to simplify some
error handling code, drop a label, and drop the remove function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

This patch is completely orthogonal to the recent constification
patch.

 drivers/thermal/broadcom/brcmstb_thermal.c |   24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 1919f91fa756..956eef8717bb 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -329,7 +329,8 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 
-	thermal = thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &of_ops);
+	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv,
+						       &of_ops);
 	if (IS_ERR(thermal)) {
 		ret = PTR_ERR(thermal);
 		dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
@@ -341,40 +342,23 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "could not get IRQ\n");
-		ret = irq;
-		goto err;
+		return irq;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					brcmstb_tmon_irq_thread, IRQF_ONESHOT,
 					DRV_NAME, priv);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
 
 	return 0;
-
-err:
-	thermal_zone_of_sensor_unregister(&pdev->dev, thermal);
-	return ret;
-}
-
-static int brcmstb_thermal_exit(struct platform_device *pdev)
-{
-	struct brcmstb_thermal_priv *priv = platform_get_drvdata(pdev);
-	struct thermal_zone_device *thermal = priv->thermal;
-
-	if (thermal)
-		thermal_zone_of_sensor_unregister(&pdev->dev, priv->thermal);
-
-	return 0;
 }
 
 static struct platform_driver brcmstb_thermal_driver = {
 	.probe = brcmstb_thermal_probe,
-	.remove = brcmstb_thermal_exit,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = brcmstb_thermal_id_table,

