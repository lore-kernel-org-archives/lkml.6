Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E497C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631A2222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kwa0apZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbfBNBbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:31:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44069 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbfBNBa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:30:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so2176817plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0/NmLZRXTRsN+OZc6mmHRQXHWfGzPgKXT90TbVPoSY=;
        b=kwa0apZGhEIq4g7pRcfmyGwZMNNQ55m9TSJ/pfEjxqFB9GTx3/GPdswuAdrz9dILFg
         whenNhCwryoP6bQ/6MjwrNeEDfwC0XXji5nfytRvPsfdhbz9JGG8ImzFNCb277NwLYQ5
         t/9bxN+WjErNwwaPgZiDoSgzk8PczAomktg1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0/NmLZRXTRsN+OZc6mmHRQXHWfGzPgKXT90TbVPoSY=;
        b=d2KlqYvFRGwAuBBFQOXjKbxWXp5xeKyCBSD0+VGiULXZtWXtoxR3w/OF7oudNvnniX
         GSCCa2Ln96UtUQAMxS9iYlD/iqNlcZP3+IGGQ9GwORXFXvjLuhHa9Taico/mX0P4rilh
         0+de6mnp4qUuwJw05SH6xJeoZTTAGIHlfj0926wiz03wKCVbzjaFRrhMxXqneZmPlqHS
         pbDj2fF/ILRweRa80WNALqU9XvI6bVz4PuND7R3nFrzWuhQK8kt3nm6Oi33xiA2V+m9A
         vYNX/k8UP8o+ObNsXpUF47AWGIAd7WQebUgGMFJSWBonMD9l7a6qblaT3sgBYCAn+vHm
         Jvzw==
X-Gm-Message-State: AHQUAubBmqD4K/nEN5XNtOdHg/6YgIYLo4lefuhTO64WKd4Edw6LYy64
        OMnRbt5BlEXsRTxM/KNpOkAAxw==
X-Google-Smtp-Source: AHgI3Ib0SaOAA5m/Z8kSp3TIEb+1/gxSM4pIE+2+1w65LMeDBj4aZ4TulQdRZ3KxoKnmpmijMPR8Pw==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr1344855plm.154.1550107857290;
        Wed, 13 Feb 2019 17:30:57 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p64sm811072pfi.56.2019.02.13.17.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 17:30:56 -0800 (PST)
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
Subject: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the devfreq core
Date:   Wed, 13 Feb 2019 17:30:42 -0800
Message-Id: <20190214013042.254790-5-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <20190214013042.254790-1-mka@chromium.org>
References: <20190214013042.254790-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devfreq expects governors to call devfreq_monitor_start/stop()
in response to DEVFREQ_GOV_START/STOP events. Since the devfreq
core itself generates these events and invokes the governor's event
handler the start/stop of the load monitor can be done in the common
code.

Call devfreq_monitor_start/stop() when the governor reports a
successful handling of DEVFREQ_GOV_START/STOP and remove these
calls from the simpleondemand and tegra governors. Make
devfreq_monitor_start/stop() static since these functions are now
only used by the devfreq core. For better integration with the
callers the functions must now be called with devfreq->lock held.

Also stop manipulating the monitor workqueue directly, use
devfreq_monitor_start/stop() instead.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c                 | 45 +++++++++++------------
 drivers/devfreq/governor.h                |  2 -
 drivers/devfreq/governor_simpleondemand.c |  8 ----
 drivers/devfreq/tegra-devfreq.c           |  2 -
 4 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index eb86461648d74..ac553c00f6790 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -404,14 +404,14 @@ static void devfreq_monitor(struct work_struct *work)
  * devfreq_monitor_start() - Start load monitoring of devfreq instance
  * @devfreq:	the devfreq instance.
  *
- * Helper function for starting devfreq device load monitoing. By
- * default delayed work based monitoring is supported. Function
- * to be called from governor in response to DEVFREQ_GOV_START
- * event when device is added to devfreq framework.
+ * Helper function for starting devfreq device load monitoring. By
+ * default delayed work based monitoring is supported. Must be called
+ * with devfreq->lock held.
  */
-void devfreq_monitor_start(struct devfreq *devfreq)
+static void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	mutex_lock(&devfreq->lock);
+	WARN(!mutex_is_locked(&devfreq->lock),
+	     "devfreq->lock must be held by the caller.\n");
 
 	if (devfreq->profile->polling_ms) {
 		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
@@ -420,28 +420,28 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 
 		devfreq->monitor_state = DEVFREQ_MONITOR_RUNNING;
 	}
-
-	mutex_unlock(&devfreq->lock);
 }
-EXPORT_SYMBOL(devfreq_monitor_start);
 
 /**
  * devfreq_monitor_stop() - Stop load monitoring of a devfreq instance
  * @devfreq:	the devfreq instance.
  *
- * Helper function to stop devfreq device load monitoing. Function
- * to be called from governor in response to DEVFREQ_GOV_STOP
- * event when device is removed from devfreq framework.
+ * Helper function to stop devfreq device load monitoring. Must be
+ * called with devfreq->lock held.
  */
-void devfreq_monitor_stop(struct devfreq *devfreq)
+static void devfreq_monitor_stop(struct devfreq *devfreq)
 {
+	/* mutex must be held for symmetry with _start() */
+	WARN(!mutex_is_locked(&devfreq->lock),
+	     "devfreq->lock must be held by the caller.\n");
+
+	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 
 	mutex_lock(&devfreq->lock);
 	devfreq->monitor_state = DEVFREQ_MONITOR_STOPPED;
 	mutex_unlock(&devfreq->lock);
 }
-EXPORT_SYMBOL(devfreq_monitor_stop);
 
 /**
  * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq instance
@@ -518,27 +518,22 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 
 	/* if new delay is zero, stop polling */
 	if (!new_delay) {
+		devfreq_monitor_stop(devfreq);
 		mutex_unlock(&devfreq->lock);
-		cancel_delayed_work_sync(&devfreq->work);
-		devfreq->monitor_state == DEVFREQ_MONITOR_STOPPED;
 		return;
 	}
 
 	/* if current delay is zero, start polling with new delay */
 	if (!cur_delay) {
-		queue_delayed_work(devfreq_wq, &devfreq->work,
-			msecs_to_jiffies(devfreq->profile->polling_ms));
+		devfreq_monitor_start(devfreq);
 		goto out;
 	}
 
 	/* if current delay is greater than new delay, restart polling */
 	if (cur_delay > new_delay) {
-		mutex_unlock(&devfreq->lock);
-		cancel_delayed_work_sync(&devfreq->work);
-		mutex_lock(&devfreq->lock);
+		devfreq_monitor_stop(devfreq);
 		if (devfreq->monitor_state != DEVFREQ_MONITOR_SUSPENDED)
-			queue_delayed_work(devfreq_wq, &devfreq->work,
-			      msecs_to_jiffies(devfreq->profile->polling_ms));
+			devfreq_monitor_start(devfreq);
 	}
 out:
 	mutex_unlock(&devfreq->lock);
@@ -601,6 +596,8 @@ static int devfreq_governor_start(struct devfreq *devfreq)
 		return err;
 	}
 
+	devfreq_monitor_start(devfreq);
+
 	return 0;
 }
 
@@ -624,6 +621,8 @@ static int devfreq_governor_stop(struct devfreq *devfreq)
 		return err;
 	}
 
+	devfreq_monitor_stop(devfreq);
+
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index d136792c0cc91..47efe747b6f79 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -57,8 +57,6 @@ struct devfreq_governor {
 				unsigned int event, void *data);
 };
 
-extern void devfreq_monitor_start(struct devfreq *devfreq);
-extern void devfreq_monitor_stop(struct devfreq *devfreq);
 extern void devfreq_interval_update(struct devfreq *devfreq,
 					unsigned int *delay);
 
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 52eb0c734b312..e0f0944a9c7aa 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -91,14 +91,6 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 				unsigned int event, void *data)
 {
 	switch (event) {
-	case DEVFREQ_GOV_START:
-		devfreq_monitor_start(devfreq);
-		break;
-
-	case DEVFREQ_GOV_STOP:
-		devfreq_monitor_stop(devfreq);
-		break;
-
 	case DEVFREQ_GOV_INTERVAL:
 		devfreq_interval_update(devfreq, (unsigned int *)data);
 		break;
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 79efa1e51bd06..515fb852dbad6 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -580,13 +580,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 	switch (event) {
 	case DEVFREQ_GOV_START:
-		devfreq_monitor_start(devfreq);
 		tegra_actmon_enable_interrupts(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
 		tegra_actmon_disable_interrupts(tegra);
-		devfreq_monitor_stop(devfreq);
 		break;
 
 	case DEVFREQ_GOV_SUSPEND:
-- 
2.20.1.791.gb4d0f1c61a-goog

