Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49139ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E09820892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xU3lpBMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E09820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeKIHcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbeKIHcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:22 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D27CF21104;
        Thu,  8 Nov 2018 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714094;
        bh=FI+E/0K28wiLQyrGKQEJCfK002ZteUBrfsFay7j3Hho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xU3lpBMhU6ApYRteH/887wpY1ZoDkCgsAWwZI0UwN1+gNW8T37abXB6yoHsONRkgd
         BuRYoE9cZZQOt+UHrLp4r4LjPVF+c8scg93aUxKKQuUuTTOQrnfL2LOwOr8gUsSXoV
         eLiSnbIvqSg7PqxHMar+rPMqAtNSVeC25vQPkzDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 038/144] mmc: sdhci: restore behavior when setting VDD via external regulator
Date:   Thu,  8 Nov 2018 13:50:09 -0800
Message-Id: <20181108215057.615363616@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



