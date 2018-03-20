Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeCTCma (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:42:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42516 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeCTCm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:42:28 -0400
X-Google-Smtp-Source: AG47ELvbSy0JZVjdhN3jr9faYfu1v7cVBOCIPxske7ewQfBIW7qfgm+jEiuBbuuU5zbN2UrSz0tHeg==
From: Baolin Wang <baolin.wang@linaro.org>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        erick.chen@spreadtrum.com, baolin.wang@linaro.org
Subject: [PATCH 1/2] spi: sprd: Simplify the transfer function
Date: Tue, 20 Mar 2018 10:42:13 +0800
Message-Id: <e458e920e9a425dfa23f13cf55b2fbcd7081997f.1521512297.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can move the hardware spinlock protection into the ADI read/write
functions to simplify the sprd_adi_transfer_one() function. Moreover
this optimization can also help to access PMIC without considering
the hardware spinlock using sprd_adi_read/write() functions.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |   64 ++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index eb82b94..b89b09d 100644
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
1.7.9.5
