Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2704BECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7D621533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZREsNBHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7D621533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389164AbeIUBFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:05:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40222 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389061AbeIUBER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so4791732plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JqAqiFp39e/iP5YLkBuDUIuE6G94xqJ7+L+i9J0h7x8=;
        b=ZREsNBHPIopn3W51dQ9fgFBIBaMd3Za5CZQ+FzL3lGOdHBFP7KLR0RMZJbMkQa2KXy
         mjmmrWxOgEA9iUYBfMh1ccm+5zDBI/p20CqtmFBPfaLl+Vo0fGB9HT8yWduXf1fXHJA5
         S6TGZcsIKQoNGsUl0AmernAR0cEQ6VbMDPb30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JqAqiFp39e/iP5YLkBuDUIuE6G94xqJ7+L+i9J0h7x8=;
        b=m1jYPUws43/1G7TvGDUWeImbGvFHmQ29E7a+vaplDLLIgGY58SmEXgQCwOqPzocFA8
         /Ym7HYOiuOiKrDbiwBhSg2qahrdcAl1zgJMbuMkfRZgY0AtlFqcJ8GuTX3c5JR7ItC4t
         hlq5sy4EzzATcJjBSmYnuuFf2raEublUTDE1+JOygwF0E+wLfYnvGIhTCCXCbbHC59Gw
         1mlnGaIXyV6/l9i1j2sCj5D0LVFN4EladZK5EOq6l3oSm1V+Ddet+C3hwyI4fATfqhJl
         q3rlUVfM92zMlaamqTj0HOKkUjwKxJzqnJLP98zoacFJyEmJic01t9AdC6pvff3XJ3mL
         zOCA==
X-Gm-Message-State: APzg51Dk0IKjvyaDc5ICd2LCYc4ln61KOSHZdLD2t6TcMC4p6Se5Drr3
        YThAC0hqOJkXtXXkbgVdVRWtRA==
X-Google-Smtp-Source: ANB0Vda2aAqRdsxxGYmZvySGAm0hLCXAIlHTetBUb7FIPpqNZ4cBXRybfWAF/6EbVISJWFFGvxO/9A==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr40066103pla.325.1537471158027;
        Thu, 20 Sep 2018 12:19:18 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:17 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 37/44] coresight: etmx: Claim devices before use
Date:   Thu, 20 Sep 2018 13:18:12 -0600
Message-Id: <1537471099-19781-38-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Use the CLAIM tags to grab the device for self-hosted usage.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 16 +++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.c | 14 +++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 206c2381a11a..fd5c4cca7db5 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -357,7 +357,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 
 static int etm_enable_hw(struct etm_drvdata *drvdata)
 {
-	int i;
+	int i, rc;
 	u32 etmcr;
 	struct etm_config *config = &drvdata->config;
 
@@ -369,6 +369,9 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_set_pwrup(drvdata);
 	/* Make sure all registers are accessible */
 	etm_os_unlock(drvdata);
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		goto done;
 
 	etm_set_prog(drvdata);
 
@@ -417,10 +420,15 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_writel(drvdata, 0x0, ETMVMIDCVR);
 
 	etm_clr_prog(drvdata);
+
+done:
+	if (rc)
+		etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
-	return 0;
+	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
+		drvdata->cpu, rc);
+	return rc;
 }
 
 struct etm_enable_arg {
@@ -569,6 +577,8 @@ static void etm_disable_hw(void *info)
 	for (i = 0; i < drvdata->nr_cntr; i++)
 		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
+	coresight_disclaim_device_unlocked(drvdata->base);
+
 	etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 064e0bfaefd0..53e2fb6e86f6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -85,13 +85,17 @@ struct etm4_enable_arg {
 
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
-	int i;
+	int i, rc;
 	struct etmv4_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
 
 	etm4_os_unlock(drvdata);
 
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		goto done;
+
 	/* Disable the trace unit before programming trace registers */
 	writel_relaxed(0, drvdata->base + TRCPRGCTLR);
 
@@ -179,10 +183,12 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		dev_err(drvdata->dev,
 			"timeout while waiting for Idle Trace Status\n");
 
+done:
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
-	return 0;
+	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
+		drvdata->cpu, rc);
+	return rc;
 }
 
 static void etm4_enable_hw_smp_call(void *info)
@@ -342,6 +348,8 @@ static void etm4_disable_hw(void *info)
 	isb();
 	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
 
+	coresight_disclaim_device_unlocked(drvdata->base);
+
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
-- 
2.7.4

