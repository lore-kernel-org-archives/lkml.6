Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA60FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E5E20643
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfBVLop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:44:45 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54653 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfBVLoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:44:44 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gx9Fv-00057O-WB; Fri, 22 Feb 2019 12:44:40 +0100
Date:   Fri, 22 Feb 2019 12:44:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Olaf Hering <olaf@aepfle.de>
cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: recalibrating x86 TSC during suspend/resume
In-Reply-To: <20190222105302.GA26398@aepfle.de>
Message-ID: <alpine.DEB.2.21.1902221212190.1777@nanos.tec.linutronix.de>
References: <20190222105302.GA26398@aepfle.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019, Olaf Hering wrote:
> Is there a way to recalibrate the x86 TSC during a suspend/resume cycle?

No.

> While the frequency will remain the same on a Laptop, it may (or rather:
> it definitly will) differ if a VM is migrated from one host to another.
> The hypervisor may choose to emulate the expected TSC frequency on the
> destination host, but this emulation comes with a significant
> performance cost. Therefore it would be good if the kernel evaluates the
> environment during resume.
> 
> The specific usecase I have is a workload within VMs that makes heavy
> use of TSC. The kernel is booted with 'clocksource=tsc highres=off nohz=off'
> because only this clocksource gives enough granularity. The default
> paravirtualized clock will return the same values via
> clock_gettime(CLOCK_MONOTONIC) if the timespan between two calls is too
> short. This does not happen with 'clocksource=tsc'.
> 
> Right now it is not possible to migrate VMs to hosts with different CPU
> speeds. This leads to "islands" of identical hardware, and makes
> maintenance of hosts harder than it needs to be. If the VM kernel would
> be able to cope with CPU/TSC frequency changes, the pool of potential
> destination hosts will become significant larger.

The problem with recalibrating TSC on resume is that it would have to be

    1) quick

    2) accurate, so NTP does not get utterly unhappy.

Newer Intels support TSC scaling for VMX, which could solve the problem. It
affects TSC readout by:

	TSC = (read(HWTSC) * multiplier) >> 48

So you can standarize on a TSC frequency accross a fleet. Not sure when
that was introduced and no idea whether it's available on AMD.

For a software solution we could try the following:

 1) Provide the raw TSC frequency of the host to the guest in some magic
    software defined MSR or CPUID. If there is an existing mechanism, use
    that.

 2) On resume check whether the MSR/CPUID is available and if so readout
    that information and check whether the frequency is the same as
    before. If not it is trivial enough to adjust the guest mult/shift
    values for both raw and NTP adjusted clocks before they are used again,
    i.e. before timekeeping_resume(). Need to look what's the best place,
    but probably the clocksource resume callback. Plus if TSC deadline
    timer is used, we'd need the same adjustment there.

    That's backward compatible, because if the MSR/CPUID is not there, then
    the recalibration is not tried.

Whether that is accurate enough or not to make NTP happy, I can't tell, but
it's definitely worth a try.

Thanks,

	tglx

