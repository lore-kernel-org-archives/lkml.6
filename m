Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeCERST (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:18:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40770 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCERSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:18:16 -0500
From: Mark Brown <broonie@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Fix build errors" to the regulator tree
In-Reply-To: 
Message-Id: <E1estkZ-0007wV-Bw@debutante>
Date: Mon, 05 Mar 2018 17:18:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Fix build errors

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

>From 7c078de5edf1b46236a52cf49614eef2dcb7ecae Mon Sep 17 00:00:00 2001
From: Maciej Purski <m.purski@samsung.com>
Date: Mon, 5 Mar 2018 14:03:59 +0100
Subject: [PATCH] regulator: core: Fix build errors

Build errors detected by kbuild test robot occur on non-of
architectures.

This patch fixes this behavior as well as using plain integer instead
of NULL in of_count_phandle_with_args().

Fixes: 0c55103 ("regulator: core: Parse coupled regulators properties")
Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/internal.h     | 34 ++++++++++++++++++++++++++--------
 drivers/regulator/of_regulator.c |  5 +++--
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index f253a47b9a99..485db15bee99 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -63,6 +63,14 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 			         const struct regulator_desc *desc,
 				 struct regulator_config *config,
 				 struct device_node **node);
+
+struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
+						 int index);
+
+int of_get_n_coupled(struct regulator_dev *rdev);
+
+bool of_check_coupling_data(struct regulator_dev *rdev);
+
 #else
 static inline struct regulator_init_data *
 regulator_of_get_init_data(struct device *dev,
@@ -72,8 +80,25 @@ regulator_of_get_init_data(struct device *dev,
 {
 	return NULL;
 }
-#endif
 
+static inline struct regulator_dev *
+of_parse_coupled_regulator(struct regulator_dev *rdev,
+			   int index)
+{
+	return NULL;
+}
+
+static inline int of_get_n_coupled(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline bool of_check_coupling_data(struct regulator_dev *rdev)
+{
+	return false;
+}
+
+#endif
 enum regulator_get_type {
 	NORMAL_GET,
 	EXCLUSIVE_GET,
@@ -83,11 +108,4 @@ enum regulator_get_type {
 
 struct regulator *_regulator_get(struct device *dev, const char *id,
 				 enum regulator_get_type get_type);
-
-struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
-						 int index);
-
-int of_get_n_coupled(struct regulator_dev *rdev);
-
-bool of_check_coupling_data(struct regulator_dev *rdev);
 #endif
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index a2eb9046adf8..98ee098e8c35 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -434,7 +434,8 @@ static bool of_coupling_find_node(struct device_node *src,
 	bool found = false;
 
 	n_phandles = of_count_phandle_with_args(src,
-						"regulator-coupled-with", 0);
+						"regulator-coupled-with",
+						NULL);
 
 	for (i = 0; i < n_phandles; i++) {
 		struct device_node *tmp = of_parse_phandle(src,
@@ -495,7 +496,7 @@ bool of_check_coupling_data(struct regulator_dev *rdev)
 
 		c_n_phandles = of_count_phandle_with_args(c_node,
 							  "regulator-coupled-with",
-							  0);
+							  NULL);
 
 		if (c_n_phandles != n_phandles) {
 			dev_err(&rdev->dev, "number of couped reg phandles mismatch\n");
-- 
2.16.2
