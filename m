Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E363DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89165204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kz061Smv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89165204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeJXCzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:55:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43397 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbeJXCzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:55:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10-v6so2775755wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+iI2WIH8XTggL0ZcvmaPJUnh55lXQmNlHjbP+7TjBmw=;
        b=Kz061SmvKEPtC/Q1J/gDZj7FFj88C1PAwKLv6E4bVjZ3CrNfr2kdIyqnxYVUxAawp4
         ed9zzU4s6Uzj2ohPH1ou5vxhcnOB0l5frlWmLk86ZntEPiPuEVjHTNNBhwKp1uj7OMt3
         EM2ceN4NjTCg0F09MO59Ry/L/iQoh0n8Cc5uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+iI2WIH8XTggL0ZcvmaPJUnh55lXQmNlHjbP+7TjBmw=;
        b=UdM8YA76jIJPXB+7MpINyExu2UlVvR6ufhSjkFGwD2OAi6eZGkWT3+c6Yygrk6T07q
         9XIMBiAb+a9e31/yGBmewKNMJaBlaQf1sI9blf72TqxVTqP/kqmvV5DRfb3H0f78qC00
         hWEzdmMZ1pk9U7LX3SKMWas8smiYlvqxvUlESe+OvTgY6vMXPw5RycLpqBW1UfUR0cNd
         UhHQzXaKNXPZ0btR9aANZ0aHR0zi+58ozLw/BdDTzjJ57vdIKW63SgCu2s7rhnGE6w8R
         c06nBqOyNiX8hf0vRpZGz666d6khIwYDO70hYGcT1bpUdfQrsyhI2/mmMLagAIVehFNb
         Qu7g==
X-Gm-Message-State: ABuFfogszvJGZSspw3+CmM9h88BgS3rU8dFxDXy8glUFyY69fadUPK8b
        tMXF1qPcQsesSoQhI8ZcTEJl96PdVETxnjShjBoVrA==
X-Google-Smtp-Source: ACcGV62I1Wym9CcQNj/ZEhWdJdqNvFg2Q7LSlu0fbhq195NmxRCNA6JwZb4DpeVTijTKZJyGlfIL6XlVrVLuv8sKjyA=
X-Received: by 2002:adf:ba06:: with SMTP id o6-v6mr25781187wrg.249.1540319461616;
 Tue, 23 Oct 2018 11:31:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 11:31:00
 -0700 (PDT)
In-Reply-To: <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
 <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de> <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 23 Oct 2018 11:31:00 -0700
Message-ID: <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com>
Subject: Re: TSC to Mono-raw Drift
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 3:36 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Fri, Oct 19, 2018 at 1:50 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> John,
>>
>> On Fri, 19 Oct 2018, John Stultz wrote:
>>> On Fri, Oct 19, 2018 at 11:57 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> > I don't think you need complex oscillation for that. The error is constant
>>> > and small enough that it is a fractional nanoseconds thing with an interval
>>> > <= 1s. So you can just add that in a regular interval. Due to it being
>>> > small you can't observe time jumping I think.
>>>
>>> Well, from the examples the trouble is we seem to be a bit fast,
>>> rather then slow.
>>> So we'll have to reduce mult by one, and rework the calculations, but
>>> maybe something like this (correcting the raw_interval value) would
>>> work.
>>
>> Shouldn't be rocket science. It's a one off calculation of adjustment value
>> and maybe the period at which the correction happens.
>>
>>> But this also sort of breaks, fundamental argument that the raw clock
>>> is a simple mult/shift transformation of the underlying clocksource
>>> counter. Its not the accuracy of the clock but the consistency that
>>> was key.
>>>
>>> The counter argument is that the raw clock is abstracting the
>>> underlying hardware so folks who would have used the TSC directly can
>>> now use the raw clock and have a generic abstracted hardware-counter
>>> interface. So userland shouldn't really be worried about the
>>> occasional injections made since they shouldn't be trying to
>>> re-generate the abstraction from the hardware themselves.  <--
>>> Remember this point as we move to the next comment:)
>>>
>>> > The end-result is 'correct' as much correct it is in relation to real
>>> > nanoseconds. :)
>>> >
>>> >> I guess I'd want to understand more of the use here and the need to
>>> >> tie the raw clock back to the hardware counter it abstracts.
>>> >
>>> > The problem there is ART which is distributed to PCIe devices and ART time
>>> > stamps are exposed in various ways. ART has a fixed ratio vs. TSC so there
>>> > is a reasonable expectation that MONOTONIC_RAW is accurate.
>>>
>>> Which is maybe sort of my issue here. The raw clock provided a
>>> abstraction away from the hardware for generic usage, but then its
>>> being re-used with other un-abstracted hardware references. So unless
>>> they use the same method of transformation, there will be problems (of
>>> varying degree).
>>
>> OTOH. If people use the CPUID provided frequency information and the TSC
>> from userspace then they get different results which is contrary to the
>> goal of providing them an abstracted way of doing it.
>
> But that's my point. If they are pulling time values from the hardware
> directly that's unabstracted. I'm not sure its smart to be comparing
> the abstracted and unabstracted time stamps if your worried about
> precision. They are sort of two separate (though similar) time
> domains.
>
>>> We might be able to reduce the degree in this case, but I worry the
>>> extra complexity may only cause problems for others.
>>
>> Is it really that complex to add a fixed correction value periodically?
>>
>> I don't think so and it should just work for any clocksource which is
>> exposed this way. Famous last words .....
>
> I'm not saying that the code is overly complex (at least compared to
> the rest of the timekeeping code :), but just how the accumulation is
> done is less-trivial. So if someone else is trying to mimic the
> abstracted time with unabstracted hardware values (again, not
> something I reccomend, but that's sort of the usage case pushing
> this), they need to use a similar method that is slightly more
> complicated (or use slower math). Its all subtle stuff, but this makes
> something that was relatively very simple (by design) a bit harder to
> explain.

Adding Mirosalv as he's always thoughtful on these sorts of issues.

I spent a little bit of time thinking this out. Unfortunately I don't
think its a simple matter of calculating the granularity error on the
raw clock and adding it in each interval. The other trouble spot is
that the adjusted clocks (monotonic/realtime) are adjusted off of that
raw clock. So they would need to have that error added as well,
otherwise the raw and a otherwise non-adjusted monotonic clock would
drift.

However, to be correct, the ntp adjustments made would have to be made
to both the base interval + error, which mucks the math up a fair bit.

Maybe Miroslav will have a better idea here, but otherwise I'll stew
on this a bit more and see what I can come up with.

thanks
-john
