Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4784ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8705020842
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="THuRnKgC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KTCc/1c0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8705020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeGMKHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:07:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49354 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGMKHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:07:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2EB660B72; Fri, 13 Jul 2018 09:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475608;
        bh=5cYhOuesC706GUAgOUXoSmE00Bwr9g+9IrGNf3kUexE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=THuRnKgCO6KQkrG8Ib+DB5LHnCIDvHi4KE8BvtbwWZHRwG+TebnWABOi7aJUnC5jH
         KgxzPv3rAvjYDkrUTi82dpaGdqGBGTdEomDXP06t/9OSUfjG0i57tXpCB9Hd1J+lrU
         VqlzgnGeRZz5flMrZKcwMdHDMQW1i258c3Mha7HA=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A602460B10;
        Fri, 13 Jul 2018 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475607;
        bh=5cYhOuesC706GUAgOUXoSmE00Bwr9g+9IrGNf3kUexE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTCc/1c00UjS9LzOidK0kklNZQGN7dL22ZLNdCJKR746Gw4ahNDZchk9h43Kf2+fO
         82UeEKBfl2PhSbXgydvSU5XfdqYJKx7v0fU/LtCBmv5n+LHS0IvhrThVk/q+pWfDXl
         po1bvNxE7+PQ0hZe+t3BaFxl6ZCPtNeE9jemBlMo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A602460B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, sayalil@codeaurora.org
Subject: [PATCH RFC 1/7] devfreq: Add new flag to do simple clock scaling
Date:   Fri, 13 Jul 2018 15:22:57 +0530
Message-Id: <1531475583-7050-2-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

Add new flag "simple_scaling" to on demand governor so that
the clocks can be scaled up only when the load is more than
up threshold and can be scaled down only when the load is less
than down differential data as provided within
struct devfreq_simple_ondemand_data.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/devfreq/governor_simpleondemand.c | 25 +++++++++++++++++++------
 include/linux/devfreq.h                   |  4 ++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 28e0f2d..532801b 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -28,6 +28,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
 	struct devfreq_simple_ondemand_data *data = df->data;
 	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
+	unsigned long min = (df->min_freq) ? df->min_freq : 0;
 
 	err = devfreq_update_stats(df);
 	if (err)
@@ -45,18 +46,30 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	    dfso_upthreshold < dfso_downdifferential)
 		return -EINVAL;
 
-	/* Assume MAX if it is going to be divided by zero */
-	if (stat->total_time == 0) {
-		*freq = max;
-		return 0;
-	}
-
 	/* Prevent overflow */
 	if (stat->busy_time >= (1 << 24) || stat->total_time >= (1 << 24)) {
 		stat->busy_time >>= 7;
 		stat->total_time >>= 7;
 	}
 
+	if (data && data->simple_scaling) {
+		if (stat->busy_time * 100 >
+		    stat->total_time * dfso_upthreshold)
+			*freq = max;
+		else if (stat->busy_time * 100 <
+		    stat->total_time * dfso_downdifferential)
+			*freq = min;
+		else
+			*freq = df->previous_freq;
+		return 0;
+	}
+
+	/* Assume MAX if it is going to be divided by zero */
+	if (stat->total_time == 0) {
+		*freq = max;
+		return 0;
+	}
+
 	/* Set MAX if it's busy enough */
 	if (stat->busy_time * 100 >
 	    stat->total_time * dfso_upthreshold) {
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 3aae5b3..2957fd8 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -236,6 +236,9 @@ extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
  *			the governor may consider slowing the frequency down.
  *			Specify 0 to use the default. Valid value = 0 to 100.
  *			downdifferential < upthreshold must hold.
+ * @simple_scaling:	Setting this flag will scale the clocks up only if the
+ *			load is above @upthreshold and will scale the clocks
+ *			down only if the load is below @downdifferential.
  *
  * If the fed devfreq_simple_ondemand_data pointer is NULL to the governor,
  * the governor uses the default values.
@@ -243,6 +246,7 @@ extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 struct devfreq_simple_ondemand_data {
 	unsigned int upthreshold;
 	unsigned int downdifferential;
+	unsigned int simple_scaling;
 };
 #endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

