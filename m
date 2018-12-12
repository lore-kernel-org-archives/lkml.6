Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B72AC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A5F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QQCo6Pdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A5F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeLLWS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:18:28 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40724 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbeLLWQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:52 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 12/26] pwm: jz4740: Allow selection of PWM channels 0 and 1
Date:   Wed, 12 Dec 2018 23:09:07 +0100
Message-Id: <20181212220922.18759-13-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544652595; bh=gzVBUknhZ+etpvM4N2BC87GurKdkHwwN5alAAk9sbAI=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QQCo6Pdx+fDz+UmyK1RpYn3Kah4Eag3TXivVejccl6VFTBys72cvp8y5QGrISolCRXSUZExZ7PPzLF2wUlFkXMrKIdo44tGYqjNnCJShvRXd0Zd7gbIBSILTM1aXUkDZm700XpmUcrjmvYFgzQ9m54+d/1O5e4SjhDfSoamEz+A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCU channels 0 and 1 were previously reserved for system tasks, and
thus unavailable for PWM.

The driver will now only allow a PWM channel to be requested if memory
resources corresponding to the register area of the channel were
supplied to the driver. This allows the TCU channels to be reserved for
system tasks from within the devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v6: New patch
    
     v7: No change

     v8: ingenic_tcu_[request,release]_channel are dropped. We now use
         the memory resources provided to the driver to detect whether
	 or not we are allowed to use the TCU channel.

 drivers/pwm/pwm-jz4740.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 6b865c14f789..7b12e5628f4f 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -28,6 +28,7 @@ struct jz4740_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clks[NUM_PWM];
 	struct regmap *map;
+	struct resource *parent_res;
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
@@ -35,6 +36,31 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 	return container_of(chip, struct jz4740_pwm_chip, chip);
 }
 
+static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz, unsigned int chn)
+{
+	struct platform_device *pdev = to_platform_device(jz->chip.dev);
+	struct resource chn_res, *res;
+	unsigned int i;
+
+	chn_res.start = jz->parent_res->start + TCU_REG_TDFRc(chn);
+	chn_res.end = chn_res.start + TCU_CHANNEL_STRIDE - 1;
+	chn_res.flags = IORESOURCE_MEM;
+
+	/*
+	 * Walk the list of resources, find if there's one that contains the
+	 * registers for the requested TCU channel
+	 */
+	for (i = 0; ; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
+		if (resource_contains(res, &chn_res))
+			return true;
+	}
+
+	return false;
+}
+
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct jz4740_pwm_chip *jz = to_jz4740(chip);
@@ -42,11 +68,7 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char clk_name[16];
 	int ret;
 
-	/*
-	 * Timers 0 and 1 are used for system tasks, so they are unavailable
-	 * for use as PWMs.
-	 */
-	if (pwm->hwpwm < 2)
+	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
 		return -EBUSY;
 
 	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
@@ -208,6 +230,12 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	jz4740->parent_res = platform_get_resource(
+				to_platform_device(dev->parent),
+				IORESOURCE_MEM, 0);
+	if (!jz4740->parent_res)
+		return -EINVAL;
+
 	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = NUM_PWM;
-- 
2.11.0

