Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeBXWo0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:44:26 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:33118 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBXWoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:44:25 -0500
Date: Sat, 24 Feb 2018 23:44:23 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH] i2c: tegra: Fix PM device usage count
Message-ID: <20180224224423.hz36gpxnlpex2cqx@agrajag.zerfleddert.de>
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

Fixes: 1f50ad2c86cd ("i2c: tegra: Add runtime power-management support")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
This is one of a number of patches for problems found using coccinelle 
scripting in the SIL2LinuxMP project. The patch has been compile-tested;
it's based on linux-next-20180223.

For a discussion of the corresponding issue, see
https://marc.info/?l=linux-pm&m=151904483924999&w=2

 drivers/i2c/busses/i2c-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 60292d243e24..d53136538339 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -484,6 +484,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 	err = pm_runtime_get_sync(i2c_dev->dev);
 	if (err < 0) {
 		dev_err(i2c_dev->dev, "runtime resume failed %d\n", err);
+		pm_runtime_put_noidle(i2c_dev->dev);
 		return err;
 	}
 
@@ -740,6 +741,7 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	ret = pm_runtime_get_sync(i2c_dev->dev);
 	if (ret < 0) {
 		dev_err(i2c_dev->dev, "runtime resume failed %d\n", ret);
+		pm_runtime_put_noidle(i2c_dev->dev);
 		return ret;
 	}
 
-- 
2.11.0
