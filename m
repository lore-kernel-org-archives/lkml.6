Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeE3N2D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:28:03 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.133]:12033 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeE3N2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:28:01 -0400
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx7oJE8yFU0CFyS7Uq+kmFDrWBCuLGqeCYZgEsPw="
X-RZG-CLASS-ID: mo05
From: Frieder Schrempf <frieder.schrempf@exceet.de>
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com, han.xu@nxp.com,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] spi: spi-mem: Extend the SPI mem interface to set a custom memory name
Date: Wed, 30 May 2018 15:14:30 +0200
Message-Id: <1527686082-15142-2-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When porting (Q)SPI controller drivers from the MTD layer to the SPI
layer, the naming scheme for the memory devices changes. To be able
to keep compatibility with the old drivers naming scheme, a function
is added to the SPI mem interface to let controller drivers set a
custom name for the memory.

Example for the FSL QSPI driver:

Name with the old driver: 21e0000.qspi,
or with multiple devices: 21e0000.qspi-0, 21e0000.qspi-1, ...

Name with the new driver without spi_mem_get_name: spi4.0

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 drivers/spi/spi-mem.c       | 25 +++++++++++++++++++++++++
 include/linux/spi/spi-mem.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770d..5e9af47 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -311,6 +311,31 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 EXPORT_SYMBOL_GPL(spi_mem_exec_op);
 
 /**
+ * spi_mem_get_name() - Let drivers using the SPI mem interface specify a
+ *			custom name for the memory to avoid compatibility
+ *			issues with ported drivers.
+ * @mem: the SPI memory
+ *
+ * When porting (Q)SPI controller drivers from the MTD layer to the SPI
+ * layer, the naming scheme for the memory devices changes. To be able to
+ * keep compatibility with the old drivers naming scheme, this function can
+ * be used to get a custom name from the controller driver.
+ * If no custom name is available, the name of the SPI device is returned.
+ *
+ * Return: a char array that contains the name for the flash memory
+ */
+const char *spi_mem_get_name(struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	if (ctlr->mem_ops && ctlr->mem_ops->get_name)
+		return ctlr->mem_ops->get_name(mem);
+
+	return dev_name(&mem->spi->dev);
+}
+EXPORT_SYMBOL_GPL(spi_mem_get_name);
+
+/**
  * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
  *			      match controller limitations
  * @mem: the SPI memory
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 4fa34a2..f1912d3 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -178,6 +178,7 @@ struct spi_controller_mem_ops {
 			    const struct spi_mem_op *op);
 	int (*exec_op)(struct spi_mem *mem,
 		       const struct spi_mem_op *op);
+	const char *(*get_name)(struct spi_mem *mem);
 };
 
 /**
@@ -236,6 +237,8 @@ bool spi_mem_supports_op(struct spi_mem *mem,
 int spi_mem_exec_op(struct spi_mem *mem,
 		    const struct spi_mem_op *op);
 
+const char *spi_mem_get_name(struct spi_mem *mem);
+
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
 
-- 
2.7.4
