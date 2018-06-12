Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2AC1EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5EA208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5EA208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934223AbeFLNSu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:18:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:64992 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934005AbeFLNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:16:50 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5CDE3wc017831;
        Tue, 12 Jun 2018 15:16:06 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jjegrr43v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Jun 2018 15:16:06 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4460848;
        Tue, 12 Jun 2018 13:16:03 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF5FEA543;
        Tue, 12 Jun 2018 13:16:01 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:16:01 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:16:01 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 11/19] mmc: mmci: add variant property to check specific data constraint
Date:   Tue, 12 Jun 2018 15:14:32 +0200
Message-ID: <1528809280-31116-12-git-send-email-ludovic.Barre@st.com>
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

This patch adds a function pointer to check specific data constraint
follow hardware variant. Needed to support the STM32 sdmmc variant
which has alignment constraint.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 5 +++++
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index abddad7..9c00804 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -312,6 +312,8 @@ static int mmci_card_busy(struct mmc_host *mmc)
 static int mmci_validate_data(struct mmci_host *host,
 			      struct mmc_data *data)
 {
+	struct variant_data *variant = host->variant;
+
 	if (!data)
 		return 0;
 
@@ -321,6 +323,9 @@ static int mmci_validate_data(struct mmci_host *host,
 		return -EINVAL;
 	}
 
+	if (variant->validate_data)
+		return variant->validate_data(host, data);
+
 	return 0;
 }
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 12ee2e6..30d3f53 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -284,6 +284,7 @@ struct mmci_host;
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @mmci_dma: Pointer to platform-specific DMA callbacks.
+ * @validate_data: if hardware block has specific constraint on validate data
  * @set_clk_ios: if clock procedure of variant is specific
  * @set_pwr_ios: if power procedure of variant is specific
  */
@@ -328,6 +329,7 @@ struct variant_data {
 	u32			start_err;
 	u32			opendrain;
 	struct mmci_dma_ops	*mmci_dma;
+	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
 	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
 	void (*set_pwrreg)(struct mmci_host *host, unsigned char power_mode,
 			   unsigned int pwr);
-- 
2.7.4

