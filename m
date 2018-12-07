Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C77C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0758B21479
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544185987;
	bh=zvN6PVb9H9wMJhY0UwSYDNkHE0VWA5Agm4NrXG9fP+I=;
	h=From:To:Subject:Date:List-ID:From;
	b=mAgwRvyACqjWX/zxhY57+a4c65j6qivl5h7PRoJ2HR8BnAoG9V++WD3+cekwunJ99
	 GYhJmPCwCNaSk+ogCC7zaBjSlEqIn+itd5E+Ug4hMOKzndnuDrAVgynCPirh/SJbAJ
	 TwUOPrB+qAjrXH7tsl70BzKdFQg+qM23BOTDdPmE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0758B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeLGMdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeLGMdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:33:05 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD020208E7;
        Fri,  7 Dec 2018 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544185984;
        bh=zvN6PVb9H9wMJhY0UwSYDNkHE0VWA5Agm4NrXG9fP+I=;
        h=From:To:Subject:Date:From;
        b=f3RvMrM4sNR1dzmveHg8VCulfh7zGYWQa9JKGMXe3L+H6ABxIV+9H/88NllGMRbfq
         26qpKeXa3MgjqrF4GPx8gwHNrpfEuLAeHAjAEm/PwzpnwFYL+DcnBwmv9aiX2oaeHX
         eBgmptbeNnhLTfD8ZY+c1MFjLlEc1Eh3GAvkk9vI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] leds: pwm: Simplify with resource-managed devm_led_classdev_register()
Date:   Fri,  7 Dec 2018 13:32:51 +0100
Message-Id: <1544185974-5932-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the exit path with resource-managed version of registering LED
class device.  The code should be functionally the same, except that on
device removal the led_pwm_priv->num_leds is not decremented to zero
(which should not have any effect as device is going away).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/leds-pwm.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 5d3faae51d59..fcb3e87a9887 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -74,12 +74,6 @@ static inline size_t sizeof_pwm_leds_priv(int num_leds)
 		      (sizeof(struct led_pwm_data) * num_leds);
 }
 
-static void led_pwm_cleanup(struct led_pwm_priv *priv)
-{
-	while (priv->num_leds--)
-		led_classdev_unregister(&priv->leds[priv->num_leds].cdev);
-}
-
 static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		       struct led_pwm *led, struct device_node *child)
 {
@@ -120,7 +114,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	if (!led_data->period && (led->pwm_period_ns > 0))
 		led_data->period = led->pwm_period_ns;
 
-	ret = led_classdev_register(dev, &led_data->cdev);
+	ret = devm_led_classdev_register(dev, &led_data->cdev);
 	if (ret == 0) {
 		priv->num_leds++;
 		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
@@ -191,25 +185,14 @@ static int led_pwm_probe(struct platform_device *pdev)
 		ret = led_pwm_create_of(&pdev->dev, priv);
 	}
 
-	if (ret) {
-		led_pwm_cleanup(priv);
+	if (ret)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
 }
 
-static int led_pwm_remove(struct platform_device *pdev)
-{
-	struct led_pwm_priv *priv = platform_get_drvdata(pdev);
-
-	led_pwm_cleanup(priv);
-
-	return 0;
-}
-
 static const struct of_device_id of_pwm_leds_match[] = {
 	{ .compatible = "pwm-leds", },
 	{},
@@ -218,7 +201,6 @@ MODULE_DEVICE_TABLE(of, of_pwm_leds_match);
 
 static struct platform_driver led_pwm_driver = {
 	.probe		= led_pwm_probe,
-	.remove		= led_pwm_remove,
 	.driver		= {
 		.name	= "leds_pwm",
 		.of_match_table = of_pwm_leds_match,
-- 
2.7.4

