Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeERQmc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:42:32 -0400
Received: from foss.arm.com ([217.140.101.70]:56030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751184AbeERQjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:39:37 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, sudeep.holla@arm.com, frowand.list@gmail.com,
        coresight@lists.linaro.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 01/11] coresight: ETM: Add support for Arm Cortex-A73 and Cortex-A35
Date: Fri, 18 May 2018 17:39:17 +0100
Message-Id: <1526661567-4578-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ETM PIDs of the Arm cortex-A CPUs to the white list of ETMs.
While at it, also add description of the CPU to which the ETM belongs,
to make it easier to identify the ETM devices.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 32 +++++++++++++--------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index cf364a5..fe5b41c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1034,7 +1034,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "CPU%d: %s initialized\n",
+			drvdata->cpu, (char *)id->data);
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1052,23 +1053,20 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+#define ETM4_AMBA_ID(cpu, pid)			\
+	{					\
+		.id	= pid,			\
+		.mask	= 0x000fffff,		\
+		.data	= #cpu " ETM v4.x",	\
+	}
+
 static const struct amba_id etm4_ids[] = {
-	{       /* ETM 4.0 - Cortex-A53  */
-		.id	= 0x000bb95d,
-		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
-	},
-	{       /* ETM 4.0 - Cortex-A57 */
-		.id	= 0x000bb95e,
-		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
-	},
-	{       /* ETM 4.0 - A72, Maia, HiSilicon */
-		.id = 0x000bb95a,
-		.mask = 0x000fffff,
-		.data = "ETM 4.0",
-	},
-	{ 0, 0},
+	ETM4_AMBA_ID(Cortex-A53, 0x000bb95d),
+	ETM4_AMBA_ID(Cortex-A57, 0x000bb95e),
+	ETM4_AMBA_ID(Cortex-A72, 0x000bb95a),
+	ETM4_AMBA_ID(Cortex-A73, 0x000bb959),
+	ETM4_AMBA_ID(Cortex-A35, 0x000bb9da),
+	{},
 };
 
 static struct amba_driver etm4x_driver = {
-- 
2.7.4
