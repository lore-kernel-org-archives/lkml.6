Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E37FDC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988F4208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988F4208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934159AbeFLNQ6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:16:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46304 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934077AbeFLNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:16:54 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5CDE9FY017844;
        Tue, 12 Jun 2018 15:16:09 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jjegrr44h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Jun 2018 15:16:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 00B433A;
        Tue, 12 Jun 2018 13:16:08 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5932A543;
        Tue, 12 Jun 2018 13:16:08 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:16:08 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:16:08 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 18/19] mmc: mmci: add specific clk/pwr procedure for stm32 sdmmc
Date:   Tue, 12 Jun 2018 15:14:39 +0200
Message-ID: <1528809280-31116-19-git-send-email-ludovic.Barre@st.com>
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

This patch adds specific clock and power ios for stm32 sdmmc variant.
power ios: stm32 dedicated procedure must be done to perform power
off/on procedures. To power off, the sdmmc must be reset and set
to power cycle state before to disabling vqmmc. This drives low
SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK to prevent the Card from
being supplied through the signal lines.
To power on, set the SDMMC in power-off SDMMC_D[7:0], SDMMC_CMD
and SDMMC_CK are driven high. Then we can set the SDMMC to
Power-on state.

clock ios: specific bits behavior:
-clock divider card_clk = mclk / (2 * clkdiv)
-ddr activation
-wide bus 1/4/8bits
-bus speed
-receive clock selection (in_ck/ck_in/fb_ck)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 86aef4f..af27a0a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -50,6 +50,10 @@
 
 static unsigned int fmax = 515633;
 
+static void mmci_sdmmc_set_pwrreg(struct mmci_host *host,
+				  unsigned char power_mode, unsigned int pwr);
+static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired);
+
 static struct variant_data variant_arm = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -490,6 +494,114 @@ static void mmci_set_pwrreg(struct mmci_host *host, unsigned char power_mode,
 	mmci_write_pwrreg(host, pwr);
 }
 
+static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
+{
+	unsigned int clk = 0, ddr = 0;
+
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_DDR52 ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
+		ddr = MCI_STM32_CLK_DDR;
+
+	/*
+	 * cclk = mclk / (2 * clkdiv)
+	 * clkdiv 0 => bypass
+	 * in ddr mode bypass is not possible
+	 */
+	if (desired) {
+		if (desired >= host->mclk && !ddr) {
+			host->cclk = host->mclk;
+		} else {
+			clk = DIV_ROUND_UP(host->mclk, 2 * desired);
+			if (clk > MCI_STM32_CLK_CLKDIV_MSK)
+				clk = MCI_STM32_CLK_CLKDIV_MSK;
+			host->cclk = host->mclk / (2 * clk);
+		}
+	}
+
+	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4)
+		clk |= MCI_STM32_CLK_WIDEBUS_4;
+	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
+		clk |= MCI_STM32_CLK_WIDEBUS_8;
+
+	clk |= MCI_STM32_CLK_HWFCEN;
+	clk |= host->clk_reg_add;
+	clk |= ddr;
+
+	/*
+	 * SDMMC_FBCK is selected when an external Delay Block is needed
+	 * with SDR104.
+	 */
+	if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50) {
+		clk |= MCI_STM32_CLK_BUSSPEED;
+		if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104) {
+			clk &= ~MCI_STM32_CLK_SEL_MSK;
+			clk |= MCI_STM32_CLK_SELFBCK;
+		}
+	}
+
+	mmci_write_clkreg(host, clk);
+}
+
+static void mmci_sdmmc_set_pwrreg(struct mmci_host *host,
+				  unsigned char power_mode, unsigned int pwr)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	pwr |= host->pwr_reg_add;
+
+	switch (power_mode) {
+	case MMC_POWER_OFF:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
+		/* Only a reset could disable sdmmc */
+		reset_control_assert(host->rst);
+		udelay(2);
+		reset_control_deassert(host->rst);
+
+		/* default mask (probe) must be activated */
+		writel(MCI_IRQENABLE | host->variant->start_err,
+		       host->base + MMCIMASK0);
+
+		/*
+		 * Set the SDMMC in Power-cycle state before to disabling vqmmc.
+		 * This will make that the SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK
+		 * are driven low, to prevent the Card from being supplied
+		 * through the signal lines.
+		 */
+		mmci_write_pwrreg(host, MCI_STM32_PWR_CYC | pwr);
+
+		if (!IS_ERR(host->mmc->supply.vqmmc) && host->vqmmc_enabled) {
+			regulator_disable(host->mmc->supply.vqmmc);
+			host->vqmmc_enabled = false;
+		}
+		break;
+	case MMC_POWER_UP:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+					      mmc->ios.vdd);
+		break;
+	case MMC_POWER_ON:
+		if (!IS_ERR(host->mmc->supply.vqmmc) && !host->vqmmc_enabled) {
+			if (regulator_enable(host->mmc->supply.vqmmc) < 0)
+				dev_err(mmc_dev(host->mmc),
+					"failed to enable vqmmc regulator\n");
+			else
+				host->vqmmc_enabled = true;
+		}
+
+		/*
+		 * After a power-cycle state, we must set the SDMMC in
+		 * Power-off. The SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are
+		 * driven high. Then we can set the SDMMC to Power-on state
+		 */
+		mmci_write_pwrreg(host, MCI_PWR_OFF | pwr);
+		mdelay(1);
+		mmci_write_pwrreg(host, MCI_PWR_ON | pwr);
+		break;
+	}
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
-- 
2.7.4

