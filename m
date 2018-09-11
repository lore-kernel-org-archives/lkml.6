Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9790AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB1420880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ovkw4Gzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB1420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeILCvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:51:22 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32930 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbeILCvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:51:21 -0400
Received: by mail-io0-f194.google.com with SMTP id r196-v6so4877584iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v/tadTJaLCYasKrq2Ovf3JA24II+vvL3f63lVp4E7YE=;
        b=Ovkw4GzcAto2liFPa4ISFzwoMQQv/gIXSt4eJ7ayJ1Hdg5uCOd4D0F8BQY2F9gG8W+
         gElL033kEn2h1FKve94tKiW/c+lJH44Ov65TYA2rznJeTSGE8wSu2xQUuOdstO5+yiXF
         hBK97IO6ZGp7U48bmbOUwtc/ZGG6HA2eXiEyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v/tadTJaLCYasKrq2Ovf3JA24II+vvL3f63lVp4E7YE=;
        b=bVASIfLXrdoRxnVYpgwT+DMc3d2Kj4KJdz6f0OPW6BsOLBxGpjxezwGK4KwxwVl55I
         Y0juqN/seYOuJX+McaUXaJf1SDRKNSCk2QA5o5kZGKBQM7fBp+M12oAwg+rDOWyHKVm7
         2UxzIXL/w3+khBUERIF4b4NIfmF5gTBWl2gMUYEl4Q/w3GifuJDh1/ftGPvplvHGsLfd
         0g6qXtYTqQEN27WlmW32E2InjmkQ+LHFO6MG4kdwpdoI7M2RoLGYaGI124NcPxD1oL7n
         UIBbeunWjv6C8Fv0Q60gD4bBwYEOCe4cQpE+oRNO2Z9fLg4/KOfM3DXVhnoGJtXob+vI
         Q8Pw==
X-Gm-Message-State: APzg51Bmr8phdalG5RJuWmQQYWZYfgBpWRNlTLUvc+msjdFpAw3dC8AL
        S434XGUMa7pZBBKNmAmUU7PQ7g==
X-Google-Smtp-Source: ANB0VdZMKV7itc8SXcDHpN6wwyO9id5NoTeNFjPuMl+kunqNoZYl38mrc0IKkX52vawoNK0VP9leUg==
X-Received: by 2002:a5e:890c:: with SMTP id k12-v6mr21751308ioj.136.1536702604430;
        Tue, 11 Sep 2018 14:50:04 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c3-v6sm1102172itd.8.2018.09.11.14.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 14:50:03 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        gregkh@linuxfoundation.org, kim.phillips@arm.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] coresight: Make sink disable functions aware of operation mode
Date:   Tue, 11 Sep 2018 15:49:53 -0600
Message-Id: <1536702595-9999-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
References: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sink disable functions aware of the operation mode they are under
so that log messages can be controlled.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c    | 2 +-
 drivers/hwtracing/coresight/coresight.c         | 6 +++---
 include/linux/coresight.h                       | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 08fa660098f8..79793cb51d82 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -305,7 +305,7 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void etb_disable(struct coresight_device *csdev)
+static void etb_disable(struct coresight_device *csdev, u32 mode)
 {
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	unsigned long flags;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 28b3ff830597..ce33c0f05148 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -246,7 +246,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev,
 	return 0;
 }
 
-static void tmc_disable_etf_sink(struct coresight_device *csdev)
+static void tmc_disable_etf_sink(struct coresight_device *csdev, u32 mode)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 56fea4ff947e..ec5100e7b7b9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1364,7 +1364,7 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev,
 	return -EINVAL;
 }
 
-static void tmc_disable_etr_sink(struct coresight_device *csdev)
+static void tmc_disable_etr_sink(struct coresight_device *csdev, u32 mode)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b2f72a1fa402..5f9fe97690fe 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -94,7 +94,7 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void tpiu_disable(struct coresight_device *csdev)
+static void tpiu_disable(struct coresight_device *csdev, u32 mode)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index edfb7f8d2f0b..c19c2692b95e 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -149,11 +149,11 @@ static int coresight_enable_sink(struct coresight_device *csdev,
 	return 0;
 }
 
-static void coresight_disable_sink(struct coresight_device *csdev)
+static void coresight_disable_sink(struct coresight_device *csdev, u32 mode)
 {
 	if (atomic_dec_return(csdev->refcnt) == 0) {
 		if (sink_ops(csdev)->disable) {
-			sink_ops(csdev)->disable(csdev);
+			sink_ops(csdev)->disable(csdev, mode);
 			csdev->enable = false;
 		}
 	}
@@ -301,7 +301,7 @@ void coresight_disable_path(struct list_head *path, u32 mode)
 
 		switch (type) {
 		case CORESIGHT_DEV_TYPE_SINK:
-			coresight_disable_sink(csdev);
+			coresight_disable_sink(csdev, mode);
 			break;
 		case CORESIGHT_DEV_TYPE_SOURCE:
 			/* sources are disabled from either sysFS or Perf */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 8fc6f1e82c17..22bb0d4f1689 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -189,7 +189,7 @@ struct coresight_device {
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev, u32 mode, void *data);
-	void (*disable)(struct coresight_device *csdev);
+	void (*disable)(struct coresight_device *csdev, u32 mode);
 	void *(*alloc_buffer)(struct coresight_device *csdev, int cpu,
 			      void **pages, int nr_pages, bool overwrite);
 	void (*free_buffer)(void *config);
-- 
2.7.4

