Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37005ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A6D2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A6D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeJSXcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:32:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJSXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:32:02 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gDWe7-0001XP-6g; Fri, 19 Oct 2018 17:25:03 +0200
Date:   Fri, 19 Oct 2018 17:25:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christopher Hall <christopher.s.hall@intel.com>
cc:     "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com, gavin.hindman@intel.com,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: TSC to Mono-raw Drift
In-Reply-To: <20181015160945.5993-1-christopher.s.hall@intel.com>
Message-ID: <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher,

Please Cc LKML on such issues in the future.

On Mon, 15 Oct 2018, Christopher Hall wrote:

Leaving context around for new readers:

> Problem Statement:
> 
> The TSC clocksource mult/shift values are derived from CPUID[15H], but the
> monotonic raw clock value is not equal to TSC in nominal nanoseconds, i.e.
> the timekeeping code is not accurately transforming TSC ticks to nominal
> nanoseconds based on CPUID[15H}.
> 
> The included code calculates the drift between nominal TSC nanoseconds and
> the monotonic raw clock.
> 
> Background:
> 
> Starting with 6th generation Intel CPUs, the TSC is "phase locked" to the
> Always Running Timer (ART). The relation between TSC and ART is read from
> CPUID[15H]. Details of the TSC-ART relation are in the "Invariant
> Timekeeping" section of the SDM.
> 
> CPUID[15H].ECX returns the nominal frequency of ART (or crystal frequency).
> CPU feature TSC_KNOWN_FREQ indicates that tsc_khz (tsc.c) is derived from
> CPUID[15H]. The calculation is in tsc.c:native_calibrate_tsc().
> 
> When the TSC clocksource is selected, the timekeeping code uses mult/shift
> values to transform TSC into nanoseconds. The mult/shift value is determined
> using tsc_khz.
> 
> Example Output:
> 
> Running for 3 seconds trial 1
> Scaled TSC delta: 3000328845
> Monotonic raw delta: 3000329117
> Ran for 3 seconds with 272 ns skew
> 
> Running for 3 seconds trial 2
> Scaled TSC delta: 3000295209
> Monotonic raw delta: 3000295482
> Ran for 3 seconds with 273 ns skew
> 
> Running for 3 seconds trial 3
> Scaled TSC delta: 3000262870
> Monotonic raw delta: 3000263142
> Ran for 3 seconds with 272 ns skew
> 
> Running for 300 seconds trial 4
> Scaled TSC delta: 300000281725
> Monotonic raw delta: 300000308905
> Ran for 300 seconds with 27180 ns skew
> 
> The skew between tsc and monotonic raw is about 91 PPB. 
> 
> System Information:
> 
> CPU model string: Intel(R) Core(TM) i5-6600 CPU @ 3.30GHz
> Kernel version tested: 4.14.71-rt44
> 	NOTE: The skew seems to be insensitive to kernel version after
> 		introduction of TSC_KNOWN_FREQ capability
> 
> >From CPUID[15H]:
> 	Time Stamp Counter/Core Crystal Clock Information (0x15):
> 		TSC/clock ratio = 276/2
> 		nominal core crystal clock = 24000000 Hz (table lookup)
> 
> TSC kHz used to calculate mult/shift value: 3312000

Now the most interesting information here would be the resulting mult/shift
value which the kernel uses. Can you please provide that?

Thanks,

	Thomas
