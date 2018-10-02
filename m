Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A8C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464D2205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464D2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeJBSxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:53:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40779 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727768AbeJBSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:53:13 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w92C8egX013766;
        Tue, 2 Oct 2018 14:10:02 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh6gsmw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 14:10:02 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9969C34;
        Tue,  2 Oct 2018 12:10:01 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7EB6C2A3B;
        Tue,  2 Oct 2018 12:10:01 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:10:01 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:10:00 +0200
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
Subject: [PATCH V4 18/25] mmc: mmci: add variant property to write datactrl before command
Date:   Tue, 2 Oct 2018 14:09:20 +0200
Message-ID: <1538482167-13819-19-git-send-email-ludovic.Barre@st.com>
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

This patch adds a boolean property to allow to write datactrl
before to send command, whatever the command type (read or write).
Needed to support the STM32 sdmmc variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 6 ++++--
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index ac33d23..e639841 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1262,7 +1262,8 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		mmci_request_end(host, host->mrq);
 	} else if (sbc) {
 		mmci_start_command(host, host->mrq->cmd, 0);
-	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
+	} else if (!host->variant->datactrl_first &&
+		   !(cmd->data->flags & MMC_DATA_READ)) {
 		mmci_start_data(host, cmd->data);
 	}
 }
@@ -1526,7 +1527,8 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->data)
 		mmci_get_next_data(host, mrq->data);
 
-	if (mrq->data && mrq->data->flags & MMC_DATA_READ)
+	if (mrq->data &&
+	    (host->variant->datactrl_first || mrq->data->flags & MMC_DATA_READ))
 		mmci_start_data(host, mrq->data);
 
 	if (mrq->sbc)
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 4b10c82..4e5c6c6 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -223,6 +223,7 @@ struct mmci_host;
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
  * @datactrl_blksz: block size in power of two
  * @datactrl_dpsm_enable: enable value for DPSM
+ * @datactrl_first: true if data must be setup before send command
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @f_max: maximum clk frequency supported by the controller.
  * @signal_direction: input/out direction of bus signals can be indicated
@@ -262,6 +263,7 @@ struct variant_data {
 	unsigned int		datactrl_mask_sdio;
 	unsigned int		datactrl_blocksz;
 	unsigned int		datactrl_dpsm_enable;
+	u8			datactrl_first:1;
 	u8			st_sdio:1;
 	u8			st_clkdiv:1;
 	u8			blksz_datactrl16:1;
-- 
2.7.4

