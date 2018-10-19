Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CCFECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98702086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98702086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJTDE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:04:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40049 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeJTDE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:04:59 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gDZxW-0004hY-HS; Fri, 19 Oct 2018 20:57:18 +0200
Date:   Fri, 19 Oct 2018 20:57:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Stultz <john.stultz@linaro.org>
cc:     Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com, gavin.hindman@intel.com,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC to Mono-raw Drift
In-Reply-To: <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com> <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de> <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
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

On Fri, 19 Oct 2018, John Stultz wrote:
> On Fri, Oct 19, 2018 at 11:37 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 19 Oct 2018, Thomas Gleixner wrote:
> >> On Mon, 15 Oct 2018, Christopher Hall wrote:
> >> > TSC kHz used to calculate mult/shift value: 3312000
> >>
> >> Now the most interesting information here would be the resulting mult/shift
> >> value which the kernel uses. Can you please provide that?
> >
> > But aside of the actual values it's pretty obvious why this happens. It's a
> > simple rounding error. Minimal, but still. To avoid rounding errors you'd
> > have to find mult and shift values which exactly result in:
> >
> >      (freq * mult) >> shift = 1e9
> >
> > which is impossible for freq = 3312 * 1e6.
> 
> Right.
> 
> > A possible fix for this is, because the error is in the low PPB range, to
> > adjust the error once per second or in some other sensible regular
> > interval.
> 
> Ehh.. I mean, this is basically what all the complicated ntp_error
> logic does for the long-term accuracy compensation.  Part of the
> allure of the raw clock is that there is no changes made over time.
> Its a very simple constant calculation.
> 
> We could try to do something like pre-seed the ntpinterval value so
> the default ntp_tick value corrects for this, but that's only going to
> effect the monotonic/realtime clock until ntpd or anyone else sets a
> different interval rate.
> 
> So  I'm not particularly eager in trying to do the type of small
> frequency oscillation we do for monotonic/realtime for long-term
> accuracy to the raw clock as that feels a bit antithetical to the
> point of the raw clock.

I don't think you need complex oscillation for that. The error is constant
and small enough that it is a fractional nanoseconds thing with an interval
<= 1s. So you can just add that in a regular interval. Due to it being
small you can't observe time jumping I think.

The end-result is 'correct' as much correct it is in relation to real
nanoseconds. :)

> I guess I'd want to understand more of the use here and the need to
> tie the raw clock back to the hardware counter it abstracts.

The problem there is ART which is distributed to PCIe devices and ART time
stamps are exposed in various ways. ART has a fixed ratio vs. TSC so there
is a reasonable expectation that MONOTONIC_RAW is accurate.

Thanks,

	tglx
