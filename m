Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D28C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D59B2620E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8va1py+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D59B2620E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964850AbeF0NQZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:16:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35177 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754547AbeF0NQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:16:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so3077236edt.2;
        Wed, 27 Jun 2018 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jgIVvi/APC9EtdoiQ5qxirLagAZpHO8IfA4T1Mt0NWw=;
        b=K8va1py+ULFCdb20krrV7yc1pAXL+m09iboCXZPpEFkEqIbRbnmDU2qKgxq6tKYz5i
         aaoGhBCE0AVpfi9uL4cq2VpiCSdkGwavxraz62k05pTDyiFf2YsxqXZVkP49GLveWC3Y
         B9w9PgGaDv1WEkWR0sXEDO7Aw4DOr4HIdHMVbCC3zvtPgtGFdFDG9L5vdpAovSfPg82A
         QSnQ36s8qs2kRi8O3ZdqQb5KQwsxnRqbb75QyvbwHSeHobW4QXgJYMLO7DrNP765MgBS
         2k6km2uWGYIkGz4w3OwwQyFbSiP1j52izojWRW6B4LGCJLGWOYPz6Oypl3bsGBcPXBUP
         3s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jgIVvi/APC9EtdoiQ5qxirLagAZpHO8IfA4T1Mt0NWw=;
        b=q/zHGGs5VCK1g5hjeWooEVbk+gi4d+h7k1vxAJAhGRMi14fOV1Oh4QrXSj649HUaHg
         jhNrvd7xqqN7WHX2EqJG3QKeEkcYAbsirOC3Xdq2ghKy7HD/0TCeQ0OuBJ/k2bk6kYSJ
         sGQeS52NKKANd/LQsEOuU1GXsADQafiKH6xBO541CAljTlbLS8TLNskYFJY9pPn+a0ue
         UFexo/Cyabk2io9YzjUJlS1+n9KsiTkX4MO1Mg6Cjg3iGV49DWBrK5FMV9UVHwFS9zaQ
         xJrtIsBq8ld6NBICbsAnXgV9yF9pCUeUvrEY50XhKbMrdg5bTyp+pEoqcDqrXwDHSPfu
         1h/Q==
X-Gm-Message-State: APt69E3K2Q/qawbNY+WfwbGqje+nJYqvN8onWLNrUiSMDTknOuXbWNuC
        31LwANHVrHOIEkOgH0f6vA==
X-Google-Smtp-Source: AAOMgpc7lWYPzGr8pQTi5E1geilpxjgVi0nSWrYupsCEFBkMUQgPmmypFF1vBjkM3ZPnSAwf6oxpsg==
X-Received: by 2002:a50:9704:: with SMTP id c4-v6mr5540140edb.246.1530105380951;
        Wed, 27 Jun 2018 06:16:20 -0700 (PDT)
Received: from carbonite.sagemdenmark.dk ([130.228.251.5])
        by smtp.gmail.com with ESMTPSA id i34-v6sm1953000edc.29.2018.06.27.06.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:16:20 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: [RFC PATCH v2 2/6] mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi
Date:   Wed, 27 Jun 2018 15:16:05 +0200
Message-Id: <20180627131609.13681-3-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627131609.13681-1-bugalski.piotr@gmail.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new interface to existing driver. New code is not used yet,
it will be enabled later.
Changes are prepared in small steps to keep patches readable.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <pbu@cryptera.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 205 ++++++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index bdbfaa632dbf..c36fcecd569a 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -2,8 +2,10 @@
  * Driver for Atmel QSPI Controller
  *
  * Copyright (C) 2015 Atmel Corporation
+ * Copyright (C) 2018 Cryptera A/S
  *
  * Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
+ * Author: Piotr Bugalski <pbu@cryptera.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -35,6 +37,7 @@
 
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/spi/spi-mem.h>
 
 /* QSPI register offsets */
 #define QSPI_CR      0x0000  /* Control Register */
@@ -186,6 +189,23 @@ struct atmel_qspi_command {
 	void		*rx_buf;
 };
 
+struct qspi_mode {
+	u8 cmd_buswidth;
+	u8 addr_buswidth;
+	u8 data_buswidth;
+	u32 config;
+};
+
+static const struct qspi_mode sama5d2_qspi_modes[] = {
+	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
+	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
+	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
+	{ 1, 2, 2, QSPI_IFR_WIDTH_DUAL_IO },
+	{ 1, 4, 4, QSPI_IFR_WIDTH_QUAD_IO },
+	{ 2, 2, 2, QSPI_IFR_WIDTH_DUAL_CMD },
+	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
+};
+
 /* Register access functions */
 static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
 {
@@ -197,6 +217,190 @@ static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
 	writel_relaxed(value, aq->regs + reg);
 }
 
+static inline bool is_compatible(const struct spi_mem_op *op,
+				 const struct qspi_mode *mode)
+{
+	if (op->cmd.buswidth != mode->cmd_buswidth)
+		return false;
+
+	if (op->addr.nbytes && op->addr.buswidth != mode->addr_buswidth)
+		return false;
+
+	if (op->data.nbytes && op->data.buswidth != mode->data_buswidth)
+		return false;
+
+	return true;
+}
+
+static int find_mode(const struct spi_mem_op *op)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
+		if (is_compatible(op, &sama5d2_qspi_modes[i]))
+			return i;
+
+	return -1;
+}
+
+static bool atmel_qspi_supports_op(struct spi_mem *mem,
+				   const struct spi_mem_op *op)
+{
+	if (find_mode(op) < 0)
+		return false;
+
+	/* special case not supported by hardware */
+	if (op->addr.nbytes == 2 && op->cmd.buswidth != op->addr.buswidth &&
+		op->dummy.nbytes == 0)
+		return false;
+
+	return true;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
+	int mode;
+	u32 dummy_cycles = 0;
+	u32 iar, icr, ifr, sr;
+	int err = 0;
+
+	iar = 0;
+	icr = QSPI_ICR_INST(op->cmd.opcode);
+	ifr = QSPI_IFR_INSTEN;
+
+	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+
+	mode = find_mode(op);
+	if (mode < 0)
+		return -ENOTSUPP;
+
+	ifr |= sama5d2_qspi_modes[mode].config;
+
+	if (op->dummy.buswidth && op->dummy.nbytes)
+		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
+
+	if (op->addr.buswidth) {
+		switch (op->addr.nbytes) {
+		case 0:
+			break;
+		case 1:
+			ifr |= QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
+			icr |= QSPI_ICR_OPT(op->addr.val & 0xff);
+			break;
+		case 2:
+			if (dummy_cycles < 8 / op->addr.buswidth) {
+				ifr &= ~QSPI_IFR_INSTEN;
+				ifr |= QSPI_IFR_ADDREN;
+				iar = (op->cmd.opcode << 16) |
+					(op->addr.val & 0xffff);
+			} else {
+				ifr |= QSPI_IFR_ADDREN;
+				iar = (op->addr.val << 8) & 0xffffff;
+				dummy_cycles -= 8 / op->addr.buswidth;
+			}
+			break;
+		case 3:
+			ifr |= QSPI_IFR_ADDREN;
+			iar = op->addr.val & 0xffffff;
+			break;
+		case 4:
+			ifr |= QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
+			iar = op->addr.val & 0x7ffffff;
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	/* Set number of dummy cycles */
+	if (dummy_cycles)
+		ifr |= QSPI_IFR_NBDUM(dummy_cycles);
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		ifr |= QSPI_IFR_DATAEN;
+
+	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
+		ifr |= QSPI_IFR_TFRTYP_TRSFR_READ;
+	else
+		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
+
+	/* Clear pending interrupts */
+	(void)qspi_readl(aq, QSPI_SR);
+
+	/* Set QSPI Instruction Frame registers */
+	qspi_writel(aq, QSPI_IAR, iar);
+	qspi_writel(aq, QSPI_ICR, icr);
+	qspi_writel(aq, QSPI_IFR, ifr);
+
+	/* Skip to the final steps if there is no data */
+	if (op->data.nbytes) {
+		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
+		(void)qspi_readl(aq, QSPI_IFR);
+
+		/* Send/Receive data */
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			_memcpy_fromio(op->data.buf.in,
+				aq->mem + iar, op->data.nbytes);
+		else
+			_memcpy_toio(aq->mem + iar,
+				op->data.buf.out, op->data.nbytes);
+
+		/* Release the chip-select */
+		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
+	}
+
+	/* Poll INSTRuction End status */
+	sr = qspi_readl(aq, QSPI_SR);
+	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
+		return err;
+
+	/* Wait for INSTRuction End interrupt */
+	reinit_completion(&aq->cmd_completion);
+	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
+	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
+	if (!wait_for_completion_timeout(&aq->cmd_completion,
+					 msecs_to_jiffies(1000)))
+		err = -ETIMEDOUT;
+	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
+
+	return err;
+}
+
+static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
+	.supports_op = atmel_qspi_supports_op,
+	.exec_op = atmel_qspi_exec_op
+};
+
+static int atmel_qspi_setup(struct spi_device *spi)
+{
+	struct spi_controller *ctrl = spi->master;
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	unsigned long src_rate;
+	u32 scr, scbr;
+
+	if (ctrl->busy)
+		return -EBUSY;
+
+	if (!spi->max_speed_hz)
+		return -EINVAL;
+
+	src_rate = clk_get_rate(aq->clk);
+	if (!src_rate)
+		return -EINVAL;
+
+	/* Compute the QSPI baudrate */
+	scbr = DIV_ROUND_UP(src_rate, spi->max_speed_hz);
+	if (scbr > 0)
+		scbr--;
+
+	scr = QSPI_SCR_SCBR(scbr);
+	qspi_writel(aq, QSPI_SCR, scr);
+
+	return 0;
+}
+
 static int atmel_qspi_run_transfer(struct atmel_qspi *aq,
 				   const struct atmel_qspi_command *cmd)
 {
@@ -756,5 +960,6 @@ static struct platform_driver atmel_qspi_driver = {
 module_platform_driver(atmel_qspi_driver);
 
 MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@atmel.com>");
+MODULE_AUTHOR("Piotr Bugalski <pbu@cryptera.com");
 MODULE_DESCRIPTION("Atmel QSPI Controller driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0

