Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85CFC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 00:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91E24D59
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 00:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F91E24D59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeFXAPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 20:15:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbeFXAPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 20:15:15 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWsfn-0000PN-4C; Sun, 24 Jun 2018 02:14:31 +0200
Date:   Sun, 24 Jun 2018 02:14:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
cc:     john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de,
        tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk,
        mark.rutland@arm.com, marc.zyngier@arm.com, broonie@kernel.org,
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
Subject: Re: [PATCH 1/8] time: Add persistent clock support
In-Reply-To: <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
References: <cover.1528878545.git.baolin.wang@linaro.org> <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org>
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

On Wed, 13 Jun 2018, Baolin Wang wrote:
> Moreover we can register the clocksource with CLOCK_SOURCE_SUSPEND_NONSTOP
> to be one persistent clock, then we can simplify the suspend/resume
> accounting by removing CLOCK_SOURCE_SUSPEND_NONSTOP timing. After that
> we can only compensate the OS time by persistent clock or RTC.

That makes sense because it adds a gazillion lines of code and removes 5?
Not really,

> +/**
> + * persistent_clock_read_data - data required to read persistent clock
> + * @read: Returns a cycle value from persistent clock.
> + * @last_cycles: Clock cycle value at last update.
> + * @last_ns: Time value (nanoseconds) at last update.
> + * @mask: Bitmask for two's complement subtraction of non 64bit clocks.
> + * @mult: Cycle to nanosecond multiplier.
> + * @shift: Cycle to nanosecond divisor.
> + */
> +struct persistent_clock_read_data {
> +	u64 (*read)(void);
> +	u64 last_cycles;
> +	u64 last_ns;
> +	u64 mask;
> +	u32 mult;
> +	u32 shift;
> +};
> +/**
> + * persistent_clock - represent the persistent clock
> + * @read_data: Data required to read from persistent clock.
> + * @seq: Sequence counter for protecting updates.
> + * @freq: The frequency of the persistent clock.
> + * @wrap: Duration for persistent clock can run before wrapping.
> + * @alarm: Update timeout for persistent clock wrap.
> + * @alarm_inited: Indicate if the alarm has been initialized.
> + */
> +struct persistent_clock {
> +	struct persistent_clock_read_data read_data;
> +	seqcount_t seq;
> +	u32 freq;
> +	ktime_t wrap;
> +	struct alarm alarm;
> +	bool alarm_inited;
> +};

NAK!

There is no reason to invent yet another set of data structures and yet
more read functions with a sequence counter. which are just a bad and
broken copy of the existing timekeeping/clocksource code. And of course the
stuff is not serialized against multiple registrations, etc. etc.

Plus the utter nonsense that any call site has to do the same thing over
and over:

    register():
    start_alarm_timer();

Why is this required in the first place? It's not at all. The only place
where such an alarm timer will be required is when the system actually goes
to suspend. Starting it at registration time is pointless and even counter
productive. Assume the clocksource wraps every 2 hours. So you start it at
boot time and after 119 minutes uptime the system suspends. So it will
wakeup one minute later to update the clocksource. Heck no. If the timer is
started when the machine actually suspends it will wake up earliest in 120
minutes.

And you even add that to the TSC which does not need it at all. It will
wrap in about 400 years on a 2GHZ machine. So you degrade the functionality
instead of improving it.

So no, this is not going anywhere.

Let's look at the problem itself:

   You want to use one clocksource for timekeeping during runtime which is
   fast and accurate and another one for suspend time injection which is
   slower and/or less accurate because the fast one stops in suspend.

   Plus you need an alarmtimer which makes sure that the clocksource does
   not wrap around during suspend.

Now lets look what we have already:

   Both clocksources already exist and are registered as clocksources with
   all required data in the clocksource core.

Ergo the only sane and logical conclusion is to expand the existing
infrastructure to handle that.

When a clocksource is registered, then the registration function already
makes decisions about using it as timekeeping clocksource. So add a few
lines of code to check whether the newly registered clocksource is suitable
and preferred for suspend.

	if (!stops_in_suspend(newcs)) {
		if (!suspend_cs || is_preferred_suspend_cs(newcs))
			suspend_cs = newcs;
	}		
		
The is_preferred_suspend_cs() can be based on rating, the maximum suspend
length which can be achieved or whatever is sensible. It should start of as
a very simple decision function based on rating and not an prematurely
overengineered monstrosity.

The suspend/resume() code needs a few very simple changes:
   
xxx_suspend():
	clocksource_prepare_suspend();

  Note, this is _NOT_ timekeeping_suspend() because that is invoked _AFTER_
  alarmtimer_suspend(). So if an alarm timer is required it needs to be
  armed before that. A trivial solution might be to just call it from
  alarmtimer_suspend(), but that a minor detail to worry about.

timekeeping_suspend()
{
	clocksource_enter_suspend();
	...

timekeeping_resume()
{
...
	if (clocksource_leave_suspend(&nsec)) {
		ts_delta = ns_to_timespec64(nsec);
		sleeptime_injected = true;
	} else if (......


Now lets look at the new functions:

void clocksource_prepare_suspend(void)
{
	if (!suspend_cs)
		return;

	if (needs_alarmtimer(suspend_cs))
		start_suspend_alarm(suspend_cs);
}

void clocksource_enter_suspend(void)
{
	if (!suspend_cs)
		return;
	suspend_start = suspend_cs->read();
}

bool clocksource_leave_suspend(u64 *nsec)
{
	u64 now, delta;

	if (!suspend_cs)
		return false;

	now = suspend_cs->read();
	delta = clocksource_delta(now, suspend_start, suspend_cs->mask);
	*nsec = mul_u64_u32_shr(delta, suspend_cs->mult, suspend_cs->shift);
	return true;
}

See? It does not need any of this totally nonsensical stuff in your
registration function and not any new read functions and whatever, because
it simply can use the bog standard mult/shift values. Why? Because the
conversion above can cope with a full 64 bit * 32 bit multiply without
falling apart. It's already there in timekeeping_resume() otherwise
resuming with a NONSTOP TSC would result in bogus sleep times after a few
minutes. It's slower than the normal clocksource conversion which is
optimized for performance, but thats completely irrelevant on resume. This
whole blurb about requiring separate mult/shift values is just plain
drivel.

Plus any reasonably broad clocksource will not need an alarmtimer at
all. Because the only reason it is needed is when the clocksource itself
wraps around. And that has absolutely nothing to do with mult/shift
values. That just depends on the frequency and the bitwidth of the counter,

So it does not need an update function either because in case of broad
enough clocksources there is absolutely no need for update and in case of
wrapping ones the alarmtimer brings it out of suspend on time. And because
the only interesting thing is the delta between suspend and resume this is
all a complete non issue.

The clocksource core already has all the registration/unregistration
functionality plus an interface to reconfigure the frequency, so
clocksources can come and go and be reconfigured and all of this just
works.

Once the extra few lines of code are in place, then you can go and cleanup
the existing mess of homebrewn interfaces and claim that this is
consolidation and simplification.

<rant>

What's wrong with you people? Didn't they teach you in school that the
first thing to do is proper problem and code analysis? If they did not, go
back to them and ask your money back,

I'm really tired of these overengineered trainwrecks which are then
advertised with bullshit marketing like the best invention since sliced
bread. This might work in random corporates, but not here.

</rant>

Thanks,

	tglx
