Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE58C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C372064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C372064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeKBDH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:07:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57917 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeKBDH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:07:59 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIHJh-00088J-Sg; Thu, 01 Nov 2018 19:03:38 +0100
Date:   Thu, 1 Nov 2018 19:03:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Stultz <john.stultz@linaro.org>
cc:     Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: TSC to Mono-raw Drift
In-Reply-To: <CALAqxLV7SGRx_jKyM_RmzBGmnqAtDRXQLcH4Yjj+HKCY1O9sOQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811011859590.1642@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com> <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de> <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de> <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com> <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de> <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com> <alpine.DEB.2.21.1811011841060.1642@nanos.tec.linutronix.de> <CALAqxLV7SGRx_jKyM_RmzBGmnqAtDRXQLcH4Yjj+HKCY1O9sOQ@mail.gmail.com>
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

On Thu, 1 Nov 2018, John Stultz wrote:
> On Thu, Nov 1, 2018 at 10:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 23 Oct 2018, John Stultz wrote:
> >> On Fri, Oct 19, 2018 at 3:36 PM, John Stultz <john.stultz@linaro.org> wrote:
> >> I spent a little bit of time thinking this out. Unfortunately I don't
> >> think its a simple matter of calculating the granularity error on the
> >> raw clock and adding it in each interval. The other trouble spot is
> >> that the adjusted clocks (monotonic/realtime) are adjusted off of that
> >> raw clock. So they would need to have that error added as well,
> >> otherwise the raw and a otherwise non-adjusted monotonic clock would
> >> drift.
> >>
> >> However, to be correct, the ntp adjustments made would have to be made
> >> to both the base interval + error, which mucks the math up a fair bit.
> >
> > Hmm, confused as usual. Why would you need to do anything like that?
> 
> Because the NTP adjustment is done off of what is now the raw clock.
> If the raw clock is "corrected" the ppb adjustment has to be done off
> of that corrected rate.

Sure, but why would that require any change? Right now the raw clock is
slightly off and you correct clock monotonic against NTP. So with that
extra correction you just see a slightly different raw clock slew and work
from there.

> Otherwise with no correction, the raw clock and the monotonic clock
> would drift apart.

They drift apart today already if you do NTP correction. They stay in sync
w/o NTP/PTP/PPS.

But maybe I confused myself completely by now.

Thanks,

	tglx
