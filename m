Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92D0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A53205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A53205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeJBSz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:55:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51319 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727562AbeJBSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:53:04 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w92C8egV013766;
        Tue, 2 Oct 2018 14:09:54 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh6gskx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 14:09:54 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D2B3234;
        Tue,  2 Oct 2018 12:09:53 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7F902A3B;
        Tue,  2 Oct 2018 12:09:53 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:53 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:53 +0200
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
Subject: [PATCH V4 11/25] mmc: mmci: add validate_data callback
Date:   Tue, 2 Oct 2018 14:09:13 +0200
Message-ID: <1538482167-13819-12-git-send-email-ludovic.Barre@st.com>
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

This patch adds validate_data callback at mmci_host_ops
to check specific constraints of variant.
Move mmci_validate_data function to regroup mmci_host_ops interfaces.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 39 +++++++++++++++++++++------------------
 drivers/mmc/host/mmci.h |  1 +
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1835d77..c8fdb24 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -233,24 +233,6 @@ static int mmci_card_busy(struct mmc_host *mmc)
 	return busy;
 }
 
-/*
- * Validate mmc prerequisites
- */
-static int mmci_validate_data(struct mmci_host *host,
-			      struct mmc_data *data)
-{
-	if (!data)
-		return 0;
-
-	if (!is_power_of_2(data->blksz)) {
-		dev_err(mmc_dev(host->mmc),
-			"unsupported block size (%d bytes)\n", data->blksz);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void mmci_reg_delay(struct mmci_host *host)
 {
 	/*
@@ -384,6 +366,27 @@ void mmci_dma_release(struct mmci_host *host)
 		host->ops->dma_release(host);
 }
 
+/*
+ * Validate mmc prerequisites
+ */
+static int mmci_validate_data(struct mmci_host *host,
+			      struct mmc_data *data)
+{
+	if (!data)
+		return 0;
+
+	if (!is_power_of_2(data->blksz)) {
+		dev_err(mmc_dev(host->mmc),
+			"unsupported block size (%d bytes)\n", data->blksz);
+		return -EINVAL;
+	}
+
+	if (host->ops && host->ops->validate_data)
+		return host->ops->validate_data(host, data);
+
+	return 0;
+}
+
 int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
 {
 	int err;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 2c9e679..9e701d8 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -273,6 +273,7 @@ struct variant_data {
 
 /* mmci variant callbacks */
 struct mmci_host_ops {
+	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*prep_data)(struct mmci_host *host, struct mmc_data *data,
 			 bool next);
 	void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
-- 
2.7.4

