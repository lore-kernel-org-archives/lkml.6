Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C026C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296A82702D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296A82702D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934075AbeF1Hcc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:32:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933094AbeF1Hca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:32:30 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fYRP9-0002Pl-Ls; Thu, 28 Jun 2018 09:31:47 +0200
Date:   Thu, 28 Jun 2018 09:31:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
 <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
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

On Tue, 26 Jun 2018, Pavel Tatashin wrote:
> On Tue, Jun 26, 2018 at 11:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > I have an idea how to distangle it and we'll end up in a staged approach,
> > which looks like this:
> >
> >     1) Earliest one (not sure how early yet)
> >
> >        Attempt to use MSR/CPUID. If not running on a hypervisor this can
> >        try the quick PIT calibration, but nothing else.
> >
> >     2) Post init_hypervisor_platform()
> >
> >        An attempt to use the hypervisor data can be made.
> >
> >     3) Post early_acpi_boot_init()
> >
> >        This can do PIT/HPET based calibration
> >
> >     4) Post x86_dtb_init()
> >
> >        PIT/PMTIMER based calibration
> >
> > Once tsc_khz is known, no further attempts of calibration are made. I'll
> > look into that later tonight.
> 
> I think, there are no reasons to try staged attempts. It usually gets
> harder to maintain overtime. In my opinion it is best if do it in two
> tries, as right now, but just cleaner. The first attempt we get a
> crude result, using the lowest denominator to which current logic
> might fallback if something else is not available that early in boot:
> i.e cpu calibration loop in native_calibrate_cpu() but later get
> something better. Also, even if early clock does not work because we
> could not get tsc early, it is not a problem, we still will probably
> determine it later during tsc_init call.

I still want to document the unholy mess of what is initialized and
available when. We have 5 hypervisors and 3 different points in early boot
where the calibrate_* callbacks are overwritten. The XEN PV one is actually
post tsc_init_early() for whatever reason.

That's all completely obscure and any attempt of moving tsc_early_init()
earlier than where it is now is just lottery.

The other issue is that double calibration, e.g. doing the PIT thing twice
is just consuming boot time for no value.

All of that has been duct taped over time and we really don't want yet
another thing glued to it just because we can.

> I have re-wrote tsc_early_init()/tsc_init(), they are much simpler now:
> 
> void __init tsc_early_init(void)
> {
>         if (!boot_cpu_has(X86_FEATURE_TSC))
>                 return;
> 
>         if (!determine_cpu_tsc_frequncies())
>                 return;

That still wants to do the TSC_ADJUST call here.

Thanks,

	tglx
