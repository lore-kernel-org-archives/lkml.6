Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755416AbeEAJPu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:15:50 -0400
Received: from foss.arm.com ([217.140.101.70]:44156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeEAJLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:11:39 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 12/27] coresight: tmc-etr: Allow commandline option to override SG use
Date: Tue,  1 May 2018 10:10:42 +0100
Message-Id: <1525165857-11096-13-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Coresight TMC-ETR SG mode could be unsafe on a platform where
the ETR is not properly connected to account for READ operations.
We use a DT node property to indicate if the system is safe.
This patch also provides a command line parameter to "force"
the use of SG mode to override the firmware information.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Hi

This is more of a debug patch for people who may want to
test their platform without too much of hacking. I am not
too keen on pushing this patch in.
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 drivers/hwtracing/coresight/coresight-tmc.c     | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28e..03b51c3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -675,6 +675,14 @@
 			Enable/disable the CPU sampling based debugging.
 			0: default value, disable debugging
 			1: enable debugging at boot time
+	coresight_tmc.etr_force_sg
+			[ARM, ARM64]
+			Format: <bool>
+			Force using the TMC ETR builtin scatter-gather mode
+			even when it may be unsafe to use.
+			Default : 0, do not force using the builtin SG mode.
+				  1, Allow using the SG, ignoring the firmware
+				     provided information.
 
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index e38379c..c7bc681 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/module.h>
 #include <linux/property.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
@@ -33,6 +34,8 @@
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
+static bool etr_force_sg;
+
 void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
 	/* Ensure formatter, unformatter and hardware fifo are empty */
@@ -307,7 +310,8 @@ const struct attribute_group *coresight_tmc_groups[] = {
 
 static inline bool tmc_etr_can_use_sg(struct tmc_drvdata *drvdata)
 {
-	return fwnode_property_present(drvdata->dev->fwnode, "scatter-gather");
+	return etr_force_sg ||
+	       fwnode_property_present(drvdata->dev->fwnode, "scatter-gather");
 }
 
 /* Detect and initialise the capabilities of a TMC ETR */
@@ -482,3 +486,4 @@ static struct amba_driver tmc_driver = {
 	.id_table	= tmc_ids,
 };
 builtin_amba_driver(tmc_driver);
+module_param(etr_force_sg, bool, 0);
-- 
2.7.4
