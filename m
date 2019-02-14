Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65433C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E26222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YIlwuLFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfBNBa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:30:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43853 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbfBNBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:30:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so2174358plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJPsF4XxjEGWMiB9f3+lShzsGeUaN6tuDYb4BL3O6BA=;
        b=YIlwuLFnsN4k9F1/3gvjIie+67GffreLIWW+CwTMVxR8aaH75NsYm79ezmabwTE+7Z
         HKOgwH8iTSFV0aDF3VdQrSKiHQWde0wU9mwev7P61sdiBhWTY+IeABrsL72f+iNgoG9F
         EwSsXD9/cRavIJZ2uFuCjTejkPYG6mESFtaxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJPsF4XxjEGWMiB9f3+lShzsGeUaN6tuDYb4BL3O6BA=;
        b=TlOI5T2SlT78m28MgmGKGoA8IuJRUubEXOPkyo/aCDPCEfmITNyh5+CRDNd1SUi6+6
         noFo73LB8cbDh8T85SatBq1j0zOxckLpN+nSLkTXRgMZKRVHH/YMEFEGlxp23ktNrCrw
         +drswz5f3fXM487YdGJVZqhI/NpwYe6FfJujDP1uxA9C20c1NL70ZvRJynKKGrf+omSt
         lReKm7Id0zd6MblCD4hk/4S59LXI9uNsV1ezCaz0vMOc9pu7vCJItvg40niFeqJCtKxm
         yA/5aMsVfLnjxDx3pl1hT8v0XSAP0gtJT1eSWq5uXW6+jXKJ2FVRxKWh98UcuJk+Pyqu
         TLaQ==
X-Gm-Message-State: AHQUAuYL4nxd4XWrIlEECWtpxJu2QLqM72y17QAXCktklUomwY6W/tIJ
        ZacVxo5eBmuMbnRyb1p30Ho8fQ==
X-Google-Smtp-Source: AHgI3Ib0uzj8u4s+io55IqeyUT/B8Bj7K2MGYIcavwhZARaOwvrzHZSNKpOX8d4kySoluce9he4KEQ==
X-Received: by 2002:a17:902:aa8c:: with SMTP id d12mr1332765plr.25.1550107854202;
        Wed, 13 Feb 2019 17:30:54 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p64sm811072pfi.56.2019.02.13.17.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 17:30:53 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/4] PM / devfreq: Track overall load monitor state instead of 'stop_polling'
Date:   Wed, 13 Feb 2019 17:30:39 -0800
Message-Id: <20190214013042.254790-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <20190214013042.254790-1-mka@chromium.org>
References: <20190214013042.254790-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field ->stop_polling indicates whether load monitoring should be/is
stopped, it is set in devfreq_monitor_suspend(). Change the variable to
hold the general state of load monitoring (stopped, running, suspended).
Besides improving readability of conditions involving the field and this
prepares the terrain for moving some duplicated code from the governors
into the devfreq core.

Hold the devfreq lock in devfreq_monitor_start/stop() to ensure proper
synchronization.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c | 34 +++++++++++++++++++++++++---------
 include/linux/devfreq.h   |  4 ++--
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b7..1d3a43f8b3a10 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -29,6 +29,10 @@
 #include <linux/of.h>
 #include "governor.h"
 
+#define DEVFREQ_MONITOR_STOPPED		0
+#define DEVFREQ_MONITOR_RUNNING		1
+#define DEVFREQ_MONITOR_SUSPENDED	2
+
 static struct class *devfreq_class;
 
 /*
@@ -407,10 +411,17 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
-	if (devfreq->profile->polling_ms)
+	mutex_lock(&devfreq->lock);
+
+	if (devfreq->profile->polling_ms) {
+		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
+
+		devfreq->monitor_state = DEVFREQ_MONITOR_RUNNING;
+	}
+
+	mutex_unlock(&devfreq->lock);
 }
 EXPORT_SYMBOL(devfreq_monitor_start);
 
@@ -425,6 +436,10 @@ EXPORT_SYMBOL(devfreq_monitor_start);
 void devfreq_monitor_stop(struct devfreq *devfreq)
 {
 	cancel_delayed_work_sync(&devfreq->work);
+
+	mutex_lock(&devfreq->lock);
+	devfreq->monitor_state = DEVFREQ_MONITOR_STOPPED;
+	mutex_unlock(&devfreq->lock);
 }
 EXPORT_SYMBOL(devfreq_monitor_stop);
 
@@ -443,13 +458,13 @@ EXPORT_SYMBOL(devfreq_monitor_stop);
 void devfreq_monitor_suspend(struct devfreq *devfreq)
 {
 	mutex_lock(&devfreq->lock);
-	if (devfreq->stop_polling) {
+	if (devfreq->monitor_state != DEVFREQ_MONITOR_RUNNING) {
 		mutex_unlock(&devfreq->lock);
 		return;
 	}
 
 	devfreq_update_status(devfreq, devfreq->previous_freq);
-	devfreq->stop_polling = true;
+	devfreq->monitor_state = DEVFREQ_MONITOR_SUSPENDED;
 	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
@@ -468,7 +483,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	unsigned long freq;
 
 	mutex_lock(&devfreq->lock);
-	if (!devfreq->stop_polling)
+	if (devfreq->monitor_state == DEVFREQ_MONITOR_STOPPED)
 		goto out;
 
 	if (!delayed_work_pending(&devfreq->work) &&
@@ -477,7 +492,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
 	devfreq->last_stat_updated = jiffies;
-	devfreq->stop_polling = false;
+	devfreq->monitor_state = DEVFREQ_MONITOR_RUNNING;
 
 	if (devfreq->profile->get_cur_freq &&
 		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
@@ -504,13 +519,14 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 	mutex_lock(&devfreq->lock);
 	devfreq->profile->polling_ms = new_delay;
 
-	if (devfreq->stop_polling)
+	if (devfreq->monitor_state == DEVFREQ_MONITOR_SUSPENDED)
 		goto out;
 
 	/* if new delay is zero, stop polling */
 	if (!new_delay) {
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
+		devfreq->monitor_state == DEVFREQ_MONITOR_STOPPED;
 		return;
 	}
 
@@ -526,7 +542,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
 		mutex_lock(&devfreq->lock);
-		if (!devfreq->stop_polling)
+		if (devfreq->monitor_state != DEVFREQ_MONITOR_SUSPENDED)
 			queue_delayed_work(devfreq_wq, &devfreq->work,
 			      msecs_to_jiffies(devfreq->profile->polling_ms));
 	}
@@ -1372,7 +1388,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	int i, j;
 	unsigned int max_state = devfreq->profile->max_state;
 
-	if (!devfreq->stop_polling &&
+	if ((devfreq->monitor_state == DEVFREQ_MONITOR_RUNNING) &&
 			devfreq_update_status(devfreq, devfreq->previous_freq))
 		return 0;
 	if (max_state == 0)
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index fbffa74bfc1bb..0a618bbb8b294 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -130,7 +130,7 @@ struct devfreq_dev_profile {
  * @max_freq:	Limit maximum frequency requested by user (0: none)
  * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
  * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
- * @stop_polling:	 devfreq polling status of a device.
+ * @monitor_state:	State of the load monitor.
  * @suspend_freq:	 frequency of a device set during suspend phase.
  * @resume_freq:	 frequency of a device set in resume phase.
  * @suspend_count:	 suspend requests counter for a device.
@@ -168,7 +168,7 @@ struct devfreq {
 	unsigned long max_freq;
 	unsigned long scaling_min_freq;
 	unsigned long scaling_max_freq;
-	bool stop_polling;
+	int monitor_state;
 
 	unsigned long suspend_freq;
 	unsigned long resume_freq;
-- 
2.20.1.791.gb4d0f1c61a-goog

