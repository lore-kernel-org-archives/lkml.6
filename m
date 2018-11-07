Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4FAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FF720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4LVV32x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FF720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbeKGUW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:22:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55017 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeKGUW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:22:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so13591379wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhMJL82kowJ5cj78PVHvmrdwIzB1mz7xkkE+QR2MfHo=;
        b=b4LVV32xT8IKhCHAlMENAuREZuboBJyVDcxAD8yCQM8BT1FWg5HkUbNMVSx8wSudCO
         JrZmeqvnf0N+dz24C6KLakdcfWrOdabsN3L6OSClSBDhT8YrTHB1l3DHTfyHRJTxtJDE
         8qxtofE+MbDAiBgO1eyW5Dw2MY/fKoP2wk65U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhMJL82kowJ5cj78PVHvmrdwIzB1mz7xkkE+QR2MfHo=;
        b=IVaMHze+GXFen2sH40Ss2RalaMDhGP7OR4LkOdAJzAgnJuYS0HWxBZ0Y+hQq1Y3NG5
         zc9miCPiAd4SbL+gut6OZ1Re+H5bOMoeP4KvgJ8Uk1gkNvcho0XXAJkW5G2zuieG0Puh
         LvRhsZhWMYSnWj9hnLmJNLPKxED+Mjlp9L4agE2kutvy26S4rt9qTAwwQci19HClTqNB
         HpppfGfv47OPj6ubjnqD9E65dau7GsXEYi4A93Hr/EgQiydd5wjaLBnRx0D0mTYQ04j2
         9kPJb34UIp20WoSY+dXP3TbjiozGTIhFKzNE970JyeRuQEPZCnkT1lboifa5tldp8PQn
         vTYQ==
X-Gm-Message-State: AGRZ1gLZVMjznkc2p9qLr0c7rJhGesOlJphX3SHEaLAO6pFlveLIMZ6m
        Fj8D2sViWzohZ+D+7hNHljc7psQoyZY=
X-Google-Smtp-Source: AJdET5f6CUn2sqIee9dWU/4QFM8ba/zYJEUgFAoc7FHKd31GznB/9oGJJMrfugxBHlVUUoKoM0yfrA==
X-Received: by 2002:a1c:f60f:: with SMTP id w15-v6mr1626937wmc.101.1541587953992;
        Wed, 07 Nov 2018 02:52:33 -0800 (PST)
Received: from [192.168.0.40] (161.230.136.77.rev.sfr.net. [77.136.230.161])
        by smtp.googlemail.com with ESMTPSA id p7-v6sm390504wrs.23.2018.11.07.02.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 02:52:33 -0800 (PST)
Subject: Re: [PATCH] irq/timings: Fix model validity
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
 <20181107085936.GI9781@hirez.programming.kicks-ass.net>
 <20181107094624.GB9828@hirez.programming.kicks-ass.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ab9e60d7-e2d3-7d0c-dbf1-c0bed7bdb516@linaro.org>
Date:   Wed, 7 Nov 2018 11:52:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107094624.GB9828@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 10:46, Peter Zijlstra wrote:
> On Wed, Nov 07, 2018 at 09:59:36AM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 07, 2018 at 12:39:31AM +0100, Rafael J. Wysocki wrote:
> 
>>> In general, however, I need to be convinced that interrupts that
>>> didn't wake up the CPU from idle are relevant for next wakeup
>>> prediction.  I see that this may be the case, but to what extent is
>>> rather unclear to me and it looks like calling
>>> irq_timings_next_event() would add considerable overhead.
>>
>> How about we add a (debug) knob so that people can play with it for now?
>> If it turns out to be useful, we'll learn.
> 
> That said; Daniel, I think there is a problem with how irqs_update()
> sets irqs->valid. We seem to set valid even when we're still training.

Yes, the fix seems right.

Thanks for fixing it.

  -- Daniel

> ---
> Subject: irq/timings: Fix model validity
> 
> The per IRQ timing predictor will produce a 'valid' prediction even if
> the model is still training. This should not happen.
> 
> Fix this by moving the actual training (online stddev algorithm) up a
> bit and returning early (before predicting) when we've not yet reached
> the sample threshold.
> 
> A direct concequence is that the predictor will only ever run with at
> least that many samples, which means we can remove one branch.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/irq/timings.c | 66 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
> index 1e4cb63a5c82..5d22fd5facd5 100644
> --- a/kernel/irq/timings.c
> +++ b/kernel/irq/timings.c
> @@ -28,6 +28,13 @@ struct irqt_stat {
>  	int	valid;
>  };
>  
> +/*
> + * The rule of thumb in statistics for the normal distribution
> + * is having at least 30 samples in order to have the model to
> + * apply.
> + */
> +#define SAMPLE_THRESHOLD	30
> +
>  static DEFINE_IDR(irqt_stats);
>  
>  void irq_timings_enable(void)
> @@ -101,7 +108,6 @@ void irq_timings_disable(void)
>   * distribution appears when the number of samples is 30 (it is the
>   * rule of thumb in statistics, cf. "30 samples" on Internet). When
>   * there are three consecutive anomalies, the statistics are resetted.
> - *
>   */
>  static void irqs_update(struct irqt_stat *irqs, u64 ts)
>  {
> @@ -146,11 +152,38 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>  	 */
>  	diff = interval - irqs->avg;
>  
> +	/*
> +	 * Online average algorithm:
> +	 *
> +	 *  new_average = average + ((value - average) / count)
> +	 *
> +	 * The variance computation depends on the new average
> +	 * to be computed here first.
> +	 *
> +	 */
> +	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
> +
> +	/*
> +	 * Online variance algorithm:
> +	 *
> +	 *  new_variance = variance + (value - average) x (value - new_average)
> +	 *
> +	 * Warning: irqs->avg is updated with the line above, hence
> +	 * 'interval - irqs->avg' is no longer equal to 'diff'
> +	 */
> +	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
> +
>  	/*
>  	 * Increment the number of samples.
>  	 */
>  	irqs->nr_samples++;
>  
> +	/*
> +	 * If we're still training the model, we can't make any predictions yet.
> +	 */
> +	if (irqs->nr_samples < SAMPLE_THRESHOLD)
> +		return;
> +
>  	/*
>  	 * Online variance divided by the number of elements if there
>  	 * is more than one sample.  Normally the formula is division
> @@ -158,16 +191,12 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>  	 * more than 32 and dividing by 32 instead of 31 is enough
>  	 * precise.
>  	 */
> -	if (likely(irqs->nr_samples > 1))
> -		variance = irqs->variance >> IRQ_TIMINGS_SHIFT;
> +	variance = irqs->variance >> IRQ_TIMINGS_SHIFT;
>  
>  	/*
> -	 * The rule of thumb in statistics for the normal distribution
> -	 * is having at least 30 samples in order to have the model to
> -	 * apply. Values outside the interval are considered as an
> -	 * anomaly.
> +	 * Values outside the interval are considered as an anomaly.
>  	 */
> -	if ((irqs->nr_samples >= 30) && ((diff * diff) > (9 * variance))) {
> +	if ((diff * diff) > (9 * variance)) {
>  		/*
>  		 * After three consecutive anomalies, we reset the
>  		 * stats as it is no longer stable enough.
> @@ -191,27 +220,6 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>  	 */
>  	irqs->valid = 1;
>  
> -	/*
> -	 * Online average algorithm:
> -	 *
> -	 *  new_average = average + ((value - average) / count)
> -	 *
> -	 * The variance computation depends on the new average
> -	 * to be computed here first.
> -	 *
> -	 */
> -	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
> -
> -	/*
> -	 * Online variance algorithm:
> -	 *
> -	 *  new_variance = variance + (value - average) x (value - new_average)
> -	 *
> -	 * Warning: irqs->avg is updated with the line above, hence
> -	 * 'interval - irqs->avg' is no longer equal to 'diff'
> -	 */
> -	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
> -
>  	/*
>  	 * Update the next event
>  	 */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

