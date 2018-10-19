Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB685ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A9021476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iz4tpors"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A9021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJTC4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:56:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38127 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbeJTC4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:56:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so38457791wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jaa+ry8zqf5Hk7PfKXT1OzZzXKzmAEWyMKsEMHrL9zE=;
        b=Iz4tpors8M0knaIBPEpruelsKjkrT/Pszqv17+TzfCnyBMJuqg/GT/c8bH2RSN99Ff
         hSwZhr836pSf8koSQgItJM6P53q3pQDyifKk8uCQBXiibXh2m+giaVUIRNO5pWVkjMLj
         OkvoiLAUFYyUExU5lbH/TID3FQfk6NEuWBH/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jaa+ry8zqf5Hk7PfKXT1OzZzXKzmAEWyMKsEMHrL9zE=;
        b=XA37vuVX2o69OLcvJgJa0fx4G8PPdNEfyPnclwm0LN0HPiSwv0PYOKdZp+rktBOyUL
         13NWaGx12XAIVSpqnBGCJs0xCgyowgIwupKzO4KwxEH/YV7s+tPieA8kSv4T3f73okfi
         4gYkTLTjhESLuioPV+jgfMBYeX04WLirWDyrfVHQXDvT5NIOgIzXrbs4ovPB7A2w8jcg
         JviI68IbTN73z1BJmv0gLLFbSGl6ooLCPr+yuAGG9/m3dfaKUol5GBRPW4z9yqgGFmH5
         YEMKqOHMIzxYMlMqsf+3Dr+yxntJ2JIc5X36gfVWtMNu6+lGuaPe/s0NDh9Zr1GABSJN
         4/wg==
X-Gm-Message-State: ABuFfoiKk/P1I1STcOM4I8z78Sa4l/KJwWVrTQQbhGRq+NADL7B6X+Ld
        OUkA/r1IABNr58XL/hrHXlBONfv/hj+Jr/Yv3zgCLXfMVJo=
X-Google-Smtp-Source: ACcGV60mMOD8ch5sOHTAMPjn3FcfH595mbznuloZJbpDQaWJn9ioVyCmco7IVJJXMn2gKtpASBOlPrTt7YQ7vrDy7lg=
X-Received: by 2002:adf:a194:: with SMTP id u20-v6mr27097447wru.50.1539974933705;
 Fri, 19 Oct 2018 11:48:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 11:48:53
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 19 Oct 2018 11:48:53 -0700
Message-ID: <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
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

On Fri, Oct 19, 2018 at 11:37 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 19 Oct 2018, Thomas Gleixner wrote:
>> On Mon, 15 Oct 2018, Christopher Hall wrote:
>> > TSC kHz used to calculate mult/shift value: 3312000
>>
>> Now the most interesting information here would be the resulting mult/shift
>> value which the kernel uses. Can you please provide that?
>
> But aside of the actual values it's pretty obvious why this happens. It's a
> simple rounding error. Minimal, but still. To avoid rounding errors you'd
> have to find mult and shift values which exactly result in:
>
>      (freq * mult) >> shift = 1e9
>
> which is impossible for freq = 3312 * 1e6.

Right.

> A possible fix for this is, because the error is in the low PPB range, to
> adjust the error once per second or in some other sensible regular
> interval.

Ehh.. I mean, this is basically what all the complicated ntp_error
logic does for the long-term accuracy compensation.  Part of the
allure of the raw clock is that there is no changes made over time.
Its a very simple constant calculation.

We could try to do something like pre-seed the ntpinterval value so
the default ntp_tick value corrects for this, but that's only going to
effect the monotonic/realtime clock until ntpd or anyone else sets a
different interval rate.

So  I'm not particularly eager in trying to do the type of small
frequency oscillation we do for monotonic/realtime for long-term
accuracy to the raw clock as that feels a bit antithetical to the
point of the raw clock.

I guess I'd want to understand more of the use here and the need to
tie the raw clock back to the hardware counter it abstracts.

thanks
-john
