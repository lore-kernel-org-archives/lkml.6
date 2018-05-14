Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526288264; cv=none;
        d=google.com; s=arc-20160816;
        b=OCvoVkNEqCfqbgIP8mAzIJ6IgPKKAfhn1WzxztWjuNxnN4euvi19XZstQATwEgoWl8
         7RmFpSjpVgnhxuR9BhEp9xciweiADkulovfs8Lyy7aIbviXXIRv0GXtLqlm3uFU3PYuS
         ssJqN2kksWM9O06iGbnL5TKbi60espG8exUXvfm5Bh2giDOnApu/tvFAX3HsXge0UaeU
         F0/arEIhpgH7cRkgBMzACvZHtbMd3TTg1zDxU9uGPWNEgFc+VtF2tHGyxCS7Dmf+r1CH
         JqXxW4DRkeZT159FW21AQ2iTV4sQVC8PRJZcYHizMaAKZQqpVjiARKbvMAHVz1tKHkBE
         S88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=sSEMab6IMNQz3/RjvLiWiFX+Zq0WYBiRrZjP2qAXMUY=;
        b=WiXrlSDo5PP2MWgFzOdnDwsVBBFWe1VBEdn8FqmgyrdxmC9r1GeERph/kg2lzZJBGR
         2pQ49OquVrXmvqU1TJq2Vnav5KZj403lVl2J67uYND2xJLczB/fTuBFE1Fsko5LQHUpJ
         HA7m416YqrRTSkgoBzvU1Cy0STRNUiu9hQvRCK7t6r1dpHnVOZge7Dt2/lKwoNuEAJrt
         gup/bhHZ+J4U7Hety3JZjyrkVNtv5UM8DmBzySrNVDEZhgZcx13lSxk3X9QeEQ1UBhYS
         0jdNg2yz0HVmuuXAFGIgVBmem05MN4X6op/BfI4njvE/Ot/f7k0RYr3HYO36y1rZEQ9E
         s4bQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=S3M7cEnx;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=S3M7cEnx;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpLbxYEtKrezxZrPSNr8XP9twI5Iv1raRlQ3AOegErbKoWKXRD+i/2VeFcuM21IPn0GRtudAA==
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de,
	john.stultz@linaro.org,
	daniel.lezcano@linaro.org,
	arnd@arndb.de,
	tony@atomide.com,
	aaro.koskinen@iki.fi,
	linux@armlinux.org.uk,
	mark.rutland@arm.com,
	marc.zyngier@arm.com
Cc: baolin.wang@linaro.org,
	broonie@kernel.org,
	paulmck@linux.vnet.ibm.com,
	mlichvar@redhat.com,
	rdunlap@infradead.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	heiko@sntech.de,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	mingo@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	douly.fnst@cn.fujitsu.com,
	len.brown@intel.com,
	rajvi.jingar@intel.com,
	alexandre.belloni@bootlin.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [RFC PATCH 10/10] time: timekeeping: Remove time compensating from nonstop clocksources
Date: Mon, 14 May 2018 16:55:36 +0800
Message-Id: <a38362d75aed947756d84976265de5772b3787cb.1526285602.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429242846860107?=
X-GMAIL-MSGID: =?utf-8?q?1600429242846860107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since we have converted all nonstop clocksources to use persistent clock,
thus we can simplify the time compensating by removing the nonstop
clocksources. Now we can compensate the suspend time for the OS time from
the persistent clock or rtc device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 kernel/time/timekeeping.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 49cbcee..48d2a80 100644
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
