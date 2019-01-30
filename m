Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADEFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633ED20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PX4Vmspc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfA3R0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:26:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46374 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731582AbfA3R0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:26:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so297494wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XrfQDMdrfjMyVkUbTxAT96m6kQZT5x+Q2hxt4/3RgHY=;
        b=PX4VmspcuGJlI5kSXkkrHEjx7uuMvuSu4Tdiq2IndHoZypWy3KWdndOmsskUfneroW
         3Qyws2Sb+LFkk61+IirdrbA+LYmcw9j2s0CzVxg0R4ZhG80+kZPM6kS2ITvdCWQTcbLo
         21xwige6RxuDBe2AkP6g5UG0Jxn/xQUpB0NDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XrfQDMdrfjMyVkUbTxAT96m6kQZT5x+Q2hxt4/3RgHY=;
        b=gWrCxMu6lKaPliWT1qRvlb7mF0CbJo4/fgvHp4O9zhd/M7mf9iUX9oVTLDj4XgdXAd
         /ijWrDVzjA+Iz2dzrSwlf2AgBbbw8wasishdI91MHzZNI1nwnsr9MV9IxQhmqBSPmQ7H
         eON+DY7rHOUYnh4Qi8gNkDutNJWOEbtmPPJP+aJIU4u1FLY1cWL4e5Xk0mEarksWzhVe
         lsDKBcGFrkEI31RN29VT5tNqYj9Hj+/lCLTfQK/AFMFZf6Z4wffoFOx7LR+017HNrcu7
         /kAQIvmde8Da0ImIY/9F73NghjhKBI7uSn2Gw8L3GO7fVedOrrw8lJ31T3oqRTrlbjjS
         S3gA==
X-Gm-Message-State: AJcUukezzBjYQJqGXYT3pMjjLsdFtbgGkQ7vPSn+xCOGB5fpjnntqvEZ
        uHi+PtS7JMarEgr6KxbS1TFnqA==
X-Google-Smtp-Source: ALg8bN68ANqwhXSOIdAvTUOW7+mvPYnPeOS4Rp8O780MxglHXm4mtp+q8FZlo8ZHdqHSx3rwSwwVdA==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr33405207wrw.50.1548869189563;
        Wed, 30 Jan 2019 09:26:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:79e5:6689:e4d2:d212])
        by smtp.gmail.com with ESMTPSA id n124sm3618880wmd.15.2019.01.30.09.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 09:26:28 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Cc:     geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3] PM-runtime: fix deadlock with ktime
Date:   Wed, 30 Jan 2019 18:26:02 +0100
Message-Id: <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
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

Hi Rafael,

Sorry, I sent the version with the typo mistake that generated the compilation error
reported by kbuild-test-robot

This version doesn't have the typo.

Regards,
Vincent

- v3: fix typo error that appears while updating commit message
- v2: Updated commit message to explain the impact of using 
  ktime_get_mono_fast_ns()

 drivers/base/power/runtime.c | 10 +++++-----
 include/linux/pm_runtime.h   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 457be03..0ea2139 100644
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
+	expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC;
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

