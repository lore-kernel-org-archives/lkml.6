Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeCUB6g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:58:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34918 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeCUB6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:58:31 -0400
From: Mark Brown <broonie@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        erick.chen@spreadtrum.com, baolin.wang@linaro.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: sprd: Simplify the transfer function" to the spi tree
In-Reply-To: <e458e920e9a425dfa23f13cf55b2fbcd7081997f.1521512297.git.baolin.wang@linaro.org>
Message-Id: <20180321015826.26A3E44007A@finisterre.ee.mobilebroadband>
Date: Wed, 21 Mar 2018 01:58:26 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sprd: Simplify the transfer function

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

>From a61aa683655f3182aca6e38404ae9aac03e771ae Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 20 Mar 2018 10:42:13 +0800
Subject: [PATCH] spi: sprd: Simplify the transfer function

We can move the hardware spinlock protection into the ADI read/write
functions to simplify the sprd_adi_transfer_one() function. Moreover
this optimization can also help to access PMIC without considering
the hardware spinlock using sprd_adi_read/write() functions.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 64 +++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 5993bdbf79e4..74bbd045aac0 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -123,7 +123,17 @@ static int sprd_adi_fifo_is_full(struct sprd_adi *sadi)
 static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 {
 	int read_timeout = ADI_READ_TIMEOUT;
+	unsigned long flags;
 	u32 val, rd_addr;
+	int ret;
+
+	ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
+					  ADI_HWSPINLOCK_TIMEOUT,
+					  &flags);
+	if (ret) {
+		dev_err(sadi->dev, "get the hw lock failed\n");
+		return ret;
+	}
 
 	/*
 	 * Set the physical register address need to read into RD_CMD register,
@@ -147,7 +157,8 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 
 	if (read_timeout == 0) {
 		dev_err(sadi->dev, "ADI read timeout\n");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 
 	/*
@@ -161,21 +172,35 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 	if (rd_addr != (reg_paddr & REG_ADDR_LOW_MASK)) {
 		dev_err(sadi->dev, "read error, reg addr = 0x%x, val = 0x%x\n",
 			reg_paddr, val);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	*read_val = val & RD_VALUE_MASK;
-	return 0;
+
+out:
+	hwspin_unlock_irqrestore(sadi->hwlock, &flags);
+	return ret;
 }
 
-static int sprd_adi_write(struct sprd_adi *sadi, unsigned long reg, u32 val)
+static int sprd_adi_write(struct sprd_adi *sadi, u32 reg_paddr, u32 val)
 {
+	unsigned long reg = sprd_adi_to_vaddr(sadi, reg_paddr);
 	u32 timeout = ADI_FIFO_DRAIN_TIMEOUT;
+	unsigned long flags;
 	int ret;
 
+	ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
+					  ADI_HWSPINLOCK_TIMEOUT,
+					  &flags);
+	if (ret) {
+		dev_err(sadi->dev, "get the hw lock failed\n");
+		return ret;
+	}
+
 	ret = sprd_adi_drain_fifo(sadi);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/*
 	 * we should wait for write fifo is empty before writing data to PMIC
@@ -192,10 +217,12 @@ static int sprd_adi_write(struct sprd_adi *sadi, unsigned long reg, u32 val)
 
 	if (timeout == 0) {
 		dev_err(sadi->dev, "write fifo is full\n");
-		return -EBUSY;
+		ret = -EBUSY;
 	}
 
-	return 0;
+out:
+	hwspin_unlock_irqrestore(sadi->hwlock, &flags);
+	return ret;
 }
 
 static int sprd_adi_transfer_one(struct spi_controller *ctlr,
@@ -203,7 +230,6 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 				 struct spi_transfer *t)
 {
 	struct sprd_adi *sadi = spi_controller_get_devdata(ctlr);
-	unsigned long flags, virt_reg;
 	u32 phy_reg, val;
 	int ret;
 
@@ -214,16 +240,7 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 		if (ret)
 			return ret;
 
-		ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
-						  ADI_HWSPINLOCK_TIMEOUT,
-						  &flags);
-		if (ret) {
-			dev_err(sadi->dev, "get the hw lock failed\n");
-			return ret;
-		}
-
 		ret = sprd_adi_read(sadi, phy_reg, &val);
-		hwspin_unlock_irqrestore(sadi->hwlock, &flags);
 		if (ret)
 			return ret;
 
@@ -241,19 +258,8 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 		if (ret)
 			return ret;
 
-		virt_reg = sprd_adi_to_vaddr(sadi, phy_reg);
 		val = *p;
-
-		ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
-						  ADI_HWSPINLOCK_TIMEOUT,
-						  &flags);
-		if (ret) {
-			dev_err(sadi->dev, "get the hw lock failed\n");
-			return ret;
-		}
-
-		ret = sprd_adi_write(sadi, virt_reg, val);
-		hwspin_unlock_irqrestore(sadi->hwlock, &flags);
+		ret = sprd_adi_write(sadi, phy_reg, val);
 		if (ret)
 			return ret;
 	} else {
-- 
2.16.2
