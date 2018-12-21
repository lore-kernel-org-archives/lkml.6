Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56383218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6DQXHCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbeLUKeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:34:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34605 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389775AbeLUKeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:34:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so13917664wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bPgIAywPM9tC5+7zzbz0/QmHiK8KUKT68feND5QntSw=;
        b=W6DQXHCChdKP+2o+Oh49fa6lIRh71HkGhUICeVCvPMojy06LmGOUQMvIdx1GSd+GET
         8H21LLIhAcuz+Rbh6uFaBXPQZlJmzy5BdbdOsjES2cX1E/c9qvIJunumoj1n3VyYx8bE
         0hCDpcrvgRLc9HD4Ryt8OWk/GGvCZYbjmTFSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bPgIAywPM9tC5+7zzbz0/QmHiK8KUKT68feND5QntSw=;
        b=rnM501bmlP5c4buoFJy3ZVTViejg8Z3ReB2GJkDPKx0qubz1x9ZYxsGQ9tSmfqcVzO
         VnU4lZerpV0neM9p1qNBYCqsvEi/njxe+gQgZpvjGPX6oPjEgIs9nL9ZwP6fik+Vb31e
         ObsTvsfJABWCn3oL5PAFMQb02qaoVK/u06Nw1vcCSJ+Xa8xBb59VRERRRmDIdVHFTsCq
         WuoUWiCckM9FKFi8N3lQnaQV/0qANVuK4BAex7DaTokwLMsVVa2ivXILsRbiu72LkZgl
         mslB9Ip/z6jLx/4Sr3oe3c/J3u6hQKMxPkFwrgCSrBvju1FFwFWJqlss1rt0M57FRLA5
         CKpw==
X-Gm-Message-State: AA+aEWa0v0sSTiWIaXM8YdrOLXpShMa3aM9OsTNHgGVsEYP37MdaSV/U
        BgZwwE6FrvA2rgDv+KLGBd49FA==
X-Google-Smtp-Source: ALg8bN5V0fT9/T/ZMqUCNnA2Dyv9WjpfIr7MKFC5vro0wkNQIgjgeMOLqSK2w9vrlzzi1cmY/uKYHg==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr2344052wmb.139.1545388446921;
        Fri, 21 Dec 2018 02:34:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ac05:2372:f02d:b03f])
        by smtp.gmail.com with ESMTPSA id h10sm10573685wmf.44.2018.12.21.02.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Dec 2018 02:34:06 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with ktime based accounting
Date:   Fri, 21 Dec 2018 11:33:56 +0100
Message-Id: <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

This patch replaces jiffies based accounting for runtime_active_time
and runtime_suspended_time with ktime base accounting. This makes the
runtime debug counters inline with genpd and other pm subsytems which
uses ktime based accounting.

timekeeping is initialized before pm_runtime_init() so ktime_get() will
be ready before first call. In fact, timekeeping_init() is called early
in start_kernel() which is way before driver_init() (and that's when
devices can start to be initialized) called from rest_init() via
kernel_init_freeable() and do_basic_setup().

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

