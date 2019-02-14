Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C8F222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IopZXxja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbfBNBbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:31:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41861 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731789AbfBNBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:30:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id k15so2181642pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUOh5urbJ5qKsBwwk9JiS26KJ91s9tOUPSxR5qZLz4c=;
        b=IopZXxjaiYhOZk3DiEuFXysOr9PyU1OW5shFcoAjWyWQPqzzKxQRq7snvXdol6Yq/0
         RAme/rEM5+pHeQIx/CdyqRkkIu04+T1xMew7zbKp2dj5yWfo6QyVMNGs6Wqz+8Qiuq2E
         UWKCqQR1w+VOm9QC1RZy2CGUSozZVf99HEm1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUOh5urbJ5qKsBwwk9JiS26KJ91s9tOUPSxR5qZLz4c=;
        b=P8fdk9v8FiXnWm33on/YBDDZfxxk5REuRoD8DQfZQ1nxJ1MabS5lj0KmAQxmRwHBQd
         aXntMte/hs3yRP76EggcM6rNynnNzVSrBGRVsBocNb4TcpfORGaOG2nGQW2BhgOsBEOK
         Y2SRU+na2UENKvVjIXMHJutDwLtom3Xl+kjWuVPxd9oq3oVSbgnv6n7K45l0H5guJtlA
         PUyHZTafYKRV1X4gG0mdyTE9cjpigpuPM+nWSqRaa66gWe1FHYIe0PgxVGxvzqlEbHvJ
         5pws7klC04SWjHKWHnKL5nPry2mNzYmStyjXxdbzn2I6omPNkw7iQl4Y/Vx5sYQKky25
         ODuQ==
X-Gm-Message-State: AHQUAuZp7Us24rbrhhqJ8SmfD/yVB1uTH++GPXS122j0i5ljVIk72cTs
        5+gtfBLrX8vcdxpd60LNjYZdzA==
X-Google-Smtp-Source: AHgI3IagHH5nYbheS5Y7OhAcpMQHA4CZK4LhO+tqffWsUCWFmoy1vTdSaNNkS/WRKAu890RoBofTJg==
X-Received: by 2002:a17:902:1aa:: with SMTP id b39mr1350593plb.244.1550107855170;
        Wed, 13 Feb 2019 17:30:55 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p64sm811072pfi.56.2019.02.13.17.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 17:30:54 -0800 (PST)
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
Subject: [PATCH 2/4] PM / devfreq: Handle monitor suspend/resume in the devfreq core
Date:   Wed, 13 Feb 2019 17:30:40 -0800
Message-Id: <20190214013042.254790-3-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <20190214013042.254790-1-mka@chromium.org>
References: <20190214013042.254790-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devfreq expects governors to call devfreq_monitor_suspend/resume()
in response to DEVFREQ_GOV_SUSPEND/RESUME events. Since the devfreq
core itself generates these events and invokes the governor's event
handler the suspend/resume of the load monitoring can be done in the
common code.

Call devfreq_monitor_suspend/resume() when the governor reports a
successful handling of DEVFREQ_GOV_SUSPEND/RESUME and remove these
calls from the simpleondemand and tegra governors. Make
devfreq_monitor_suspend/resume() static since these functions are now
only used by the devfreq core.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c                 | 18 ++++++++----------
 drivers/devfreq/governor.h                |  2 --
 drivers/devfreq/governor_simpleondemand.c |  8 --------
 drivers/devfreq/tegra-devfreq.c           |  2 --
 4 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1d3a43f8b3a10..7fab6c4cf719b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -447,15 +447,13 @@ EXPORT_SYMBOL(devfreq_monitor_stop);
  * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq instance
  * @devfreq:	the devfreq instance.
  *
- * Helper function to suspend devfreq device load monitoing. Function
- * to be called from governor in response to DEVFREQ_GOV_SUSPEND
- * event or when polling interval is set to zero.
+ * Helper function to suspend devfreq device load monitoring.
  *
  * Note: Though this function is same as devfreq_monitor_stop(),
  * intentionally kept separate to provide hooks for collecting
  * transition statistics.
  */
-void devfreq_monitor_suspend(struct devfreq *devfreq)
+static void devfreq_monitor_suspend(struct devfreq *devfreq)
 {
 	mutex_lock(&devfreq->lock);
 	if (devfreq->monitor_state != DEVFREQ_MONITOR_RUNNING) {
@@ -468,17 +466,14 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
-EXPORT_SYMBOL(devfreq_monitor_suspend);
 
 /**
  * devfreq_monitor_resume() - Resume load monitoring of a devfreq instance
  * @devfreq:    the devfreq instance.
  *
- * Helper function to resume devfreq device load monitoing. Function
- * to be called from governor in response to DEVFREQ_GOV_RESUME
- * event or when polling interval is set to non-zero.
+ * Helper function to resume devfreq device load monitoring.
  */
-void devfreq_monitor_resume(struct devfreq *devfreq)
+static void devfreq_monitor_resume(struct devfreq *devfreq)
 {
 	unsigned long freq;
 
@@ -501,7 +496,6 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 out:
 	mutex_unlock(&devfreq->lock);
 }
-EXPORT_SYMBOL(devfreq_monitor_resume);
 
 /**
  * devfreq_interval_update() - Update device devfreq monitoring interval
@@ -903,6 +897,8 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 					DEVFREQ_GOV_SUSPEND, NULL);
 		if (ret)
 			return ret;
+
+		devfreq_monitor_suspend(devfreq);
 	}
 
 	if (devfreq->suspend_freq) {
@@ -944,6 +940,8 @@ int devfreq_resume_device(struct devfreq *devfreq)
 					DEVFREQ_GOV_RESUME, NULL);
 		if (ret)
 			return ret;
+
+		devfreq_monitor_resume(devfreq);
 	}
 
 	return 0;
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index f53339ca610fc..d136792c0cc91 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -59,8 +59,6 @@ struct devfreq_governor {
 
 extern void devfreq_monitor_start(struct devfreq *devfreq);
 extern void devfreq_monitor_stop(struct devfreq *devfreq);
-extern void devfreq_monitor_suspend(struct devfreq *devfreq);
-extern void devfreq_monitor_resume(struct devfreq *devfreq);
 extern void devfreq_interval_update(struct devfreq *devfreq,
 					unsigned int *delay);
 
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index c0417f0e081e0..52eb0c734b312 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -103,14 +103,6 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 		devfreq_interval_update(devfreq, (unsigned int *)data);
 		break;
 
-	case DEVFREQ_GOV_SUSPEND:
-		devfreq_monitor_suspend(devfreq);
-		break;
-
-	case DEVFREQ_GOV_RESUME:
-		devfreq_monitor_resume(devfreq);
-		break;
-
 	default:
 		break;
 	}
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c59d2eee5d309..79efa1e51bd06 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -591,11 +591,9 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 	case DEVFREQ_GOV_SUSPEND:
 		tegra_actmon_disable_interrupts(tegra);
-		devfreq_monitor_suspend(devfreq);
 		break;
 
 	case DEVFREQ_GOV_RESUME:
-		devfreq_monitor_resume(devfreq);
 		tegra_actmon_enable_interrupts(tegra);
 		break;
 	}
-- 
2.20.1.791.gb4d0f1c61a-goog

