Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeBXWoH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:44:07 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:33108 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeBXWoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:44:06 -0500
Date: Sat, 24 Feb 2018 23:44:04 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: sprd: Fix PM device usage count
Message-ID: <20180224224404.un32pjj76chi2bqc@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() increases the device's usage count even when
reporting an error, so add a call to pm_runtime_put_noidle() in the
related error branches.

Fixes: 8b9ec0719834 ("i2c: Add Spreadtrum I2C controller driver")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
This is one of a number of patches for problems found using coccinelle 
scripting in the SIL2LinuxMP project. The patch has been compile-tested;
it's based on linux-next-20180223.

For a discussion of the corresponding issue, see
https://marc.info/?l=linux-pm&m=151904483924999&w=2

 drivers/i2c/busses/i2c-sprd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 25fcc3c1e32b..5dae56e9ef73 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -284,8 +284,10 @@ static int sprd_i2c_master_xfer(struct i2c_adapter *i2c_adap,
 	int im, ret;
 
 	ret = pm_runtime_get_sync(i2c_dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(i2c_dev->dev);
 		return ret;
+	}
 
 	for (im = 0; im < num - 1; im++) {
 		ret = sprd_i2c_handle_msg(i2c_adap, &msgs[im], 0);
@@ -572,8 +574,10 @@ static int sprd_i2c_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_get_sync(i2c_dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(i2c_dev->dev);
 		return ret;
+	}
 
 	i2c_del_adapter(&i2c_dev->adap);
 	clk_disable_unprepare(i2c_dev->clk);
-- 
2.11.0
