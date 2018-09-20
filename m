Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609F0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ADA21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7QG43wP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ADA21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389039AbeIUBEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36732 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388558AbeIUBEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id p5-v6so4798819plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jasPfZK2wsoNdBWcuDJHTJ/t7P13W2dMZ0nkyY04hwI=;
        b=Y7QG43wPm9TKE2tYCf0S6IUT4pUBEArOvbatjgDJCpuO05UTKAuke4NOpTovBSa/BX
         3ntebuh3HLc1+DTTBVKYqSFq/tF1zUzslLACaS/48jgNnRfX0BanRmCuoIepFoHrswd+
         qrdC05hgviCWwKtJU4Mc24cPiJtzaoHmhBHb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jasPfZK2wsoNdBWcuDJHTJ/t7P13W2dMZ0nkyY04hwI=;
        b=a/tSdnBV8h8lgEkxEZ4QghFv2ita8rrLHZ5b+jbquymnOqHhryos+Dt4iGaZc6bEuT
         Q+S6eCMRui6T4ONf4oBPhLaGQzzJaIVcTXRJ9MmbTnifVfi3fx6oIfqQW/8s2xn0gMsL
         kq6nF1bJAnV9w0StqEPHMhDw5Gh1tVDWyYs07qrAuN9S49hnCRc6ZozIBkCaZEDO03vx
         b245X69Sh/L5h7GHNkmOCmZI8LatemUu3BpCYQzNA4gC5bIzVNoLWrxM9hqdY2okqvcL
         NkpfC13alXp7dsJ2Q7cCkEEy25A9GA0ey1I6fBdQbDXjU5GXVc79fQenGXz1PZ5UyeBu
         zgFg==
X-Gm-Message-State: APzg51D2qW9jG+srVy+pugfkHPEiNMIDVSaC+XhL7kzYqM+S+aqIAl5D
        8FJiT3uibk64Nq/lsYLkjuw+t0WUfS0=
X-Google-Smtp-Source: ANB0VdZyaZ2R3UDRtmJgd4RUfBh5apMgYfsEL8GMNaqZE4AALYI7V7F4K+OZENH3G7qCLlfZBKu2Ww==
X-Received: by 2002:a17:902:24e1:: with SMTP id l30-v6mr40914387plg.315.1537471152152;
        Thu, 20 Sep 2018 12:19:12 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:11 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 33/44] coresight: etm3: Add support for handling errors
Date:   Thu, 20 Sep 2018 13:18:08 -0600
Message-Id: <1537471099-19781-34-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add support for reporting errors back from the SMP cross
function call for enabling ETM.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 42 ++++++++++++++++++---------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 9ce8fba20b0f..206c2381a11a 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -355,11 +355,10 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 	return 0;
 }
 
-static void etm_enable_hw(void *info)
+static int etm_enable_hw(struct etm_drvdata *drvdata)
 {
 	int i;
 	u32 etmcr;
-	struct etm_drvdata *drvdata = info;
 	struct etm_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
@@ -421,6 +420,21 @@ static void etm_enable_hw(void *info)
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+	return 0;
+}
+
+struct etm_enable_arg {
+	struct etm_drvdata *drvdata;
+	int rc;
+};
+
+static void etm_enable_hw_smp_call(void *info)
+{
+	struct etm_enable_arg *arg = info;
+
+	if (WARN_ON(!arg))
+		return;
+	arg->rc = etm_enable_hw(arg->drvdata);
 }
 
 static int etm_cpu_id(struct coresight_device *csdev)
@@ -475,14 +489,13 @@ static int etm_enable_perf(struct coresight_device *csdev,
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
 	/* And enable it */
-	etm_enable_hw(drvdata);
-
-	return 0;
+	return etm_enable_hw(drvdata);
 }
 
 static int etm_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etm_enable_arg arg = { 0 };
 	int ret;
 
 	spin_lock(&drvdata->spinlock);
@@ -492,20 +505,21 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	 * hw configuration will take place on the local CPU during bring up.
 	 */
 	if (cpu_online(drvdata->cpu)) {
+		arg.drvdata = drvdata;
 		ret = smp_call_function_single(drvdata->cpu,
-					       etm_enable_hw, drvdata, 1);
-		if (ret)
-			goto err;
+					       etm_enable_hw_smp_call, &arg, 1);
+		if (!ret)
+			ret = arg.rc;
+		if (!ret)
+			drvdata->sticky_enable = true;
+	} else {
+		ret = -ENODEV;
 	}
 
-	drvdata->sticky_enable = true;
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

