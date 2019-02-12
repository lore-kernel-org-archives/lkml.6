Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40750C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9F020838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfBLOHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:07:52 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:60507 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfBLOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:07:47 -0500
X-Greylist: delayed 84945 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2019 09:07:46 EST
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 534A920000C;
        Tue, 12 Feb 2019 14:07:43 +0000 (UTC)
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
Subject: [PATCH v3 1/3] mmc: sdhci: use WP GPIO in sdhci_check_ro()
Date:   Tue, 12 Feb 2019 15:07:35 +0100
Message-Id: <20190212140737.8668-2-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212140737.8668-1-thomas.petazzoni@bootlin.com>
References: <20190212140737.8668-1-thomas.petazzoni@bootlin.com>
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
controller specific ->get_ro() functions are implemented just to check
a WP GPIO state.

Instead of pushing this to more controller-specific implementations,
let's handle this in the core SDHCI code, just like it is already done
for the CD GPIO in sdhci_get_cd().

The below patch simply changes sdhci_check_ro() to use the value of
the WP GPIO if available.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
Changes since v2:

 - As suggested by Adrian Hunter, keep the argument of
   sdhci_check_ro() as it is: a "struct sdhci_host*"

Changes since v1:

 - As suggested by Adrian Hunter, call the ->get_ro() if it exists
   before falling back to using mmc_gpio_get_ro(). Indeed, if the
   controller-specific code has implemented a ->get_ro() callback, it
   should take precedence over what the SDHCI core does.

   Due to this change, I have not added Thierry Redding Reviewed-by.

 - Fix typo in the commit log noticed by Thierry Redding.
---
 drivers/mmc/host/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index df05352b6a4a..b3444d12c8c8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2033,6 +2033,8 @@ static int sdhci_check_ro(struct sdhci_host *host)
 		is_readonly = 0;
 	else if (host->ops->get_ro)
 		is_readonly = host->ops->get_ro(host);
+	else if (mmc_can_gpio_ro(host->mmc))
+		is_readonly = mmc_gpio_get_ro(host->mmc);
 	else
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
-- 
2.20.1

