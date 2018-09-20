Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B067CECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C8321531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFxhI9VX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C8321531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbeIUBDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44724 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388702AbeIUBDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so4869055pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ivmOX6tgxT1fHE4D3dvFMA9pX4WdQdVXEtSEe52x+DM=;
        b=eFxhI9VX8R79nHZBuH0TWpyBnN5A+DY0+Cs4SC1yYLGIKrMvCWboYZJ3d8FX6YOBek
         EHXq+BVWwUR6n3bqxNZQb5GLK+e+fMYROc2mvW3CTbsEo7i7hq8UFSdElIUWEtdn+pJV
         HEA+AVnp2dhE/nGef1DFuYVl4nsix+4TTzvJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ivmOX6tgxT1fHE4D3dvFMA9pX4WdQdVXEtSEe52x+DM=;
        b=YwM9SaORMhlkNE5AYOkkrKg4tDZZ+IAJYDu5F5HNezOt3d0KcQic8UrqZ1bcIAUUGW
         27hAIHrRByBmEyopFaIT6NOHGITd2BnAehVEL879u1/Gpv1PReiFwbjzjXoZn12cOWuQ
         lRg12Zq1TfuwpcdSjVadVEn5R79zpkSqRUkBx8Mh83N8NcclVG1qBdn+NknrPRDP6C5r
         sl6w/zF7MdTY0QaFqF6iIWwzgn2hz5RsmJhsx5lBiCY9k/xzOsFtkohc42SFzBvIsDrg
         2YYKLSxd8jlPHVRukSky0nA16RRmAgYki4L86aWAdDkoJPlUijv7QYAtl6dcdC0GvvTC
         5tfw==
X-Gm-Message-State: APzg51A0EGSuxOJ+uxSpbp0LQxh2r1B/dJrCFMK2DbLQnyKttCuFvft6
        r4jLUH4UI9notr5OgOUg9hvyrZnJOLY=
X-Google-Smtp-Source: ANB0VdZmtqzKAqK8soThp/nHliOt85tv+ah4cYRT0NNwTM6PDrPGhmtri5XRAja2+QxIvecLOK7O5g==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr43022850pfg.42.1537471116843;
        Thu, 20 Sep 2018 12:18:36 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:35 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/44] coresight: Fix handling of sinks
Date:   Thu, 20 Sep 2018 13:17:45 -0600
Message-Id: <1537471099-19781-11-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 5e8880ca8078..07382c55b31d 100644
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

