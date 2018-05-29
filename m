Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934267AbeE2NTt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:19:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39960 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934240AbeE2NQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:16:21 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 03/12] coresight: tmc-etr: Do not clean trace buffer
Date: Tue, 29 May 2018 14:15:28 +0100
Message-Id: <1527599737-28408-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We zero out the entire trace buffer used for ETR before it is enabled,
for helping with debugging. With the addition of scatter-gather mode,
the buffer could be bigger and non-contiguous.

Get rid of this step; if someone wants to debug, they can always add it
as and when needed.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f88342d..1de05c9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -13,9 +13,6 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl, sts;
 
-	/* Zero out the memory to help with debug */
-	memset(drvdata->vaddr, 0, drvdata->size);
-
 	CS_UNLOCK(drvdata->base);
 
 	/* Wait for TMCSReady bit to be set */
@@ -340,9 +337,8 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	if (drvdata->mode == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
-		 * buffer. The trace buffer is cleared in tmc_etr_enable_hw(),
-		 * so we don't have to explicitly clear it. Also, since the
-		 * tracer is still enabled drvdata::buf can't be NULL.
+		 * buffer. Since the tracer is still enabled drvdata::buf can't
+		 * be NULL.
 		 */
 		tmc_etr_enable_hw(drvdata);
 	} else {
-- 
2.7.4
