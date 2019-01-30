Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2000BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41172184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdbWLO+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfA3LQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:16:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55571 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbfA3LQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:16:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so21022919wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ynD/SKO0NKYF/TZnALi5yaZz+mi8VJz9rkAXrSOgxSg=;
        b=fdbWLO+0W3s4gxf54oKHr34BvQZE1DTRv1+2imPUtVYqpY5T1J/RczVnUNU8ZucjA/
         dkxKQTvDiQ0gKZh7ri4Py9/BqT5Wtceyq9u9lrC6mQl39TVPqaybKqbovIHmD3bhVE17
         WwiHuRbEuXfbY4iZ+uLxwqNJfwCOd4UsQKCbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ynD/SKO0NKYF/TZnALi5yaZz+mi8VJz9rkAXrSOgxSg=;
        b=o6H9uXoXfCtY2ozjB7O7g/P/Vbvrt4VwWeR1XTADB6v9IFA8359rHGpyc/OGPZW5CT
         V+cfrEXBnWwbCpYyk0AMPPGaCiehM7dWobKHlpuBI2Dw5iNxAZMHnOUEuoa6gjtkNBgE
         clknPb6a6drDLkrXNDPeBj9kYqq0l3G69qKzLWRvdHfZnliha+v8uqDELjjppTYssL1j
         1iKcQ5kTTiwRkMSQlIeDrl2npRs/vrEkECFsGOsKdPdcOpQ40QuH2ZTju9k7diV81lO+
         DAiv2kTYHpZI3EkZrxYftXLbeKuQIJHAUSC66pE9am68GjvfOYLpfgzX+JeHhu7TPh6b
         cEfg==
X-Gm-Message-State: AJcUukd435jMbCavz940nQxIXjl/tmpf33dh8oRIyyA6MQIXyfEQa/HM
        rRs6Ogqj/bxnnZjwBsBre8f1TA==
X-Google-Smtp-Source: ALg8bN5lST2LvgHuXidA21jm/or7QqwCfXtbdWussrt5ZKWA7LVBGL9QY2XV1K9Ny1rXX6gT1lV+4w==
X-Received: by 2002:a1c:3282:: with SMTP id y124mr25933459wmy.134.1548846991495;
        Wed, 30 Jan 2019 03:16:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:79e5:6689:e4d2:d212])
        by smtp.gmail.com with ESMTPSA id p10sm4502173wmd.14.2019.01.30.03.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 03:16:30 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Cc:     geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 ] PM-runtime: fix deadlock with ktime
Date:   Wed, 30 Jan 2019 12:16:24 +0100
Message-Id: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A deadlock has been seen when swicthing clocksources which use PM runtime.
The call path is:
change_clocksource
    ...
    write_seqcount_begin
    ...
    timekeeping_update
        ...
        sh_cmt_clocksource_enable
            ...
            rpm_resume
                pm_runtime_mark_last_busy
                    ktime_get
                        do
                            read_seqcount_begin
                        while read_seqcount_retry
    ....
    write_seqcount_end

Although we should be safe because we haven't yet changed the clocksource
at that time, we can't because of seqcount protection.

Use ktime_get_mono_fast_ns() instead which is lock safe for such case

With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
monotonic across an update and as a result can goes backward. According to
update_fast_timekeeper() description: "In the worst case, this can
result is a slightly wrong timestamp (a few nanoseconds)". For
PM runtime autosuspend, this means only that the suspend decision can
be slightly sub optimal.

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

- v2: Updated commit message to explain the impact of using 
  ktime_get_mono_fast_ns()

 drivers/base/power/runtime.c | 10 +++++-----
 include/linux/pm_runtime.h   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 457be03..708a13f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -130,7 +130,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 {
 	int autosuspend_delay;
 	u64 last_busy, expires = 0;
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = ktime_get_mono_fast_ns();
 
 	if (!dev->power.use_autosuspend)
 		goto out;
@@ -909,7 +909,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
+	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
@@ -928,7 +928,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 int pm_schedule_suspend(struct device *dev, unsigned int delay)
 {
 	unsigned long flags;
-	ktime_t expires;
+	u64 expires;
 	int retval;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
@@ -945,8 +945,8 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
-	expires = ktime_add(ktime_get(), ms_to_ktime(delay));
-	dev->power.timer_expires = ktime_to_ns(expires);
+	expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC);
+	dev->power.timer_expires = expires;
 	dev->power.timer_autosuspends = 0;
 	hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
 
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 54af4ee..fed5be7 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
 
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
+	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
 }
 
 static inline bool pm_runtime_is_irq_safe(struct device *dev)
-- 
2.7.4

