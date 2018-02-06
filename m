Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBFQhc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:37:32 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18934 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeBFQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:34:40 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 06 Feb 2018 08:34:39 -0800
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH v3 01/11] regulator: core: add API to get voltage constraints
Date: Tue, 6 Feb 2018 18:34:02 +0200
Message-ID: <1517934852-23255-2-git-send-email-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laxman Dewangan <ldewangan@nvidia.com>

Add API to get min/max rail voltage configured from platform for
given rails.

Changes to the commit message by
Peter De Schrijver <pdeschrijver@nvidia.com>

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/regulator/core.c           | 31 +++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index be767dd..c498774 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3246,6 +3246,37 @@ int regulator_get_voltage(struct regulator *regulator)
 EXPORT_SYMBOL_GPL(regulator_get_voltage);
 
 /**
+ * regulator_get_constraint_voltages - get platform specific constraint voltage,
+ * @regulator: regulator source
+ * @min_uV: Minimum microvolts.
+ * @max_uV: Maximum microvolts.
+ *
+ * This returns the current regulator voltage in uV.
+ *
+ * NOTE: If the regulator is disabled it will return the voltage value. This
+ * function should not be used to determine regulator state.
+ */
+
+int regulator_get_constraint_voltages(struct regulator *regulator,
+	int *min_uV, int *max_uV)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+
+	if (rdev->desc && rdev->desc->fixed_uV && rdev->desc->n_voltages == 1) {
+		*min_uV = rdev->desc->fixed_uV;
+		*max_uV = rdev->desc->fixed_uV;
+		return 0;
+	}
+	if (rdev->constraints) {
+		*min_uV = rdev->constraints->min_uV;
+		*max_uV = rdev->constraints->max_uV;
+		return 0;
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(regulator_get_constraint_voltages);
+
+/**
  * regulator_set_current_limit - set regulator output current limit
  * @regulator: regulator source
  * @min_uA: Minimum supported current in uA
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index df176d7..d3f495a 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -250,6 +250,8 @@ int regulator_is_supported_voltage(struct regulator *regulator,
 int regulator_set_voltage_time(struct regulator *regulator,
 			       int old_uV, int new_uV);
 int regulator_get_voltage(struct regulator *regulator);
+int regulator_get_constraint_voltages(struct regulator *regulator,
+	int *min_uV, int *max_uV);
 int regulator_sync_voltage(struct regulator *regulator);
 int regulator_set_current_limit(struct regulator *regulator,
 			       int min_uA, int max_uA);
-- 
1.9.1
