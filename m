Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9BBECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BAB20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BAB20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbeGPKK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:10:58 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:29246 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeGPKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:10:57 -0400
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="13607031"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jul 2018 02:44:22 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Mon, 16 Jul 2018
 02:44:22 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <me@jue.yt>, <wsa@the-dreams.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        Juergen Fitschen <jfi@ssv-embedded.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 3/3] i2c: at91: added slave mode support
Date:   Mon, 16 Jul 2018 11:40:37 +0200
Message-ID: <20180716094037.1843-4-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180716094037.1843-1-ludovic.desroches@microchip.com>
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Fitschen <jfi@ssv-embedded.de>

Slave mode driver is based on the concept of i2c-designware driver.

Signed-off-by: Juergen Fitschen <me@jue.yt>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/i2c/busses/Makefile         |   3 +
 drivers/i2c/busses/i2c-at91-core.c  |  13 +++-
 drivers/i2c/busses/i2c-at91-slave.c | 147 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-at91.h       |  30 +++++++-
 4 files changed, 189 insertions(+), 4 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-at91-slave.c

diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 378daa860ed4..1ab8b51a7657 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -35,6 +35,9 @@ obj-$(CONFIG_I2C_ALTERA)	+= i2c-altera.o
 obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
 obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
 i2c-at91-objs			:= i2c-at91-core.o i2c-at91-master.o
+ifeq ($(CONFIG_I2C_SLAVE),y)
+	i2c-at91-objs		+= i2c-at91-slave.o
+endif
 obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
 obj-$(CONFIG_I2C_AXXIA)		+= i2c-axxia.o
 obj-$(CONFIG_I2C_BCM2835)	+= i2c-bcm2835.o
diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
index 5d9c6c81e6ab..c74283fa567f 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -60,8 +60,10 @@ void at91_init_twi_bus(struct at91_twi_dev *dev)
 {
 	at91_disable_twi_interrupts(dev);
 	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
-
-	at91_init_twi_bus_master(dev);
+	if (dev->slave_detected)
+		at91_init_twi_bus_slave(dev);
+	else
+		at91_init_twi_bus_master(dev);
 }
 
 static struct at91_twi_pdata at91rm9200_config = {
@@ -243,7 +245,12 @@ static int at91_twi_probe(struct platform_device *pdev)
 	dev->adapter.timeout = AT91_I2C_TIMEOUT;
 	dev->adapter.dev.of_node = pdev->dev.of_node;
 
-	rc = at91_twi_probe_master(pdev, phy_addr, dev);
+	dev->slave_detected = i2c_detect_slave_mode(&pdev->dev);
+
+	if (dev->slave_detected)
+		rc = at91_twi_probe_slave(pdev, phy_addr, dev);
+	else
+		rc = at91_twi_probe_master(pdev, phy_addr, dev);
 	if (rc)
 		return rc;
 
diff --git a/drivers/i2c/busses/i2c-at91-slave.c b/drivers/i2c/busses/i2c-at91-slave.c
new file mode 100644
index 000000000000..4b4808e0c8f7
--- /dev/null
+++ b/drivers/i2c/busses/i2c-at91-slave.c
@@ -0,0 +1,147 @@
+/*
+ *  i2c slave support for Atmel's AT91 Two-Wire Interface (TWI)
+ *
+ *  Copyright (C) 2017 Juergen Fitschen <me@jue.yt>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+
+#include "i2c-at91.h"
+
+static irqreturn_t atmel_twi_interrupt_slave(int irq, void *dev_id)
+{
+	struct at91_twi_dev *dev = dev_id;
+	const unsigned status = at91_twi_read(dev, AT91_TWI_SR);
+	const unsigned irqstatus = status & at91_twi_read(dev, AT91_TWI_IMR);
+	u8 value;
+
+	if (!irqstatus)
+		return IRQ_NONE;
+
+	/* slave address has been detected on I2C bus */
+	if (irqstatus & AT91_TWI_SVACC) {
+		if (status & AT91_TWI_SVREAD) {
+			i2c_slave_event(dev->slave,
+					I2C_SLAVE_READ_REQUESTED, &value);
+			writeb_relaxed(value, dev->base + AT91_TWI_THR);
+			at91_twi_write(dev, AT91_TWI_IER,
+				       AT91_TWI_TXRDY | AT91_TWI_EOSACC);
+		} else {
+			i2c_slave_event(dev->slave,
+					I2C_SLAVE_WRITE_REQUESTED, &value);
+			at91_twi_write(dev, AT91_TWI_IER,
+				       AT91_TWI_RXRDY | AT91_TWI_EOSACC);
+		}
+		at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_SVACC);
+	}
+
+	/* byte transmitted to remote master */
+	if (irqstatus & AT91_TWI_TXRDY) {
+		i2c_slave_event(dev->slave, I2C_SLAVE_READ_PROCESSED, &value);
+		writeb_relaxed(value, dev->base + AT91_TWI_THR);
+	}
+
+	/* byte received from remote master */
+	if (irqstatus & AT91_TWI_RXRDY) {
+		value = readb_relaxed(dev->base + AT91_TWI_RHR);
+		i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED, &value);
+	}
+
+	/* master sent stop */
+	if (irqstatus & AT91_TWI_EOSACC) {
+		at91_twi_write(dev, AT91_TWI_IDR,
+			       AT91_TWI_TXRDY | AT91_TWI_RXRDY | AT91_TWI_EOSACC);
+		at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_SVACC);
+		i2c_slave_event(dev->slave, I2C_SLAVE_STOP, &value);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int at91_reg_slave(struct i2c_client *slave)
+{
+	struct at91_twi_dev *dev = i2c_get_adapdata(slave->adapter);
+
+	if (dev->slave)
+		return -EBUSY;
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	/* Make sure twi_clk doesn't get turned off! */
+	pm_runtime_get_sync(dev->dev);
+
+	dev->slave = slave;
+	dev->smr = AT91_TWI_SMR_SADR(slave->addr);
+
+	at91_init_twi_bus(dev);
+	at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_SVACC);
+
+	dev_info(dev->dev, "entered slave mode (ADR=%d)\n", slave->addr);
+
+	return 0;
+}
+
+static int at91_unreg_slave(struct i2c_client *slave)
+{
+	struct at91_twi_dev *dev = i2c_get_adapdata(slave->adapter);
+
+	WARN_ON(!dev->slave);
+
+	dev_info(dev->dev, "leaving slave mode\n");
+
+	dev->slave = NULL;
+	dev->smr = 0;
+
+	at91_init_twi_bus(dev);
+
+	pm_runtime_put(dev->dev);
+
+	return 0;
+}
+
+static u32 at91_twi_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SLAVE | I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
+		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+}
+
+static const struct i2c_algorithm at91_twi_algorithm_slave = {
+	.reg_slave	= at91_reg_slave,
+	.unreg_slave	= at91_unreg_slave,
+	.functionality	= at91_twi_func,
+};
+
+int at91_twi_probe_slave(struct platform_device *pdev,
+			 u32 phy_addr, struct at91_twi_dev *dev)
+{
+	int rc;
+
+	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt_slave,
+			      0, dev_name(dev->dev), dev);
+	if (rc) {
+		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
+		return rc;
+	}
+
+	dev->adapter.algo = &at91_twi_algorithm_slave;
+
+	return 0;
+}
+
+void at91_init_twi_bus_slave(struct at91_twi_dev *dev)
+{
+	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_MSDIS);
+	if (dev->slave_detected && dev->smr) {
+		at91_twi_write(dev, AT91_TWI_SMR, dev->smr);
+		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SVEN);
+	}
+}
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index 555b1674ddbe..bb502c192697 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -53,6 +53,10 @@
 #define	AT91_TWI_IADRSZ_1	0x0100	/* Internal Device Address Size */
 #define	AT91_TWI_MREAD		BIT(12)	/* Master Read Direction */
 
+#define	AT91_TWI_SMR		0x0008	/* Slave Mode Register */
+#define	AT91_TWI_SMR_SADR_MAX	0x007f
+#define	AT91_TWI_SMR_SADR(x)	(((x) & AT91_TWI_SMR_SADR_MAX) << 16)
+
 #define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
 
 #define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
@@ -63,13 +67,17 @@
 #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
 #define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
 #define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
+#define	AT91_TWI_SVREAD		BIT(3)	/* Slave Read */
+#define	AT91_TWI_SVACC		BIT(4)	/* Slave Access */
 #define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
 #define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
 #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
+#define	AT91_TWI_EOSACC		BIT(11)	/* End Of Slave Access */
 #define	AT91_TWI_LOCK		BIT(23) /* TWI Lock due to Frame Errors */
 
 #define	AT91_TWI_INT_MASK \
-	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
+	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK \
+	| AT91_TWI_SVACC | AT91_TWI_EOSACC)
 
 #define	AT91_TWI_IER		0x0024	/* Interrupt Enable Register */
 #define	AT91_TWI_IDR		0x0028	/* Interrupt Disable Register */
@@ -137,6 +145,11 @@ struct at91_twi_dev {
 	bool recv_len_abort;
 	u32 fifo_size;
 	struct at91_twi_dma dma;
+	bool slave_detected;
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	unsigned smr;
+	struct i2c_client *slave;
+#endif
 };
 
 unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg);
@@ -149,3 +162,18 @@ void at91_init_twi_bus(struct at91_twi_dev *dev);
 void at91_init_twi_bus_master(struct at91_twi_dev *dev);
 int at91_twi_probe_master(struct platform_device *pdev, u32 phy_addr,
 			  struct at91_twi_dev *dev);
+
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+void at91_init_twi_bus_slave(struct at91_twi_dev *dev);
+int at91_twi_probe_slave(struct platform_device *pdev, u32 phy_addr,
+			 struct at91_twi_dev *dev);
+
+#else
+static inline void at91_init_twi_bus_slave(struct at91_twi_dev *dev) {}
+static inline int at91_twi_probe_slave(struct platform_device *pdev,
+				       u32 phy_addr, struct at91_twi_dev *dev)
+{
+	return -EINVAL;
+}
+
+#endif
-- 
2.12.2

