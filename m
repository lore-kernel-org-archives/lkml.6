Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8882C676C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85CC2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85CC2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJHTVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:21:24 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17928 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbeJHTVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:21:23 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w98C4RZN024182;
        Mon, 8 Oct 2018 14:09:44 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mxjgxjvbj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Oct 2018 14:09:44 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6C06D3D;
        Mon,  8 Oct 2018 12:09:43 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E2372D01;
        Mon,  8 Oct 2018 12:09:43 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 8 Oct 2018
 14:09:43 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 8 Oct 2018
 14:09:42 +0200
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
Subject: [PATCH V6 12/23] mmc: mmci: expand startbiterr to irqmask and error check
Date:   Mon, 8 Oct 2018 14:08:44 +0200
Message-ID: <1539000535-13261-13-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

All variants don't pretend to have a startbiterr.
-While data error check, if status register return an error
(like  MCI_DATACRCFAIL) we must avoid to check MCI_STARTBITERR
(if not desired).
-expand start_err to MCI_IRQENABLE to avoid to set this bit by default.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 27 ++++++++++++++++-----------
 drivers/mmc/host/mmci.h |  6 +++---
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0e8b65d..737adf4 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1042,14 +1042,18 @@ static void
 mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
+	unsigned int status_err;
+
 	/* Make sure we have data to handle */
 	if (!data)
 		return;
 
 	/* First check for errors */
-	if (status & (MCI_DATACRCFAIL | MCI_DATATIMEOUT |
-		      host->variant->start_err |
-		      MCI_TXUNDERRUN | MCI_RXOVERRUN)) {
+	status_err = status & (host->variant->start_err |
+			       MCI_DATACRCFAIL | MCI_DATATIMEOUT |
+			       MCI_TXUNDERRUN | MCI_RXOVERRUN);
+
+	if (status_err) {
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
@@ -1066,18 +1070,18 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		success = data->blksz * data->blocks - remain;
 
 		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ, status 0x%08x at 0x%08x\n",
-			status, success);
-		if (status & MCI_DATACRCFAIL) {
+			status_err, success);
+		if (status_err & MCI_DATACRCFAIL) {
 			/* Last block was not successful */
 			success -= 1;
 			data->error = -EILSEQ;
-		} else if (status & MCI_DATATIMEOUT) {
+		} else if (status_err & MCI_DATATIMEOUT) {
 			data->error = -ETIMEDOUT;
-		} else if (status & MCI_STARTBITERR) {
+		} else if (status_err & MCI_STARTBITERR) {
 			data->error = -ECOMM;
-		} else if (status & MCI_TXUNDERRUN) {
+		} else if (status_err & MCI_TXUNDERRUN) {
 			data->error = -EIO;
-		} else if (status & MCI_RXOVERRUN) {
+		} else if (status_err & MCI_RXOVERRUN) {
 			if (success > host->variant->fifosize)
 				success -= host->variant->fifosize;
 			else
@@ -1918,7 +1922,7 @@ static int mmci_probe(struct amba_device *dev,
 			goto clk_disable;
 	}
 
-	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+	writel(MCI_IRQENABLE | variant->start_err, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
 
@@ -2005,7 +2009,8 @@ static void mmci_restore(struct mmci_host *host)
 		writel(host->datactrl_reg, host->base + MMCIDATACTRL);
 		writel(host->pwr_reg, host->base + MMCIPOWER);
 	}
-	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+	writel(MCI_IRQENABLE | host->variant->start_err,
+	       host->base + MMCIMASK0);
 	mmci_reg_delay(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d5979e8..8e7ea44 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -181,9 +181,9 @@
 #define MMCIFIFO		0x080 /* to 0x0bc */
 
 #define MCI_IRQENABLE	\
-	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
-	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
-	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_STARTBITERRMASK)
+	(MCI_CMDCRCFAILMASK | MCI_DATACRCFAILMASK | MCI_CMDTIMEOUTMASK | \
+	MCI_DATATIMEOUTMASK | MCI_TXUNDERRUNMASK | MCI_RXOVERRUNMASK |	\
+	MCI_CMDRESPENDMASK | MCI_CMDSENTMASK)
 
 /* These interrupts are directed to IRQ1 when two IRQ lines are available */
 #define MCI_IRQ1MASK \
-- 
2.7.4

