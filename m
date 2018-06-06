Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E01960767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeFFNn4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:43:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48451 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFFNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:43:54 -0400
From: Colin King <colin.king@canonical.com>
To: Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] pinctrl: pinctrl-single: add allocation failure checking of saved_vals
Date: Wed,  6 Jun 2018 14:43:38 +0100
Message-Id: <20180606134338.4645-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently saved_vals is being allocated and there is no check for
failed allocation (which is more likely than normal when using
GFP_ATOMIC).  Fix this by checking for a failed allocation and
propagating this error return down the the caller chain.

Detected by CoverityScan, CID#1469841 ("Dereference null return value")

Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 9c3c00515aa0..0905ee002041 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1588,8 +1588,11 @@ static int pcs_save_context(struct pcs_device *pcs)
 
 	mux_bytes = pcs->width / BITS_PER_BYTE;
 
-	if (!pcs->saved_vals)
+	if (!pcs->saved_vals) {
 		pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);
+		if (!pcs->saved_vals)
+			return -ENOMEM;
+	}
 
 	switch (pcs->width) {
 	case 64:
@@ -1649,8 +1652,13 @@ static int pinctrl_single_suspend(struct platform_device *pdev,
 	if (!pcs)
 		return -EINVAL;
 
-	if (pcs->flags & PCS_CONTEXT_LOSS_OFF)
-		pcs_save_context(pcs);
+	if (pcs->flags & PCS_CONTEXT_LOSS_OFF) {
+		int ret;
+
+		ret = pcs_save_context(pcs);
+		if (ret < 0)
+			return ret;
+	}
 
 	return pinctrl_force_sleep(pcs->pctl);
 }
-- 
2.17.0
