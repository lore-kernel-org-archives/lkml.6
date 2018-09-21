Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0451C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6476421531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6476421531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbeIUPfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:35:12 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43196 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389010AbeIUPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:34:57 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9jK4O001508;
        Fri, 21 Sep 2018 11:46:37 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkn0u88j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:37 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC9FF42;
        Fri, 21 Sep 2018 09:46:36 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7422D2ACC;
        Fri, 21 Sep 2018 09:46:36 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:36 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:35 +0200
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
Subject: [PATCH V2 06/27] mmc: mmci: merge prepare data functions
Date:   Fri, 21 Sep 2018 11:46:00 +0200
Message-ID: <1537523181-14578-7-git-send-email-ludovic.Barre@st.com>
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

This patch merges the prepare data functions.
This allows to define a single access to prepare data service.
This prepares integration for mmci host ops.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
change v2:
-rename to mmci_prep/unprep_data

 drivers/mmc/host/mmci.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 43f2a1a..0cbe71c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -652,10 +652,14 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 }
 
 static inline int mmci_dma_prep_data(struct mmci_host *host,
-				     struct mmc_data *data)
+				     struct mmc_data *data,
+				     bool next)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
+	struct mmci_dmae_next *nd = &dmae->next_data;
 
+	if (next)
+		return __mmci_dma_prep_data(host, data, &nd->chan, &nd->desc);
 	/* Check if next job is already prepared. */
 	if (dmae->cur && dmae->desc_current)
 		return 0;
@@ -665,22 +669,13 @@ static inline int mmci_dma_prep_data(struct mmci_host *host,
 				    &dmae->desc_current);
 }
 
-static inline int mmci_dma_prep_next(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-	struct mmci_dmae_priv *dmae = host->dma_priv;
-	struct mmci_dmae_next *nd = &dmae->next_data;
-
-	return __mmci_dma_prep_data(host, data, &nd->chan, &nd->desc);
-}
-
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = host->data;
 	int ret;
 
-	ret = mmci_dma_prep_data(host, host->data);
+	ret = mmci_dma_prep_data(host, host->data, false);
 	if (ret)
 		return ret;
 
@@ -737,7 +732,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mmci_validate_data(host, data))
 		return;
 
-	if (!mmci_dma_prep_next(host, data))
+	if (!mmci_dma_prep_data(host, data, true))
 		data->host_cookie = ++host->next_cookie < 0 ?
 			1 : host->next_cookie;
 }
-- 
2.7.4

