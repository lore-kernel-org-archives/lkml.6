Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130CAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78EE2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691617;
	bh=sSY7qvCTRrQZbN9Sxty38CmBO0GJYULe5V86bm+ByOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yEIuGz+BXuxEKMRjS32erxopvAM/jE5S9dEmfobqe21K/s1Tr7E1mzuit/FlKJjbV
	 eQObb3ZP6BHg0h5m4gjHiSd8/HVf++5gs5Mjbh5xyj+JqwgHIkLE7bPaDi/kkQE4FV
	 W8dqL6Q3S1BEzmy1S2ZMa08lf71Pl4b9q7GULaIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfA1QG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:06:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732066AbfA1QGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:06:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9F12147A;
        Mon, 28 Jan 2019 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691604;
        bh=sSY7qvCTRrQZbN9Sxty38CmBO0GJYULe5V86bm+ByOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIHNo8exF1DTELjXFUokDNzp5MlVrwmlmLIC/SY7pfAPf6RYVANKST3Mu3R0jXX1t
         RLojOqqxDF1HHRKM5+C2Ua29jGAuW9JhGxa67E36cu9ZNKV8g+ZlNJFxRQk2yxrVM/
         14XrfcFhqlD/mRlzcQdxzRYSmV7hWHvz4T7beBlQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 157/258] mmc: sdhci-xenon: Fix timeout checks
Date:   Mon, 28 Jan 2019 10:57:43 -0500
Message-Id: <20190128155924.51521-157-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 0e6e7c2ff397e1bbebc882ca3132148aaaef1ddd ]

Always check the wait condition before returning timeout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Zhoujie Wu <zjwu@marvell.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 10 +++++++---
 drivers/mmc/host/sdhci-xenon.c     | 10 +++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index c335052d0c02..caccedc836dc 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -357,9 +357,13 @@ static int xenon_emmc_phy_enable_dll(struct sdhci_host *host)
 
 	/* Wait max 32 ms */
 	timeout = ktime_add_ms(ktime_get(), 32);
-	while (!(sdhci_readw(host, XENON_SLOT_EXT_PRESENT_STATE) &
-		XENON_DLL_LOCK_STATE)) {
-		if (ktime_after(ktime_get(), timeout)) {
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (sdhci_readw(host, XENON_SLOT_EXT_PRESENT_STATE) &
+		    XENON_DLL_LOCK_STATE)
+			break;
+		if (timedout) {
 			dev_err(mmc_dev(host->mmc), "Wait for DLL Lock time-out\n");
 			return -ETIMEDOUT;
 		}
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 4d0791f6ec23..a0b5089b3274 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -34,9 +34,13 @@ static int xenon_enable_internal_clk(struct sdhci_host *host)
 	sdhci_writel(host, reg, SDHCI_CLOCK_CONTROL);
 	/* Wait max 20 ms */
 	timeout = ktime_add_ms(ktime_get(), 20);
-	while (!((reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
-			& SDHCI_CLOCK_INT_STABLE)) {
-		if (ktime_after(ktime_get(), timeout)) {
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (reg & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
 			dev_err(mmc_dev(host->mmc), "Internal clock never stabilised.\n");
 			return -ETIMEDOUT;
 		}
-- 
2.19.1

