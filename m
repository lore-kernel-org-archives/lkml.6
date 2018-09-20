Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5B0ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775B521531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZ+KcUT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775B521531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbeIUBDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36704 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388833AbeIUBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id p5-v6so4798385plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DlUy1q8xvUE78unon9sEGi7tys9wdd/Gqaovz6nz19Y=;
        b=WZ+KcUT1Ol+MwdW9PBAo1T9QfV5/uuBgp4UNikDTkBIGpIjg1Lcsj+4Rs0bUsmH9lo
         XgYJ6gr21IeajFbIP3YWMcyryEXTemAFBGvvBzUT+W7pA6vx+r7WcQuECN/h1OJUt8Gk
         /2P//p/gmR4cJrrENnqYKt9GqMQ6UOZW34wqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DlUy1q8xvUE78unon9sEGi7tys9wdd/Gqaovz6nz19Y=;
        b=oFUOWq1SiLDiAaSLgdSLpIqYj5DtNtPG/hRymY6qGW55dKMN0nP/Stnmrc6itfJpo9
         y5srACy1n5AMxcDnjmkJQEk3bXVkik0JH3GBbsza0XZnJ8O8oY0G6ru2fT5yYFOH4phz
         Ugxg8Oswvt903rmxPhkiH3PY2QLtrQs+DNgq/PY63bHZO5W3Lk4h7bBaPdlM1+ELK1LU
         byCPbX+qTicGnVe8TzZJy5BJt4/A+s8vlyajFEFpHmLNCRa6+Rgd4uvVkNAV06MZvMHj
         Yb9/8jUkHYaTAigaNYN9FxbM7/fNBCrHcijDvCJhS6ppS8HcZ+P6eDjd63IwEbhxxcEB
         8Tmw==
X-Gm-Message-State: APzg51A8+eiVpU5zFTkrRaOFK1ZUFGPWmsoIf9CdORB197tC3AdHVH79
        99G93RaFPPqMp1fa6JHK5MVrUwQQ++U=
X-Google-Smtp-Source: ANB0VdYZFsbxyzZwdzrby4yyGxKlrJcKFfDNDYoYwWz6vA5EVpt/cvddLKIFASrYAisv8nkUIRddtg==
X-Received: by 2002:a17:902:bd07:: with SMTP id p7-v6mr40066858pls.32.1537471129149;
        Thu, 20 Sep 2018 12:18:49 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:48 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 18/44] coresight: Convert driver messages to dev_dbg
Date:   Thu, 20 Sep 2018 13:17:53 -0600
Message-Id: <1537471099-19781-19-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Convert component enable/disable messages from dev_info to dev_dbg.
When used with perf, the components in the paths are enabled/disabled
during each schedule of the run, which can flood the dmesg with these
messages. Moreover, they are only useful for debug purposes. So,
convert such messages to dev_dbg() which can be turned on as
needed.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-dynamic-replicator.c | 4 ++--
 drivers/hwtracing/coresight/coresight-etb10.c              | 6 +++---
 drivers/hwtracing/coresight/coresight-etm3x.c              | 4 ++--
 drivers/hwtracing/coresight/coresight-etm4x.c              | 4 ++--
 drivers/hwtracing/coresight/coresight-funnel.c             | 4 ++--
 drivers/hwtracing/coresight/coresight-replicator.c         | 4 ++--
 drivers/hwtracing/coresight/coresight-stm.c                | 4 ++--
 drivers/hwtracing/coresight/coresight-tmc-etf.c            | 8 ++++----
 drivers/hwtracing/coresight/coresight-tmc-etr.c            | 4 ++--
 drivers/hwtracing/coresight/coresight-tmc.c                | 4 ++--
 drivers/hwtracing/coresight/coresight-tpiu.c               | 4 ++--
 11 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index f6d0571ab9dd..ebb80438f6a5 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -56,7 +56,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
-	dev_info(drvdata->dev, "REPLICATOR enabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
 	return 0;
 }
 
@@ -75,7 +75,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
-	dev_info(drvdata->dev, "REPLICATOR disabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 0dad8626bcfb..3d4b6df32a06 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -160,7 +160,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 out:
-	dev_info(drvdata->dev, "ETB enabled\n");
+	dev_dbg(drvdata->dev, "ETB enabled\n");
 	return 0;
 }
 
@@ -266,7 +266,7 @@ static void etb_disable(struct coresight_device *csdev)
 
 	local_set(&drvdata->mode, CS_MODE_DISABLED);
 
-	dev_info(drvdata->dev, "ETB disabled\n");
+	dev_dbg(drvdata->dev, "ETB disabled\n");
 }
 
 static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
@@ -509,7 +509,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "ETB dumped\n");
+	dev_dbg(drvdata->dev, "ETB dumped\n");
 }
 
 static int etb_open(struct inode *inode, struct file *file)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 7c74263c333d..9ce8fba20b0f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -501,7 +501,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
-	dev_info(drvdata->dev, "ETM tracing enabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
 
 err:
@@ -604,7 +604,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
-	dev_info(drvdata->dev, "ETM tracing disabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
 }
 
 static void etm_disable(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 1d94ebec027b..c1dcc7c289a5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -267,7 +267,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 	drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
-	dev_info(drvdata->dev, "ETM tracing enabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
 
 err:
@@ -380,7 +380,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
-	dev_info(drvdata->dev, "ETM tracing disabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
 }
 
 static void etm4_disable(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 448145a36675..ee7a30bf9480 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -65,7 +65,7 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 
 	funnel_enable_hw(drvdata, inport);
 
-	dev_info(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
+	dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
 	return 0;
 }
 
@@ -89,7 +89,7 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 
 	funnel_disable_hw(drvdata, inport);
 
-	dev_info(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
+	dev_dbg(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
 }
 
 static const struct coresight_ops_link funnel_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 8d2eaaab6c2f..feac98315471 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -35,7 +35,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	dev_info(drvdata->dev, "REPLICATOR enabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
 	return 0;
 }
 
@@ -44,7 +44,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	dev_info(drvdata->dev, "REPLICATOR disabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index c46c70aec1d5..35d6f9709274 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -211,7 +211,7 @@ static int stm_enable(struct coresight_device *csdev,
 	stm_enable_hw(drvdata);
 	spin_unlock(&drvdata->spinlock);
 
-	dev_info(drvdata->dev, "STM tracing enabled\n");
+	dev_dbg(drvdata->dev, "STM tracing enabled\n");
 	return 0;
 }
 
@@ -274,7 +274,7 @@ static void stm_disable(struct coresight_device *csdev,
 		pm_runtime_put(drvdata->dev);
 
 		local_set(&drvdata->mode, CS_MODE_DISABLED);
-		dev_info(drvdata->dev, "STM tracing disabled\n");
+		dev_dbg(drvdata->dev, "STM tracing disabled\n");
 	}
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0549249f4b39..434003a43346 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -233,7 +233,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 	if (ret)
 		return ret;
 
-	dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETB/ETF enabled\n");
 	return 0;
 }
 
@@ -256,7 +256,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETB/ETF disabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETB/ETF disabled\n");
 }
 
 static int tmc_enable_etf_link(struct coresight_device *csdev,
@@ -275,7 +275,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	drvdata->mode = CS_MODE_SYSFS;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETF enabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
 	return 0;
 }
 
@@ -295,7 +295,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETF disabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETF disabled\n");
 }
 
 static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int cpu,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index bafd73e71c4c..5e9bb2f0e9c0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1098,7 +1098,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		tmc_etr_free_sysfs_buf(free_buf);
 
 	if (!ret)
-		dev_info(drvdata->dev, "TMC-ETR enabled\n");
+		dev_dbg(drvdata->dev, "TMC-ETR enabled\n");
 
 	return ret;
 }
@@ -1141,7 +1141,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETR disabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETR disabled\n");
 }
 
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 1b817ec1192c..ea249f0bcd73 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -81,7 +81,7 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 	}
 
 	if (!ret)
-		dev_info(drvdata->dev, "TMC read start\n");
+		dev_dbg(drvdata->dev, "TMC read start\n");
 
 	return ret;
 }
@@ -103,7 +103,7 @@ static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
 	}
 
 	if (!ret)
-		dev_info(drvdata->dev, "TMC read end\n");
+		dev_dbg(drvdata->dev, "TMC read end\n");
 
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 459ef930d98c..ce0b84583861 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -74,7 +74,7 @@ static int tpiu_enable(struct coresight_device *csdev, u32 mode)
 
 	tpiu_enable_hw(drvdata);
 
-	dev_info(drvdata->dev, "TPIU enabled\n");
+	dev_dbg(drvdata->dev, "TPIU enabled\n");
 	return 0;
 }
 
@@ -100,7 +100,7 @@ static void tpiu_disable(struct coresight_device *csdev)
 
 	tpiu_disable_hw(drvdata);
 
-	dev_info(drvdata->dev, "TPIU disabled\n");
+	dev_dbg(drvdata->dev, "TPIU disabled\n");
 }
 
 static const struct coresight_ops_sink tpiu_sink_ops = {
-- 
2.7.4

