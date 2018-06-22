Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1754CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B626B24900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B626B24900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbeFVV1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:27:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42816 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeFVV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:27:18 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWTaP-00047u-6E; Fri, 22 Jun 2018 23:27:17 +0200
Date:   Fri, 22 Jun 2018 23:27:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        neeraju@codeaurora.org, gkohli@codeaurora.org,
        cpandya@codeaurora.org
Subject: Re: [PATCH v2] time: Fix sleeptime injection for non-stop clocksource
 & persistent clock
In-Reply-To: <1527680699-16068-1-git-send-email-mojha@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1806222312340.1589@nanos.tec.linutronix.de>
References: <1527680699-16068-1-git-send-email-mojha@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018, Mukesh Ojha wrote:
> Currently, for both non-stop clocksource and persistent clock
> there is a corner case, when a driver failed to go suspend mode.
> rtc_resume() injects the sleeptime as timekeeping_rtc_skipresume()
> returned 'false'(sleeptime_injected=false) due to which we can
> see mismatch in timestamps between system clock and other timers.
> 
> Fix this by updating sleeptime_injected=true for both non-stop
> clocksource and persistent clock.
> 
> Success case:
> ------------
>                                          {sleeptime_injected=true}
> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>   rtc_resume()
> 
> Failure case:
> ------------
>              {failure in sleep path} {sleeptime_injected=false}
> rtc_suspend()          =>            rtc_resume()

I can see the problem.

> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> Changes in v2:
>  * Updated the commit text.
>  * Removed extra variable and used the earlier static
>    variable 'sleeptime_injected'.
> 
>  kernel/time/timekeeping.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 49cbcee..2754c1b 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1610,6 +1610,17 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>   */
>  bool timekeeping_rtc_skipresume(void)
>  {
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	/*
> +	 * This is to ensure that we don't end up injecting
> +	 * the sleeptime via rtc_resume() for non-stop clocksource
> +	 * when we fail to sleep.
> +	 */
> +	if (!sleeptime_injected)
> +		sleeptime_injected = ((tk->tkr_mono.clock->flags &
> +			CLOCK_SOURCE_SUSPEND_NONSTOP) ||
> +			(persistent_clock_exists)) ? true : false;

But this is really a horrible hack. The right thing to do is to keep track
whether timekeeping_suspend() has been reached in the first place. There is
a very simple way to do that. Uncompiled and completely untested patch
below, but you get the idea.

Thanks,

	tglx

8<-------------------
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df904c22..32ae9aea61c3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1510,8 +1510,20 @@ void __weak read_boot_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-/* Flag for if timekeeping_resume() has injected sleeptime */
-static bool sleeptime_injected;
+/*
+ * Flag reflecting whether timekeeping_resume() has injected sleeptime.
+ *
+ * The flag starts of true and is only cleared when a suspend reaches
+ * timekeeping_suspend(), timekeeping_resume() sets it when the timekeeper
+ * clocksource is not stopping across suspend and has been used to update
+ * sleep time. If the timekeeper clocksource has stopped then the flag
+ * stays false and is used by the RTC resume code to decide whether sleep
+ * time must be injected and if so the flag gets set then.
+ *
+ * If a suspend fails before reaching timekeeping_resume() then the flag
+ * stays true and prevents erroneous sleeptime injection.
+ */
+static bool sleeptime_injected = true;
 
 /* Flag for if there is a persistent clock on this platform */
 static bool persistent_clock_exists;
@@ -1646,6 +1658,8 @@ void timekeeping_inject_sleeptime64(struct timespec64 *delta)
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
+	sleeptime_injected = true;
+
 	timekeeping_forward_now(tk);
 
 	__timekeeping_inject_sleeptime(tk, delta);
@@ -1671,7 +1685,6 @@ void timekeeping_resume(void)
 	struct timespec64 ts_new, ts_delta;
 	u64 cycle_now;
 
-	sleeptime_injected = false;
 	read_persistent_clock64(&ts_new);
 
 	clockevents_resume();
@@ -1743,6 +1756,8 @@ int timekeeping_suspend(void)
 	if (timekeeping_suspend_time.tv_sec || timekeeping_suspend_time.tv_nsec)
 		persistent_clock_exists = true;
 
+	sleeptime_injected = false;
+
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	timekeeping_forward_now(tk);


