Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174F5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE235206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YA2mrzhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbeLNOWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:22:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41783 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbeLNOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:22:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so5598528wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 06:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gblBWhL5bL5/PqNiDoTT+eK7kGF945547r4fz/El95c=;
        b=YA2mrzhxaAb5wd6Si34th/G9mbvSEZ/3p0NXG0MSPsC1HtWbMXIuhavA2E+MDHRP4o
         4bqyvGmE34YT00BuBk25lCJEY9xpgmVv8dsAB07RIM6Deu5icTaY/UIHMlb4YQT1hho/
         AItYhk4DjBBKHYanBIgnRRoPX9RdxZzn86X7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gblBWhL5bL5/PqNiDoTT+eK7kGF945547r4fz/El95c=;
        b=UEaohoXBqhS0g+mY1vCpZ2WJKMc8G13yFQ+rWo/pouRvPDLZGdAyYnXLeM3N/GZdxs
         +wuZSsKNcwLavbglUtYA3K43FkZa30BIfVmG+JfTOC5RUUm8/kUDfG0RXP6hTpL4x4Qv
         CVl0D9dda7b+2MqYno1FSyDAE0BYWddMPa3NWZUU+3wjq8YzEpCPkRfvWGFwz/dBV9sf
         41wzOg56xDrZYZVEAqwPwQaA+rB9OVLBOsHDOhsiRoem+8Hc3UWtk+h6kbFiAP0/ONKp
         HyyC6jCuAzQG/J1qla4BTji5eJrwWh/EihLOuOCsvzeIW0oUvdjz7iKOQjQ2HwlhXXmj
         veRg==
X-Gm-Message-State: AA+aEWauOHS4GBCRDtiLDj+kOwp9/joOZfn5+mbaAY81MBd+iApyhy4y
        a2vmFKFe/7HAD3MtY3EZLG7ngQ==
X-Google-Smtp-Source: AFSGD/UTWp40dyB7Rahox9PAkLtsVMS3uxnm7Or+PrtJIwZUkKxsAzaYNaKdj13i1fp7oG+sc5nzig==
X-Received: by 2002:adf:9591:: with SMTP id p17mr2929178wrp.224.1544797352371;
        Fri, 14 Dec 2018 06:22:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ed2e:a6ad:f6ef:ff8e])
        by smtp.gmail.com with ESMTPSA id m4sm25793829wmi.3.2018.12.14.06.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 06:22:31 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 1/3] PM/pm_runtime: move autosuspend on hrtimer
Date:   Fri, 14 Dec 2018 15:22:25 +0100
Message-Id: <1544797347-20601-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm runtime uses the timer infrastructure for autosuspend. This implies that
the minimum time before autosuspending a device is in the range
of 1 tick included to 2 ticks excluded
-On arm64 this means between 4ms and 8ms with default jiffies configuration
-And on arm, it is between 10ms and 20ms

These values are quite high for embedded system which sometimes wants
duration in the range of 1 ms.

We can move autosuspend on hrtimer to get finer granularity for short
duration and takes advantage of slack to keep some margins and gathers
long timeout in minimum wakeups.

On an arm64 platform that uses 1ms for autosuspending timeout of its GPU,
the power consumption improves by 10% for idle use case with hrtimer.

The latency impact on arm64 hikey octo cores is :
- mark_last_busy: from 1.11 us to 1.25 us
- rpm_suspend: from 15.54 us to 15.38 us
  Only the code path of rpm_suspend that starts hrtimer has been measured

arm64 image (arm64 default defconfig) decreases by around 3KB
with following details:

$ size vmlinux-timer
   text	   data	    bss	    dec	    hex	filename
12034646	6869268	 386840	19290754	1265a82	vmlinux

$ size vmlinux-hrtimer
   text	   data	    bss	    dec	    hex	filename
12030550	6870164	 387032	19287746	1264ec2	vmlinux

The latency impact on arm 32bits snowball dual cores is :
- mark_last_busy: from 0.31 us usec to 0.77 us
- rpm_suspend: from 6.83 us to 6.67 usec

The increase of the image for snowball platform that I used for testing
performance impact, is neglictable (244B)

$ size vmlinux-timer
   text	   data	    bss	    dec	    hex	filename
7157961	2119580	 264120	9541661	 91981d	build-ux500/vmlinux

size vmlinux-hrtimer
   text	   data	    bss	    dec	    hex	filename
7157773	2119884	 264248	9541905	 919911	vmlinux-hrtimer

And arm 32bits image (multi_v7_defconfig) increases by around 1.7KB
with following details:

$ size vmlinux-timer
   text	   data	    bss	    dec	    hex	filename
13304443	6803420	 402768	20510631	138f7a7	vmlinux

$ size vmlinux-hrtimer
   text	   data	    bss	    dec	    hex	filename
13304299	6805276	 402768	20512343	138fe57	vmlinux

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 63 ++++++++++++++++++++++++--------------------
 include/linux/pm.h           |  5 ++--
 include/linux/pm_runtime.h   |  6 ++---
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index beb85c3..7062469 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -8,6 +8,8 @@
  */
 
 #include <linux/sched/mm.h>
+#include <linux/ktime.h>
+#include <linux/hrtimer.h>
 #include <linux/export.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
@@ -93,7 +95,7 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
 static void pm_runtime_deactivate_timer(struct device *dev)
 {
 	if (dev->power.timer_expires > 0) {
-		del_timer(&dev->power.suspend_timer);
+		hrtimer_cancel(&dev->power.suspend_timer);
 		dev->power.timer_expires = 0;
 	}
 }
@@ -124,12 +126,11 @@ static void pm_runtime_cancel_pending(struct device *dev)
  * This function may be called either with or without dev->power.lock held.
  * Either way it can be racy, since power.last_busy may be updated at any time.
  */
-unsigned long pm_runtime_autosuspend_expiration(struct device *dev)
+u64 pm_runtime_autosuspend_expiration(struct device *dev)
 {
 	int autosuspend_delay;
-	long elapsed;
-	unsigned long last_busy;
-	unsigned long expires = 0;
+	u64 last_busy, expires = 0;
+	u64 now = ktime_to_ns(ktime_get());
 
 	if (!dev->power.use_autosuspend)
 		goto out;
@@ -139,19 +140,9 @@ unsigned long pm_runtime_autosuspend_expiration(struct device *dev)
 		goto out;
 
 	last_busy = READ_ONCE(dev->power.last_busy);
-	elapsed = jiffies - last_busy;
-	if (elapsed < 0)
-		goto out;	/* jiffies has wrapped around. */
 
-	/*
-	 * If the autosuspend_delay is >= 1 second, align the timer by rounding
-	 * up to the nearest second.
-	 */
-	expires = last_busy + msecs_to_jiffies(autosuspend_delay);
-	if (autosuspend_delay >= 1000)
-		expires = round_jiffies(expires);
-	expires += !expires;
-	if (elapsed >= expires - last_busy)
+	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	if (expires <= now)
 		expires = 0;	/* Already expired. */
 
  out:
@@ -515,7 +506,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	/* If the autosuspend_delay time hasn't expired yet, reschedule. */
 	if ((rpmflags & RPM_AUTO)
 	    && dev->power.runtime_status != RPM_SUSPENDING) {
-		unsigned long expires = pm_runtime_autosuspend_expiration(dev);
+		u64 expires = pm_runtime_autosuspend_expiration(dev);
 
 		if (expires != 0) {
 			/* Pending requests need to be canceled. */
@@ -528,10 +519,20 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 			 * expire; pm_suspend_timer_fn() will take care of the
 			 * rest.
 			 */
-			if (!(dev->power.timer_expires && time_before_eq(
-			    dev->power.timer_expires, expires))) {
+			if (!(dev->power.timer_expires &&
+					dev->power.timer_expires <= expires)) {
+				/*
+				 * We add a slack of 25% to gather wakeups
+				 * without sacrificing the granularity.
+				 */
+				u64 slack = READ_ONCE(dev->power.autosuspend_delay) *
+						    (NSEC_PER_MSEC >> 2);
+
 				dev->power.timer_expires = expires;
-				mod_timer(&dev->power.suspend_timer, expires);
+				hrtimer_start_range_ns(&dev->power.suspend_timer,
+						ns_to_ktime(expires),
+						slack,
+						HRTIMER_MODE_ABS);
 			}
 			dev->power.timer_autosuspends = 1;
 			goto out;
@@ -895,23 +896,25 @@ static void pm_runtime_work(struct work_struct *work)
  *
  * Check if the time is right and queue a suspend request.
  */
-static void pm_suspend_timer_fn(struct timer_list *t)
+static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 {
-	struct device *dev = from_timer(dev, t, power.suspend_timer);
+	struct device *dev = container_of(timer, struct device, power.suspend_timer);
 	unsigned long flags;
-	unsigned long expires;
+	u64 expires;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
 	expires = dev->power.timer_expires;
 	/* If 'expire' is after 'jiffies' we've been called too early. */
-	if (expires > 0 && !time_after(expires, jiffies)) {
+	if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
 	}
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return HRTIMER_NORESTART;
 }
 
 /**
@@ -922,6 +925,7 @@ static void pm_suspend_timer_fn(struct timer_list *t)
 int pm_schedule_suspend(struct device *dev, unsigned int delay)
 {
 	unsigned long flags;
+	ktime_t expires;
 	int retval;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
@@ -938,10 +942,10 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
-	dev->power.timer_expires = jiffies + msecs_to_jiffies(delay);
-	dev->power.timer_expires += !dev->power.timer_expires;
+	expires = ktime_add(ktime_get(), ms_to_ktime(delay));
+	dev->power.timer_expires = ktime_to_ns(expires);
 	dev->power.timer_autosuspends = 0;
-	mod_timer(&dev->power.suspend_timer, dev->power.timer_expires);
+	hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
 
  out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -1491,7 +1495,8 @@ void pm_runtime_init(struct device *dev)
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-	timer_setup(&dev->power.suspend_timer, pm_suspend_timer_fn, 0);
+	hrtimer_init(&dev->power.suspend_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	dev->power.suspend_timer.function = pm_suspend_timer_fn;
 
 	init_waitqueue_head(&dev->power.wait_queue);
 }
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78..0bd9de1 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/timer.h>
+#include <linux/hrtimer.h>
 #include <linux/completion.h>
 
 /*
@@ -608,7 +609,7 @@ struct dev_pm_info {
 	unsigned int		should_wakeup:1;
 #endif
 #ifdef CONFIG_PM
-	struct timer_list	suspend_timer;
+	struct hrtimer		suspend_timer;
 	unsigned long		timer_expires;
 	struct work_struct	work;
 	wait_queue_head_t	wait_queue;
@@ -631,7 +632,7 @@ struct dev_pm_info {
 	enum rpm_status		runtime_status;
 	int			runtime_error;
 	int			autosuspend_delay;
-	unsigned long		last_busy;
+	u64			last_busy;
 	unsigned long		active_jiffies;
 	unsigned long		suspended_jiffies;
 	unsigned long		accounting_timestamp;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index f0fc470..54af4ee 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -51,7 +51,7 @@ extern void pm_runtime_no_callbacks(struct device *dev);
 extern void pm_runtime_irq_safe(struct device *dev);
 extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
 extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
-extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
+extern u64 pm_runtime_autosuspend_expiration(struct device *dev);
 extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
@@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
 
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, jiffies);
+	WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
 }
 
 static inline bool pm_runtime_is_irq_safe(struct device *dev)
@@ -168,7 +168,7 @@ static inline void __pm_runtime_use_autosuspend(struct device *dev,
 						bool use) {}
 static inline void pm_runtime_set_autosuspend_delay(struct device *dev,
 						int delay) {}
-static inline unsigned long pm_runtime_autosuspend_expiration(
+static inline u64 pm_runtime_autosuspend_expiration(
 				struct device *dev) { return 0; }
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
-- 
2.7.4

