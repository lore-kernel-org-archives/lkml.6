Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3478DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054DA204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054DA204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeKBUdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:33:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58990 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:33:05 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIXaO-00041t-PY; Fri, 02 Nov 2018 12:25:56 +0100
Date:   Fri, 2 Nov 2018 12:25:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miroslav Lichvar <mlichvar@redhat.com>
cc:     John Stultz <john.stultz@linaro.org>,
        Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC to Mono-raw Drift
In-Reply-To: <20181102112006.GM19434@localhost>
Message-ID: <alpine.DEB.2.21.1811021225010.1895@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de> <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com> <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de> <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de> <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com> <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com> <alpine.DEB.2.21.1811011841060.1642@nanos.tec.linutronix.de>
 <CALAqxLV7SGRx_jKyM_RmzBGmnqAtDRXQLcH4Yjj+HKCY1O9sOQ@mail.gmail.com> <alpine.DEB.2.21.1811011859590.1642@nanos.tec.linutronix.de> <20181102112006.GM19434@localhost>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018, Miroslav Lichvar wrote:
> On Thu, Nov 01, 2018 at 07:03:37PM +0100, Thomas Gleixner wrote:
> > On Thu, 1 Nov 2018, John Stultz wrote:
> > > On Thu, Nov 1, 2018 at 10:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > On Tue, 23 Oct 2018, John Stultz wrote:
> > > >> However, to be correct, the ntp adjustments made would have to be made
> > > >> to both the base interval + error, which mucks the math up a fair bit.
> > > >
> > > > Hmm, confused as usual. Why would you need to do anything like that?
> > > 
> > > Because the NTP adjustment is done off of what is now the raw clock.
> > > If the raw clock is "corrected" the ppb adjustment has to be done off
> > > of that corrected rate.
> > 
> > Sure, but why would that require any change? Right now the raw clock is
> > slightly off and you correct clock monotonic against NTP. So with that
> > extra correction you just see a slightly different raw clock slew and work
> > from there.
> 
> It makes sense to me.
> 
> I think there are basically two different ways how it could be done.
> One is to correct the frequency of the raw clock, on which sits the
> mono/real clock. The other is to create a new raw clock which is
> separate from the mono/real clock, and add an offset to the NTP
> frequency to match the frequencies of the two clocks when not
> synchronized by NTP/PTP. The latter would provide a more stable
> mono/real clock.
> 
> clocksource -> MONOTONIC_RAW -> MONOTONIC/REALTIME
> 
> or 
> 
> clocksource -> ? -> MONOTONIC_RAW
>                  -> MONOTONIC/REALTIME

That's what we have now. At least I don't see how the raw thing is coupled
in NTP.

Thanks,

	tglx
