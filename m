Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10171C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92FD206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896331;
	bh=t3Z3UC1H3BvnPEfAjft8EBHjMxVLIFKasujIj++WxTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JwxxW7HxjEtVoM7Nu4j0/Kik58DxjntJJhHyY1wwnBb9xP1ReNsFIH0tTjSozRPRJ
	 LHgP/4M0eCk3VomyUFvoQ4cz84xpH3ba1FKHq3PMPPjRwYF+p3W9drv+oP3p7CohdP
	 YOfZ1rrOtBiZxwiCtiPShVRVP/aoWVGMFYNd0rQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbfBKOpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732608AbfBKOp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1281F20700;
        Mon, 11 Feb 2019 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896327;
        bh=t3Z3UC1H3BvnPEfAjft8EBHjMxVLIFKasujIj++WxTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buazbOkU7bI5+nXnbnaeN6VgIbR2+5iqQdDgxJJ8GsGgB5viUKZqDn5UofODp4rmc
         H++xwuM+ntvkKMcAJl/8+jCNPEvkQCmfIfa6wXe8NAew4wHW71rn8qqD8lOUhMHEof
         Z+7sLFdF5/Cj7/LkVbzbSbfx1RctP0ETJZx3NTaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 147/313] mmc: sdhci-of-esdhc: Fix timeout checks
Date:   Mon, 11 Feb 2019 15:17:07 +0100
Message-Id: <20190211141903.414917559@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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



