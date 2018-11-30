Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D62C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C6E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C6E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeK3SI6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:08:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:10237 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeK3SI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:08:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 23:00:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208,223";a="96142703"
Received: from xdu1-mobl.sh.intel.com (HELO xdu1-mobl) ([10.239.200.30])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2018 23:00:38 -0800
Date:   Fri, 30 Nov 2018 15:00:28 +0800
From:   "Du, Alek" <alek.du@intel.com>
To:     linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sdhci: fix the fake timeout bug
Message-ID: <20181130150028.732896d8@xdu1-mobl>
Organization: Intel APAC R&D
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From b893df3a1a937bd5fe22d39ceae93454a2e5e0e4 Mon Sep 17 00:00:00 2001
From: Alek Du <alek.du@intel.com>
Date: Fri, 30 Nov 2018 14:02:28 +0800
Subject: [PATCH] sdhci: fix the fake timeout bug

We observed some fake timeouts on some devices, the log is like this:

[ 7586.290201] mmc1: Timeout waiting for hardware cmd interrupt.
[ 7586.290420] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
...
[ 7586.291774] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000203

From the clock control register dump, we are pretty sure the clock was
stabilized.

In other cases, we also observed:

[ 7596.530171] mmc1: Timeout waiting for hardware cmd interrupt.

and

[ 1956.534634] mmc1: Reset 0x2 never completed.

But we are pretty sure the mmc controller is working perfectly under low
system load.

After checking the sdhci code, we found the timeout check actually has a
little window that the CPU can be scheduled out and when it comes back,
the original time set or check is not valid.

Signed-off-by: Alek Du <alek.du@intel.com>
---
 drivers/mmc/host/sdhci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae53fa2e..f88c49fc574e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -218,12 +218,17 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
 		if (ktime_after(ktime_get(), timeout)) {
+			/* check it again, since there is a window between
+			   bit check and time check */
+			if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
+				break;
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
 			sdhci_dumpregs(host);
 			return;
+		} else {
+			udelay(10);
 		}
-		udelay(10);
 	}
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
@@ -1395,9 +1400,10 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
 	else
 		timeout += 10 * HZ;
-	sdhci_mod_timer(host, cmd->mrq, timeout);
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	/* setup timer after command to avoid fake timeout */
+	sdhci_mod_timer(host, cmd->mrq, timeout);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
@@ -1611,12 +1617,19 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (ktime_after(ktime_get(), timeout)) {
+			/* check it again since there is a window between
+			   status check and time check */
+			if ((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+					& SDHCI_CLOCK_INT_STABLE)
+				break;
 			pr_err("%s: Internal clock never stabilised.\n",
 			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			return;
 		}
-		udelay(10);
+		else {
+			udelay(10);
+		}
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
-- 
2.17.1
