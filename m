Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B3894C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74580208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74580208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934200AbeFLNRv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:17:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38642 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933924AbeFLNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:16:55 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5CDE5IO017839;
        Tue, 12 Jun 2018 15:16:10 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jjegrr44n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Jun 2018 15:16:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 231223A;
        Tue, 12 Jun 2018 13:16:10 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E6C07A54C;
        Tue, 12 Jun 2018 13:16:09 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:16:09 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:16:09 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 19/19] mmc: mmci: add stm32 sdmmc variant
Date:   Tue, 12 Jun 2018 15:14:40 +0200
Message-ID: <1528809280-31116-20-git-send-email-ludovic.Barre@st.com>
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

This patch adds a stm32 sdmmc variant, rev 1.1.
Introduces a new Manufacturer id "0x53, ascii 'S' to define
new stm32 sdmmc familly with clean range of amba
revision/configurations bits (corresponding to sdmmc_ver
register with major/minor fields).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index af27a0a..bed671d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -267,6 +267,29 @@ static struct variant_data variant_stm32 = {
 	.mmci_dma		= &dmaengine,
 };
 
+static struct variant_data variant_stm32_sdmmc = {
+	.fifosize		= 16 * 4,
+	.fifohalfsize		= 8 * 4,
+	.f_max			= 208000000,
+	.stm32_clkdiv		= true,
+	.reset			= true,
+	.cmdreg_cpsm_enable	= MCI_CPSM_STM32_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_STM32_LRSP_CRC,
+	.cmdreg_srsp_crc	= MCI_CPSM_STM32_SRSP_CRC,
+	.cmdreg_srsp		= MCI_CPSM_STM32_SRSP,
+	.cmdreg_stop		= MCI_CPSM_STM32_CMDSTOP,
+	.data_cmd_enable	= MCI_CPSM_STM32_CMDTRANS,
+	.irq_pio_mask		= MCI_IRQ_PIO_STM32_MASK,
+	.datactrl_first		= true,
+	.datalength_bits	= 25,
+	.datactrl_blocksz	= 14,
+	.mmci_dma		= &sdmmc_idma,
+	.stm32_idmabsize_mask	= GENMASK(12, 5),
+	.validate_data		= sdmmc_idma_validate_data,
+	.set_clkreg		= mmci_sdmmc_set_clkreg,
+	.set_pwrreg		= mmci_sdmmc_set_pwrreg,
+};
+
 static struct variant_data variant_qcom = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -1907,6 +1930,11 @@ static const struct amba_id mmci_ids[] = {
 		.mask   = 0x00ffffff,
 		.data	= &variant_stm32,
 	},
+	{
+		.id     = 0x10153180,
+		.mask	= 0xf0ffffff,
+		.data	= &variant_stm32_sdmmc,
+	},
 	/* Qualcomm variants */
 	{
 		.id     = 0x00051180,
-- 
2.7.4

