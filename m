Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E24DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F93F26D5C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F93F26D5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeFZPmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:42:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50438 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbeFZPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:42:54 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXq6k-0004CE-8S; Tue, 26 Jun 2018 17:42:18 +0200
Date:   Tue, 26 Jun 2018 17:42:14 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
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

Pavel,

first of all, sorry for my last outburst. I just was in a lousy mood after
staring into too much half baken stuff and failed to make myself stay away
from the computer.

On Sun, 24 Jun 2018, Thomas Gleixner wrote:
> On Sat, 23 Jun 2018, Pavel Tatashin wrote:
> And this early init sequence also needs to pull over the tsc adjust
> magic. So tsc_early_delay_calibrate() which should btw. be renamed to
> tsc_early_init() should have:
> 
> {
> 	cpu_khz = x86_platform.calibrate_cpu();
>         tsc_khz = x86_platform.calibrate_tsc();
> 
>         tsc_khz = tsc_khz ? : cpu_khz;
>         if (!tsc_khz)
>                 return;
> 
>         /* Sanitize TSC ADJUST before cyc2ns gets initialized */
>         tsc_store_and_check_tsc_adjust(true);
> 
> 	calc_lpj(tsc_khz);
> 		
> 	tsc_sched_clock_init();
> }

Peter made me look deeper into this and there are a few issues, which I
missed, depending on when some of the resources become available. So we
probably cannot hook all of this into tsc_early_delay_calibrate().

I have an idea how to distangle it and we'll end up in a staged approach,
which looks like this:

    1) Earliest one (not sure how early yet)

       Attempt to use MSR/CPUID. If not running on a hypervisor this can
       try the quick PIT calibration, but nothing else.

    2) Post init_hypervisor_platform()

       An attempt to use the hypervisor data can be made.

    3) Post early_acpi_boot_init()

       This can do PIT/HPET based calibration

    4) Post x86_dtb_init()

       PIT/PMTIMER based calibration

Once tsc_khz is known, no further attempts of calibration are made. I'll
look into that later tonight.

Thanks,

	tglx
