Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EF8B0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF1F208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF1F208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbeFLNQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:16:16 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64346 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754246AbeFLNQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:16:14 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5CDEOdd008771;
        Tue, 12 Jun 2018 15:15:59 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jjet6g107-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Jun 2018 15:15:59 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C6A543A;
        Tue, 12 Jun 2018 13:15:58 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D51DA546;
        Tue, 12 Jun 2018 13:15:58 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:15:58 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:15:58 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 08/19] mmc: mmci: add variant property to define irq pio mask
Date:   Tue, 12 Jun 2018 15:14:29 +0200
Message-ID: <1528809280-31116-9-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch allows to define specific pio mask for variants.
Needed to support the STM32 sdmmc variant which has some bits
with different meaning (bits: 21,20,13,12,9)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 13 +++++++++++--
 drivers/mmc/host/mmci.h |  5 ++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1f44c61..5fd3ffb6 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -62,6 +62,7 @@ static struct variant_data variant_arm = {
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
 	.mmci_dma		= &dmaengine,
@@ -80,6 +81,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
 	.mmci_dma		= &dmaengine,
@@ -99,6 +101,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
 	.mmci_dma		= &dmaengine,
@@ -124,6 +127,7 @@ static struct variant_data variant_u300 = {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
 	.mmci_dma		= &dmaengine,
@@ -150,6 +154,7 @@ static struct variant_data variant_nomadik = {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
 	.mmci_dma		= &dmaengine,
@@ -182,6 +187,7 @@ static struct variant_data variant_ux500 = {
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
 	.mmci_dma		= &dmaengine,
@@ -216,6 +222,7 @@ static struct variant_data variant_ux500v2 = {
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
 	.mmci_dma		= &dmaengine,
@@ -232,6 +239,7 @@ static struct variant_data variant_stm32 = {
 	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
 	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
@@ -268,6 +276,7 @@ static struct variant_data variant_qcom = {
 	.qcom_fifo		= true,
 	.qcom_dml		= true,
 	.mmcimask1		= true,
+	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
 	.mmci_dma		= &dmaengine,
@@ -486,7 +495,7 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
 	if (host->singleirq) {
 		unsigned int mask0 = readl(base + MMCIMASK0);
 
-		mask0 &= ~MCI_IRQ1MASK;
+		mask0 &= ~variant->irq_pio_mask;
 		mask0 |= mask;
 
 		writel(mask0, base + MMCIMASK0);
@@ -1046,7 +1055,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 			if (status & host->mask1_reg)
 				mmci_pio_irq(irq, dev_id);
 
-			status &= ~MCI_IRQ1MASK;
+			status &= ~host->variant->irq_pio_mask;
 		}
 
 		/*
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index a2bf8bc..b91b130 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -186,7 +186,7 @@
 	MCI_CMDRESPENDMASK | MCI_CMDSENTMASK)
 
 /* These interrupts are directed to IRQ1 when two IRQ lines are available */
-#define MCI_IRQ1MASK \
+#define MCI_IRQ_PIO_MASK \
 	(MCI_RXFIFOHALFFULLMASK | MCI_RXDATAAVLBLMASK | \
 	 MCI_TXFIFOHALFEMPTYMASK)
 
@@ -275,6 +275,8 @@ struct mmci_host;
  * @qcom_dml: enables qcom specific dma glue for dma transfers.
  * @reversed_irq_handling: handle data irq before cmd irq.
  * @mmcimask1: true if variant have a MMCIMASK1 register.
+ * @irq_pio_mask: bitmask used to manage interrupt pio transfert in mmcimask
+ *		  register
  * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
@@ -317,6 +319,7 @@ struct variant_data {
 	bool			qcom_dml;
 	bool			reversed_irq_handling;
 	bool			mmcimask1;
+	unsigned int		irq_pio_mask;
 	u32			start_err;
 	u32			opendrain;
 	struct mmci_dma_ops	*mmci_dma;
-- 
2.7.4

