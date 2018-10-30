Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07482C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04E420827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04E420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJ3TK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:10:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44637 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbeJ3TK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:10:28 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9UAEYL6014434;
        Tue, 30 Oct 2018 11:16:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nen67gbpa-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Oct 2018 11:16:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 19B6434;
        Tue, 30 Oct 2018 10:16:58 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD2372991;
        Tue, 30 Oct 2018 10:16:57 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 30 Oct
 2018 11:16:57 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 30 Oct
 2018 11:16:57 +0100
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
Subject: [PATCH] mmc: mmci: add variant property to send stop cmd if a command fail
Date:   Tue, 30 Oct 2018 11:16:29 +0100
Message-ID: <1540894589-4004-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

The mmc framework follows the requirement of SD_Specification:
the STOP_TRANSMISSION is sent on multiple write/read commands
and the stop command (alone), not needed on other ADTC commands.

But, if an error happens on command or data step, some variants
require a stop command "STOP_TRANSMISION" to clear the DPSM
"Data Path State Machine". If it's not done the next data
command freezes hardware block.
Needed to support the STM32 sdmmc variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 33 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 19650ed..ecedca3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/highmem.h>
 #include <linux/log2.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/pm.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -57,6 +58,8 @@ void sdmmc_variant_init(struct mmci_host *host);
 #else
 static inline void sdmmc_variant_init(struct mmci_host *host) {}
 #endif
+static void
+mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c);
 
 static unsigned int fmax = 515633;
 
@@ -274,6 +277,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.cmdreg_lrsp_crc	= MCI_CPSM_STM32_LRSP_CRC,
 	.cmdreg_srsp_crc	= MCI_CPSM_STM32_SRSP_CRC,
 	.cmdreg_srsp		= MCI_CPSM_STM32_SRSP,
+	.cmdreg_stop		= MCI_CPSM_STM32_CMDSTOP,
 	.data_cmd_enable	= MCI_CPSM_STM32_CMDTRANS,
 	.irq_pio_mask		= MCI_IRQ_PIO_STM32_MASK,
 	.datactrl_first		= true,
@@ -574,6 +578,24 @@ void mmci_dma_error(struct mmci_host *host)
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
+	/*
+	 * If an error happens on command or data step, some variants
+	 * require a stop command to reinit the DPSM.
+	 * If it's not done the next data command freeze hardware block.
+	 */
+	if (host->variant->cmdreg_stop) {
+		u32 dpsm;
+
+		dpsm = readl_relaxed(host->base + MMCISTATUS);
+		dpsm &= MCI_STM32_DPSMACTIVE;
+
+		if (dpsm && ((mrq->cmd && mrq->cmd->error) ||
+			     (mrq->data && mrq->data->error))) {
+			mmci_start_command(host, &host->stop_abort, 0);
+			return;
+		}
+	}
+
 	writel(0, host->base + MMCICOMMAND);
 
 	BUG_ON(host->data);
@@ -1106,6 +1128,10 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 		mmci_reg_delay(host);
 	}
 
+	if (host->variant->cmdreg_stop &&
+	    cmd->opcode == MMC_STOP_TRANSMISSION)
+		c |= host->variant->cmdreg_stop;
+
 	c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136)
@@ -1957,6 +1983,13 @@ static int mmci_probe(struct amba_device *dev,
 		mmc->max_busy_timeout = 0;
 	}
 
+	/* prepare the stop command, used to abort and reinitialized the DPSM */
+	if (variant->cmdreg_stop) {
+		host->stop_abort.opcode = MMC_STOP_TRANSMISSION;
+		host->stop_abort.arg = 0;
+		host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	}
+
 	mmc->ops = &mmci_ops;
 
 	/* We support these PM capabilities. */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index ec13d90..afb6ec4 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -166,6 +166,7 @@
 #define MCI_ST_CEATAEND		(1 << 23)
 #define MCI_ST_CARDBUSY		(1 << 24)
 /* Extended status bits for the STM32 variants */
+#define MCI_STM32_DPSMACTIVE	BIT(12)
 #define MCI_STM32_BUSYD0	BIT(20)
 
 #define MMCICLEAR		0x038
@@ -269,6 +270,7 @@ struct mmci_host;
  * @cmdreg_lrsp_crc: enable value for long response with crc
  * @cmdreg_srsp_crc: enable value for short response with crc
  * @cmdreg_srsp: enable value for short response without crc
+ * @cmdreg_stop: enable value for stop and abort transmission
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
@@ -322,6 +324,7 @@ struct variant_data {
 	unsigned int		cmdreg_lrsp_crc;
 	unsigned int		cmdreg_srsp_crc;
 	unsigned int		cmdreg_srsp;
+	unsigned int		cmdreg_stop;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
@@ -384,6 +387,7 @@ struct mmci_host {
 	void __iomem		*base;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
+	struct mmc_command	stop_abort;
 	struct mmc_data		*data;
 	struct mmc_host		*mmc;
 	struct clk		*clk;
-- 
2.7.4

