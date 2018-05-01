Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeEAKjy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:39:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39306 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbeEAKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:39:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CD0C6079C
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
Subject: [PATCH RFC 4/4] host: sdhci-msm: implement get_current_limit() host op
Date: Tue,  1 May 2018 16:09:13 +0530
Message-Id: <1525171153-24476-5-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
References: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

This is needed to get the current capabilities of vdd
regulator that is not managed by SDHCI driver.

Change-Id: I927c14b9890f1d672fe8a3e89d0b334f43463b36
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 0e0f12d..083b4a5 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2079,6 +2079,18 @@ static void sdhci_msm_set_default_hw_caps(struct device *dev,
 	{},
 };
 
+static unsigned int sdhci_msm_get_current_limit(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_msm_reg_data *vdd_data = msm_host->pdata.vdd_data;
+	u32 max_curr = 0;
+
+	if (vdd_data)
+		max_curr = vdd_data->hpm_uA;
+	return max_curr;
+}
+
 MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 
 static const struct sdhci_ops sdhci_msm_ops = {
@@ -2090,6 +2102,7 @@ static void sdhci_msm_set_default_hw_caps(struct device *dev,
 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
 	.write_w = sdhci_msm_writew,
 	.write_b = sdhci_msm_writeb,
+	.get_current_limit = sdhci_msm_get_current_limit,
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
