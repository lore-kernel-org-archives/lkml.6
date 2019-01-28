Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E11C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7CD2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697203;
	bh=tjeEche6ZNZYVU8pLyszRRgNp+HB/RH4lCSkzsOJx0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yWMpFPF67DW9Ko550TFD6oC5GlqVQhFD2w9KYkti05J3RxgSOEJU+GabV1X9sHNHc
	 lnVUn1tq3hLPzvwQM3bckyZow5+x0S93iqeDl/S/lPWUn1u6P0KY3Tb0v0wFNwyG1u
	 tWbK/IyVaIfSqvvjqEuq2KRRz7zbi13Mc+82dG4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfA1RkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729338AbfA1Pwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:52:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 035942175B;
        Mon, 28 Jan 2019 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690764;
        bh=tjeEche6ZNZYVU8pLyszRRgNp+HB/RH4lCSkzsOJx0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGkc8UtNw5F5ADkqQXhuKiILqLCtNEHozKAxj756zNPjQL7az5KAJhL7hJXgx4WAT
         CAp2XxpvFbT1kdEGkUnCrZaa6lchRzOtuIsxTv2Klk2mrn5lVTRPV+/fcBDXf7Yjin
         AZ5sGa3uBLucY+iOdFXcmM66pHORd9/Kb9jBVBJE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 186/304] mmc: sdhci-of-esdhc: Fix timeout checks
Date:   Mon, 28 Jan 2019 10:41:43 -0500
Message-Id: <20190128154341.47195-186-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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
index 86fc9f022002..d111bf62acd9 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -528,8 +528,12 @@ static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
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
@@ -594,8 +598,12 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 
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

