Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD91C676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475D62084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N0dOFLJg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F8inf5hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475D62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJHUKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:10:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJHUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:10:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3BAC360BFA; Mon,  8 Oct 2018 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003514;
        bh=5cYhOuesC706GUAgOUXoSmE00Bwr9g+9IrGNf3kUexE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0dOFLJgTrzUwXh7LApPPEDA4xFNHMqE1VNBGEq76EVB/0kN0TPhZQkDRyb6GFZzw
         BaXrh5U8ThkTWXfUPxj5M3r4fM5/P01xfPAaDibRfJujlGp/EMaCti84dCo8Iwj8LL
         w8DYnl1is8cgeb2WIiBsWILl94mIo2XAAgurJFiQ=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDE4160C6A;
        Mon,  8 Oct 2018 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003513;
        bh=5cYhOuesC706GUAgOUXoSmE00Bwr9g+9IrGNf3kUexE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8inf5hmv5PFbRP2oB+fJZmfDaVrjXzEqwM0UYtV6zOXWsWoLGHyH6s72S+lmT7SJ
         6BKrPZ6BnUPVtghBquBelnto4Dw6Zo/KjZWgLz4FpC6Xv4+zeuAaDKC7NFXCVkKtEK
         7TLO9hnEgoA0LDDPgFR8FFE1QxTEIQ9yXBukzeIA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDE4160C6A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
Subject: [PATCH V1 1/7] devfreq: Add new flag to do simple clock scaling
Date:   Mon,  8 Oct 2018 18:28:00 +0530
Message-Id: <1539003486-24087-2-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
References: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
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

