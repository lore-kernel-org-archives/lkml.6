Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BDDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F344920848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y0Zmxu1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F344920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbeJYWwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbeJYWwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:06 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC8422085B;
        Thu, 25 Oct 2018 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477148;
        bh=21Ks0DfgFNjClGDMQ+ItP2+sz5lw4/BqrtX2RT/696s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y0Zmxu1P8FhEiy+U2/nlU0a/rr1grdwBMpYIxgdvxSuce4wcTTw6+/TM7bxOtn5uj
         45MiF7D3eSqxalpYSX97Kbgc6/+K46GNJ1+CxdYQslOCAXmJLBTGDXhqWyjsnoMlA+
         yOsQ5t3gLpnLwj4B3sfQKY8EE/XFcPtQco+zNyNs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 07/98] mmc: sdhci: restore behavior when setting VDD via external regulator
Date:   Thu, 25 Oct 2018 10:17:22 -0400
Message-Id: <20181025141853.214051-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@marvell.com>

[ Upstream commit 918f4cbd4340ddd1eb389cd8efa3b07ac74ec4c0 ]

After commit 52221610dd84 ("mmc: sdhci: Improve external VDD regulator
support"), for the VDD is supplied via external regulators, we ignore
the code to convert a VDD voltage request into one of the standard
SDHCI voltage levels, then program it in the SDHCI_POWER_CONTROL. This
brings two issues:

1. SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk isn't handled properly any
more.

2. What's more, once SDHCI_POWER_ON bit is set, some controllers such
as the sdhci-pxav3 used in marvell berlin SoCs require the voltage
levels programming in the SDHCI_POWER_CONTROL register, even the VDD
is supplied by external regulator. So the host in marvell berlin SoCs
still works fine after the commit. However, commit 3cbc6123a93d ("mmc:
sdhci: Set SDHCI_POWER_ON with external vmmc") sets the SDHCI_POWER_ON
bit, this would make the host in marvell berlin SoCs won't work any
more with external vmmc.

This patch restores the behavior when setting VDD through external
regulator by moving the call of mmc_regulator_set_ocr() to the end
of sdhci_set_power() function.

After this patch, the sdcard on Marvell Berlin SoC boards work again.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Fixes: 52221610dd84 ("mmc: sdhci: Improve external VDD ...")
Reviewed-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 56578504fd24..2295bf6e94a1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1248,19 +1248,6 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 	struct mmc_host *mmc = host->mmc;
 	u8 pwr = 0;
 
-	if (!IS_ERR(mmc->supply.vmmc)) {
-		spin_unlock_irq(&host->lock);
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-		spin_lock_irq(&host->lock);
-
-		if (mode != MMC_POWER_OFF)
-			sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
-		else
-			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
-
-		return;
-	}
-
 	if (mode != MMC_POWER_OFF) {
 		switch (1 << vdd) {
 		case MMC_VDD_165_195:
@@ -1319,6 +1306,12 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
 			mdelay(10);
 	}
+
+	if (!IS_ERR(mmc->supply.vmmc)) {
+		spin_unlock_irq(&host->lock);
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		spin_lock_irq(&host->lock);
+	}
 }
 
 /*****************************************************************************\
-- 
2.17.1

