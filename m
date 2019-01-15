Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B6DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDFF20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbfAOQ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:29:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57926 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731497AbfAOQ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:29:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 067A020A7A; Tue, 15 Jan 2019 17:29:00 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id C003120A7D;
        Tue, 15 Jan 2019 17:28:49 +0100 (CET)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/3] mmc: sdhci: use WP GPIO in sdhci_check_ro()
Date:   Tue, 15 Jan 2019 17:28:35 +0100
Message-Id: <20190115162837.5399-2-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though SDHCI controllers may have a dedicated WP pin that can be
queried using the SDHCI_PRESENT_STATE register, some platforms may
chose to use a separate regular GPIO to route the WP signal. Such a
GPIO is typically represented using the wp-gpios property in the
Device Tree.

Unfortunately, the current sdhci_check_ro() function does not make use
of such GPIO when available: it either uses a host controller specific
->get_ro() operation, or uses the SDHCI_PRESENT_STATE. Several host
controller specific ->get_ro() functions are implemented just to use
check a WP GPIO state.

Instead of pushing this to more controller-specific implementations,
let's handle this in the core SDHCI code, just like it is already done
for the CD GPIO in sdhci_get_cd().

The below patch simply changes sdhci_check_ro() to use the value of
the WP GPIO if available. We need to adjust the prototype of the
function to use a mmc_host* as argument instead of sdhci_host*, since
the mmc_can_gpio_ro() and mmc_gpio_get_ro() helpers take a mmc_host*.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/mmc/host/sdhci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index df05352b6a4a..63cc4bd033b9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2022,8 +2022,9 @@ static int sdhci_get_cd(struct mmc_host *mmc)
 	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
 }
 
-static int sdhci_check_ro(struct sdhci_host *host)
+static int sdhci_check_ro(struct mmc_host *mmc)
 {
+	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
 	int is_readonly;
 
@@ -2031,6 +2032,8 @@ static int sdhci_check_ro(struct sdhci_host *host)
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		is_readonly = 0;
+	else if (mmc_can_gpio_ro(mmc))
+		is_readonly = mmc_gpio_get_ro(mmc);
 	else if (host->ops->get_ro)
 		is_readonly = host->ops->get_ro(host);
 	else
@@ -2052,11 +2055,11 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 	int i, ro_count;
 
 	if (!(host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT))
-		return sdhci_check_ro(host);
+		return sdhci_check_ro(mmc);
 
 	ro_count = 0;
 	for (i = 0; i < SAMPLE_COUNT; i++) {
-		if (sdhci_check_ro(host)) {
+		if (sdhci_check_ro(mmc)) {
 			if (++ro_count > SAMPLE_COUNT / 2)
 				return 1;
 		}
-- 
2.20.1

