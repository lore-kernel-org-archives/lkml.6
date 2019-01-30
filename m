Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C761C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A28F21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OftG1KsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfA3IQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:16:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32985 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfA3IQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:16:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so14836488wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6lyGIVRnQ1BZvQ2ddIjLm1Fs9ngmnkEvH1AhMLp+N2Y=;
        b=OftG1KsKOarpHCwPtS6SGEeDQz//JSHkDh6FbZgPEbNADXVGHgC7QcGsFawMwIj557
         tdY1JNElo/xPW/bzdizrfqcxKwEEKbLw88AIqyNPKXDEO7OuF4GIt73+VD+IfaSNcib+
         hWe/H80y1eYeD7Z2WmAN6MnWTRGlZgg5hEP4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6lyGIVRnQ1BZvQ2ddIjLm1Fs9ngmnkEvH1AhMLp+N2Y=;
        b=mCmweoCnkZ79/8Nl6NDzRRXpSz0LZ64IHaLdt2l8D5kWXdxa/rWF9pkmd/pKMzbRcS
         xIX0zXQGvSzoocJqId3p9XVVUXZhbPVh1itkmKGCHxM3Etbjc+l1O1yxC3G7rZKdUhB8
         2Xzvgc355+XXlaEJJWIcnt8An4pwxPkRQKHwwJxLbTRNKbpAjxNeFgDDKOpyvEX9Lq08
         cN83xcxmlgXbwQT1rKylc8w/e5g2HkaIA4MmTbt9gwS/ref5f2KlOXCtdBekxtCA/7M0
         WQkSHF5mJXfH36zyvvVQA8OGhR/MZyTOYqYKIzzzZ9+jNSVzFV3YbTYiKVH0dFkgimwS
         QaRA==
X-Gm-Message-State: AJcUukdAVif4mzuuGTgU7ws7imdBYOVIAlM5ICFo4UhUQy082TGMiIwp
        8nPFO0SPmj0aIZg4wij3uwReug==
X-Google-Smtp-Source: ALg8bN4X9PAHIE82svv2XmbTltSN2N7UeURKnK285EY/7L5ZaBqwYT92eBN53UCyQgudHlAmYKAjiA==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr22603694wmc.96.1548836214254;
        Wed, 30 Jan 2019 00:16:54 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:79e5:6689:e4d2:d212])
        by smtp.gmail.com with ESMTPSA id t5sm1952500wmd.15.2019.01.30.00.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 00:16:53 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Cc:     geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] PM-runtime: fix deadlock with ktime
Date:   Wed, 30 Jan 2019 09:16:34 +0100
Message-Id: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
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

Use ktime_get_mono_fast_ns instead which is lock safe for such case

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
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

