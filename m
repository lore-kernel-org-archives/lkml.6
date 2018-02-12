Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935461AbeBLNVx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:21:53 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34769 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935210AbeBLNRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:17:40 -0500
X-Google-Smtp-Source: AH8x227mQBvM6rfBiqRWZ+X6ll29b8JBJ5IGv2NN+4PeV240u5BreIQITqleTW04zkaY9vUKmOf5DQ==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 04/21] regulator: da9055: Pass descriptor instead of GPIO number
Date: Mon, 12 Feb 2018 14:17:00 +0100
Message-Id: <20180212131717.27193-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212131717.27193-1-linus.walleij@linaro.org>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting up a fixed regulator on the DA9055, pass a descriptor
instead of a global GPIO number. This facility is not used in the
kernel so we can easily just say that this should be a descriptor
if/when put to use.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Lee: would be nice if you could ACK this smallish patch
to the MFD header.
---
 drivers/regulator/da9055-regulator.c | 4 ++--
 include/linux/mfd/da9055/pdata.h     | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index d029c941a1e1..f40c3b8644ae 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
@@ -455,8 +456,7 @@ static int da9055_gpio_init(struct da9055_regulator *regulator,
 		char name[18];
 		int gpio_mux = pdata->gpio_ren[id];
 
-		config->ena_gpio = pdata->ena_gpio[id];
-		config->ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
+		config->ena_gpiod = pdata->ena_gpiods[id];
 		config->ena_gpio_invert = 1;
 
 		/*
diff --git a/include/linux/mfd/da9055/pdata.h b/include/linux/mfd/da9055/pdata.h
index 04e092be4b07..1a94fa2ac309 100644
--- a/include/linux/mfd/da9055/pdata.h
+++ b/include/linux/mfd/da9055/pdata.h
@@ -12,6 +12,7 @@
 #define DA9055_MAX_REGULATORS	8
 
 struct da9055;
+struct gpio_desc;
 
 enum gpio_select {
 	NO_GPIO = 0,
@@ -47,7 +48,7 @@ struct da9055_pdata {
 	 * controls the regulator set A/B, 0 if  not available.
 	 */
 	enum gpio_select *reg_rsel;
-	/* GPIOs to enable regulator, 0 if not available */
-	int *ena_gpio;
+	/* GPIO descriptors to enable regulator, NULL if not available */
+	struct gpio_desc **ena_gpiods;
 };
 #endif /* __DA9055_PDATA_H */
-- 
2.14.3
