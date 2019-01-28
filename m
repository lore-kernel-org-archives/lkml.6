Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F6DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FEF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690771;
	bh=Qi8zBp4ErWC6+27RVqVn8817acWdExkYBRiLWbTHZJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SjX9BzuER/z+lEzifDYXKVuaxBn7eh3Frz1Xa3pq0rtysBmApl1EvMmh8tHXQE7ca
	 ZBTxD5W+Nz3lMIX4Wh+zgu+yWo3uMW2xqHrfrv52VyrhSyJ6wNy78+t6xE1HeAakAR
	 Bd5FmET0SO0QlXYDBq8qe1uFgjtSsrV5zwYKSMe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfA1Pwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfA1Pwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:52:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D12F2147A;
        Mon, 28 Jan 2019 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690766;
        bh=Qi8zBp4ErWC6+27RVqVn8817acWdExkYBRiLWbTHZJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1GZ3ZoAD2yCQ215SJwQydgIaAXrBJRtK2PnQJIfjnLt3bbqVhTUIINhQq46HPuDY
         flUF2M6XX5/D0/WyK91LvIVCVGe0PmeKj0F1yZ0Mwlame0oCL0WMQCnijl3lo4K9Cv
         EIyG7kNtcwQG1H2ig9v2uRptEHTjMsTbFq0vqnYI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 187/304] mmc: sdhci-omap: Fix timeout checks
Date:   Mon, 28 Jan 2019 10:41:44 -0500
Message-Id: <20190128154341.47195-187-sashal@kernel.org>
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

