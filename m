Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2243C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9242620811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298674;
	bh=zG2CRkspvyULeDxwvt7UiPMQstwEmbo4dMyXIfQe7R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ss7PZvafyO2odsewvWu1iP+dut6K/LY0SY5PnAsEmVdDq47DBuqeScwO/JtwiywB9
	 j0aILFY0/Q3r2eQYFVR3zxSzYibG4jpxzr8is6XE4x5OdcS5aO0T4Wu1NhZ6kG626p
	 olP8Fd+wRYoNFgp0qSgje9dnMvGA76A8SL8Jq+rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbeLTJ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:26:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeLTJ0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE7421852;
        Thu, 20 Dec 2018 09:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297990;
        bh=zG2CRkspvyULeDxwvt7UiPMQstwEmbo4dMyXIfQe7R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvbiiMViK8qxgMjT1D36Zm9naCHx/G6Bz6gqf7RIExLUDK2j8cy5qPuBACisipI9+
         VaC6oDCcII+0bHCeRJ3hus2V2CCzNUErmU62eeo/rpcEaLk2M2VgZnGmeSF88osggm
         HSkXHxVYqj4OTGywFg+yDQ93jcXk4P8GTL+I1xVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alek Du <alek.du@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 07/72] mmc: sdhci: fix the timeout check window for clock and reset
Date:   Thu, 20 Dec 2018 10:18:06 +0100
Message-Id: <20181220085922.626631889@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alek Du <alek.du@intel.com>

commit b704441e38f645dcfba1348ca3cc1ba43d1a9f31 upstream.

We observed some premature timeouts on a virtualization platform, the log
is like this:

case 1:
[159525.255629] mmc1: Internal clock never stabilised.
[159525.255818] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[159525.256049] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
...
[159525.257205] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
>From the clock control register dump, we are pretty sure the clock was
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -193,8 +193,12 @@ void sdhci_reset(struct sdhci_host *host
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
@@ -1417,9 +1421,13 @@ void sdhci_enable_clk(struct sdhci_host
 
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


