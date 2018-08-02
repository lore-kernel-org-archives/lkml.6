Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B1CC46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F420721501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="jGVao+pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F420721501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbeHBOpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:45:45 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.133]:23757 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbeHBOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533214478;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=1Nw4oy/M2+Hl0Qt84GNVPRKcClVDBIXjTslZX0Rwdsg=;
        b=jGVao+piXBjIah1Aa8lOuYemU9PoPsZzyw3myXbqpoIriQXomGtWu9RRh14TIo6/se
        or6tmR1vw28EVWl8D9tkn8HWzJ7NHHligfHCdEgjps/8ewVuF7oqjp05QPq4I1CSdvdk
        Jqu6TDYypFWwQEzJJfoN/Qf9hg6wosgM5CU/3oEtvYCJAWZIN1pYM98+WRZlGUTI0VIG
        6eX1lJHbzxciQ+iVpaPDnb620q8gYT1yZrQlr0pXfL/02Vd77RKylYkNeEU81S5CTOB1
        zgScNowu/v5ZBmqWrSmXDpTNSc+D5M5B/6K+ALFTYeBqY0OqEuBeGnDEmtTeaBAXMc1J
        vZJQ==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+ReE5zXU1i255vGQvjM+ToVYx2MGL/3gV0P3t0="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.14 AUTH)
        with ESMTPSA id Z0998bu72CsS7Pe
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 2 Aug 2018 14:54:28 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com, richard@nod.at,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org
Cc:     cyrille.pitchen@wedev4u.fr, frieder.schrempf@exceet.de,
        pp@emlix.com, Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] spi: spi-mem: Extend the SPI mem interface to set a custom memory name
Date:   Thu,  2 Aug 2018 14:53:53 +0200
Message-Id: <1533214434-28761-3-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
References: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When porting (Q)SPI controller drivers from the MTD layer to the SPI
layer, the naming scheme for the memory devices changes. To be able
to keep compatibility with the old drivers naming scheme, a name
field is added to struct spi_mem and a hook is added to let controller
drivers set a custom name for the memory device.

Example for the FSL QSPI driver:

Name with the old driver: 21e0000.qspi,
or with multiple devices: 21e0000.qspi-0, 21e0000.qspi-1, ...

Name with the new driver without spi_mem_get_name: spi4.0

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 drivers/spi/spi-mem.c       | 28 ++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 12 ++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770d..e43842c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -311,6 +311,24 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 EXPORT_SYMBOL_GPL(spi_mem_exec_op);
 
 /**
+ * spi_mem_get_name() - Return the SPI mem device name to be used by the
+ *			upper layer if necessary
+ * @mem: the SPI memory
+ *
+ * This function allows SPI mem users to retrieve the SPI mem device name.
+ * It is useful if the upper layer needs to expose a custom name for
+ * compatibility reasons.
+ *
+ * Return: a string containing the name of the memory device to be used
+ *	   by the SPI mem user
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
@@ -344,6 +362,7 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
 static int spi_mem_probe(struct spi_device *spi)
 {
 	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
+	struct spi_controller *ctlr = spi->controller;
 	struct spi_mem *mem;
 
 	mem = devm_kzalloc(&spi->dev, sizeof(*mem), GFP_KERNEL);
@@ -351,6 +370,15 @@ static int spi_mem_probe(struct spi_device *spi)
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
index 72cc9bc..0d41826 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -125,6 +125,7 @@ struct spi_mem_op {
  * struct spi_mem - describes a SPI memory device
  * @spi: the underlying SPI device
  * @drvpriv: spi_mem_driver private data
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
@@ -167,6 +169,13 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ * @get_name: get a custom name for the SPI mem device from the controller.
+ *	      This might be needed if the controller driver has been ported
+ *	      to use the SPI mem layer and a custom name is used to keep
+ *	      mtdparts compatible.
+ *	      Note that if the implementation of this function allocates memory
+ *	      dynamically, then it should do so with devm_xxx(), as we don't
+ *	      have a ->free_name() function.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -178,6 +187,7 @@ struct spi_controller_mem_ops {
 			    const struct spi_mem_op *op);
 	int (*exec_op)(struct spi_mem *mem,
 		       const struct spi_mem_op *op);
+	const char *(*get_name)(struct spi_mem *mem);
 };
 
 /**
@@ -236,6 +246,8 @@ bool spi_mem_supports_op(struct spi_mem *mem,
 int spi_mem_exec_op(struct spi_mem *mem,
 		    const struct spi_mem_op *op);
 
+const char *spi_mem_get_name(struct spi_mem *mem);
+
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
 
-- 
2.7.4

