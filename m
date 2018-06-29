Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5902B27F8E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5902B27F8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935175AbeF2Oai (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:30:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:50277 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934210AbeF2Oaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:30:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 07:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="212186383"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2018 07:30:26 -0700
Message-ID: <3ae524498e6833abd5bb225987de97580262c4de.camel@linux.intel.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date:   Fri, 29 Jun 2018 17:30:25 +0300
In-Reply-To: <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
         <20180621212518.19914-10-pasha.tatashin@oracle.com>
         <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
         <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
         <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
         <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
         <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 12:43 +0200, Thomas Gleixner wrote:
> On Thu, 28 Jun 2018, Thomas Gleixner wrote:
> > I still want to document the unholy mess of what is initialized and
> > available when. We have 5 hypervisors and 3 different points in
> > early boot
> > where the calibrate_* callbacks are overwritten. The XEN PV one is
> > actually
> > post tsc_init_early() for whatever reason.
> > 
> > That's all completely obscure and any attempt of moving
> > tsc_early_init()
> > earlier than where it is now is just lottery.
> > 
> > The other issue is that double calibration, e.g. doing the PIT thing
> > twice
> > is just consuming boot time for no value.
> > 
> > All of that has been duct taped over time and we really don't want
> > yet
> > another thing glued to it just because we can.

Hmm... Good question about Intel MID, I would try to put my
understanding here.

> Boot sequence:
> 
>   start_kernel()
> 
> 	INTEL_MID:
> 		x86_intel_mid_early_setup()
> 	   	calibrate_tsc = intel_mid_calibrate_tsc
> 
> 	   	intel_mid_calibrate_tsc() { return 0; }

This sounds like a stub against very old calibration code since Intel
MID has no PIT, HPET, PMTIMER to calibrate from.

> 
>   setup_arch()
> 
> 	x86_init.oem.arch_setup();
> 	  INTEL_MID:
> 		intel_mid_arch_setup()
> 
> 		PENWELL:
> 		   x86_platform.calibrate_tsc = mfld_calibrate_tsc;
> 
> 		   MSR based magic. Value would be available right away.
> 		   
> 		TANGIER:
> 		   x86_platform.calibrate_tsc = tangier_calibrate_tsc;
> 	
> 		   Different MSR based magic. Value would be available
> 		   right away.		

This stuff is how we can read TSC frequency on those platforms.

The commit 7da7c1561366 ("x86, tsc: Add static (MSR) TSC calibration on
Intel Atom SoCs") introduced a common way for all those chips to get TSC
frequency, while forgetting remove old code.

Surprisingly, the same guy even amended legacy code in the commit
f3a02ecebed7 ("x86/tsc: Set TSC_KNOWN_FREQ and TSC_RELIABLE flags on
Intel Atom SoCs").



> INTEL_MID	intel_mid_calibrate_tsc()	intel_mid_calibrate_
> tsc()
> Generic		native_calibrate_cpu()		native_ca
> librate_cpu()
> 
> INTEL_MID	mfld_calibrate_tsc()		mfld_calibrate_ts
> c()
> PENWELL		native_calibrate_cpu()		native_ca
> librate_cpu()
> 
> INTEL_MID	tangier_calibrate_tsc()		tangier_calibr
> ate_tsc()
> TANGIER		native_calibrate_cpu()		native_ca
> librate_cpu()
> 


Taking above into consideration, I think we may just remove the legacy
code from mfld.c and mrfld.c and see what happen.

If you can tell me points to test, I can prepare patches to remove and
test on both Medfiled and Merrifield platforms (Penwell and Tangier SoCs
respectively).

> The INTEL MID stuff is wierd and not really obvious. AFAIR those
> systems
> don't have PIT or such, so they need to rely on the MSR/CPUID
> mechanisms to
> work, but that's just working because and not for obvious reasons.
> Andy,
> can you shed some light on that stuff?

Hope above makes sense.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
