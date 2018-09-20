Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1893721533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3P0FTMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1893721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbeIUBF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:05:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39994 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388572AbeIUBEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so4875664pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SzFk6dtDlJeMVc6wDpFORp4xi55mVKK/kcJWa63rh4U=;
        b=O3P0FTMqrFW1T19bYs+eHLsebUDbMoVpQAtSryseJoCJ1YMnY9JJ2lhrEMRPdexLSJ
         BSbovZszdcoUuq0jbhANctb754vz9jIAYEqjIQ2VcKlCxyKTcUplCcArKmXU4IwIXtKQ
         ApbYuv2/D0SGRuWjPUlR8UIZpaxcyzSghJmF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SzFk6dtDlJeMVc6wDpFORp4xi55mVKK/kcJWa63rh4U=;
        b=snE14meEWdPX3EJAPMUTdefFOiYD8Xv+B7mK+4CpY6CdshZPNl+a6ezJ25c7hihPEm
         jeAm1pkI6/MHSH8MJ6SLteoxn5cqPLT18pUNbKHuxmnToUD2xe6YNct67IRc0u6gbbdV
         vuSCY6DY6II8GWRA3A3HtLdAkgIxrWASpcyW75slmwXw7UWpeKLDFOsOr/9KqMKKx/lK
         a4/DluuMyUV041LVl7fJkLXt7q87Et5yph1tvZiYbCIVCWXgC0J9aTIinjvhqhUh4nJx
         MHejDXaNMimomcdiV9yp/kVjLv5QbCWOLQYuttuCYOfsG9Dkkz4t9s5CYyCTDknehxOH
         lYjQ==
X-Gm-Message-State: APzg51B2SRUtylESi3u9OYke84b5RFOWJ4pJpR6rvP+P5FJ1d1zaPtKr
        YncmGdTrscrFjHNeBqjAC+nU7A==
X-Google-Smtp-Source: ANB0VdbZWxPYsErQxFuJgk/oYqcWjl/Cejx4z3sRZ/Jz01IIAEvYodRyfLTR1j79mFXCWhf/7H3Drg==
X-Received: by 2002:a62:fc5:: with SMTP id 66-v6mr42417065pfp.237.1537471150739;
        Thu, 20 Sep 2018 12:19:10 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:09 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 32/44] coresight: etm4x: Add support for handling errors
Date:   Thu, 20 Sep 2018 13:18:07 -0600
Message-Id: <1537471099-19781-33-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add support for handling errors in enabling the component.
The ETM is enabled via cross call to owner CPU. Make
necessary changes to report the error back from the cross
call.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 39 ++++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index b7379e9cfb30..064e0bfaefd0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -78,10 +78,14 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	return drvdata->trcid;
 }
 
-static void etm4_enable_hw(void *info)
+struct etm4_enable_arg {
+	struct etmv4_drvdata *drvdata;
+	int rc;
+};
+
+static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i;
-	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
@@ -178,6 +182,16 @@ static void etm4_enable_hw(void *info)
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+	return 0;
+}
+
+static void etm4_enable_hw_smp_call(void *info)
+{
+	struct etm4_enable_arg *arg = info;
+
+	if (WARN_ON(!arg))
+		return;
+	arg->rc = etm4_enable_hw(arg->drvdata);
 }
 
 static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
@@ -243,7 +257,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	if (ret)
 		goto out;
 	/* And enable it */
-	etm4_enable_hw(drvdata);
+	ret = etm4_enable_hw(drvdata);
 
 out:
 	return ret;
@@ -252,6 +266,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 static int etm4_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etm4_enable_arg arg = { 0 };
 	int ret;
 
 	spin_lock(&drvdata->spinlock);
@@ -260,19 +275,17 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
 	 */
+	arg.drvdata = drvdata;
 	ret = smp_call_function_single(drvdata->cpu,
-				       etm4_enable_hw, drvdata, 1);
-	if (ret)
-		goto err;
-
-	drvdata->sticky_enable = true;
+				       etm4_enable_hw_smp_call, &arg, 1);
+	if (!ret)
+		ret = arg.rc;
+	if (!ret)
+		drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
-	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
-	return 0;
-
-err:
-	spin_unlock(&drvdata->spinlock);
+	if (!ret)
+		dev_dbg(drvdata->dev, "ETM tracing enabled\n");
 	return ret;
 }
 
-- 
2.7.4

