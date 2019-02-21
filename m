Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA87C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3079220880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfBUKL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:11:26 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4453 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbfBUKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:11:24 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LA6sRO023425;
        Thu, 21 Feb 2019 11:11:12 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qsbm9bt6j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Feb 2019 11:11:12 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 162A149;
        Thu, 21 Feb 2019 10:11:11 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E16B2858;
        Thu, 21 Feb 2019 10:11:10 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Feb
 2019 11:11:10 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Feb
 2019 11:11:09 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 2/2] mmc: mmci: add quirk property to add stm32 transfer mode
Date:   Thu, 21 Feb 2019 11:10:51 +0100
Message-ID: <1550743851-13588-3-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a quirk bit to define specific stm32 transfer
modes. sdmmc data transfer mode selection could be:
-Block data transfer ending on block count.
-SDIO multibyte data transfer.
-MMC Stream data transfer (not used).
-Block data transfer ending with STOP_TRANSMISSION command.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 11 +++++++++++
 drivers/mmc/host/mmci.h |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 387ff14..44c721a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -284,6 +284,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datactrl_blocksz	= 14,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
 	.init			= sdmmc_variant_init,
+	.quirks			= MMCI_QUIRK_STM32_DTMODE,
 };
 
 static struct variant_data variant_qcom = {
@@ -1028,6 +1029,16 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	else
 		datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
 
+	if (variant->quirks & MMCI_QUIRK_STM32_DTMODE) {
+		if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
+		    data->blocks == 1)
+			datactrl |= MCI_DPSM_STM32_MODE_SDIO;
+		else if (data->stop && !host->mrq->sbc)
+			datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;
+		else
+			datactrl |= MCI_DPSM_STM32_MODE_BLOCK;
+	}
+
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 474f4fa..9fbd0a4 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -131,6 +131,11 @@
 /* Control register extensions in the Qualcomm versions */
 #define MCI_DPSM_QCOM_DATA_PEND	BIT(17)
 #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
+/* Control register extensions in STM32 versions */
+#define MCI_DPSM_STM32_MODE_BLOCK	(0 << 2)
+#define MCI_DPSM_STM32_MODE_SDIO	(1 << 2)
+#define MCI_DPSM_STM32_MODE_STREAM	(2 << 2)
+#define MCI_DPSM_STM32_MODE_BLOCK_STOP	(3 << 2)
 
 #define MMCIDATACNT		0x030
 #define MMCISTATUS		0x034
@@ -357,6 +362,8 @@ struct variant_data {
 	void (*init)(struct mmci_host *host);
 };
 
+#define MMCI_QUIRK_STM32_DTMODE	BIT(0)
+
 /* mmci variant callbacks */
 struct mmci_host_ops {
 	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
-- 
2.7.4

