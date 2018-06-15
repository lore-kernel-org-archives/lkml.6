Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 61B38C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF75208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF75208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965910AbeFONbr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:31:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41490 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965572AbeFONbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:31:43 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so14661405lfa.8;
        Fri, 15 Jun 2018 06:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R7hhvlI4Tc86sTOGOZ44GcW8PXmw/KsWTgC+dHK7usI=;
        b=DCapNG9e0WzTAXfjEjOv2VeN04hZGHRgYmZ7Sr5ltikkyGlZDHXs85aYjDIPFp4UN6
         9Fre9AnnAZ2OXNl3ameygqyO3SCBYHbYFpCd8VV23zzL6fFUxQzIiyUrB9B7/PVkKdd6
         ZLV59/a3OXh6otavDo75A3p/88RgqWhPWFkNuu3taRVTyAL2xgvt/m2BF/t18S6V+HiZ
         lQAG/rzrjMEx/Qixab1942JRa3Um0waZbazNaprLAza/4+cw18k0v9PEZwJxWVEy5yIf
         wZyuDbXb9RjkMWQkEnvaYv3oWRfj0ESILq7HS1hAZUpvdADwZjn2HbleamjwfUMp0vF9
         nRIg==
X-Gm-Message-State: APt69E2zaembPpFVuEoMhUXD+gSz2vUyx6XQUaBqE87GZbb6N86OZ36h
        el3HB42PhZT2il5UbyMNBkY=
X-Google-Smtp-Source: ADUXVKItc2xoIsftGsI4WFPM9Q5ts93W1/IOQItXiUm7iK1QMNWZMwfjB1c7212ZQfJohxDFPZKopw==
X-Received: by 2002:a19:7b0c:: with SMTP id w12-v6mr1235970lfc.22.1529069501165;
        Fri, 15 Jun 2018 06:31:41 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id w185-v6sm362845lff.47.2018.06.15.06.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 06:31:40 -0700 (PDT)
Date:   Fri, 15 Jun 2018 16:31:33 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, heiko@sntech.de,
        gregkh@linuxfoundation.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v6 4/4] input/power: Add driver for BD71837/BD71847 PMIC
 power button
Message-ID: <6bf288c2b6aa13b10f3861b0ae621ffd95aaf9c2.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD71837 PMIC power button driver providing power-key press
information to user-space.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/input/misc/Kconfig          | 10 +++++
 drivers/input/misc/Makefile         |  1 +
 drivers/input/misc/bd718xx-pwrkey.c | 90 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/bd71837.h         | 82 +++++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 drivers/input/misc/bd718xx-pwrkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 572b15fa18c2..694c05d3f9fb 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -96,6 +96,16 @@ config INPUT_ATMEL_CAPTOUCH
 	  To compile this driver as a module, choose M here: the
 	  module will be called atmel_captouch.
 
+config INPUT_BD718XX_PWRKEY
+	tristate "ROHM BD71837/BD71847 power key support"
+	depends on MFD_BD71837
+	help
+	  Say Y here if you want support for the power key usually found
+	  on boards using a ROHM BD71837/BD71847 compatible PMIC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bd718xx-pwrkey.
+
 config INPUT_BMA150
 	tristate "BMA150/SMB380 acceleration sensor support"
 	depends on I2C
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 72cde28649e2..ea5b81cbf2bf 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
 obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
 obj-$(CONFIG_INPUT_BMA150)		+= bma150.o
+obj-$(CONFIG_INPUT_BD718XX_PWRKEY)	+= bd718xx-pwrkey.o
 obj-$(CONFIG_INPUT_CM109)		+= cm109.o
 obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
diff --git a/drivers/input/misc/bd718xx-pwrkey.c b/drivers/input/misc/bd718xx-pwrkey.c
new file mode 100644
index 000000000000..e8ac9475c3cf
--- /dev/null
+++ b/drivers/input/misc/bd718xx-pwrkey.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// bd718xx-pwrkey.c -- ROHM BD71837MWV and BD71847 power button driver
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/mfd/bd71837.h>
+
+struct bd718xx_pwrkey {
+	struct input_dev *idev;
+	struct bd71837 *mfd;
+	int irq;
+};
+
+static irqreturn_t button_irq(int irq, void *_priv)
+{
+	struct input_dev *idev = (struct input_dev *)_priv;
+
+	input_report_key(idev, KEY_POWER, 1);
+	input_sync(idev);
+	input_report_key(idev, KEY_POWER, 0);
+	input_sync(idev);
+
+	return IRQ_HANDLED;
+}
+
+static int bd718xx_pwr_btn_probe(struct platform_device *pdev)
+{
+	int err = -ENOMEM;
+	struct bd718xx_pwrkey *pk;
+
+	pk = devm_kzalloc(&pdev->dev, sizeof(*pk), GFP_KERNEL);
+	if (!pk)
+		goto err_out;
+
+	pk->mfd = dev_get_drvdata(pdev->dev.parent);
+
+	pk->idev = devm_input_allocate_device(&pdev->dev);
+	if (!pk->idev)
+		goto err_out;
+
+	pk->idev->name = "bd718xx-pwrkey";
+	pk->idev->phys = "bd718xx-pwrkey/input0";
+	pk->idev->dev.parent = &pdev->dev;
+
+	input_set_capability(pk->idev, EV_KEY, KEY_POWER);
+
+	err = platform_get_irq_byname(pdev, "pwr-btn-s");
+	if (err < 0) {
+		dev_err(&pdev->dev, "could not get power key interrupt\n");
+		goto err_out;
+	}
+
+	pk->irq = err;
+	err = devm_request_threaded_irq(&pdev->dev, pk->irq, NULL, &button_irq,
+					0, "bd718xx-pwrkey", pk);
+	if (err)
+		goto err_out;
+
+	platform_set_drvdata(pdev, pk);
+	err = regmap_update_bits(pk->mfd->regmap,
+				 BD71837_REG_PWRONCONFIG0,
+				 BD718XX_PWRBTN_SHORT_PRESS_MASK,
+				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
+	if (err)
+		goto err_out;
+
+	err = input_register_device(pk->idev);
+
+err_out:
+
+	return err;
+}
+
+static struct platform_driver bd718xx_pwr_btn_driver = {
+	.probe	= bd718xx_pwr_btn_probe,
+	.driver = {
+		.name	= "bd718xx-pwrkey",
+	},
+};
+module_platform_driver(bd718xx_pwr_btn_driver);
+MODULE_DESCRIPTION("Power button driver for buttons connected to ROHM bd71837/bd71847 PMIC");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+
diff --git a/include/linux/mfd/bd71837.h b/include/linux/mfd/bd71837.h
index 641b7dba3076..410c0afa0452 100644
--- a/include/linux/mfd/bd71837.h
+++ b/include/linux/mfd/bd71837.h
@@ -100,6 +100,86 @@ enum {
 	BD71837_MAX_REGISTER           = 0x100,
 };
 
+/* register write induced reset settings */
+
+/* even though the bit zero is not SWRESET type we still want to write zero
+ * to it when changing type. Biz zero is 'SWRESET' trigger bit and if we
+ * write 1 to it we will trigger the action. So always write 0 to it when
+ * changning SWRESET action - no matter what we read from it.
+ */
+#define BD71837_SWRESET_TYPE_MASK 7
+#define BD71837_SWRESET_TYPE_DISABLED 0
+#define BD71837_SWRESET_TYPE_COLD 4
+#define BD71837_SWRESET_TYPE_WARM 6
+
+#define BD71837_SWRESET_RESET_MASK 1
+#define BD71837_SWRESET_RESET 1
+
+/* Poweroff state transition conditions */
+
+#define BD718XX_ON_REQ_POWEROFF_MASK 1
+#define BD718XX_SWRESET_POWEROFF_MASK 2
+#define BD718XX_WDOG_POWEROFF_MASK 4
+#define BD718XX_KEY_L_POWEROFF_MASK 8
+
+#define BD718XX_POWOFF_TO_SNVS 0
+#define BD718XX_POWOFF_TO_RDY 0xF
+
+#define BD718XX_POWOFF_TIME_MASK 0xF0
+enum {
+	BD718XX_POWOFF_TIME_5MS = 0,
+	BD718XX_POWOFF_TIME_10MS,
+	BD718XX_POWOFF_TIME_15MS,
+	BD718XX_POWOFF_TIME_20MS,
+	BD718XX_POWOFF_TIME_25MS,
+	BD718XX_POWOFF_TIME_30MS,
+	BD718XX_POWOFF_TIME_35MS,
+	BD718XX_POWOFF_TIME_40MS,
+	BD718XX_POWOFF_TIME_45MS,
+	BD718XX_POWOFF_TIME_50MS,
+	BD718XX_POWOFF_TIME_75MS,
+	BD718XX_POWOFF_TIME_100MS,
+	BD718XX_POWOFF_TIME_250MS,
+	BD718XX_POWOFF_TIME_500MS,
+	BD718XX_POWOFF_TIME_750MS,
+	BD718XX_POWOFF_TIME_1500MS
+};
+
+/* Poweron sequence state transition conditions */
+
+#define BD718XX_RDY_TO_SNVS_MASK 0xF
+#define BD718XX_SNVS_TO_RUN_MASK 0xF0
+
+#define BD718XX_PWR_TRIG_KEY_L 1
+#define BD718XX_PWR_TRIG_KEY_S 2
+#define BD718XX_PWR_TRIG_PMIC_ON 4
+#define BD718XX_PWR_TRIG_VSYS_UVLO 8
+#define BD718XX_RDY_TO_SNVS_SIFT 0
+#define BD718XX_SNVS_TO_RUN_SIFT 4
+
+/* Timeout value for detecting short press */
+
+#define BD718XX_PWRBTN_SHORT_PRESS_MASK 0xF
+
+enum {
+	BD718XX_PWRBTN_SHORT_PRESS_10MS = 0,
+	BD718XX_PWRBTN_SHORT_PRESS_500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_1000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_1500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_2000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_2500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_3000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_3500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_4000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_4500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_5000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_5500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_6000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_6500MS,
+	BD718XX_PWRBTN_SHORT_PRESS_7000MS,
+	BD718XX_PWRBTN_SHORT_PRESS_7500MS
+};
+
 #define REGLOCK_PWRSEQ	0x1
 #define REGLOCK_VREG	0x10
 
@@ -222,6 +302,7 @@ enum {
 struct bd71837;
 struct bd71837_pmic;
 struct bd71837_clk;
+struct bd718xx_pwrkey;
 
 /*
  * Board platform data may be used to initialize regulators.
@@ -244,6 +325,7 @@ struct bd71837 {
 
 	struct bd71837_pmic *pmic;
 	struct bd71837_clk *clk;
+	struct bd718xx_pwrkey *pwrkey;
 
 	struct bd71837_board *of_plat_data;
 };
-- 
2.14.3

