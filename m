Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeCIAaD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:30:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:45340 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbeCIAaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:30:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="23169113"
Message-ID: <1520558683.37755.2.camel@intel.com>
Subject: Re: [PATCH v2] x86/tsc: Convert ART in nanoseconds to TSC.
From: Rajvi Jingar <rajvi.Jingar@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <christopher.s.hall@intel.com>
Date: Thu, 8 Mar 2018 17:24:43 -0800
In-Reply-To: <alpine.DEB.2.21.1803081518020.8662@nanos.tec.linutronix.de>
References: <1520354849-32593-1-git-send-email-rajvi.jingar@intel.com>
         <alpine.DEB.2.21.1803081518020.8662@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.22.254.140]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thank you for your comments.

On Thu, 2018-03-08 at 15:25 +0100, Thomas Gleixner wrote:
> On Tue, 6 Mar 2018, Rajvi Jingar wrote:
> > Device drivers use get_device_system_crosststamp() to produce
> > precise
> > system/device cross-timestamps. The PHC clock and ALSA interfaces,
> > for example, make the cross-timestamps available to user
> > applications.
> > On Intel platforms, get_device_system_crosststamp() requires a TSC
> > value derived from ART (Always Running Timer) to compute the
> > monotonic
> >  raw and realtime system timestamps.
> > 
> > Starting with Intel Goldmont platforms, the PCIe root complex
> > supports
> > the PTM time sync protocol. PTM requires all timestamps to be in
> > units
> > of nanoseconds. The Intel root complex hardware propagates system
> > time –
> > derived from ART - in units of nanoseconds performing the
> > conversion
> > as follows:
> > 
> > ART_NS = ART * 1e9 / <crystal frequency>
> > 
> > When user software requests a cross-timestamp, the system
> > timestamps
> > (generally read from device registers) must be converted to TSC by
> > the driver software as follows:
> > 
> > TSC = ART_NS * TSC_KHZ / 1e6
> > 
> > This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is
> > set
> > indicating the tsc_khz is derived from CPUID[15H]. Drivers should
> > check that this flag is set before conversion to TSC is attempted.
> 
> Clear and coherent changelog. Well done!
> 
> > Changes from v1:
> > 
> > * use existing frequency hardcode for platforms where
> > CPUID[15H].ECX == 0
> > (v1 added redundant hardcode just for the ART.ns conversion)
> > 
> > * use tsc_khz for TSC conversion, also requires driver to check
> > X86_FEATURE_TSC_KNOWN_FREQ (v1 used CPUID[15H].ECX value directly)
> 
> Maintainer lazyness request: Can you please put the changes paragraph
> below
> the --- seperator so it is discarded when the patch is extracted from
> mail. It's not part of the changelog which goes into git.
> 

Sure. It has been changed in v3.

> > +struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
> 
> Can you please add kernel doc format function documentation which
> explains
> the calling conventions?
> 

kernel-do format documentation is added to v3.

> > +{
> > +	u64 tmp, res, rem;
> > +
> > +	rem = do_div(art_ns, USEC_PER_SEC);
> > +
> > +	res = art_ns * tsc_khz;
> > +	tmp = rem * tsc_khz;
> > +
> > +	do_div(tmp, USEC_PER_SEC);
> > +	res += tmp;
> > +
> > +	return (struct system_counterval_t) {.cs =
> > art_related_clocksource,
> > +			.cycles = res};
> 
> Definitely way better than the previous one. Good job!
> 
> Thanks,
> 
> 	tglx

Thank you,
Rajvi
