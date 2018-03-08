Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935784AbeCHO0R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:26:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933489AbeCHO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:26:16 -0500
Date: Thu, 8 Mar 2018 15:25:48 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rajvi Jingar <rajvi.jingar@intel.com>
cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, christopher.s.hall@intel.com
Subject: Re: [PATCH v2] x86/tsc: Convert ART in nanoseconds to TSC.
In-Reply-To: <1520354849-32593-1-git-send-email-rajvi.jingar@intel.com>
Message-ID: <alpine.DEB.2.21.1803081518020.8662@nanos.tec.linutronix.de>
References: <1520354849-32593-1-git-send-email-rajvi.jingar@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-615922065-1520518841=:8662"
Content-ID: <alpine.DEB.2.21.1803081521040.8662@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-615922065-1520518841=:8662
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1803081521041.8662@nanos.tec.linutronix.de>

On Tue, 6 Mar 2018, Rajvi Jingar wrote:
> Device drivers use get_device_system_crosststamp() to produce precise
> system/device cross-timestamps. The PHC clock and ALSA interfaces,
> for example, make the cross-timestamps available to user applications.
> On Intel platforms, get_device_system_crosststamp() requires a TSC
> value derived from ART (Always Running Timer) to compute the monotonic
>  raw and realtime system timestamps.
> 
> Starting with Intel Goldmont platforms, the PCIe root complex supports
> the PTM time sync protocol. PTM requires all timestamps to be in units
> of nanoseconds. The Intel root complex hardware propagates system time –
> derived from ART - in units of nanoseconds performing the conversion
> as follows:
> 
> ART_NS = ART * 1e9 / <crystal frequency>
> 
> When user software requests a cross-timestamp, the system timestamps
> (generally read from device registers) must be converted to TSC by
> the driver software as follows:
> 
> TSC = ART_NS * TSC_KHZ / 1e6
> 
> This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
> indicating the tsc_khz is derived from CPUID[15H]. Drivers should
> check that this flag is set before conversion to TSC is attempted.

Clear and coherent changelog. Well done!

> Changes from v1:
> 
> * use existing frequency hardcode for platforms where CPUID[15H].ECX == 0
> (v1 added redundant hardcode just for the ART.ns conversion)
> 
> * use tsc_khz for TSC conversion, also requires driver to check
> X86_FEATURE_TSC_KNOWN_FREQ (v1 used CPUID[15H].ECX value directly)

Maintainer lazyness request: Can you please put the changes paragraph below
the --- seperator so it is discarded when the patch is extracted from
mail. It's not part of the changelog which goes into git.

> +struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)

Can you please add kernel doc format function documentation which explains
the calling conventions?

> +{
> +	u64 tmp, res, rem;
> +
> +	rem = do_div(art_ns, USEC_PER_SEC);
> +
> +	res = art_ns * tsc_khz;
> +	tmp = rem * tsc_khz;
> +
> +	do_div(tmp, USEC_PER_SEC);
> +	res += tmp;
> +
> +	return (struct system_counterval_t) {.cs = art_related_clocksource,
> +			.cycles = res};

Definitely way better than the previous one. Good job!

Thanks,

	tglx
--8323329-615922065-1520518841=:8662--
