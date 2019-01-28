Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57953C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264DB2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692196;
	bh=v9SB+xocR2LsfzPltnP3yecD3Zv7NY+wqANdNXz8J2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hPbTXQOJeShr5S7YEDA6GG0u3URAahSybkjtxSBioJ0SI9axcEPxo+pXec8ivqiwB
	 Mw/kLvjrNm2I7XVYHJVoc1B8GlySqKWV1XjgCw5TFVpFE9AtY6UR0q5+WhBJDPgekU
	 vsj9hbtIFO3iAvaaW+iZwcVXTRVPTaBBP87TkJrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfA1QQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:16:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732889AbfA1QQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622D420879;
        Mon, 28 Jan 2019 16:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692189;
        bh=v9SB+xocR2LsfzPltnP3yecD3Zv7NY+wqANdNXz8J2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DgbGRXYDG5L2/eOhENCLV4xPMq4e2Ic+VdvdCSsHzFrYgP6QU29p5fAXRigw1V+r+
         PZZZAjlh8eTU1b3aTLq3AIW+epJozbLL66XrBwdKsob6YlKPN/Mz21OhxxIY7xyeAs
         ms9TGAS3WrSupzCc4jE2V0sRx5llLSRW5yh6iR30=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 103/170] mmc: sdhci-xenon: Fix timeout checks
Date:   Mon, 28 Jan 2019 11:10:53 -0500
Message-Id: <20190128161200.55107-103-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index ec8794335241..82051f2b7191 100644
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

