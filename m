Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3U2cA5dAGVvuYwAAmS7hNA
	; Thu, 07 Jun 2018 14:26:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F17B7607E7; Thu,  7 Jun 2018 14:26:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D0BE86063F;
	Thu,  7 Jun 2018 14:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0BE86063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933604AbeFGO02 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:26:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40170 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932814AbeFGO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:26:25 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbX-0005Zn-9z; Thu, 07 Jun 2018 15:09:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-00039v-HK; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Shawn Lin" <shawn.lin@rock-chips.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.135837128@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 303/410] mmc: dw_mmc: Fix out-of-bounds access for
 slot's caps
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

commit 0d84b9e5631d923744767dc6608672df906dd092 upstream.

Add num_caps field for dw_mci_drv_data to validate the controller
id from DT alias and non-DT ways.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Fixes: 800d78bfccb3 ("mmc: dw_mmc: add support for implementation specific callbacks")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16:
 - Drop changes to dw_mmc-{k3,rockchip,zx}.c
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -394,6 +394,7 @@ static unsigned long exynos_dwmmc_caps[4
 
 static const struct dw_mci_drv_data exynos_drv_data = {
 	.caps			= exynos_dwmmc_caps,
+	.num_caps		= ARRAY_SIZE(exynos_dwmmc_caps),
 	.init			= dw_mci_exynos_priv_init,
 	.setup_clock		= dw_mci_exynos_setup_clock,
 	.prepare_command	= dw_mci_exynos_prepare_command,
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2064,8 +2064,15 @@ static int dw_mci_init_slot_caps(struct
 	} else {
 		ctrl_id = to_platform_device(host->dev)->id;
 	}
-	if (drv_data && drv_data->caps)
+
+	if (drv_data && drv_data->caps) {
+		if (ctrl_id >= drv_data->num_caps) {
+			dev_err(host->dev, "invalid controller id %d\n",
+				ctrl_id);
+			return -EINVAL;
+		}
 		mmc->caps |= drv_data->caps[ctrl_id];
+	}
 
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -237,6 +237,7 @@ struct dw_mci_tuning_data {
 /**
  * dw_mci driver data - dw-mshc implementation specific driver data.
  * @caps: mmc subsystem specified capabilities of the controller(s).
+ * @num_caps: number of capabilities specified by @caps.
  * @init: early implementation specific initialization.
  * @setup_clock: implementation specific clock configuration.
  * @prepare_command: handle CMD register extensions.
@@ -250,6 +251,7 @@ struct dw_mci_tuning_data {
  */
 struct dw_mci_drv_data {
 	unsigned long	*caps;
+	u32		num_caps;
 	int		(*init)(struct dw_mci *host);
 	int		(*setup_clock)(struct dw_mci *host);
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
