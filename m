Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F2EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA3420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA3420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbeHALWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:22:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37226 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388843AbeHALWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:22:51 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w719SV9M016568;
        Wed, 1 Aug 2018 11:37:37 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kgdxvjuxu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 11:37:37 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F81A31;
        Wed,  1 Aug 2018 09:37:37 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B487A2960;
        Wed,  1 Aug 2018 09:37:36 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:37 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Aug 2018
 11:37:35 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 13/14] mmc: mmci: add dma_error callback
Date:   Wed, 1 Aug 2018 11:37:00 +0200
Message-ID: <1533116221-380-14-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds dma_error callback at mmci_host_ops
to allow to call specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 20 +++++++++++---------
 drivers/mmc/host/mmci.h          |  2 ++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b124a73..d5ca93e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -453,6 +453,12 @@ void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 		host->ops->dma_finalize(host, data);
 }
 
+void mmci_dma_error(struct mmci_host *host)
+{
+	if (host->ops && host->ops->dma_error)
+		host->ops->dma_error(host);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -615,7 +621,7 @@ static void __mmci_dmae_unmap(struct mmci_host *host, struct mmc_data *data)
 		     mmc_get_dma_dir(data));
 }
 
-static void mmci_dma_data_error(struct mmci_host *host)
+void mmci_dmae_error(struct mmci_host *host)
 {
 	struct dmaengine_priv *dmae = host->dma_priv;
 
@@ -656,7 +662,7 @@ void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data)
 	 * contiguous buffers.  On TX, we'll get a FIFO underrun error.
 	 */
 	if (status & MCI_RXDATAAVLBLMASK) {
-		mmci_dma_data_error(host);
+		mmci_dma_error(host);
 		if (!data->error)
 			data->error = -EIO;
 	} else if (!data->host_cookie) {
@@ -827,13 +833,9 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
 	.dma_finalize = mmci_dmae_finalize,
+	.dma_error = mmci_dmae_error,
 };
 #else
-/* Blank functions if the DMA engine is not available */
-static inline void mmci_dma_data_error(struct mmci_host *host)
-{
-}
-
 static struct mmci_host_ops mmci_variant_ops = {};
 #endif
 
@@ -1011,7 +1013,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
-		mmci_dma_data_error(host);
+		mmci_dma_error(host);
 
 		/*
 		 * Calculate how far we are into the transfer.  Note that
@@ -1157,7 +1159,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	if ((!sbc && !cmd->data) || cmd->error) {
 		if (host->data) {
 			/* Terminate the DMA transfer */
-			mmci_dma_data_error(host);
+			mmci_dma_error(host);
 
 			mmci_stop_data(host);
 		}
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 3f482d5..0a4811d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -282,6 +282,7 @@ struct mmci_host_ops {
 	void (*dma_release)(struct mmci_host *host);
 	int (*dma_start)(struct mmci_host *host, unsigned int *datactrl);
 	void (*dma_finalize)(struct mmci_host *host, struct mmc_data *data);
+	void (*dma_error)(struct mmci_host *host);
 };
 
 struct mmci_host {
@@ -342,3 +343,4 @@ int mmci_dmae_setup(struct mmci_host *host);
 void mmci_dmae_release(struct mmci_host *host);
 int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl);
 void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data);
+void mmci_dmae_error(struct mmci_host *host);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index ba7e311..80701b4 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -189,6 +189,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
 	.dma_finalize = mmci_dmae_finalize,
+	.dma_error = mmci_dmae_error,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4

