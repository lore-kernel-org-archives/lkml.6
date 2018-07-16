Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C0DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B46D20839
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B46D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeGPVTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:19:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeGPVTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:19:49 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ffAS7-0004AM-3T; Mon, 16 Jul 2018 22:50:39 +0200
Date:   Mon, 16 Jul 2018 22:50:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        gkohli@codeaurora.org, cpandya@codeaurora.org,
        neeraju@codeaurora.org
Subject: Re: [PATCH v4] time: Fix extra sleeptime injection when suspend
 fails
In-Reply-To: <1531773650-30424-1-git-send-email-mojha@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1807162241470.1693@nanos.tec.linutronix.de>
References: <1531773650-30424-1-git-send-email-mojha@codeaurora.org>
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

On Tue, 17 Jul 2018, Mukesh Ojha wrote:
> @@ -102,7 +102,7 @@ static int rtc_resume(struct device *dev)
>  	struct timespec64	sleep_time;
>  	int err;
>  
> -	if (timekeeping_rtc_skipresume())
> +	if (!timekeeping_rtc_skipresume())
>  		return 0;

That does not make any sense at all, really. 

>  /* Flag for if there is a persistent clock on this platform */
>  static bool persistent_clock_exists;
> @@ -1610,7 +1622,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>   */
>  bool timekeeping_rtc_skipresume(void)
>  {
> -	return sleeptime_injected;
> +	return suspend_timing_needed;

Just make this !suspend_timing_needed and the function name and its return
value still makes sense.

> @@ -1701,13 +1714,13 @@ void timekeeping_resume(void)
>  					      tk->tkr_mono.mask);
>  		nsec = mul_u64_u32_shr(cyc_delta, clock->mult, clock->shift);
>  		ts_delta = ns_to_timespec64(nsec);
> -		sleeptime_injected = true;
> +		suspend_timing_needed = false;
>  	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
>  		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
> -		sleeptime_injected = true;
> +		suspend_timing_needed = false;
>  	}
>  
> -	if (sleeptime_injected)
> +	if (!suspend_timing_needed)
>  		__timekeeping_inject_sleeptime(tk, &ts_delta);

This reads odd as well. I'd rather keep a local variable inject_sleeptime
or such and set that in the code pathes above.

   	if (...) {
	   	...
		inject_sleeptime = true;
   	} else if (...) {
	   	...
		inject_sleeptime = true;
	}

	if (inject_sleeptime) {
		suspend_timing_needed = false;
		__timekeeping_inject_sleeptime();
	}

Hmm? Just blindly converting everything results in functional, but
nonsensical code. Think about what happens when you look at that stuff 6
month from now...

Thanks,

	tglx

