Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A73BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED78208B7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED78208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935378AbeF1M2h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:28:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56111 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932640AbeF1M2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:28:36 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fYW1D-0006lc-Gw; Thu, 28 Jun 2018 14:27:23 +0200
Date:   Thu, 28 Jun 2018 14:27:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
        douly.fnst@cn.fujitsu.com, Prarit Bhargava <prarit@redhat.com>,
        feng.tang@intel.com, Petr Mladek <pmladek@suse.com>,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <20180628114615.GF2494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806281421550.1778@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de> <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
 <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de> <20180628114615.GF2494@hirez.programming.kicks-ass.net>
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

On Thu, 28 Jun 2018, Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:43:59PM +0200, Thomas Gleixner wrote:
> > 	init_hypervisor_platform()
> > 	   vmware:
> > 	           Retrieves frequency and store it for the
> > 		   calibration function
> > 
> > 		   khz = vmware_get_khz_magic()
> > 		   vmware_tsc_khz = khz
> > 		   calibrate_cpu = vmware_get_tsc_khz
> > 	   	   calibrate_tsc = vmware_get_tsc_khz
> > 		   preset_lpj(khz)
> > 
> >  	   hyperv:
> > 		   if special hyperv MSRs are available:
> > 
> > 		      calibrate_cpu = hv_get_tsc_khz
> > 		      calibrate_tsc = hv_get_tsc_khz
> > 
> > 		   MSR is readable already in this function
> > 
> > 	   jailhouse:
> > 	   
> > 		   Frequency is available in this function and store
> > 		   in a variable for the calibration function
> > 
> > 		   calibrate_cpu	= jailhouse_get_tsc
> > 		   calibrate_tsc	= jailhouse_get_tsc
> > 
> > 	...
> > 	
> > 	kvmclock_init()
> > 
> > 		if (magic_conditions)
> > 			calibrate_tsc = kvm_get_tsc_khz
> > 			calibrate_cpu = kvm_get_tsc_khz
> > 
> > 			kvm_get_preset_lpj()
> > 			   khz = kvm_get_tsc_khz()
> > 			   preset_lpj(khz);
> 
> Note that all these which get TSC values from a HV _should_ set
> X86_FEATURE_TSC_KNOWN_FREQ to avoid the late recalibrate.

True.

> Calibrating against a virtual PIT/HPET/PMTIMER is utterly pointless.

It kinda works :)
 
> > The generic initilizaiton does everything twice, which makes no sense,
> > except for the unlikely case were no fast functions are available and the
> > quick PIT calibration fails (PMTIMER/HPET) are not available in early
> > calibration. HPET 
> 
> Incomplete; but I suspect you want to talk about how we can make HPET
> available early by putting it in a fixmap.

As I figured out now that's only part of the picture. We also need to do
that past x86_dtb_init() because early_quirks() and the early acpi/sfi/dtb
stuff needs to be completed before it makes sense to access hpet. But at
that point we also have the PMTIMER info.

> And only if we fail, do we at a later stage try again using PMTIMER.
> 
> Currently it all works by accident, since !hpet and acpi_pm_read_early()
> returns 0, but really we should not be running the fallback crap at all
> that early.

Right.

Thanks,

	tglx
