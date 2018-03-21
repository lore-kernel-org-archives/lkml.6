Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeCURpo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:45:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53175 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbeCURpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:45:42 -0400
From: Colin King <colin.king@canonical.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] phy: qcom-qusb2: fix missing assignment to an error return code
Date: Wed, 21 Mar 2018 17:45:38 +0000
Message-Id: <20180321174538.2194-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error return code is not being assigned to ret from the call
to clk_prepare_enable and consequently the current check on ret
picks up the previous error return. Fix this by adding in the
missing assignment to ret.

Detected by CoverityScan, CID#166020 ("Logically Dead code")

Fixes: 891a96f65ac3 ("phy: qcom-qusb2: Add support for runtime PM)
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 94afeac1a19e..6f5689a40884 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -439,7 +439,7 @@ static int __maybe_unused qusb2_phy_runtime_resume(struct device *dev)
 	}
 
 	if (!qphy->has_se_clk_scheme) {
-		clk_prepare_enable(qphy->ref_clk);
+		ret = clk_prepare_enable(qphy->ref_clk);
 		if (ret) {
 			dev_err(dev, "failed to enable ref clk, %d\n", ret);
 			goto disable_ahb_clk;
-- 
2.15.1
