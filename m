Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161777AbeBPRM2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:12:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48344 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161066AbeBPRMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:12:23 -0500
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9055: Pass descriptor instead of GPIO number" to the regulator tree
In-Reply-To: <20180212131717.27193-5-linus.walleij@linaro.org>
Message-Id: <E1emjYb-00084h-2t@debutante>
Date: Fri, 16 Feb 2018 17:12:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9055: Pass descriptor instead of GPIO number

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

>From 8d05560d1d011e5a842556efdbd70cc8a21499bb Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 12 Feb 2018 14:17:00 +0100
Subject: [PATCH] regulator: da9055: Pass descriptor instead of GPIO number

When setting up a fixed regulator on the DA9055, pass a descriptor
instead of a global GPIO number. This facility is not used in the
kernel so we can easily just say that this should be a descriptor
if/when put to use.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.16.1
