Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56469C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063602098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="caTxx/zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063602098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeJLU0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:26:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34088 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbeJLU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:26:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id j17-v6so11303043lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QFWh2VY+/WHVnwKgB1Ultl1aw9SB9K99iEk317UWLjQ=;
        b=caTxx/zxXkEm9pN8MB3n+ze57S/dfwSqW4I40t+7ScB/77GKpqJ8g4YW0QmGMWp3a6
         N+axGj5RkOdMWImrLW5ZZUxN4lT6uMaJ3MgVDVw3RdtNl/V+5cQiNJ0WKiypJIQI/+Mq
         NQZLW7kSDETeX06MRQ6hggCFLq73gCWVTtbKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QFWh2VY+/WHVnwKgB1Ultl1aw9SB9K99iEk317UWLjQ=;
        b=MXKmkoLtIgATbHaFvQPAbV0grT+pG543RL862oqfwzGsjWd36fb99UA53T3ZH8mSIQ
         N8daSxRhTcHFQV5FuW5jueEWedYMU9a4MUFSaJosYJ+4U5Xa0iE3f/RLPrDlfQwWK6sF
         UwRziTW6uhZgCBllZ4XcSbhY7vhVl2q4ov4tJzrhM5RSEZMs/Zj8kVPFbB2RJ3eOsVIw
         VrgBlJcfWE5y7WWHPhWT/hE9+0PqtwkZ4k4wFHBs9YrNmin6gg/qO5CbSFjLdNMpCWLY
         VgZ4vLr1evqC/xB3t4uzF60zPMDuiqhm20fYfpQrYFpPYPijPsk8glb81J7KD9awHOlT
         7eKA==
X-Gm-Message-State: ABuFfojayVVXtu8si/bUfw4s+o5+plkd1EPFHnY3UdaHD/Dknmb8bh8t
        wQsIvDxXM9obDDHwHNb1uWg2AA==
X-Google-Smtp-Source: ACcGV62PVgvHt6JngNf4p8esuFYrHc9FytB8xZxlwPx+VwyutLvup5H9XzxBo5N9aUAkDmdLhrp1Ow==
X-Received: by 2002:a2e:9dc4:: with SMTP id x4-v6mr4341433ljj.133.1539348857666;
        Fri, 12 Oct 2018 05:54:17 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u7-v6sm252741lju.15.2018.10.12.05.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 05:54:15 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2] regulator/gpio: Allow nonexclusive GPIO access
Date:   Fri, 12 Oct 2018 14:54:12 +0200
Message-Id: <20181012125412.21324-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
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

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Fixes: efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix the print string to use ternary operator and alternative
  text.
- Collect Tested-by's from affected systems.
- Mark: I tested to apply this on the regulator tree pulled
  in my for-next branches for GPIO and pin control on top and
  it seems to work! Could you apply it?
---
 drivers/gpio/gpiolib.c        | 19 +++++++++++++++++--
 drivers/regulator/fixed.c     | 13 +++++++++++++
 include/linux/gpio/consumer.h |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7c222df8f834..56178af4ecd9 100644
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
2.17.2

