Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE25BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3E2205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3E2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeJBSyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:54:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13547 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727809AbeJBSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:53:13 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w92C8gou013788;
        Tue, 2 Oct 2018 14:10:07 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh6gsnp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 14:10:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4072A31;
        Tue,  2 Oct 2018 12:10:06 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 043792A42;
        Tue,  2 Oct 2018 12:10:06 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:10:05 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:10:05 +0200
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
Subject: [PATCH V4 22/25] mmc: mmci: add clock divider for stm32 sdmmc
Date:   Tue, 2 Oct 2018 14:09:24 +0200
Message-ID: <1538482167-13819-23-git-send-email-ludovic.Barre@st.com>
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

The STM32 sdmmc variant has a different clock divider.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 2 ++
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0898cc9..0421e18 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1857,6 +1857,8 @@ static int mmci_probe(struct amba_device *dev,
 	 */
 	if (variant->st_clkdiv)
 		mmc->f_min = DIV_ROUND_UP(host->mclk, 257);
+	else if (variant->stm32_clkdiv)
+		mmc->f_min = DIV_ROUND_UP(host->mclk, 2046);
 	else if (variant->explicit_mclk_control)
 		mmc->f_min = clk_round_rate(host->clk, 100000);
 	else
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index f793426..1520289 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -216,6 +216,7 @@ struct mmci_host;
  * @data_cmd_enable: enable value for data commands.
  * @st_sdio: enable ST specific SDIO logic
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
+ * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
  * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
  * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
@@ -269,6 +270,7 @@ struct variant_data {
 	u8			datacnt_useless:1;
 	u8			st_sdio:1;
 	u8			st_clkdiv:1;
+	u8			stm32_clkdiv:1;
 	u8			blksz_datactrl16:1;
 	u8			blksz_datactrl4:1;
 	u32			pwrreg_powerup;
-- 
2.7.4

