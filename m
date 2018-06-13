Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9C446C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52704204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxFoDyXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52704204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935529AbeFMLeO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:34:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45802 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935498AbeFMLeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:34:07 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so1261740pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=96RSIq0UKsniTsrwhV4W30c30m0HqKjh/VL2LbphPg0=;
        b=VxFoDyXwmJHA73Z0m3RSWXMUpyPaomU7g5p4cpz7wjL8jLFhq/BrQ2LQwkWKDv5Zl/
         6Y8dmiGd2X3kecr9oyEoDg7C2HSSjy/aEHncpDh5YkQKqz7nH7hr0yOIx46tTVb+ud60
         VQaf6bqw/QEaQsOvbeGbEQDh9KnJ5WtHLeITk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=96RSIq0UKsniTsrwhV4W30c30m0HqKjh/VL2LbphPg0=;
        b=TYTxz3kg4wmN3g7AfMUEz37P9NGqI5a5U6qE1wEabdF+JWS4JKd0wm4dmkDQQzRy2R
         t+4qD0z99gJqruz+cxM/qj3OFEjDWePq/hNKkIz7dY53QR5cc6zP4xxvPjyVQZmPxKH2
         7BeNlx//n6/ZFZ86awt+oW9pFZqSgbJUhM39mtY4gy/X2uVdwZPezyhunAbYLWQS0NDU
         hzBuZ2E4ii7CiTDcCYZW6GId/3TU9D9rXjor7YjpcKZC2kgXy3w59tbJ1kq02SkNlI63
         FU5i4sdNCTpGSyvWGTImoinNExurwWfDIzVuwml+BRF5vQpErU/6Blt06Es2etOa0SXY
         Ax2w==
X-Gm-Message-State: APt69E2/abtH9SxJr2aLEUccCAgLs2u/TJaHhgDyfLSlCiFLk+r2HvLU
        LcWrDsCk4gIrYi5Q6dCQHA7Zsw==
X-Google-Smtp-Source: ADUXVKLkDGxsVsrAw5GyA9Gn0lgN+gXe891hkrkjCpAzPD3u+vkiaOi7u897ib5pXSKv8Qm6EOCBtA==
X-Received: by 2002:a62:86c3:: with SMTP id x186-v6mr4587177pfd.4.1528889646727;
        Wed, 13 Jun 2018 04:34:06 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2745370pgq.35.2018.06.13.04.33.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 04:34:06 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     tglx@linutronix.de, john.stultz@linaro.org,
        daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com,
        aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com,
        marc.zyngier@arm.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org,
        paulmck@linux.vnet.ibm.com, mlichvar@redhat.com,
        rdunlap@infradead.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de,
        linus.walleij@linaro.org, viresh.kumar@linaro.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        douly.fnst@cn.fujitsu.com, len.brown@intel.com,
        rajvi.jingar@intel.com, alexandre.belloni@bootlin.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 8/8] time: timekeeping: Remove time compensating from nonstop clocksources
Date:   Wed, 13 Jun 2018 19:32:35 +0800
Message-Id: <7901216d145d942553641c74f5ee6241acf18976.1528878545.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have converted all nonstop clocksources to use persistent clock,
thus we can simplify the time compensating by removing the nonstop
clocksources. Now we can compensate the suspend time for the OS time from
the persistent clock or rtc device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 kernel/time/timekeeping.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df9..3026d98 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1666,7 +1666,6 @@ void timekeeping_inject_sleeptime64(struct timespec64 *delta)
 void timekeeping_resume(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	struct clocksource *clock = tk->tkr_mono.clock;
 	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
 	u64 cycle_now;
@@ -1682,27 +1681,17 @@ void timekeeping_resume(void)
 
 	/*
 	 * After system resumes, we need to calculate the suspended time and
-	 * compensate it for the OS time. There are 3 sources that could be
-	 * used: Nonstop clocksource during suspend, persistent clock and rtc
-	 * device.
+	 * compensate it for the OS time. There are 2 sources that could be
+	 * used: persistent clock and rtc device.
 	 *
 	 * One specific platform may have 1 or 2 or all of them, and the
 	 * preference will be:
-	 *	suspend-nonstop clocksource -> persistent clock -> rtc
+	 *	persistent clock -> rtc
 	 * The less preferred source will only be tried if there is no better
 	 * usable source. The rtc part is handled separately in rtc core code.
 	 */
 	cycle_now = tk_clock_read(&tk->tkr_mono);
-	if ((clock->flags & CLOCK_SOURCE_SUSPEND_NONSTOP) &&
-		cycle_now > tk->tkr_mono.cycle_last) {
-		u64 nsec, cyc_delta;
-
-		cyc_delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last,
-					      tk->tkr_mono.mask);
-		nsec = mul_u64_u32_shr(cyc_delta, clock->mult, clock->shift);
-		ts_delta = ns_to_timespec64(nsec);
-		sleeptime_injected = true;
-	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
+	if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
 		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
 		sleeptime_injected = true;
 	}
-- 
1.7.9.5

