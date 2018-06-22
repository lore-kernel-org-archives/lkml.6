Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1909C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8150A248DE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8150A248DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeFVVJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:09:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42797 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbeFVVJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:09:23 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWTJ3-00042L-5u; Fri, 22 Jun 2018 23:09:21 +0200
Date:   Fri, 22 Jun 2018 23:09:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miroslav Lichvar <mlichvar@redhat.com>
cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCHv2] timekeeping: Update multiplier when NTP frequency is
 set directly
In-Reply-To: <20180604133421.19559-1-mlichvar@redhat.com>
Message-ID: <alpine.DEB.2.21.1806222308560.1589@nanos.tec.linutronix.de>
References: <20180604133421.19559-1-mlichvar@redhat.com>
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

On Mon, 4 Jun 2018, Miroslav Lichvar wrote:

> When the NTP frequency is set directly from userspace using the
> ADJ_FREQUENCY or ADJ_TICK timex mode, immediately update the
> timekeeper's multiplier instead of waiting for the next tick.
> 
> This removes a hidden non-deterministic delay in setting of the
> frequency and allows an extremely tight control of the system clock
> with update rates close to or even exceeding the kernel HZ.
> 
> The update is limited to archs using modern timekeeping
> (!ARCH_USES_GETTIMEOFFSET).

John ?????

> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
> 
> Notes:
>     RFC->v1:
>     - added a new parameter to force the update of the timekeeper to the current
>       NTP tick length only from adjtimex()
>     - added timekeeping_advance() to keep the parameter local to timekeeping.c
>     v1->v2:
>     - replaced bool parameter with enum
>     - changed timekeeping_advance() to not make any updates for TK_ADV_FREQ with
>       !ARCH_USES_GETTIMEOFFSET (an alternative might be to update with zero offset)
> 
>  kernel/time/timekeeping.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 49cbceef5deb..a08ef3771ab5 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -34,6 +34,14 @@
>  #define TK_MIRROR		(1 << 1)
>  #define TK_CLOCK_WAS_SET	(1 << 2)
>  
> +enum timekeeping_adv_mode {
> +	/* Update timekeeper when a tick has passed */
> +	TK_ADV_TICK,
> +
> +	/* Update timekeeper on a direct frequency change */
> +	TK_ADV_FREQ
> +};
> +
>  /*
>   * The most important data for readout fits into a single 64 byte
>   * cache line.
> @@ -2021,11 +2029,11 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
>  	return offset;
>  }
>  
> -/**
> - * update_wall_time - Uses the current clocksource to increment the wall time
> - *
> +/*
> + * timekeeping_advance - Updates the timekeeper to the current time and
> + * current NTP tick length
>   */
> -void update_wall_time(void)
> +static void timekeeping_advance(enum timekeeping_adv_mode mode)
>  {
>  	struct timekeeper *real_tk = &tk_core.timekeeper;
>  	struct timekeeper *tk = &shadow_timekeeper;
> @@ -2042,14 +2050,17 @@ void update_wall_time(void)
>  
>  #ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
>  	offset = real_tk->cycle_interval;
> +
> +	if (mode != TK_ADV_TICK)
> +		goto out;
>  #else
>  	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
>  				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
> -#endif
>  
>  	/* Check if there's really nothing to do */
> -	if (offset < real_tk->cycle_interval)
> +	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
>  		goto out;
> +#endif
>  
>  	/* Do some additional sanity checking */
>  	timekeeping_check_update(tk, offset);
> @@ -2105,6 +2116,15 @@ void update_wall_time(void)
>  		clock_was_set_delayed();
>  }
>  
> +/**
> + * update_wall_time - Uses the current clocksource to increment the wall time
> + *
> + */
> +void update_wall_time(void)
> +{
> +	timekeeping_advance(TK_ADV_TICK);
> +}
> +
>  /**
>   * getboottime64 - Return the real time of system boot.
>   * @ts:		pointer to the timespec64 to be set
> @@ -2332,6 +2352,10 @@ int do_adjtimex(struct timex *txc)
>  	write_seqcount_end(&tk_core.seq);
>  	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
>  
> +	/* Update the multiplier immediately if frequency was set directly */
> +	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
> +		timekeeping_advance(TK_ADV_FREQ);
> +
>  	if (tai != orig_tai)
>  		clock_was_set();
>  
> -- 
> 2.14.3
> 
> 
