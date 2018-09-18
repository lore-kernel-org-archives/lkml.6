Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03752ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC07220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC07220C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeIRQ3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:29:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55580 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729678AbeIRQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:29:01 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8IAsMQG004533;
        Tue, 18 Sep 2018 12:56:18 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mgryf0w5p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Sep 2018 12:56:18 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D40D53A;
        Tue, 18 Sep 2018 10:56:17 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B30732A9E;
        Tue, 18 Sep 2018 10:56:17 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 18 Sep
 2018 12:56:17 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 18 Sep
 2018 12:56:17 +0200
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
Subject: [PATCH V2 08/27] mmc: mmci: add get_next_data callback
Date:   Tue, 18 Sep 2018 12:55:25 +0200
Message-ID: <1537268144-21152-9-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
References: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds get_next_data callback to mmci_host_ops.
Generic mmci_get_next_data factorizes next_cookie check and
the host ops call.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 16 ++++++++++------
 drivers/mmc/host/mmci.h          |  3 +++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5734c05..55c4222 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -390,6 +390,14 @@ void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
 	data->host_cookie = 0;
 }
 
+void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
+{
+	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
+
+	if (host->ops && host->ops->get_next_data)
+		host->ops->get_next_data(host, data);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -738,12 +746,11 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	return 0;
 }
 
-static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
+void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmci_dmae_next *next = &dmae->next_data;
 
-	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
 	WARN_ON(!data->host_cookie && (next->desc || next->chan));
 
 	dmae->desc_current = next->desc;
@@ -785,13 +792,10 @@ void mmci_dmae_unprep_data(struct mmci_host *host,
 static struct mmci_host_ops mmci_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_next_data = mmci_dmae_get_next_data,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
-{
-}
-
 static inline int mmci_dma_setup(struct mmci_host *host)
 {
 	return 0;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 61500cf..c0a84cf 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -277,6 +277,7 @@ struct mmci_host_ops {
 			 bool next);
 	void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
 			    int err);
+	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
 };
 
@@ -333,3 +334,5 @@ int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 			bool next);
 void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 			   int err);
+void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
+
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index e3cbdda..432a823 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -182,6 +182,7 @@ static int qcom_dma_setup(struct mmci_host *host)
 static struct mmci_host_ops qcom_variant_ops = {
 	.prep_data = mmci_dmae_prep_data,
 	.unprep_data = mmci_dmae_unprep_data,
+	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
 };
 
-- 
2.7.4

