Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755790AbeEaRFu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:05:50 -0400
Received: from muru.com ([72.249.23.125]:45570 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755797AbeEaRFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:05:49 -0400
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH] phy: mapphone-mdm6600: Fix wrong enum used for status lines
Date: Thu, 31 May 2018 10:05:38 -0700
Message-Id: <20180531170538.32264-1-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuilt test robot reported:

drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: warning:  is used
uninitialized in this function [-Wuninitialized]
        val |= values[i] << i;
               ~~~~~~^~~

Looking at the phy_mdm6600_status() values does get initialized by
gpiod_get_array_value_cansleep(), but we are using wrong enum
in that function. Let's fix the use, both end up being three though
so urgent rush on this one AFAIK.

Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for
MDM6600 on Droid 4")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -182,13 +182,13 @@ static void phy_mdm6600_status(struct work_struct *work)
 	ddata = container_of(work, struct phy_mdm6600, status_work.work);
 	dev = ddata->dev;
 
-	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
+	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_STATUS_LINES,
 					       ddata->status_gpios->desc,
 					       values);
 	if (error)
 		return;
 
-	for (i = 0; i < PHY_MDM6600_NR_CMD_LINES; i++) {
+	for (i = 0; i < PHY_MDM6600_NR_STATUS_LINES; i++) {
 		val |= values[i] << i;
 		dev_dbg(ddata->dev, "XXX %s: i: %i values[i]: %i val: %i\n",
 			__func__, i, values[i], val);
-- 
2.17.0
