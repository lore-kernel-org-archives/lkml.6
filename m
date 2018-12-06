Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEDEC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F0220850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F0220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeLFJZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:25:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:51071 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbeLFJZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:25:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 01:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,321,1539673200"; 
   d="scan'208";a="116484582"
Received: from xdu1-desk.sh.intel.com ([10.239.154.142])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Dec 2018 01:25:19 -0800
From:   alek.du@intel.com
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alek Du <alek.du@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci: fix the timeout check window for clock and reset
Date:   Thu,  6 Dec 2018 17:24:59 +0800
Message-Id: <20181206092459.26202-1-alek.du@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alek Du <alek.du@intel.com>

We observed some premature timeouts on a virtualization platform, the log
is like this:

case 1:
[159525.255629] mmc1: Internal clock never stabilised.
[159525.255818] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[159525.256049] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
...
[159525.257205] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
From the clock control register dump, we are pretty sure the clock was
stablized.

case 2:
[  914.550127] mmc1: Reset 0x2 never completed.
[  914.550321] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[  914.550608] mmc1: sdhci: Sys addr:  0x00000010 | Version:  0x00001002

After checking the sdhci code, we found the timeout check actually has a
little window that the CPU can be scheduled out and when it comes back,
the original time set or check is not valid.

Fixes: 5a436cc0af62 ("mmc: sdhci: Optimize delay loops")
Cc: stable@vger.kernel.org      # v4.12+
Signed-off-by: Alek Du <alek.du@intel.com>
---
 drivers/mmc/host/sdhci.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae53fa2e..451b08a818a9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -216,8 +216,12 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 	timeout = ktime_add_ms(ktime_get(), 100);
 
 	/* hw clears the bit when it's done */
-	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
-		if (ktime_after(ktime_get(), timeout)) {
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
+			break;
+		if (timedout) {
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
 			sdhci_dumpregs(host);
@@ -1608,9 +1612,13 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 
 	/* Wait max 20 ms */
 	timeout = ktime_add_ms(ktime_get(), 20);
-	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
-		& SDHCI_CLOCK_INT_STABLE)) {
-		if (ktime_after(ktime_get(), timeout)) {
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
 			pr_err("%s: Internal clock never stabilised.\n",
 			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
-- 
2.17.1

