Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4637CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A67920700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896335;
	bh=dwqIzyW1NJovQoX0LVGnXHkGXqr3JhnF3DUOI40Wwbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qR7cTpGXH7q/9b3G/yWPgsBQl9gGh0ix7XsYJAOX6kwUzcO5QxmlAd47spE4Wq3CH
	 VKkwoe7roWsLfnPtJRfFXsnxkjN7umn/QMNI73T0hCIOcidZoNA3KbYJxGsS0c+ipp
	 z1iKrJjkQQjMLrB21gM9bgNXDGn++a9Y2M2/qZ6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbfBKOpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:45:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732387AbfBKOpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3D62081B;
        Mon, 11 Feb 2019 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896330;
        bh=dwqIzyW1NJovQoX0LVGnXHkGXqr3JhnF3DUOI40Wwbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWLuLOJirt0XhlhnoUytMV40SqIsr/bm3+YX5zbXgnc9WY6OKSU5IYdoinK25ieta
         FfR5fCnz21HiTmcKev0I8ECRfchaHObUuFGkB/2IvDPqMPfu8oyuWUfqSaunoIjaHj
         6VBVkfx6dwVxO5EkebVxDyYB09gDIp4KMraK/QL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 148/313] mmc: sdhci-omap: Fix timeout checks
Date:   Mon, 11 Feb 2019 15:17:08 +0100
Message-Id: <20190211141903.475739367@linuxfoundation.org>
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

[ Upstream commit 9f0ea0bda1d06120b053bb0c283f54afec59293d ]

Always check the wait condition before returning timeout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-omap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index d264391616f9..d02f5cf76b3d 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -220,8 +220,12 @@ static void sdhci_omap_conf_bus_power(struct sdhci_omap_host *omap_host,
 
 	/* wait 1ms */
 	timeout = ktime_add_ms(ktime_get(), SDHCI_OMAP_TIMEOUT);
-	while (!(sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL) & HCTL_SDBP)) {
-		if (WARN_ON(ktime_after(ktime_get(), timeout)))
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL) & HCTL_SDBP)
+			break;
+		if (WARN_ON(timedout))
 			return;
 		usleep_range(5, 10);
 	}
@@ -653,8 +657,12 @@ static void sdhci_omap_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 
 	/* wait 1ms */
 	timeout = ktime_add_ms(ktime_get(), SDHCI_OMAP_TIMEOUT);
-	while (!(sdhci_omap_readl(omap_host, SDHCI_OMAP_STAT) & INT_CC_EN)) {
-		if (WARN_ON(ktime_after(ktime_get(), timeout)))
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (sdhci_omap_readl(omap_host, SDHCI_OMAP_STAT) & INT_CC_EN)
+			break;
+		if (WARN_ON(timedout))
 			return;
 		usleep_range(5, 10);
 	}
-- 
2.19.1



