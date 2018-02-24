Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbeBXWnb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:43:31 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:33094 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeBXWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:43:30 -0500
Date: Sat, 24 Feb 2018 23:43:28 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: imx: Fix PM device usage count
Message-ID: <20180224224328.2pfki7rqcxqetmlz@agrajag.zerfleddert.de>
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

Fixes: 588eb93ea49f ("i2c: imx: add runtime pm support to improve the
  performance")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
In i2c_imx_xfer(), one could also move the "out" label up (in front of
the call to pm_runtime_put_autosuspend()), but I'm not sure what the
underlying error scenario is; calling _put_noidle() seems to be the
safer bet.

This is one of a number of patches for problems found using coccinelle 
scripting in the SIL2LinuxMP project. The patch has been compile-tested;
it's based on linux-next-20180223.

For a discussion of the corresponding issue, see
https://marc.info/?l=linux-pm&m=151904483924999&w=2

 drivers/i2c/busses/i2c-imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 999557729ad2..dae3c923d42c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -890,8 +890,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
 	result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
-	if (result < 0)
+	if (result < 0) {
+		pm_runtime_put_noidle(i2c_imx->adapter.dev.parent);
 		goto out;
+	}
 
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx);
@@ -1179,8 +1181,10 @@ static int i2c_imx_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		return ret;
+	}
 
 	/* remove adapter */
 	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
-- 
2.11.0
