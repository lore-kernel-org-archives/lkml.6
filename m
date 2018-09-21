Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33DDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602B72154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602B72154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390019AbeIUPgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:36:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43383 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390005AbeIUPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:36:22 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9jNgI001706;
        Fri, 21 Sep 2018 11:46:48 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkn0u89q-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC2ED31;
        Fri, 21 Sep 2018 09:46:46 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AEA6B2ACB;
        Fri, 21 Sep 2018 09:46:46 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:46 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:46 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 16/27] mmc: mmci: add datactrl block size variant property
Date:   Fri, 21 Sep 2018 11:46:10 +0200
Message-ID: <1537523181-14578-17-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch allows to define a datactrl block size
by variant, requested by STM32 sdmmc variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 13 +++++++++++--
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9d93fe7..e2272c7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -52,6 +52,7 @@ static struct variant_data variant_arm = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
 	.datalength_bits	= 16,
+	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
@@ -65,6 +66,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.fifosize		= 128 * 4,
 	.fifohalfsize		= 64 * 4,
 	.datalength_bits	= 16,
+	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -78,6 +80,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.fifohalfsize		= 64 * 4,
 	.clkreg_enable		= MCI_ARM_HWFCEN,
 	.datalength_bits	= 16,
+	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -92,6 +95,7 @@ static struct variant_data variant_u300 = {
 	.clkreg_enable		= MCI_ST_U300_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.datalength_bits	= 16,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio			= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
@@ -111,6 +115,7 @@ static struct variant_data variant_nomadik = {
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -133,6 +138,7 @@ static struct variant_data variant_ux500 = {
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -160,6 +166,7 @@ static struct variant_data variant_ux500v2 = {
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
 	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -187,6 +194,7 @@ static struct variant_data variant_stm32 = {
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -208,6 +216,7 @@ static struct variant_data variant_qcom = {
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
 	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
+	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 208000000,
 	.explicit_mclk_control	= true,
@@ -1840,13 +1849,13 @@ static int mmci_probe(struct amba_device *dev,
 	/*
 	 * Block size can be up to 2048 bytes, but must be a power of two.
 	 */
-	mmc->max_blk_size = 1 << 11;
+	mmc->max_blk_size = 1 << variant->datactrl_blocksz;
 
 	/*
 	 * Limit the number of blocks transferred so that we don't overflow
 	 * the maximum request size.
 	 */
-	mmc->max_blk_count = mmc->max_req_size >> 11;
+	mmc->max_blk_count = mmc->max_req_size >> variant->datactrl_blocksz;
 
 	spin_lock_init(&host->lock);
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 44e06bb..46c8862 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -217,6 +217,7 @@ struct mmci_host;
  * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
  *		     register
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
+ * @datactrl_blksz: block size in power of two
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @f_max: maximum clk frequency supported by the controller.
  * @signal_direction: input/out direction of bus signals can be indicated
@@ -248,6 +249,7 @@ struct variant_data {
 	unsigned int		data_cmd_enable;
 	unsigned int		datactrl_mask_ddrmode;
 	unsigned int		datactrl_mask_sdio;
+	unsigned int		datactrl_blocksz;
 	bool			st_sdio;
 	bool			st_clkdiv;
 	bool			blksz_datactrl16;
-- 
2.7.4

