Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeBZK10 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:27:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48346 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbeBZK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:26:20 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Joseph Lo <josephl@nvidia.com>
Subject: [PATCH v3 8/8] mfd: cros_ec_i2c: moving the system sleep pm ops to late
Date: Mon, 26 Feb 2018 11:26:06 +0100
Message-Id: <20180226102606.15093-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180226102606.15093-1-enric.balletbo@collabora.com>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Lo <josephl@nvidia.com>

The cros_ec_i2c driver is still active after it had suspended or before it
resumes. Besides that, it also tried to transfer data even after the I2C
host had been suspended. This will lead the system to crash.

During the test, we also observe that the EC needs to be resumed earlier
due to some status polling from the EC FW (e.g. battery status). So we
move the PM ops to late stage to make it work normally.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3:
- [8/8] Add static to cros_ec_i2c_pm_ops.
- [8/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [8/8] This patch is new in this series replacing [5/6] of v1.

 drivers/mfd/cros_ec_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/mfd/cros_ec_i2c.c
index 02a7bacdc056..ef9b4763356f 100644
--- a/drivers/mfd/cros_ec_i2c.c
+++ b/drivers/mfd/cros_ec_i2c.c
@@ -342,8 +342,9 @@ static int cros_ec_i2c_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(cros_ec_i2c_pm_ops, cros_ec_i2c_suspend,
-			  cros_ec_i2c_resume);
+static const struct dev_pm_ops cros_ec_i2c_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_i2c_suspend, cros_ec_i2c_resume)
+};
 
 #ifdef CONFIG_OF
 static const struct of_device_id cros_ec_i2c_of_match[] = {
-- 
2.16.1
