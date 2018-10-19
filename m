Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF59ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3314121470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KF5rFqt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3314121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJTD3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:29:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56232 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbeJTD3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:29:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so4627182wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZlMlQPOJclJv+xXGcoxBjGLiqyoC1ZhiiZGbeszupIU=;
        b=KF5rFqt3R8pxhKJyFAbL3sBUPXiHPYQv1gtKHV1+zpWimMWbmDcdbH4Dpfmn5LBYLJ
         t8+/P78UOoBivrf+qsK4StxMwZdz9KvWFYO9oevFw5jA1YPkJHlONRIph2EKf9tDDpJI
         iX+T74rKXsm7J1YUp0Bmyl9SeKmPCMs07yBYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZlMlQPOJclJv+xXGcoxBjGLiqyoC1ZhiiZGbeszupIU=;
        b=EEVAtOWv/GyVNle9WPECWUtMpVz8SIo3IVsNBoTeZBHn/cPJ0mPc122PT24+vxobrU
         DQlTElq703P0/d6dFwTS4nkmqrEyoLV+36vTf8gaaIxrlTfKC4zRoibnXM6GwE0Wt0Hd
         ESkw2UpLIGiOQgG6AVhSnCGdyRiLj4ismu33X6mWr5YdyknvS22STTBsVZ3YZ3FwQf3u
         gThJ5TLIIoBnqwM1OPAvIza2FLXN4/3JhPFRXJE6MdXW8EHN5QnBzIQmG1AceZhbw1a7
         LlV+ktSjRdil889c25VK1lN9KqS6FRcRfbQI4Adn+i6RjwaZcxiIDmP8YoXgWXjHxTT0
         AD5Q==
X-Gm-Message-State: ABuFfoikoZvNxFC20VDSJ57bsPF081AGw3UNhIChj/WUN67TGlBS6pYt
        aosYtK/9YVC7lwH3G+FnecaYPpx8IPibpQPpRsK2fQ==
X-Google-Smtp-Source: ACcGV629VjYCwlorgdm8hlpB/KrEq1QplbxZaji1QwsR/vDCodyeQP0c/esMm1xz2a8W6n40VSfQpSgtlnpbN0WckgU=
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr5875085wml.15.1539976908025;
 Fri, 19 Oct 2018 12:21:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 12:21:47
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
 <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com> <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 19 Oct 2018 12:21:47 -0700
Message-ID: <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
Subject: Re: TSC to Mono-raw Drift
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com, gavin.hindman@intel.com,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:57 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 19 Oct 2018, John Stultz wrote:
>> On Fri, Oct 19, 2018 at 11:37 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Fri, 19 Oct 2018, Thomas Gleixner wrote:
>> >> On Mon, 15 Oct 2018, Christopher Hall wrote:
>> >> > TSC kHz used to calculate mult/shift value: 3312000
>> >>
>> >> Now the most interesting information here would be the resulting mult/shift
>> >> value which the kernel uses. Can you please provide that?
>> >
>> > But aside of the actual values it's pretty obvious why this happens. It's a
>> > simple rounding error. Minimal, but still. To avoid rounding errors you'd
>> > have to find mult and shift values which exactly result in:
>> >
>> >      (freq * mult) >> shift = 1e9
>> >
>> > which is impossible for freq = 3312 * 1e6.
>>
>> Right.
>>
>> > A possible fix for this is, because the error is in the low PPB range, to
>> > adjust the error once per second or in some other sensible regular
>> > interval.
>>
>> Ehh.. I mean, this is basically what all the complicated ntp_error
>> logic does for the long-term accuracy compensation.  Part of the
>> allure of the raw clock is that there is no changes made over time.
>> Its a very simple constant calculation.
>>
>> We could try to do something like pre-seed the ntpinterval value so
>> the default ntp_tick value corrects for this, but that's only going to
>> effect the monotonic/realtime clock until ntpd or anyone else sets a
>> different interval rate.
>>
>> So  I'm not particularly eager in trying to do the type of small
>> frequency oscillation we do for monotonic/realtime for long-term
>> accuracy to the raw clock as that feels a bit antithetical to the
>> point of the raw clock.
>
> I don't think you need complex oscillation for that. The error is constant
> and small enough that it is a fractional nanoseconds thing with an interval
> <= 1s. So you can just add that in a regular interval. Due to it being
> small you can't observe time jumping I think.

Well, from the examples the trouble is we seem to be a bit fast,
rather then slow.
So we'll have to reduce mult by one, and rework the calculations, but
maybe something like this (correcting the raw_interval value) would
work.

But this also sort of breaks, fundamental argument that the raw clock
is a simple mult/shift transformation of the underlying clocksource
counter. Its not the accuracy of the clock but the consistency that
was key.

The counter argument is that the raw clock is abstracting the
underlying hardware so folks who would have used the TSC directly can
now use the raw clock and have a generic abstracted hardware-counter
interface. So userland shouldn't really be worried about the
occasional injections made since they shouldn't be trying to
re-generate the abstraction from the hardware themselves.  <--
Remember this point as we move to the next comment:)

> The end-result is 'correct' as much correct it is in relation to real
> nanoseconds. :)
>
>> I guess I'd want to understand more of the use here and the need to
>> tie the raw clock back to the hardware counter it abstracts.
>
> The problem there is ART which is distributed to PCIe devices and ART time
> stamps are exposed in various ways. ART has a fixed ratio vs. TSC so there
> is a reasonable expectation that MONOTONIC_RAW is accurate.

Which is maybe sort of my issue here. The raw clock provided a
abstraction away from the hardware for generic usage, but then its
being re-used with other un-abstracted hardware references. So unless
they use the same method of transformation, there will be problems (of
varying degree).

We might be able to reduce the degree in this case, but I worry the
extra complexity may only cause problems for others.

thanks
-john
