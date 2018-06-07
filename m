Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id A4pALrI+GVutSwAAmS7hNA
	; Thu, 07 Jun 2018 14:18:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 526986089E; Thu,  7 Jun 2018 14:18:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B5B326063F;
	Thu,  7 Jun 2018 14:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5B326063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933410AbeFGOSv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:18:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39538 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933096AbeFGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0005Zx-Cs; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-00039g-D6; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.603059745@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 300/410] mmc: sdhci: export sdhci_execute_tuning()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 85a882c2e91d3655927ecdc1db823d1420a65b8f upstream.

Some SDHCI-compat controllers support not only SD, but also eMMC,
but they use different commands for tuning: CMD19 for SD, CMD21 for
eMMC.

Due to the difference of the underlying mechanism, some controllers
(at least, the Cadence IP is the case) provide their own registers
for the eMMC tuning.

This commit will be useful when we want to override .execute_tuning
callback (for eMMC HS200 tuning), but still let it fall back to
sdhci_execute_tuning() for SD timing.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16: Delete an additional prototype]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -52,7 +52,6 @@ static unsigned int debug_quirks2;
 static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_finish_command(struct sdhci_host *);
-static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_tuning_timer(unsigned long data);
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
@@ -1840,7 +1839,7 @@ static int sdhci_card_busy(struct mmc_ho
 	return !(present_state & SDHCI_DATA_LVL_MASK);
 }
 
-static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
+int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	u16 ctrl;
@@ -2054,6 +2053,7 @@ out:
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
 
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -402,6 +402,7 @@ void sdhci_set_clock(struct sdhci_host *
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
+int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
