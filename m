Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB31ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0440D21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0440D21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389719AbeIUPe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:34:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54899 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389681AbeIUPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:34:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9iYm9008885;
        Fri, 21 Sep 2018 11:46:32 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkmu38k4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7C7134;
        Fri, 21 Sep 2018 09:46:31 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D6F12AC3;
        Fri, 21 Sep 2018 09:46:31 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:31 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:31 +0200
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
Subject: [PATCH V2 02/27] mmc: mmci: internalize dma_inprogress into mmci dma functions
Date:   Fri, 21 Sep 2018 11:45:56 +0200
Message-ID: <1537523181-14578-3-git-send-email-ludovic.Barre@st.com>
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

This patch internalizes the dma_inprogress into mmci dma interfaces.
This allows to simplify and prepare the next dma callbacks
for mmci host ops. dma_inprogress is called in mmci_dma_data_error
and mmci_dma_finalize.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
change v3:
-remove __dma_inprogress rename

 drivers/mmc/host/mmci.c | 16 ++++++++++------
 drivers/mmc/host/mmci.h |  2 --
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index bf0bb07..cbd67bc 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -497,6 +497,9 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
+	if (!dma_inprogress(host))
+		return;
+
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
 	dmaengine_terminate_all(host->dma_current);
 	host->dma_in_progress = false;
@@ -512,6 +515,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 	u32 status;
 	int i;
 
+	if (!dma_inprogress(host))
+		return;
+
 	/* Wait up to 1ms for the DMA to complete */
 	for (i = 0; ; i++) {
 		status = readl(host->base + MMCISTATUS);
@@ -903,8 +909,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
-		if (dma_inprogress(host))
-			mmci_dma_data_error(host);
+		mmci_dma_data_error(host);
 
 		/*
 		 * Calculate how far we are into the transfer.  Note that
@@ -942,8 +947,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
 	if (status & MCI_DATAEND || data->error) {
-		if (dma_inprogress(host))
-			mmci_dma_finalize(host, data);
+		mmci_dma_finalize(host, data);
+
 		mmci_stop_data(host);
 
 		if (!data->error)
@@ -1050,8 +1055,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	if ((!sbc && !cmd->data) || cmd->error) {
 		if (host->data) {
 			/* Terminate the DMA transfer */
-			if (dma_inprogress(host))
-				mmci_dma_data_error(host);
+			mmci_dma_data_error(host);
 
 			mmci_stop_data(host);
 		}
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 517591d..21aaf9a 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -333,8 +333,6 @@ struct mmci_host {
 	bool			dma_in_progress;
 
 #define dma_inprogress(host)	((host)->dma_in_progress)
-#else
-#define dma_inprogress(host)	(0)
 #endif
 };
 
-- 
2.7.4

