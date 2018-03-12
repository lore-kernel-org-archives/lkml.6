Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932478AbeCLQ3E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:29:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45026 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932421AbeCLQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:29:03 -0400
From: Mark Brown <broonie@kernel.org>
To: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: leave one item to record if regulator is enabled" to the regulator tree
In-Reply-To: <20171215151112.25C1744006B@finisterre.ee.mobilebroadband>
Message-Id: <20180312162859.6479C440079@finisterre.ee.mobilebroadband>
Date: Mon, 12 Mar 2018 16:28:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: leave one item to record if regulator is enabled

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6d55d4654bdb36febef53a69bed769cc9f4c19fb Mon Sep 17 00:00:00 2001
From: Chunyan Zhang <zhang.chunyan@linaro.org>
Date: Fri, 15 Dec 2017 21:43:47 +0800
Subject: [PATCH] regulator: leave one item to record if regulator is enabled

The items "disabled" and "enabled" are a little redundant, since only one
of them would be set to record if the regulator device should keep on
or be switched to off in suspend states.

So in this patch, the "disabled" was removed, only leave the "enabled":
  - enabled == 1 for regulator-on-in-suspend
  - enabled == 0 for regulator-off-in-suspend
  - enabled == -1 means do nothing when entering suspend mode.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c          | 14 ++++++--------
 drivers/regulator/of_regulator.c  |  6 ++++--
 include/linux/regulator/machine.h | 12 +++++++++---
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 97bc9f7adf2f..5ea80e94eb69 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -742,21 +742,19 @@ static int suspend_set_state(struct regulator_dev *rdev,
 	 * only warn if the driver implements set_suspend_voltage or
 	 * set_suspend_mode callback.
 	 */
-	if (!rstate->enabled && !rstate->disabled) {
+	if (rstate->enabled != ENABLE_IN_SUSPEND &&
+	    rstate->enabled != DISABLE_IN_SUSPEND) {
 		if (rdev->desc->ops->set_suspend_voltage ||
 		    rdev->desc->ops->set_suspend_mode)
 			rdev_warn(rdev, "No configuration\n");
 		return 0;
 	}
 
-	if (rstate->enabled && rstate->disabled) {
-		rdev_err(rdev, "invalid configuration\n");
-		return -EINVAL;
-	}
-
-	if (rstate->enabled && rdev->desc->ops->set_suspend_enable)
+	if (rstate->enabled == ENABLE_IN_SUSPEND &&
+		rdev->desc->ops->set_suspend_enable)
 		ret = rdev->desc->ops->set_suspend_enable(rdev);
-	else if (rstate->disabled && rdev->desc->ops->set_suspend_disable)
+	else if (rstate->enabled == DISABLE_IN_SUSPEND &&
+		rdev->desc->ops->set_suspend_disable)
 		ret = rdev->desc->ops->set_suspend_disable(rdev);
 	else /* OK if set_suspend_enable or set_suspend_disable is NULL */
 		ret = 0;
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 14637a01ba2d..41dad42b18f0 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -177,10 +177,12 @@ static void of_get_regulation_constraints(struct device_node *np,
 
 		if (of_property_read_bool(suspend_np,
 					"regulator-on-in-suspend"))
-			suspend_state->enabled = true;
+			suspend_state->enabled = ENABLE_IN_SUSPEND;
 		else if (of_property_read_bool(suspend_np,
 					"regulator-off-in-suspend"))
-			suspend_state->disabled = true;
+			suspend_state->enabled = DISABLE_IN_SUSPEND;
+		else
+			suspend_state->enabled = DO_NOTHING_IN_SUSPEND;
 
 		if (!of_property_read_u32(suspend_np,
 					"regulator-suspend-microvolt", &pval))
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 9cd4fef37203..e50519f13d4d 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -42,6 +42,11 @@ struct regulator;
 #define REGULATOR_CHANGE_DRMS		0x10
 #define REGULATOR_CHANGE_BYPASS		0x20
 
+/* operations in suspend mode */
+#define DO_NOTHING_IN_SUSPEND	(-1)
+#define DISABLE_IN_SUSPEND	0
+#define ENABLE_IN_SUSPEND	1
+
 /* Regulator active discharge flags */
 enum regulator_active_discharge {
 	REGULATOR_ACTIVE_DISCHARGE_DEFAULT,
@@ -58,14 +63,15 @@ enum regulator_active_discharge {
  *
  * @uV: Operating voltage during suspend.
  * @mode: Operating mode during suspend.
- * @enabled: Enabled during suspend.
- * @disabled: Disabled during suspend.
+ * @enabled: operations during suspend.
+ *	     - DO_NOTHING_IN_SUSPEND
+ *	     - DISABLE_IN_SUSPEND
+ *	     - ENABLE_IN_SUSPEND
  */
 struct regulator_state {
 	int uV;	/* suspend voltage */
 	unsigned int mode; /* suspend regulator operating mode */
 	int enabled; /* is regulator enabled in this suspend state */
-	int disabled; /* is the regulator disabled in this suspend state */
 };
 
 /**
-- 
2.16.2
