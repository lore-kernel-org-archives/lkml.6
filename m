Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeERQjv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:39:51 -0400
Received: from foss.arm.com ([217.140.101.70]:56100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbeERQjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:39:47 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, sudeep.holla@arm.com, frowand.list@gmail.com,
        coresight@lists.linaro.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, John Horley <john.horley@arm.com>,
        Robert Walker <robert.walker@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 06/11] dts: bindings: Restrict coresight tmc-etr scatter-gather mode
Date: Fri, 18 May 2018 17:39:22 +0100
Message-Id: <1526661567-4578-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to add the support for ETR builtin scatter-gather mode
for dealing with large amount of trace buffers. However, on some of
the platforms, using the ETR SG mode can lock up the system due to
the way the ETR is connected to the memory subsystem.

In SG mode, the ETR performs READ from the scatter-gather table to
fetch the next page and regular WRITE of trace data. If the READ
operation doesn't complete(due to the memory subsystem issues,
which we have seen on a couple of platforms) the trace WRITE
cannot proceed leading to issues. So, we by default do not
use the SG mode, unless it is known to be safe on the platform.
We define a DT property for the TMC node to specify whether we
have a proper SG mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: John Horley <john.horley@arm.com>
Cc: Robert Walker <robert.walker@arm.com>
Cc: devicetree@vger.kernel.org
Cc: frowand.list@gmail.com
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
 drivers/hwtracing/coresight/coresight-tmc.c         | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 15ac8e8..603d3c6 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -86,6 +86,8 @@ its hardware characteristcs.
 	* arm,buffer-size: size of contiguous buffer space for TMC ETR
 	 (embedded trace router)
 
+	* arm,scatter-gather: boolean. Indicates that the TMC-ETR can safely
+	  use the SG mode on this system.
 
 Example:
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 93c5bfc..7d8331d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/property.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
@@ -304,6 +305,12 @@ const struct attribute_group *coresight_tmc_groups[] = {
 	NULL,
 };
 
+static inline bool tmc_etr_can_use_sg(struct tmc_drvdata *drvdata)
+{
+	return fwnode_property_present(drvdata->dev->fwnode,
+				       "arm,scatter-gather");
+}
+
 /* Detect and initialise the capabilities of a TMC ETR */
 static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 			     u32 devid, void *dev_caps)
@@ -313,7 +320,7 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 	/* Set the unadvertised capabilities */
 	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
 
-	if (!(devid & TMC_DEVID_NOSCAT))
+	if (!(devid & TMC_DEVID_NOSCAT) && tmc_etr_can_use_sg(drvdata))
 		tmc_etr_set_cap(drvdata, TMC_ETR_SG);
 
 	/* Check if the AXI address width is available */
-- 
2.7.4
