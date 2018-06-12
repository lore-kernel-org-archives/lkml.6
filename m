Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1187C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67132208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67132208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934209AbeFLNSb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:18:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56943 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934006AbeFLNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:16:50 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5CDDbPY008981;
        Tue, 12 Jun 2018 15:16:08 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jj63btf2m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Jun 2018 15:16:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89AD234;
        Tue, 12 Jun 2018 13:16:04 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA88AA54A;
        Tue, 12 Jun 2018 13:16:03 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:16:03 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:16:03 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 13/19] mmc: mmci: send stop cmd if a data command fail
Date:   Tue, 12 Jun 2018 15:14:34 +0200
Message-ID: <1528809280-31116-14-git-send-email-ludovic.Barre@st.com>
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

The mmc framework follows the requirement of SD_Specification:
the STOP_TRANSMISSION is sent on multiple write/read commands
and the stop command (alone), not needed on other ADTC commands.

But, some variants require a stop command "STOP_TRANSMISION" to clear
the DPSM "Data Path State Machine" if an error happens on command or data
step. If it's not done the next data command will freeze hardware block.
Needed to support the STM32 sdmmc variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 36 +++++++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h |  3 +++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 87724e1..9af7db8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -24,6 +24,7 @@
 #include <linux/mmc/pm.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
@@ -522,11 +523,28 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
 	host->mask1_reg = mask;
 }
 
-static void mmci_stop_data(struct mmci_host *host)
+static int mmci_stop_data(struct mmci_host *host)
 {
+	struct mmc_command *stop = &host->stop_abort;
+	struct mmc_data *data = host->data;
+	unsigned int cmd = 0;
+
 	mmci_write_datactrlreg(host, 0);
 	mmci_set_mask1(host, 0);
 	host->data = NULL;
+
+	if (host->variant->cmdreg_stop) {
+		cmd |= host->variant->cmdreg_stop;
+		if (!data->stop) {
+			memset(stop, 0, sizeof(struct mmc_command));
+			stop->opcode = MMC_STOP_TRANSMISSION;
+			stop->arg = 0;
+			stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
+			data->stop = stop;
+		}
+	}
+
+	return cmd;
 }
 
 static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
@@ -703,6 +721,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
 	unsigned int status_err;
+	unsigned int cmd_reg = 0;
 
 	/* Make sure we have data to handle */
 	if (!data)
@@ -761,7 +780,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	if (status & MCI_DATAEND || data->error) {
 		mmci_dma_finalize(host, data);
 
-		mmci_stop_data(host);
+		cmd_reg = mmci_stop_data(host);
 
 		if (!data->error)
 			/* The error clause is handled above, success! */
@@ -770,7 +789,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		if (!data->stop || host->mrq->sbc) {
 			mmci_request_end(host, data->mrq);
 		} else {
-			mmci_start_command(host, data->stop, 0);
+			mmci_start_command(host, data->stop, cmd_reg);
 		}
 	}
 }
@@ -780,6 +799,8 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	     unsigned int status)
 {
 	void __iomem *base = host->base;
+	struct mmc_data *data = host->data;
+	unsigned int cmd_reg = 0;
 	bool sbc;
 
 	if (!cmd)
@@ -865,11 +886,16 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	}
 
 	if ((!sbc && !cmd->data) || cmd->error) {
-		if (host->data) {
+		if (data) {
 			/* Terminate the DMA transfer */
 			mmci_dma_error(host);
 
-			mmci_stop_data(host);
+			cmd_reg = mmci_stop_data(host);
+
+			if (data->stop) {
+				mmci_start_command(host, data->stop, cmd_reg);
+				return;
+			}
 		}
 		mmci_request_end(host, host->mrq);
 	} else if (sbc) {
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 2d7e901..4b4cd1d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -243,6 +243,7 @@ struct mmci_host;
  * @cmdreg_lrsp_crc: enable value for long response with crc
  * @cmdreg_srsp_crc: enable value for short response with crc
  * @cmdreg_srsp: enable value for short response without crc
+ * @cmdreg_stop: enable value for stop and abort transmission
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
@@ -298,6 +299,7 @@ struct variant_data {
 	unsigned int		cmdreg_lrsp_crc;
 	unsigned int		cmdreg_srsp_crc;
 	unsigned int		cmdreg_srsp;
+	unsigned int		cmdreg_stop;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
@@ -343,6 +345,7 @@ struct mmci_host {
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
+	struct mmc_command	stop_abort;
 	struct mmc_host		*mmc;
 	struct clk		*clk;
 	bool			singleirq;
-- 
2.7.4

