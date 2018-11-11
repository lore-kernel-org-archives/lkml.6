Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D17C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478A2208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="dCt4r5K9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478A2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeKKLV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:21:28 -0500
Received: from onstation.org ([52.200.56.107]:51776 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbeKKLV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:21:28 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 362A5354;
        Sun, 11 Nov 2018 01:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1541900069;
        bh=0FC39zTfVGW9D+y9Ly2m3S69gKSqhW+FK5vshiJY4JY=;
        h=From:To:Cc:Subject:Date:From;
        b=dCt4r5K9ft/D5iR5yqzjrGrCPYhKNXZmeSCMTag3/8yStCicHSscyOZDUITLE3qoC
         y+9fdvRZh6y6MQjmQY4pgkZI7mzxJx5WVLERs4hJTnTxbsAQ3KcBqJW0ieyRg+hlZV
         43fNUd/g/pwOB5zLvYYJn4o2feGCSZ6ydYYqfdos=
From:   Brian Masney <masneyb@onstation.org>
To:     bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: ssbi-gpio: fix gpio-hog related boot issues
Date:   Sat, 10 Nov 2018 20:34:11 -0500
Message-Id: <20181111013411.14153-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to setup up a gpio hog, device probing will repeatedly
fail with -EPROBE_DEFERED errors. It is caused by a circular dependency
between the gpio and pinctrl frameworks. If the gpio-ranges property is
present in device tree, then the gpio framework will handle the gpio pin
registration and eliminate the circular dependency.

See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
gpio-hog related boot issues") for a detailed commit message that
explains the issue in much more detail. The code comment in this commit
came from Christian's commit.

I did not test this change against any hardware supported by this
particular driver, however I was able to validate this same fix works
for pinctrl-spmi-gpio.c using a LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
For the patch and discussion regarding pinctrl-spmi-gpio.c, see
https://lore.kernel.org/lkml/20181101001149.13453-6-masneyb@onstation.org/

 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 6b30bef829ab..ded7d765af2e 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -762,12 +762,23 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = gpiochip_add_pin_range(&pctrl->chip,
-				     dev_name(pctrl->dev),
-				     0, 0, pctrl->chip.ngpio);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to add pin range\n");
-		goto unregister_gpiochip;
+	/*
+	 * For DeviceTree-supported systems, the gpio core checks the
+	 * pinctrl's device node for the "gpio-ranges" property.
+	 * If it is present, it takes care of adding the pin ranges
+	 * for the driver. In this case the driver can skip ahead.
+	 *
+	 * In order to remain compatible with older, existing DeviceTree
+	 * files which don't set the "gpio-ranges" property or systems that
+	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
+	 */
+	if (!of_property_read_bool(pctrl->dev->of_node, "gpio-ranges")) {
+		ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev),
+					     0, 0, pctrl->chip.ngpio);
+		if (ret) {
+			dev_err(pctrl->dev, "failed to add pin range\n");
+			goto unregister_gpiochip;
+		}
 	}
 
 	platform_set_drvdata(pdev, pctrl);
-- 
2.17.2

