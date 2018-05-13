Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEMVPG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 17:15:06 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34058 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeEMVPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 17:15:04 -0400
X-Google-Smtp-Source: AB8JxZoflE4xilKFHRfLivDRi2UVvSCUMo9dcc8NFdl/HSlDjSLaQQmqc4wyURNpLAQ61ej3lSdX3Q==
From: Dmitry Osipenko <digetx@gmail.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] i2c: tegra: Remove suspend-resume
Date: Mon, 14 May 2018 00:13:47 +0300
Message-Id: <20180513211347.7187-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing prevents I2C clients to access I2C while Tegra's driver is being
suspended, this results in -EBUSY error returned to the clients and that
may have unfortunate consequences. In particular this causes problems
for the TPS6586x MFD driver which emits hundreds of "failed to read
interrupt status" error messages on resume from suspend. This happens if
TPS6586X is used to wake system from suspend by the expired RTC alarm
timer because TPS6586X is an I2C device driver and its IRQ handler reads
the status register while Tegra's I2C driver is suspended, i.e. just after
kernel enabled IRQ's during of resume-from-suspend process.

Note that the removed tegra_i2c_resume() invoked tegra_i2c_init() which
performs HW reset. That seems was also not entirely correct because moving
tegra_i2c_resume to an earlier stage of resume-from-suspend process causes
I2C transfer to fail in the case of TPS6586X. It is fine to remove the
HW-reinitialization for now because it should be only needed in a case of
using lowest power-mode during suspend, which upstream kernel doesn't
support.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Cc: <stable@vger.kernel.org>
---
 drivers/i2c/busses/i2c-tegra.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 60292d243e24..5fccd1f1bca8 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -173,7 +173,6 @@ struct tegra_i2c_hw_feature {
  * @msg_buf_remaining: size of unsent data in the message buffer
  * @msg_read: identifies read transfers
  * @bus_clk_rate: current i2c bus clock rate
- * @is_suspended: prevents i2c controller accesses after suspend is called
  */
 struct tegra_i2c_dev {
 	struct device *dev;
@@ -194,7 +193,6 @@ struct tegra_i2c_dev {
 	int msg_read;
 	u32 bus_clk_rate;
 	u16 clk_divisor_non_hs_mode;
-	bool is_suspended;
 	bool is_multimaster_mode;
 	spinlock_t xfer_lock;
 };
@@ -734,9 +732,6 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	int i;
 	int ret = 0;
 
-	if (i2c_dev->is_suspended)
-		return -EBUSY;
-
 	ret = pm_runtime_get_sync(i2c_dev->dev);
 	if (ret < 0) {
 		dev_err(i2c_dev->dev, "runtime resume failed %d\n", ret);
@@ -1051,37 +1046,9 @@ static int tegra_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int tegra_i2c_suspend(struct device *dev)
-{
-	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
-
-	i2c_lock_adapter(&i2c_dev->adapter);
-	i2c_dev->is_suspended = true;
-	i2c_unlock_adapter(&i2c_dev->adapter);
-
-	return 0;
-}
-
-static int tegra_i2c_resume(struct device *dev)
-{
-	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
-	int ret;
-
-	i2c_lock_adapter(&i2c_dev->adapter);
-
-	ret = tegra_i2c_init(i2c_dev);
-	if (!ret)
-		i2c_dev->is_suspended = false;
-
-	i2c_unlock_adapter(&i2c_dev->adapter);
-
-	return ret;
-}
-
 static const struct dev_pm_ops tegra_i2c_pm = {
 	SET_RUNTIME_PM_OPS(tegra_i2c_runtime_suspend, tegra_i2c_runtime_resume,
 			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend, tegra_i2c_resume)
 };
 #define TEGRA_I2C_PM	(&tegra_i2c_pm)
 #else
-- 
2.17.0
