Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB7FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7FF222A8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897247;
	bh=/amk+QAmog6yftkj0BwTwvWkWxtV2ONmSwHJYtJQ23g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cD8PiF22cpuyWnGqRgL1jQIMp1jsQ6j6IMDPczeP+GfQmIeKC9PGIh0GM2mX4/Sjr
	 7Q8yQHvEtM8ywWCd9zYJvmOIi8Xe5N2qae8j44rhL2o3wPRSxEBVFI00fRFZWYgTwr
	 ReVPD15nMX59Fh2wX8v4mh1HKo6D1N+np2Poz5HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbfBKO6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:58:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389629AbfBKO6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:58:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722A3222A6;
        Mon, 11 Feb 2019 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897123;
        bh=/amk+QAmog6yftkj0BwTwvWkWxtV2ONmSwHJYtJQ23g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnirnfTeWGiNjgoRRZJqXdx/Kggj2o0BWtSAUMaNRNeukpfXR460pYnm4lt1FO1K3
         xKpNszXxRgzoDT8YmwWgNMs+iLQgM48rmwnb6sngAeNGa8aDfPm1Z1qLMuIWhjzefU
         L7cVk0qXrK/W+OUiAnXwmsb2GVhk40d6cLBvO4hc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Zhoujie Wu <zjwu@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 099/205] mmc: sdhci-xenon: Fix timeout checks
Date:   Mon, 11 Feb 2019 15:18:17 +0100
Message-Id: <20190211141835.080273538@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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



