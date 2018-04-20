Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbeDTJ03 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:26:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40960 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeDTJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:26:28 -0400
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        patches@opensource.cirrus.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: wm8350: fix missing increment of loop index i
Date: Fri, 20 Apr 2018 10:26:23 +0100
Message-Id: <20180420092623.1327-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It seems that the loop index i is not being incremented and hence
potentially the while loop could spin forever. Fortunately with the
data being used this does not appear to happen at the moment.

Fixes: da09155ac8d3 ("regulator: Add WM8350 regulator support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/wm8350-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index da9106bd2109..8ad11b074b49 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -911,6 +911,7 @@ static unsigned int get_mode(int uA, const struct wm8350_dcdc_efficiency *eff)
 	while (eff[i].uA_load_min != -1) {
 		if (uA >= eff[i].uA_load_min && uA <= eff[i].uA_load_max)
 			return eff[i].mode;
+		i++;
 	}
 	return REGULATOR_MODE_NORMAL;
 }
-- 
2.17.0
