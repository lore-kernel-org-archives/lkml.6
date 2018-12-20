Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1515CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E542186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhHwS8/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbeLTORL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:17:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39250 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733182AbeLTORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:17:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so2355578wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Knn4iUcnejv9TyDbBm0a94Rk0LLVciIk4+jKF5JXBmY=;
        b=hhHwS8/0lRF2rmUVEh50/tQQR4YfVUnbFFw61w5XX8uDKj5rBQtH7hIoCknyltCyOe
         ey6XELSBNUWmKwVDbNg4qS9aqVS8VRJAKb4EvNfAV1MtefWuXkzz9geRF7xS+IYv0Asw
         7mE8hmN9/GeEB1y5bA2RCFSKDB+VatJysdaxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Knn4iUcnejv9TyDbBm0a94Rk0LLVciIk4+jKF5JXBmY=;
        b=NkATDMZiSd74dLkzcuqzQ89iR4WNF0gNYTKeCRs7W2zrrAMzQlU8Kmv7AxPTFCvMiQ
         dC2S99CfLFH7VTX4LdddEnv2hUzfcges9gByvOzMprZ1qm6DyMqJ0bDkbCKwHaAuniiR
         tki9bm4T+/0P3M0/WI9UudgcdZciFBgropBM3WTwZk9NgKnJ9l+xtniQwygD1v4965TU
         aVXnXapk0iPFm0ojT/lsglFT+6bgUo5abvEAVhoWgJmbUYm9JuAGd+10kJ1XVQc7r0fF
         R4GQc8zlu6T942DcDMikLZeUTNqiwXMW4t1Dw+kfHpnydaKU96Sb1DhNQDoVE4dsDvGf
         iaZQ==
X-Gm-Message-State: AA+aEWZ2wxTAxsh4dnRwh9kvohAcWHdFnQ8ZBzrtqjOkANvJbFUM2zjF
        QvnGyEIJiI313Wszc5pr4rlyvA==
X-Google-Smtp-Source: AFSGD/VKuPzumNLcozFsbpz/a4BrIzuK7Ny+9hI28yCSze3taDYSLnajo7QnIubcGb87vp+DiPvvzw==
X-Received: by 2002:a1c:9806:: with SMTP id a6mr2824292wme.114.1545315429397;
        Thu, 20 Dec 2018 06:17:09 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f9b3:37c1:b11a:64ce])
        by smtp.gmail.com with ESMTPSA id m132sm4616849wmd.15.2018.12.20.06.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 06:17:08 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 3/3] PM/runtime:Replace jiffies based accounting with ktime based accounting
Date:   Thu, 20 Dec 2018 15:17:06 +0100
Message-Id: <1545315426-14545-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

This patch replaces jiffies based accounting for runtime_active_time
and runtime_suspended_time with ktime base accounting. This makes the
runtime debug counters inline with genpd and other pm subsytems which
uses ktime based accounting.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
[move from ktime to raw nsec]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 17 +++++++++--------
 drivers/base/power/sysfs.c   | 11 ++++++++---
 include/linux/pm.h           |  6 +++---
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e695544..f700524 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -64,8 +64,8 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	unsigned long now = jiffies;
-	unsigned long delta;
+	u64 now = ktime_to_ns(ktime_get());
+	u64 delta;
 
 	delta = now - dev->power.accounting_timestamp;
 
@@ -75,9 +75,9 @@ void update_pm_runtime_accounting(struct device *dev)
 		return;
 
 	if (dev->power.runtime_status == RPM_SUSPENDED)
-		dev->power.suspended_jiffies += delta;
+		dev->power.suspended_time += delta;
 	else
-		dev->power.active_jiffies += delta;
+		dev->power.active_time += delta;
 }
 
 static void __update_runtime_status(struct device *dev, enum rpm_status status)
@@ -88,17 +88,18 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
 
 u64 pm_runtime_suspended_time(struct device *dev)
 {
-	unsigned long flags, time;
+	u64 time;
+	unsigned long flags;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
 	update_pm_runtime_accounting(dev);
 
-	time = dev->power.suspended_jiffies;
+	time = dev->power.suspended_time;
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
-	return jiffies_to_nsecs(time);
+	return time;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
 
@@ -1503,7 +1504,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = jiffies;
+	dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d713738..96c8a22 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -125,9 +125,12 @@ static ssize_t runtime_active_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
+	u64 tmp;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
+	tmp = dev->power.active_time;
+	do_div(tmp, NSEC_PER_MSEC);
+	ret = sprintf(buf, "%llu\n", tmp);
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
@@ -138,10 +141,12 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
+	u64 tmp;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n",
-		jiffies_to_msecs(dev->power.suspended_jiffies));
+	tmp = dev->power.suspended_time;
+	do_div(tmp, NSEC_PER_MSEC);
+	ret = sprintf(buf, "%llu\n", tmp);
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78..e5a34e2 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -632,9 +632,9 @@ struct dev_pm_info {
 	int			runtime_error;
 	int			autosuspend_delay;
 	unsigned long		last_busy;
-	unsigned long		active_jiffies;
-	unsigned long		suspended_jiffies;
-	unsigned long		accounting_timestamp;
+	u64			active_time;
+	u64			suspended_time;
+	u64			accounting_timestamp;
 #endif
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
-- 
2.7.4

