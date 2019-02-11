Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED72C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD840218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901028;
	bh=w3dJQWlZSCt6rMrOewxA9MuIMFaIYjd6D//NnVx1P6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hhPFDhzd6KXZtojZ05UFOLCAcp1BSSaagdI/5qYtAsDY6s2CMvSBnfWJKxJ+KncVh
	 YKCr5kkBdBS3MLZ5uDjwVjkLaO03tF5UvQ6OELs+Inoc0cWLMpla6Al3/rh4Fb7YoN
	 4dz9WrXbjxs8dB1TbK3ELLSTmYDNv34x2WMyU/Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbfBKQDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:03:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729949AbfBKO3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB7D420844;
        Mon, 11 Feb 2019 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895351;
        bh=w3dJQWlZSCt6rMrOewxA9MuIMFaIYjd6D//NnVx1P6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4B8UtrrvTtF63p5YDhWCIv3ScYPVdf4Ly2t4e3fcQ2KeXI/OvkHSJ05PpcelZ3j0
         UpUW6q0z2fzEtaL0RW/HjJRtI2yA9GtzVP0B50kSWHUwQUbrcdgNRQRNxRNw4N2V/b
         wLR0gzbKKlEEzFJucaofgpASebpSfUsXZOa1xBIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 175/352] mmc: sdhci-of-esdhc: Fix timeout checks
Date:   Mon, 11 Feb 2019 15:16:42 +0100
Message-Id: <20190211141858.217322820@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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



