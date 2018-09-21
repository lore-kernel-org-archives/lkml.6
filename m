Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C257C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1DF21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1DF21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389702AbeIUPhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:37:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43247 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389313AbeIUPfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:35:16 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9jK4I001508;
        Fri, 21 Sep 2018 11:46:31 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkn0u882-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9473E31;
        Fri, 21 Sep 2018 09:46:30 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 67CFD2AC3;
        Fri, 21 Sep 2018 09:46:30 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:30 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:30 +0200
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
Subject: [PATCH V2 01/27] mmc: mmci: internalize dma map/unmap into mmci dma functions
Date:   Fri, 21 Sep 2018 11:45:55 +0200
Message-ID: <1537523181-14578-2-git-send-email-ludovic.Barre@st.com>
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

This patch internalizes the management of dma map/unmap into
mmci dma interfaces. This allows to simplify and prepare the next dma
callbacks for mmci host ops.
mmci_dma_unmap was called in mmci_data_irq & mmci_cmd_irq functions
and can be integrated in mmci_dma_data_error.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1841d250..bf0bb07 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -482,16 +482,6 @@ static inline void mmci_dma_release(struct mmci_host *host)
 	host->dma_rx_channel = host->dma_tx_channel = NULL;
 }
 
-static void mmci_dma_data_error(struct mmci_host *host)
-{
-	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
-	dmaengine_terminate_all(host->dma_current);
-	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
-	host->data->host_cookie = 0;
-}
-
 static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 {
 	struct dma_chan *chan;
@@ -505,6 +495,18 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 		     mmc_get_dma_dir(data));
 }
 
+static void mmci_dma_data_error(struct mmci_host *host)
+{
+	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
+	dmaengine_terminate_all(host->dma_current);
+	host->dma_in_progress = false;
+	host->dma_current = NULL;
+	host->dma_desc_current = NULL;
+	host->data->host_cookie = 0;
+
+	mmci_dma_unmap(host, host->data);
+}
+
 static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
 	u32 status;
@@ -528,10 +530,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 		mmci_dma_data_error(host);
 		if (!data->error)
 			data->error = -EIO;
-	}
-
-	if (!data->host_cookie)
+	} else if (!data->host_cookie) {
 		mmci_dma_unmap(host, data);
+	}
 
 	/*
 	 * Use of DMA with scatter-gather is impossible.
@@ -742,10 +743,6 @@ static inline void mmci_dma_release(struct mmci_host *host)
 {
 }
 
-static inline void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
-{
-}
-
 static inline void mmci_dma_finalize(struct mmci_host *host,
 				     struct mmc_data *data)
 {
@@ -906,10 +903,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
-		if (dma_inprogress(host)) {
+		if (dma_inprogress(host))
 			mmci_dma_data_error(host);
-			mmci_dma_unmap(host, data);
-		}
 
 		/*
 		 * Calculate how far we are into the transfer.  Note that
@@ -1055,10 +1050,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	if ((!sbc && !cmd->data) || cmd->error) {
 		if (host->data) {
 			/* Terminate the DMA transfer */
-			if (dma_inprogress(host)) {
+			if (dma_inprogress(host))
 				mmci_dma_data_error(host);
-				mmci_dma_unmap(host, host->data);
-			}
+
 			mmci_stop_data(host);
 		}
 		mmci_request_end(host, host->mrq);
-- 
2.7.4

