Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746DFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450B221873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151451;
	bh=40HQvD5gtbJ5c7qycQ2+xgh0rBixMUc+dX842omhrrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHbMEw2E5pay8sajKxpkpCE/TrrI5gsVPNbhvvbWCAtMSFinoQrX+QSkhcenS9qw/
	 2EpzKKgs0A0xbzpynk/6hvlCVS/hLj+X4y8cO8xzyvksgS9zK5ByVZ7WSuaZ8tCy5S
	 8GJcvpxG+oyJgcsVxupOFMDgzKfD+xQXU2hjOwLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeLRQkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbeLRQkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0387218A5;
        Tue, 18 Dec 2018 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151234;
        bh=40HQvD5gtbJ5c7qycQ2+xgh0rBixMUc+dX842omhrrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYDJqJhSOg6walClAGmcwERfp0QM8o9dBy4tW8CMv2gTYvoYY8YtMKxPYxeOauieq
         B+o1qOucQnxO71kTq56WjdE6mvA1fslZwPdCRXYGdGjKZA7HyOXfoiXqNIBvYG+bAn
         0F2XHO/Ug2VGdDiE0+jpnx3wBcLhjjymyIofaNcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alek Du <alek.du@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 20/44] mmc: sdhci: fix the timeout check window for clock and reset
Date:   Tue, 18 Dec 2018 17:39:32 +0100
Message-Id: <20181218163929.871016709@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1495,9 +1499,13 @@ void sdhci_enable_clk(struct sdhci_host
 
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


