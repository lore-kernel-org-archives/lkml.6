Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeEUMO5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:14:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38697 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752633AbeEUMJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:05 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 09/33] phy: tegra: use match_string() helper
Date: Mon, 21 May 2018 19:57:46 +0800
Message-ID: <1526903890-35761-10-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/phy/tegra/xusb.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 11aa590..de1b4eb 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -102,19 +102,6 @@ static struct phy *tegra_xusb_pad_of_xlate(struct device *dev,
 	return np;
 }
 
-static int
-tegra_xusb_lane_lookup_function(struct tegra_xusb_lane *lane,
-				    const char *function)
-{
-	unsigned int i;
-
-	for (i = 0; i < lane->soc->num_funcs; i++)
-		if (strcmp(function, lane->soc->funcs[i]) == 0)
-			return i;
-
-	return -EINVAL;
-}
-
 int tegra_xusb_lane_parse_dt(struct tegra_xusb_lane *lane,
 			     struct device_node *np)
 {
@@ -126,7 +113,7 @@ int tegra_xusb_lane_parse_dt(struct tegra_xusb_lane *lane,
 	if (err < 0)
 		return err;
 
-	err = tegra_xusb_lane_lookup_function(lane, function);
+	err = match_string(lane->soc->funcs, lane->soc->num_funcs, function);
 	if (err < 0) {
 		dev_err(dev, "invalid function \"%s\" for lane \"%s\"\n",
 			function, np->name);
-- 
1.7.12.4
