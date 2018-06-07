Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 616aIjA/GVsZWAAAmS7hNA
	; Thu, 07 Jun 2018 14:20:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7A61E6089E; Thu,  7 Jun 2018 14:20:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D91CA602FC;
	Thu,  7 Jun 2018 14:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D91CA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeFGOT0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:19:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39516 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933091AbeFGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0005Zi-BG; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-00039b-Bj; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.87317720@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 299/410] mmc: sdhci: Allow override of mmc host
 operations
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

commit bf60e592a1af4d6f65dd54593250183f14360eed upstream.

In the past, fixes for specific hardware devices were implemented
in sdhci using quirks.  That approach is no longer accepted because
the growing number of quirks was starting to make the code difficult
to understand and maintain.

One alternative to quirks, is to allow drivers to override the default
mmc host operations.  This patch makes it easy to do that, and it is
needed for a subsequent bug fix, for which separate patches are
provided.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/host/sdhci.c  | 3 ++-
 include/linux/mmc/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2781,6 +2781,8 @@ struct sdhci_host *sdhci_alloc_host(stru
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
+	host->mmc_host_ops = sdhci_ops;
+	mmc->ops = &host->mmc_host_ops;
 
 	return host;
 }
@@ -2939,7 +2941,6 @@ int sdhci_add_host(struct sdhci_host *ho
 	/*
 	 * Set host parameters.
 	 */
-	mmc->ops = &sdhci_ops;
 	mmc->f_max = host->max_clk;
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -109,6 +109,7 @@ struct sdhci_host {
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
+	struct mmc_host_ops mmc_host_ops;	/* MMC host ops */
 	u64 dma_mask;		/* custom DMA mask */
 
 #if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
