Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE04DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835402147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691612;
	bh=rSD6YiDphKOV7ssRm3rD1xARt4BqaXxvUmP1ln7uCNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AoVpJv8FoNp+lWupGdIEj/ahPr3FFEUUM5R6vMcNtGGqoG4vGTC32vH+FVw5VQat/
	 AnlPrgUPr0VbRc3IJ7OdTEkrNqE2S4/6WweG1/dl0KYMD0LMj37IbSDpK/UHWR4bCG
	 vUEZ+spRmeaX4SQYyBgUX9a94xgZTLcAHFO3K7Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbfA1QGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:06:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbfA1QGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:06:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF12C2147A;
        Mon, 28 Jan 2019 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691599;
        bh=rSD6YiDphKOV7ssRm3rD1xARt4BqaXxvUmP1ln7uCNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYf4XoV+bECAWahEuqQIfVCsxp6Xwfbxqxcd+Q3kDNpdrbup1+avLKzjBuqwk4tAT
         XoKHdCgeqfwavjjGm9hZXVpTxygKKQQ3vqK9WMka1pwyB30dqzN6QgruwFNC27PXE6
         +5edOrfBAYMO38TnD1ivO0PcZOXrrwvSfCfZ0Be4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 155/258] mmc: sdhci-of-esdhc: Fix timeout checks
Date:   Mon, 28 Jan 2019 10:57:41 -0500
Message-Id: <20190128155924.51521-155-sashal@kernel.org>
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

[ Upstream commit ea6d027312111c6d96309ad1a684b33cb37e6764 ]

Always check the wait condition before returning timeout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 9cb7554a463d..a7bf8515116f 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -526,8 +526,12 @@ static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
 	/* Wait max 20 ms */
 	timeout = ktime_add_ms(ktime_get(), 20);
 	val = ESDHC_CLOCK_STABLE;
-	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & val)) {
-		if (ktime_after(ktime_get(), timeout)) {
+	while  (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (sdhci_readl(host, ESDHC_PRSSTAT) & val)
+			break;
+		if (timedout) {
 			pr_err("%s: Internal clock never stabilised.\n",
 				mmc_hostname(host->mmc));
 			break;
@@ -591,8 +595,12 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	/* Wait max 20 ms */
 	timeout = ktime_add_ms(ktime_get(), 20);
-	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE)) {
-		if (ktime_after(ktime_get(), timeout)) {
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE)
+			break;
+		if (timedout) {
 			pr_err("%s: Internal clock never stabilised.\n",
 				mmc_hostname(host->mmc));
 			return;
-- 
2.19.1

