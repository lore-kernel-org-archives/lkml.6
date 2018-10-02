Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD9C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4FF2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4FF2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJBSxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:53:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23327 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727810AbeJBSxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:53:18 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w92C8gor013788;
        Tue, 2 Oct 2018 14:09:58 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh6gsmd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 14:09:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39FC431;
        Tue,  2 Oct 2018 12:09:58 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 146672A3B;
        Tue,  2 Oct 2018 12:09:58 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:57 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:57 +0200
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
Subject: [PATCH V4 15/25] mmc: mmci: add variant properties to define cpsm & cmdresp bits
Date:   Tue, 2 Oct 2018 14:09:17 +0200
Message-ID: <1538482167-13819-16-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
References: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds command variant properties to define
cpsm enable bit and responses.
Needed to support the STM32 variant (shift of cpsm bit,
specific definition of commands response).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/mmci.h |  8 ++++++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 168bb6d..00a9244 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -50,6 +50,10 @@ static unsigned int fmax = 515633;
 static struct variant_data variant_arm = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
@@ -64,6 +68,10 @@ static struct variant_data variant_arm = {
 static struct variant_data variant_arm_extended_fifo = {
 	.fifosize		= 128 * 4,
 	.fifohalfsize		= 64 * 4,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
@@ -78,6 +86,10 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.fifosize		= 128 * 4,
 	.fifohalfsize		= 64 * 4,
 	.clkreg_enable		= MCI_ARM_HWFCEN,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
 	.pwrreg_powerup		= MCI_PWR_UP,
@@ -93,6 +105,10 @@ static struct variant_data variant_u300 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg_enable		= MCI_ST_U300_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
@@ -113,6 +129,10 @@ static struct variant_data variant_nomadik = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
@@ -136,6 +156,10 @@ static struct variant_data variant_ux500 = {
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
@@ -163,6 +187,10 @@ static struct variant_data variant_ux500v2 = {
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
@@ -192,6 +220,10 @@ static struct variant_data variant_stm32 = {
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
@@ -212,6 +244,10 @@ static struct variant_data variant_qcom = {
 				  MCI_QCOM_CLK_SELECT_IN_FBCLK,
 	.clkreg_8bit_bus_enable = MCI_QCOM_CLK_WIDEBUS_8,
 	.datactrl_mask_ddrmode	= MCI_QCOM_CLK_SELECT_IN_DDR_MODE,
+	.cmdreg_cpsm_enable	= MCI_CPSM_ENABLE,
+	.cmdreg_lrsp_crc	= MCI_CPSM_RESPONSE | MCI_CPSM_LONGRSP,
+	.cmdreg_srsp_crc	= MCI_CPSM_RESPONSE,
+	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
 	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
@@ -1010,16 +1046,19 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
 	    cmd->opcode, cmd->arg, cmd->flags);
 
-	if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
+	if (readl(base + MMCICOMMAND) & host->variant->cmdreg_cpsm_enable) {
 		writel(0, base + MMCICOMMAND);
 		mmci_reg_delay(host);
 	}
 
-	c |= cmd->opcode | MCI_CPSM_ENABLE;
+	c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136)
-			c |= MCI_CPSM_LONGRSP;
-		c |= MCI_CPSM_RESPONSE;
+			c |= host->variant->cmdreg_lrsp_crc;
+		else if (cmd->flags & MMC_RSP_CRC)
+			c |= host->variant->cmdreg_srsp_crc;
+		else
+			c |= host->variant->cmdreg_srsp;
 	}
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 8aafafd..e49aba3 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -204,6 +204,10 @@ struct mmci_host;
  * @clkreg_enable: enable value for MMCICLOCK register
  * @clkreg_8bit_bus_enable: enable value for 8 bit bus
  * @clkreg_neg_edge_enable: enable value for inverted data/cmd output
+ * @cmdreg_cpsm_enable: enable value for CPSM
+ * @cmdreg_lrsp_crc: enable value for long response with crc
+ * @cmdreg_srsp_crc: enable value for short response with crc
+ * @cmdreg_srsp: enable value for short response without crc
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
@@ -243,6 +247,10 @@ struct variant_data {
 	unsigned int		clkreg_enable;
 	unsigned int		clkreg_8bit_bus_enable;
 	unsigned int		clkreg_neg_edge_enable;
+	unsigned int		cmdreg_cpsm_enable;
+	unsigned int		cmdreg_lrsp_crc;
+	unsigned int		cmdreg_srsp_crc;
+	unsigned int		cmdreg_srsp;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
-- 
2.7.4

