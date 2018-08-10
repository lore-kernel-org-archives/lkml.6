Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD2C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEF921EFB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEF921EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbeHJUlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:41:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11402 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeHJUlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:41:02 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4ef0000>; Fri, 10 Aug 2018 11:09:51 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:10:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Aug 2018 11:10:00 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:10:05 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:10:05 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4fb0000>; Fri, 10 Aug 2018 11:10:05 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 25/40] mmc: sdhci: Add a quirk to disable card clock during tuning
Date:   Fri, 10 Aug 2018 21:08:27 +0300
Message-ID: <1533924522-1037-26-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk to disable card clock when the tuning command is sent.

This has to be done to prevent the SDHCI controller from hanging on
Tegra210. Without the quirk enabled there appears to be around 10%
chance that the tuning sequence will fail and time out due to the
controller locking up.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 15 +++++++++++++++
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 04dc443..166b16f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2175,6 +2175,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	struct mmc_request mrq = {};
 	unsigned long flags;
 	u32 b = host->sdma_boundary;
+	u16 clk;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -2183,6 +2184,13 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	cmd.mrq = &mrq;
 
 	mrq.cmd = &cmd;
+
+	if (host->quirks2 & SDHCI_QUIRK2_TUNE_DIS_CARD_CLK) {
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	}
+
 	/*
 	 * In response to CMD19, the card sends 64 bytes of tuning
 	 * block to the Host Controller. So we set the block size
@@ -2213,6 +2221,13 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	if (host->quirks2 & SDHCI_QUIRK2_TUNE_DIS_CARD_CLK) {
+		udelay(1);
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	}
+
 	/* Wait for Buffer Read Ready interrupt */
 	wait_event_timeout(host->buf_ready_int, (host->tuning_done == 1),
 			   msecs_to_jiffies(50));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a99008..cc411b0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -452,6 +452,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
 /* Don't clear the SDHCI_TRANSFER_MODE register on tuning commands */
 #define SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG	(1<<18)
+/* Disable card clock during tuning */
+#define SDHCI_QUIRK2_TUNE_DIS_CARD_CLK			(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4

