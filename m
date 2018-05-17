Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbeEQQlh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:41:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53144 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752655AbeEQQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:41:35 -0400
From: Mark Brown <broonie@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Resolve coupled regulators" to the regulator tree
In-Reply-To: <1524494022-22260-5-git-send-email-m.purski@samsung.com>
Message-Id: <20180517164127.086B744007E@finisterre.ee.mobilebroadband>
Date: Thu, 17 May 2018 17:41:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Resolve coupled regulators

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

>From d3d64537c33956c94cfa2376b87d8917868a0f5e Mon Sep 17 00:00:00 2001
From: Maciej Purski <m.purski@samsung.com>
Date: Mon, 23 Apr 2018 16:33:40 +0200
Subject: [PATCH] regulator: core: Resolve coupled regulators

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires
higher voltage, there might occur a situation that the spread between
two devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators.

Fill coupling descriptor with data obtained from DTS using previously
defined of_functions. Fail to register a regulator, if some data
inconsistency occurs. If some coupled regulators are not yet registered,
don't fail to register, but try to resolve them in late init call.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 100 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0ca941b53571..6ed568b96c0e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4129,6 +4129,96 @@ static int regulator_register_resolve_supply(struct device *dev, void *data)
 	return 0;
 }
 
+static int regulator_fill_coupling_array(struct regulator_dev *rdev)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int n_coupled = c_desc->n_coupled;
+	struct regulator_dev *c_rdev;
+	int i;
+
+	for (i = 1; i < n_coupled; i++) {
+		/* already resolved */
+		if (c_desc->coupled_rdevs[i])
+			continue;
+
+		c_rdev = of_parse_coupled_regulator(rdev, i - 1);
+
+		if (c_rdev) {
+			c_desc->coupled_rdevs[i] = c_rdev;
+			c_desc->n_resolved++;
+		}
+	}
+
+	if (rdev->coupling_desc.n_resolved < n_coupled)
+		return -1;
+	else
+		return 0;
+}
+
+static int regulator_register_fill_coupling_array(struct device *dev,
+						  void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+
+	if (!IS_ENABLED(CONFIG_OF))
+		return 0;
+
+	if (regulator_fill_coupling_array(rdev))
+		rdev_dbg(rdev, "unable to resolve coupling\n");
+
+	return 0;
+}
+
+static int regulator_resolve_coupling(struct regulator_dev *rdev)
+{
+	int n_phandles;
+
+	if (!IS_ENABLED(CONFIG_OF))
+		n_phandles = 0;
+	else
+		n_phandles = of_get_n_coupled(rdev);
+
+	if (n_phandles + 1 > MAX_COUPLED) {
+		rdev_err(rdev, "too many regulators coupled\n");
+		return -EPERM;
+	}
+
+	/*
+	 * Every regulator should always have coupling descriptor filled with
+	 * at least pointer to itself.
+	 */
+	rdev->coupling_desc.coupled_rdevs[0] = rdev;
+	rdev->coupling_desc.n_coupled = n_phandles + 1;
+	rdev->coupling_desc.n_resolved++;
+
+	/* regulator isn't coupled */
+	if (n_phandles == 0)
+		return 0;
+
+	/* regulator, which can't change its voltage, can't be coupled */
+	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE)) {
+		rdev_err(rdev, "voltage operation not allowed\n");
+		return -EPERM;
+	}
+
+	if (rdev->constraints->max_spread <= 0) {
+		rdev_err(rdev, "wrong max_spread value\n");
+		return -EPERM;
+	}
+
+	if (!of_check_coupling_data(rdev))
+		return -EPERM;
+
+	/*
+	 * After everything has been checked, try to fill rdevs array
+	 * with pointers to regulators parsed from device tree. If some
+	 * regulators are not registered yet, retry in late init call
+	 */
+	regulator_fill_coupling_array(rdev);
+
+	return 0;
+}
+
 /**
  * regulator_register - register regulator
  * @regulator_desc: regulator to register
@@ -4262,6 +4352,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto wash;
 
+	mutex_lock(&regulator_list_mutex);
+	ret = regulator_resolve_coupling(rdev);
+	mutex_unlock(&regulator_list_mutex);
+
+	if (ret != 0)
+		goto wash;
+
 	/* add consumers devices */
 	if (init_data) {
 		mutex_lock(&regulator_list_mutex);
@@ -4756,6 +4853,9 @@ static int __init regulator_init_complete(void)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_late_cleanup);
 
+	class_for_each_device(&regulator_class, NULL, NULL,
+			      regulator_register_fill_coupling_array);
+
 	return 0;
 }
 late_initcall_sync(regulator_init_complete);
-- 
2.17.0
