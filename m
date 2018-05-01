Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeEAKjt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:39:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39124 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbeEAKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:39:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 431CD60710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From: Vijay Viswanath <vviswana@codeaurora.org>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
Subject: [PATCH RFC 3/4] host: sdhci: fix current caps when there is no host->vmmc
Date: Tue,  1 May 2018 16:09:12 +0530
Message-Id: <1525171153-24476-4-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
References: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

When the regulators are not managed by SDHCI host driver (i.e.,
when host->vmmc and host->vmmcq are absent), get the regulator
current capabilities through a new host op get_current_limit().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
[vviswana@codeaurora.org: fixed trivial merge conflicts]
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>

Change-Id: I3370a2411beec1f03cc5f102bf95cd816c60351e
---
 drivers/mmc/host/sdhci.c | 11 ++++++++---
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0d5fcca..edc2ccd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3570,10 +3570,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * value.
 	 */
 	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
-	if (!max_current_caps && !IS_ERR(mmc->supply.vmmc)) {
-		int curr = regulator_get_current_limit(mmc->supply.vmmc);
-		if (curr > 0) {
+	if (!max_current_caps) {
+		u32 curr = 0;
+
+		if (!IS_ERR(mmc->supply.vmmc))
+			curr = regulator_get_current_limit(mmc->supply.vmmc);
+		else if (host->ops->get_current_limit)
+			curr = host->ops->get_current_limit(host);
 
+		if (curr > 0) {
 			/* convert to SDHCI_MAX_CURRENT format */
 			curr = curr/1000;  /* convert to mA */
 			curr = curr/SDHCI_MAX_CURRENT_MULTIPLIER;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 54bc444..a01af78 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -584,6 +584,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	unsigned int	(*get_current_limit)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
