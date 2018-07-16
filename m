Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63FAECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A069820779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A069820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeGPIzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:55:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeGPIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:55:03 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1feys8-0007iT-S7; Mon, 16 Jul 2018 10:28:45 +0200
Date:   Mon, 16 Jul 2018 10:28:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
cc:     john.stultz@linaro.org, sboyd@kernel.org, arnd@arndb.de,
        broonie@kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] time: Introduce one suspend clocksource to
 compensate the suspend time
In-Reply-To: <4aa9a65166f7e10984bfcff59e72d86e37c369a1.1531384486.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.21.1807161010390.2644@nanos.tec.linutronix.de>
References: <4aa9a65166f7e10984bfcff59e72d86e37c369a1.1531384486.git.baolin.wang@linaro.org>
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

On Thu, 12 Jul 2018, Baolin Wang wrote:
> On some hardware with multiple clocksources, we have course grained
> clocksources that support the CLOCK_SOURCE_SUSPEND_NONSTOP flag, but
> which are less ideal for timekeeping then other clocksources which
> halt in suspend.
> 
> Currently, the timekeeping core only supports timing suspend using
> CLOCK_SOURCE_SUSPEND_NONSTOP clocksources if that clocksource is the
> current clocksource for timekeeping.
> 
> As a result, some architectures try to implement read_persisitent_clock64()
> using those non-stop clocksources, but isn't really ideal. Thus this
> patch provides logic to allow a registered SUSPEND_NONSTOP clocksource,

Please see Documentation/process/submitting-patches.rst and search for
'This patch...'

> +/**
> + * clocksource_suspend_select - Select the best clocksource for suspend timing
> + * @fallback:	if select a fallback clocksource
> + */
> +static void clocksource_suspend_select(bool fallback)
> +{
> +	struct clocksource *cs, *old_suspend;
> +
> +	old_suspend = suspend_clocksource;
> +	if (fallback)
> +		suspend_clocksource = NULL;
> +
> +	list_for_each_entry(cs, &clocksource_list, list) {
> +		/* Skip current if we were requested for a fallback. */
> +		if (fallback && cs == old_suspend)
> +			continue;
> +
> +		__clocksource_suspend_select(cs);
> +	}
> +
> +	/* If we failed to find a fallback restore the old one. */
> +	if (!suspend_clocksource)
> +		suspend_clocksource = old_suspend;

That's for the case where something tries to remove a clocksource, right?
The logic here looks odd as the calling code for the fallback case has to
check whether the clocksource which is about to be removed is the suspend
clocksource. Why not just returning -EBUSY/0 for the fallback case?

The other question is whether this should be enforced. We might as well
decide to just let the clocksource go and have no suspend clocksource.

> +/**
> + * clocksource_start_suspend_timing - Start measuring the suspend timing
> + * @cs:			current clocksource from timekeeping
> + * @start_cycles:	current cycles from timekeeping
> + *
> + * This function will save the start cycle values of suspend timer to calculate
> + * the suspend time when resuming system.
> + *
> + * This function is called late in the suspend process from timekeeping_suspend(),
> + * that means processes are freezed, non-boot cpus and interrupts are disabled
> + * now. It is therefore possible to start the suspend timer without taking the
> + * clocksource mutex.
> + */
> +void clocksource_start_suspend_timing(struct clocksource *cs, u64 start_cycles)
> +{
> +	if (!suspend_clocksource)
> +		return;
> +
> +	/*
> +	 * If current clocksource is the suspend timer, we should use the
> +	 * tkr_mono.cycle_last value as suspend_start to avoid same reading
> +	 * from suspend timer.
> +	 */
> +	if (clocksource_is_suspend(cs)) {
> +		suspend_start = start_cycles;
> +		return;
> +	}
> +
> +	if (suspend_clocksource->enable &&
> +	    WARN_ON_ONCE(suspend_clocksource->enable(suspend_clocksource))) {
> +		pr_warn_once("Failed to enable the non-suspend-able clocksource.\n");
> +		return;

This is horrible to read and the WARN is really not helpful because
the bracktrace is already known.

> @@ -779,6 +910,16 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
>  {
>  	unsigned long flags;
>  
> +	/*
> +	 * The nonstop clocksource can be selected as the suspend clocksource to
> +	 * calculate the suspend time, so it should not supply suspend/resume
> +	 * interfaces to suspend the nonstop clocksource when system suspends.
> +	 */
> +	if ((cs->flags & CLOCK_SOURCE_SUSPEND_NONSTOP) &&
> +	    (cs->suspend || cs->resume))
> +		pr_warn("Nonstop clocksource %s should not supply suspend/resume interfaces\n",
> +			cs->name);

Lacks braces.

See https://lkml.kernel.org/r/alpine.DEB.2.20.1701171956290.3645@nanos

Othar that the few nits this looks good. Nice work!

Thanks,

	tglx
