Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeCTCmj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:42:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44249 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeCTCmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:42:31 -0400
X-Google-Smtp-Source: AG47ELu0zrjMAdsO2FU0JYzdVkO5+IMNGq2KCwvXQ/ILon9qAOOFLsA8KMS3Ro3VfeKBd9r5z7RTBw==
From: Baolin Wang <baolin.wang@linaro.org>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        erick.chen@spreadtrum.com, baolin.wang@linaro.org
Subject: [PATCH 2/2] spi: sprd: Add the support of restarting the system
Date: Tue, 20 Mar 2018 10:42:14 +0800
Message-Id: <8d23126707fa8ac81a46288e08864aca0fc0e906.1521512297.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e458e920e9a425dfa23f13cf55b2fbcd7081997f.1521512297.git.baolin.wang@linaro.org>
References: <e458e920e9a425dfa23f13cf55b2fbcd7081997f.1521512297.git.baolin.wang@linaro.org>
In-Reply-To: <e458e920e9a425dfa23f13cf55b2fbcd7081997f.1521512297.git.baolin.wang@linaro.org>
References: <e458e920e9a425dfa23f13cf55b2fbcd7081997f.1521512297.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Spreadtrum platform, we use one PMIC watchdog to reset the whole system
with loading one suitable timeout value (usually 50ms) for the watchdog.

In theory, we should implement the restart function in drivers/power/reset
subsystem to access the PMIC watchdog with regmap. When restart the system,
other cores will be stopped by IPI, but if other cores were accessing PMIC
with holding the regmap mutex lock, that will cause dead-lock issue if we
try to access the PMIC watchdog with regmap to restart the whole system.
Thus we can implement the restart function in ADI driver to avoid this
issue.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |  112 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index b89b09d..6fc50cf 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -4,6 +4,7 @@
  * SPDX-License-Identifier: GPL-2.0
  */
 
+#include <linux/delay.h>
 #include <linux/hwspinlock.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -12,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/spi/spi.h>
 #include <linux/sizes.h>
 
@@ -67,6 +69,40 @@
 #define ADI_READ_TIMEOUT		2000
 #define REG_ADDR_LOW_MASK		GENMASK(11, 0)
 
+/* Registers definitions for PMIC watchdog controller */
+#define REG_WDG_LOAD_LOW		0x80
+#define REG_WDG_LOAD_HIGH		0x84
+#define REG_WDG_CTRL			0x88
+#define REG_WDG_LOCK			0xa0
+
+/* Bits definitions for register REG_WDG_CTRL */
+#define BIT_WDG_RUN			BIT(1)
+#define BIT_WDG_RST			BIT(3)
+
+/* Registers definitions for PMIC */
+#define PMIC_RST_STATUS			0xee8
+#define PMIC_MODULE_EN			0xc08
+#define PMIC_CLK_EN			0xc18
+#define BIT_WDG_EN			BIT(2)
+
+/* Definition of PMIC reset status register */
+#define HWRST_STATUS_RECOVERY		0x20
+#define HWRST_STATUS_NORMAL		0x40
+#define HWRST_STATUS_ALARM		0x50
+#define HWRST_STATUS_SLEEP		0x60
+#define HWRST_STATUS_FASTBOOT		0x30
+#define HWRST_STATUS_SPECIAL		0x70
+#define HWRST_STATUS_PANIC		0x80
+#define HWRST_STATUS_CFTREBOOT		0x90
+#define HWRST_STATUS_AUTODLOADER	0xa0
+#define HWRST_STATUS_IQMODE		0xb0
+#define HWRST_STATUS_SPRDISK		0xc0
+
+/* Use default timeout 50 ms that converts to watchdog values */
+#define WDG_LOAD_VAL			((50 * 1000) / 32768)
+#define WDG_LOAD_MASK			GENMASK(15, 0)
+#define WDG_UNLOCK_KEY			0xe551
+
 struct sprd_adi {
 	struct spi_controller	*ctlr;
 	struct device		*dev;
@@ -74,6 +110,7 @@ struct sprd_adi {
 	struct hwspinlock	*hwlock;
 	unsigned long		slave_vbase;
 	unsigned long		slave_pbase;
+	struct notifier_block	restart_handler;
 };
 
 static int sprd_adi_check_paddr(struct sprd_adi *sadi, u32 paddr)
@@ -270,6 +307,72 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	return 0;
 }
 
+static int sprd_adi_restart_handler(struct notifier_block *this,
+				    unsigned long mode, void *cmd)
+{
+	struct sprd_adi *sadi = container_of(this, struct sprd_adi,
+					     restart_handler);
+	u32 val, reboot_mode = 0;
+
+	if (!cmd)
+		reboot_mode = HWRST_STATUS_NORMAL;
+	else if (!strncmp(cmd, "recovery", 8))
+		reboot_mode = HWRST_STATUS_RECOVERY;
+	else if (!strncmp(cmd, "alarm", 5))
+		reboot_mode = HWRST_STATUS_ALARM;
+	else if (!strncmp(cmd, "fastsleep", 9))
+		reboot_mode = HWRST_STATUS_SLEEP;
+	else if (!strncmp(cmd, "bootloader", 10))
+		reboot_mode = HWRST_STATUS_FASTBOOT;
+	else if (!strncmp(cmd, "panic", 5))
+		reboot_mode = HWRST_STATUS_PANIC;
+	else if (!strncmp(cmd, "special", 7))
+		reboot_mode = HWRST_STATUS_SPECIAL;
+	else if (!strncmp(cmd, "cftreboot", 9))
+		reboot_mode = HWRST_STATUS_CFTREBOOT;
+	else if (!strncmp(cmd, "autodloader", 11))
+		reboot_mode = HWRST_STATUS_AUTODLOADER;
+	else if (!strncmp(cmd, "iqmode", 6))
+		reboot_mode = HWRST_STATUS_IQMODE;
+	else if (!strncmp(cmd, "sprdisk", 7))
+		reboot_mode = HWRST_STATUS_SPRDISK;
+	else
+		reboot_mode = HWRST_STATUS_NORMAL;
+
+	/* Record the reboot mode */
+	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_RST_STATUS, &val);
+	val |= reboot_mode;
+	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_RST_STATUS, val);
+
+	/* Enable the interface clock of the watchdog */
+	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_MODULE_EN, &val);
+	val |= BIT_WDG_EN;
+	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_MODULE_EN, val);
+
+	/* Enable the work clock of the watchdog */
+	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_CLK_EN, &val);
+	val |= BIT_WDG_EN;
+	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_CLK_EN, val);
+
+	/* Unlock the watchdog */
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, WDG_UNLOCK_KEY);
+
+	/* Load the watchdog timeout value, 50ms is always enough. */
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_LOW,
+		       WDG_LOAD_VAL & WDG_LOAD_MASK);
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_HIGH, 0);
+
+	/* Start the watchdog to reset system */
+	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);
+	val |= BIT_WDG_RUN | BIT_WDG_RST;
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
+
+	mdelay(1000);
+
+	dev_emerg(sadi->dev, "Unable to restart system\n");
+	return NOTIFY_DONE;
+}
+
 static void sprd_adi_hw_init(struct sprd_adi *sadi)
 {
 	struct device_node *np = sadi->dev->of_node;
@@ -383,6 +486,14 @@ static int sprd_adi_probe(struct platform_device *pdev)
 		goto free_hwlock;
 	}
 
+	sadi->restart_handler.notifier_call = sprd_adi_restart_handler;
+	sadi->restart_handler.priority = 128;
+	ret = register_restart_handler(&sadi->restart_handler);
+	if (ret) {
+		dev_err(&pdev->dev, "can not register restart handler\n");
+		goto free_hwlock;
+	}
+
 	return 0;
 
 free_hwlock:
@@ -397,6 +508,7 @@ static int sprd_adi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
 	struct sprd_adi *sadi = spi_controller_get_devdata(ctlr);
 
+	unregister_restart_handler(&sadi->restart_handler);
 	hwspin_lock_free(sadi->hwlock);
 	return 0;
 }
-- 
1.7.9.5
