Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BB6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1DF23DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="YFC1bIVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1DF23DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeGELRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:17:33 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.130]:26838 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753488AbeGELRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530789449;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=tZCaPM+ETK/jVFWKAexZNweKjFocXwoGR7nnTUtOZMM=;
        b=YFC1bIVWnV2GGYsVBuItgbA0fdPJdXxbat6G2C080PNLRquYqEMVwZo2OldwXlfaK9
        kT1HJ/bzIXbpiMH02ATUSV26Q9HPpVBmWW4u4kGl+78hLT8ji4EHWxpXnPzGhdh5NmlW
        CMpVOvAS7Ja0CQC9VF79JvUXZj7XwAThutH3i42U3e3IkfJkXgbxIe7DYTQZVIcXSQYD
        bNhTj0ABlko5ZqAlgWCAQqkXjvRHsKSsbLliQJsonH4dEM18cSC7S/ez6ZHP9sN2A5UC
        oOb+bFO1owtm0P8+jjdLG9PTjleALBrO872Z2QqzuKch6wOvAnf0uwTMdKSOhN1kTdrs
        fSCg==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+daE87UU5bgm7XHzClQnm8VxHglxo5wj3H1fls="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id a0925bu65BH04i1
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 13:17:00 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] spi: spi-mem: Extend the SPI mem interface to set a custom memory name
Date:   Thu,  5 Jul 2018 13:14:57 +0200
Message-Id: <1530789310-16254-2-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
Changes in v2:
==============
* Add a name field to struct spi_mem and fill it while probing

 drivers/spi/spi-mem.c       | 30 ++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h |  7 ++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770d..048101c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -311,6 +311,26 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
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
+	return mem->name;
+}
+EXPORT_SYMBOL_GPL(spi_mem_get_name);
+
+/**
  * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
  *			      match controller limitations
  * @mem: the SPI memory
@@ -344,6 +364,7 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
 static int spi_mem_probe(struct spi_device *spi)
 {
 	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
+	struct spi_controller *ctlr = spi->controller;
 	struct spi_mem *mem;
 
 	mem = devm_kzalloc(&spi->dev, sizeof(*mem), GFP_KERNEL);
@@ -351,6 +372,15 @@ static int spi_mem_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	mem->spi = spi;
+
+	if (ctlr->mem_ops && ctlr->mem_ops->get_name)
+		mem->name = ctlr->mem_ops->get_name(mem);
+	else
+		mem->name = dev_name(&spi->dev);
+
+	if (IS_ERR_OR_NULL(mem->name))
+		return PTR_ERR(mem->name);
+
 	spi_set_drvdata(spi, mem);
 
 	return memdrv->probe(mem);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 4fa34a2..c3f82d1 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -124,7 +124,8 @@ struct spi_mem_op {
 /**
  * struct spi_mem - describes a SPI memory device
  * @spi: the underlying SPI device
- * @drvpriv: spi_mem_drviver private data
+ * @drvpriv: spi_mem_driver private data
+ * @name: name of the SPI memory device
  *
  * Extra information that describe the SPI memory device and may be needed by
  * the controller to properly handle this device should be placed here.
@@ -135,6 +136,7 @@ struct spi_mem_op {
 struct spi_mem {
 	struct spi_device *spi;
 	void *drvpriv;
+	char *name;
 };
 
 /**
@@ -178,6 +180,7 @@ struct spi_controller_mem_ops {
 			    const struct spi_mem_op *op);
 	int (*exec_op)(struct spi_mem *mem,
 		       const struct spi_mem_op *op);
+	const char *(*get_name)(struct spi_mem *mem);
 };
 
 /**
@@ -236,6 +239,8 @@ bool spi_mem_supports_op(struct spi_mem *mem,
 int spi_mem_exec_op(struct spi_mem *mem,
 		    const struct spi_mem_op *op);
 
+const char *spi_mem_get_name(struct spi_mem *mem);
+
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
 
-- 
2.7.4

