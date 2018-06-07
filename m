Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DYpALrI+GVutSwAAmS7hNA
	; Thu, 07 Jun 2018 14:21:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BC3DD6089E; Thu,  7 Jun 2018 14:21:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3634C6063F;
	Thu,  7 Jun 2018 14:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3634C6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933418AbeFGOTU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:19:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39525 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933092AbeFGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0005dI-O1; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-00039l-EI; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.332017313@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 301/410] mmc: sdhci-pci: Fix S0i3 for Intel BYT-based
 controllers
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

From: Adrian Hunter <adrian.hunter@intel.com>

commit f8870ae6e2d6be75b1accc2db981169fdfbea7ab upstream.

Tuning can leave the IP in an active state (Buffer Read Enable bit set)
which prevents the entry to low power states (i.e. S0i3). Data reset will
clear it.

Generally tuning is followed by a data transfer which will anyway sort out
the state, so it is rare that S0i3 is actually prevented.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16:
 - Drop chnages in ni_byt_sdio_probe_slot(), byt_sd_probe_slot()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/host/sdhci-pci.c | 35 +++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -265,8 +265,34 @@ static void sdhci_pci_int_hw_reset(struc
 	usleep_range(300, 1000);
 }
 
+static int intel_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	int err = sdhci_execute_tuning(mmc, opcode);
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (err)
+		return err;
+
+	/*
+	 * Tuning can leave the IP in an active state (Buffer Read Enable bit
+	 * set) which prevents the entry to low power states (i.e. S0i3). Data
+	 * reset will clear it.
+	 */
+	sdhci_reset(host, SDHCI_RESET_DATA);
+
+	return 0;
+}
+
+static void byt_probe_slot(struct sdhci_pci_slot *slot)
+{
+	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
+
+	ops->execute_tuning = intel_execute_tuning;
+}
+
 static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
+	byt_probe_slot(slot);
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_HW_RESET;
 	slot->host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
@@ -278,6 +304,7 @@ static int byt_emmc_probe_slot(struct sd
 
 static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
+	byt_probe_slot(slot);
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE;
 	return 0;
 }
