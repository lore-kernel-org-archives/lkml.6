Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C81C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9250208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9250208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbeHASTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:19:48 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3125 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390206AbeHASTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:19:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b61e0bf000b>; Wed, 01 Aug 2018 09:33:03 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Aug 2018 09:33:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Aug 2018 09:33:15 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Aug
 2018 16:33:14 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 1 Aug 2018 16:33:14 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b61e0c80001>; Wed, 01 Aug 2018 09:33:14 -0700
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
Subject: [PATCH 11/40] mmc: sdhci: Add a quirk to skip clearing the transfer mode register on tuning
Date:   Wed, 1 Aug 2018 19:32:01 +0300
Message-ID: <1533141150-10511-12-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SDHCI_QUIRK2_TUNE_SKIP_XFERRMODE_REG_PROG to skip programming the
SDHCI_TRANSFER_MODE in sdhci_set_transfer_mode() if tuning command is
being sent.

On Tegra210 and Tegra186 the tuning sequence hangs if the SDHCI
transfer mode register is touched.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 6 ++++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a7b5602..04dc443 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1028,6 +1028,12 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
 	if (data == NULL) {
 		if (host->quirks2 &
+			SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG &&
+				(cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+				 cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)) {
+			return;
+		}
+		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
 			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..0a99008 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -450,6 +450,8 @@ struct sdhci_host {
  * obtainable timeout.
  */
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+/* Don't clear the SDHCI_TRANSFER_MODE register on tuning commands */
+#define SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG	(1<<18)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4

