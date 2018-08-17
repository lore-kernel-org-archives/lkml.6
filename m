Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EF8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A966218EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A966218EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeHQNKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:10:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44332 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeHQNKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:10:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D5421A026F;
        Fri, 17 Aug 2018 12:07:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 230B41A00F4;
        Fri, 17 Aug 2018 12:07:19 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1ACBE402D8;
        Fri, 17 Aug 2018 18:07:15 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     broonie@kernel.org, boris.brezillon@bootlin.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheetah0585@163.com, Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH] spi: fsl-espi: master->mem_ops is implemented in the controller
Date:   Fri, 17 Aug 2018 18:07:05 +0800
Message-Id: <1534500425-9977-1-git-send-email-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The length of the transmitted data needs to be adjusted due to the maximum 
length limit for espi transmission messages

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 drivers/spi/spi-fsl-espi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1d332e2..4724127 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -22,6 +22,7 @@
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
 #include <sysdev/fsl_soc.h>
+#include <linux/spi/spi-mem.h>
 
 /* eSPI Controller registers */
 #define ESPI_SPMODE	0x00	/* eSPI mode register */
@@ -659,6 +660,29 @@ static void fsl_espi_init_regs(struct device *dev, bool initial)
 	fsl_espi_write_reg(espi, ESPI_SPMODE, SPMODE_INIT_VAL | SPMODE_ENABLE);
 }
 
+static int fsl_espi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	if (!mem || !op)
+		return -EINVAL;
+	op->data.nbytes = min3((unsigned long)op->data.nbytes,
+			spi_max_transfer_size(mem->spi),
+			spi_max_message_size(mem->spi) -
+			sizeof(op->cmd.opcode) -
+			op->addr.nbytes -
+			op->dummy.nbytes);
+	return 0;
+}
+
+static int fsl_espi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	return -ENOTSUPP;
+}
+
+static const struct spi_controller_mem_ops fsl_espi_mem_ops = {
+	.adjust_op_size = fsl_espi_adjust_op_size,
+	.exec_op = fsl_espi_exec_op,
+};
+
 static int fsl_espi_probe(struct device *dev, struct resource *mem,
 			  unsigned int irq, unsigned int num_cs)
 {
@@ -682,6 +706,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	master->auto_runtime_pm = true;
 	master->max_message_size = fsl_espi_max_message_size;
 	master->num_chipselect = num_cs;
+	master->mem_ops = &fsl_espi_mem_ops;
 
 	espi = spi_master_get_devdata(master);
 	spin_lock_init(&espi->lock);
-- 
2.7.4

