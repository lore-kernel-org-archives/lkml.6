Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624BDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3DF2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUnzHrw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3DF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeJKWDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:03:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35193 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeJKWDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:03:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id r191-v6so6873096lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3Flfwyl0NkT5SQooUVYbkxhb13sv0hTuLStxlsvlvhg=;
        b=AUnzHrw0Os3ZLwURY8I5PtZ9NBx3evD4Dv2cD5RQcgQx4qXo3ZDJ4xQkV26QcA6Q+c
         xI+XJx1cJGgON6N0O47aMy6/qKmn8xoG8wD/dgrAbCpu6ixzeDorCDQELDk5Z50DfI9P
         Ny+Spnx29XIQMAIk66APUZ6IE1CMvdb0IqzTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Flfwyl0NkT5SQooUVYbkxhb13sv0hTuLStxlsvlvhg=;
        b=eEJ54sBPUupEg/0qo7TwtZf111Ym3w70DlhMi8Ly/N2DKcLvMGEIV5JueMe6bgpPnA
         x5MNQtihu8SdV8gRqFv4dYmiD8KJJKhhi7GpszkghLFEvbWMEJouoGl+R6FkPnqCIhP3
         bQRcQBxFWdK6GkwOiIt1eMEPy2rC5+MSrXP2p/amMiq3WnKQ74YXg4LSTdK2U622Ocdu
         7KBDuaZw6YJ/wBVqOgW88sJHkDQqRNVDlEOyI7mELHQfgXLwwUlESFuyNrnh2mZU9oq6
         sbgQ8LRNtEsyJzds7qssy3LHxnkiDYoWB6J/V4IacYHN4mRtSKJglHhli+xCpmtvjnjt
         BxvQ==
X-Gm-Message-State: ABuFfogtyPSQ6dyFLPkgFiz8tMN7bn7ZgJENimHTCyD2gQl+PZfxQKk1
        vjvJV9dUJ3D914Bk249LNfgRzg==
X-Google-Smtp-Source: ACcGV61VdZ7hBWOcwd24ovncpxAMV2cYBYaQ5/1MZs1I+AsVlFNA12pTm4V58snFBn6K+Qam5bfz4Q==
X-Received: by 2002:a19:18e3:: with SMTP id 96-v6mr1373960lfy.133.1539268536594;
        Thu, 11 Oct 2018 07:35:36 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v4-v6sm6018745ljd.86.2018.10.11.07.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 07:35:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] gpio/regulator: Allow nonexclusive GPIO access
Date:   Thu, 11 Oct 2018 16:35:31 +0200
Message-Id: <20181011143531.7195-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Marek, it would be great if you could try this on top
of linux-next and report if it solves your problem on the
Samsung Exynos.

If it does I hope it will apply cleanly on the regulator
tree.
---
 drivers/gpio/gpiolib.c        | 19 +++++++++++++++++--
 drivers/regulator/fixed.c     | 13 +++++++++++++
 include/linux/gpio/consumer.h |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7c222df8f834..f82a741ff428 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4144,8 +4144,23 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
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
+				 con_id);
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
index 0f350616d372..f2f887795d43 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -39,6 +39,7 @@ struct gpio_descs {
 #define GPIOD_FLAGS_BIT_DIR_OUT		BIT(1)
 #define GPIOD_FLAGS_BIT_DIR_VAL		BIT(2)
 #define GPIOD_FLAGS_BIT_OPEN_DRAIN	BIT(3)
+#define GPIOD_FLAGS_BIT_NONEXCLUSIVE	BIT(4)
 
 /**
  * Optional flags that can be passed to one of gpiod_* to configure direction
-- 
2.17.1

