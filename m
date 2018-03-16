Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbeCPJp3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:45:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeCPJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:45:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D796E60C64
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-msm@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH 2/6] phy: qcom-qusb2: Fix crash if nvmem cell not specified
Date: Fri, 16 Mar 2018 15:14:55 +0530
Message-Id: <1521193500-4696-3-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver currently crashes due to NULL pointer deference
while updating PHY tune register if nvmem cell is NULL.
Since, fused value for Tune1/2 register is optional,
we'd rather bail out.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 94afeac..40fdef8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -315,6 +315,10 @@ static void qusb2_phy_set_tune2_param(struct qusb2_phy *qphy)
 	const struct qusb2_phy_cfg *cfg = qphy->cfg;
 	u8 *val;
 
+	/* efuse register is optional */
+	if (!qphy->cell)
+		return;
+
 	/*
 	 * Read efuse register having TUNE2/1 parameter's high nibble.
 	 * If efuse register shows value as 0x0, or if we fail to find
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
