Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeERQmB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:42:01 -0400
Received: from foss.arm.com ([217.140.101.70]:56068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751942AbeERQjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:39:43 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, sudeep.holla@arm.com, frowand.list@gmail.com,
        coresight@lists.linaro.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 04/11] coresight: tmc-etr: Disallow perf mode
Date: Fri, 18 May 2018 17:39:20 +0100
Message-Id: <1526661567-4578-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't support ETR in perf mode yet. So, don't
even try to enable the hardware, even by mistake.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 28 ++-----------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index c73bcb3..6c5e8d1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -223,32 +223,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 
 static int tmc_enable_etr_sink_perf(struct coresight_device *csdev)
 {
-	int ret = 0;
-	unsigned long flags;
-	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->reading) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * In Perf mode there can be only one writer per sink.  There
-	 * is also no need to continue if the ETR is already operated
-	 * from sysFS.
-	 */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	drvdata->mode = CS_MODE_PERF;
-	tmc_etr_enable_hw(drvdata);
-out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-	return ret;
+	/* We don't support perf mode yet ! */
+	return -EINVAL;
 }
 
 static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
-- 
2.7.4
