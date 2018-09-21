Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03183ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF7621531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF7621531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbeIUPfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:35:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56394 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389739AbeIUPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:35:17 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9hw2q025556;
        Fri, 21 Sep 2018 11:46:55 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mmkmr380c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:55 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82BE231;
        Fri, 21 Sep 2018 09:46:54 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 61AA42AC3;
        Fri, 21 Sep 2018 09:46:54 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:54 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:54 +0200
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
Subject: [PATCH V2 23/27] mmc: mmci: add variant property to request a reset
Date:   Fri, 21 Sep 2018 11:46:17 +0200
Message-ID: <1537523181-14578-24-git-send-email-ludovic.Barre@st.com>
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

Some variants could require a reset.
STM32 sdmmc variant needs to reset hardware block
during the power cycle procedure (for re-initialization)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
 drivers/mmc/host/mmci.c                        | 9 +++++++++
 drivers/mmc/host/mmci.h                        | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 03796cf..e952707 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -11,6 +11,8 @@ Required properties:
 - compatible             : contains "arm,pl18x", "arm,primecell".
 - vmmc-supply            : phandle to the regulator device tree node, mentioned
                            as the VCC/VDD supply in the eMMC/SD specs.
+depend of variant:
+- resets                 : phandle to internal reset line.
 
 Optional properties:
 - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b1d5bc5..6b3c33f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -37,6 +37,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/reset.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -1854,6 +1855,14 @@ static int mmci_probe(struct amba_device *dev,
 
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
+	if (variant->reset) {
+		host->rst = devm_reset_control_get_exclusive(&dev->dev, NULL);
+		if (IS_ERR(host->rst)) {
+			ret = PTR_ERR(host->rst);
+			goto clk_disable;
+		}
+	}
+
 	/* Get regulators and the supported OCR mask */
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index e130689..f0fa185 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -247,6 +247,7 @@ struct mmci_host;
  * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
+ * @reset: true if variant has need reset signal.
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -285,6 +286,7 @@ struct variant_data {
 	bool			qcom_dml;
 	bool			reversed_irq_handling;
 	bool			mmcimask1;
+	bool			reset;
 	unsigned int		irq_pio_mask;
 	u32			start_err;
 	u32			opendrain;
@@ -318,6 +320,8 @@ struct mmci_host {
 	struct clk		*clk;
 	bool			singleirq;
 
+	struct reset_control	*rst;
+
 	spinlock_t		lock;
 
 	unsigned int		mclk;
-- 
2.7.4

