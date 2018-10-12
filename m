Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C26EC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0254A21473
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Dg6nfyRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0254A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJMAei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:34:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeJMAei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WKaviPFIE+VeKHuCD5uQZgOiRtIPi0A2BFmbyQnBM8g=; b=Dg6nfyRXOhvx
        pp7MnFIDAIvkFY7RRAKFEg+MdVpPwhICHcG33FhxfZYTiSTXpT7S767wpboZtmf5tttrfO9+Lug5G
        +OKddKgXn8Ki94Ly8vDVjnduRgsucU7do1UFpuYjdxffWyLl0etd3i8iMHj3DjKyyUIGUFgqXCLlj
        jvi8Q=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB0oH-0006eC-0w; Fri, 12 Oct 2018 17:01:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 785A1440078; Fri, 12 Oct 2018 19:01:08 +0200 (CEST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator/gpio: Allow nonexclusive GPIO access" to the regulator tree
In-Reply-To: 
Message-Id: <20181012170108.785A1440078@finisterre.ee.mobilebroadband>
Date:   Fri, 12 Oct 2018 19:01:08 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator/gpio: Allow nonexclusive GPIO access

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b0ce7b29bfcd090ddba476f45a75ec0a797b048a Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Oct 2018 14:54:12 +0200
Subject: [PATCH] regulator/gpio: Allow nonexclusive GPIO access

This allows nonexclusive (simultaneous) access to a single
GPIO line for the fixed regulator enable line. This happens
when several regulators use the same GPIO for enabling and
disabling a regulator, and all need a handle on their GPIO
descriptor.

This solution with a special flag is not entirely elegant
and should ideally be replaced by something more careful as
this makes it possible for several consumers to
enable/disable the same GPIO line to the left and right
without any consistency. The current use inside the regulator
core should however be fine as it takes special care to
handle this.

For the state of the GPIO backend, this is still the
lesser evil compared to going back to global GPIO
numbers.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Fixes: efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpio/gpiolib.c        | 19 +++++++++++++++++--
 drivers/regulator/fixed.c     | 13 +++++++++++++
 include/linux/gpio/consumer.h |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8f8a1999393..8228306aba46 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3908,8 +3908,23 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 	 * the device name as label
 	 */
 	status = gpiod_request(desc, con_id ? con_id : devname);
-	if (status < 0)
-		return ERR_PTR(status);
+	if (status < 0) {
+		if (status == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
+			/*
+			 * This happens when there are several consumers for
+			 * the same GPIO line: we just return here without
+			 * further initialization. It is a bit if a hack.
+			 * This is necessary to support fixed regulators.
+			 *
+			 * FIXME: Make this more sane and safe.
+			 */
+			dev_info(dev, "nonexclusive access to GPIO for %s\n",
+				 con_id ? con_id : devname);
+			return desc;
+		} else {
+			return ERR_PTR(status);
+		}
+	}
 
 	status = gpiod_configure_flags(desc, con_id, lookupflags, flags);
 	if (status < 0) {
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 7d639ad953b6..ccc29038f19a 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -170,6 +170,19 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 			gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
 	}
 
+	/*
+	 * Some fixed regulators share the enable line between two
+	 * regulators which makes it necessary to get a handle on the
+	 * same descriptor for two different consumers. This will get
+	 * the GPIO descriptor, but only the first call will initialize
+	 * it so any flags such as inversion or open drain will only
+	 * be set up by the first caller and assumed identical on the
+	 * next caller.
+	 *
+	 * FIXME: find a better way to deal with this.
+	 */
+	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+
 	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, gflags);
 	if (IS_ERR(cfg.ena_gpiod))
 		return PTR_ERR(cfg.ena_gpiod);
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 21ddbe440030..33695a1d8b35 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -30,6 +30,7 @@ struct gpio_descs {
 #define GPIOD_FLAGS_BIT_DIR_OUT		BIT(1)
 #define GPIOD_FLAGS_BIT_DIR_VAL		BIT(2)
 #define GPIOD_FLAGS_BIT_OPEN_DRAIN	BIT(3)
+#define GPIOD_FLAGS_BIT_NONEXCLUSIVE	BIT(4)
 
 /**
  * Optional flags that can be passed to one of gpiod_* to configure direction
-- 
2.19.0

