Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6D1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D422075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D422075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbeGQRpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:45:46 -0400
Received: from foss.arm.com ([217.140.101.70]:50116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730880AbeGQRpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:45:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F00E15AD;
        Tue, 17 Jul 2018 10:12:09 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 087513F5A0;
        Tue, 17 Jul 2018 10:12:07 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robert.walker@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 01/10] coresight: Fix handling of sinks
Date:   Tue, 17 Jul 2018 18:11:32 +0100
Message-Id: <1531847501-22226-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coresight components could be operated either in sysfs mode or in perf
mode. For some of the components, the mode of operation doesn't matter as
they simply relay the data to the next component in the trace path. But for
sinks, they need to be able to provide the trace data back to the user.
Thus we need to make sure that "mode" is handled appropriately. e.g,
the sysfs mode could have multiple sources driving the trace data, while
perf mode doesn't allow sharing the sink.

The coresight_enable_sink() however doesn't really allow this check to
trigger as it skips the "enable_sink" callback if the component is
already enabled, irrespective of the mode. This could cause mixing
of data from different modes or even same mode (in perf), if the
sources are different. Also, if we fail to enable the sink while
enabling a path (where sink is the first component enabled),
we could end up in disabling the components in the "entire"
path which were not enabled in this trial, causing disruptions
in the existing trace paths.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 3e07fd3..c0dabbd 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -132,12 +132,14 @@ static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
 
-	if (!csdev->enable) {
-		if (sink_ops(csdev)->enable) {
-			ret = sink_ops(csdev)->enable(csdev, mode);
-			if (ret)
-				return ret;
-		}
+	/*
+	 * We need to make sure the "new" session is compatible with the
+	 * existing "mode" of operation.
+	 */
+	if (sink_ops(csdev)->enable) {
+		ret = sink_ops(csdev)->enable(csdev, mode);
+		if (ret)
+			return ret;
 		csdev->enable = true;
 	}
 
@@ -339,8 +341,14 @@ int coresight_enable_path(struct list_head *path, u32 mode)
 		switch (type) {
 		case CORESIGHT_DEV_TYPE_SINK:
 			ret = coresight_enable_sink(csdev, mode);
+			/*
+			 * Sink is the first component turned on. If we
+			 * failed to enable the sink, there are no components
+			 * that need disabling. Disabling the path here
+			 * would mean we could disrupt an existing session.
+			 */
 			if (ret)
-				goto err;
+				goto out;
 			break;
 		case CORESIGHT_DEV_TYPE_SOURCE:
 			/* sources are enabled from either sysFS or Perf */
-- 
2.7.4

