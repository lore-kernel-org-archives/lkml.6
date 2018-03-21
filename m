Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeCUB63 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:58:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34798 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCUB62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:58:28 -0400
From: Mark Brown <broonie@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        erick.chen@spreadtrum.com, baolin.wang@linaro.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: sprd: Add the support of restarting the system" to the spi tree
In-Reply-To: <8d23126707fa8ac81a46288e08864aca0fc0e906.1521512297.git.baolin.wang@linaro.org>
Message-Id: <20180321015815.C62E144007A@finisterre.ee.mobilebroadband>
Date: Wed, 21 Mar 2018 01:58:15 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sprd: Add the support of restarting the system

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From ac1775012058e13ef1522938e27f5973d9e3f053 Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 20 Mar 2018 10:42:14 +0800
Subject: [PATCH] spi: sprd: Add the support of restarting the system

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 112 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 74bbd045aac0..197d4b0d81af 100644
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
2.16.2
