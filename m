Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AED0C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F752146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544185991;
	bh=pcUa1ze8xfJ0wDtlInSEWA6gYDVpvTUqzPxNIWiA8+A=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X0fiWUxogUQTHTG9xNurVdxj4kTH7p4xU8+QInP9wCMUnGT0PxG2ekFbFKuBRbVV1
	 H3xnPUDguP3yKLwoxBvy7kMAkp49XnVDrXbOpBjBZpJk3ImF1E5G/uqP5Xg071YTt+
	 9jmAxrcX9Us5doOcgk0wPvJFx107z1UeVoiDCZeY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F752146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLGMdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:33:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeLGMdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:33:07 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA79E2146F;
        Fri,  7 Dec 2018 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544185986;
        bh=pcUa1ze8xfJ0wDtlInSEWA6gYDVpvTUqzPxNIWiA8+A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hhdeNX6il1rKM5kox2sfFltoALrdpwMC1NquY92RG9ZsHSQjOdUimfa3sYGAmFwRt
         RDA6B30kJ1/kewPSb3+wm/nFA2yfV4JWFvjZo6fGk9NEk3W7LYUfOpG2CMzprGf3EP
         ZmRsLXvJRRBF7d/lk0h7jdZke4ZyP69xovyq1XGs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] leds: pwm: Use OF variant of LED registering function
Date:   Fri,  7 Dec 2018 13:32:52 +0100
Message-Id: <1544185974-5932-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544185974-5932-1-git-send-email-krzk@kernel.org>
References: <1544185974-5932-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM leds can be instantiated from Device Tree so pass the
respective device node to LED core.  This provides the LED system with
proper device node and exposes it through uevent.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index fcb3e87a9887..af08bcdc4fd8 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -114,7 +114,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	if (!led_data->period && (led->pwm_period_ns > 0))
 		led_data->period = led->pwm_period_ns;
 
-	ret = devm_led_classdev_register(dev, &led_data->cdev);
+	ret = devm_of_led_classdev_register(dev, child, &led_data->cdev);
 	if (ret == 0) {
 		priv->num_leds++;
 		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
-- 
2.7.4

