Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B5FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0743F218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfBKWNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:13:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57704 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfBKWNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:13:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0010EBD;
        Mon, 11 Feb 2019 14:13:33 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CCA13F675;
        Mon, 11 Feb 2019 14:13:29 -0800 (PST)
Date:   Mon, 11 Feb 2019 22:13:25 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "me@packi.ch" <me@packi.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "schwab@suse.de" <schwab@suse.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "zongbox@gmail.com" <zongbox@gmail.com>
Subject: Re: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
Message-ID: <20190211221325.7244b575@why.wild-wind.fr.eu.org>
In-Reply-To: <83562b9d-e94b-76ce-7240-aac1dce43205@wdc.com>
References: <mhng-baffacaa-599b-4c89-a5a0-e0c85ddb6d44@palmer-si-x1c4>
        <83562b9d-e94b-76ce-7240-aac1dce43205@wdc.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 12:03:30 -0800
Atish Patra <atish.patra@wdc.com> wrote:

> On 2/11/19 11:02 AM, Palmer Dabbelt wrote:
> > On Fri, 08 Feb 2019 20:26:07 PST (-0800), david.abdurachmanov@gmail.com wrote:  
> >> On Sat, Feb 9, 2019 at 12:03 AM Atish Patra <atish.patra@wdc.com> wrote:  
> >>>
> >>> On 2/8/19 1:11 AM, Christoph Hellwig wrote:  
> >>>>> +     * We don't support running Linux on hertergenous ISA systems.
> >>>>> +     * But first "okay" processor might not be the boot cpu.
> >>>>> +     * Check the ISA of boot cpu.  
> >>>>
> >>>> Please use up your available 80 characters per line in comments.
> >>>>  
> >>> I will fix it.
> >>>  
> >>>>> +            /*
> >>>>> +             * All "okay" hart should have same isa. We don't know how to
> >>>>> +             * handle if they don't. Throw a warning for now.
> >>>>> +             */
> >>>>> +            if (elf_hwcap && temp_hwcap != elf_hwcap)
> >>>>> +                    pr_warn("isa mismatch: 0x%lx != 0x%lx\n",
> >>>>> +                            elf_hwcap, temp_hwcap);
> >>>>> +
> >>>>> +            if (hartid == boot_cpu_hartid)
> >>>>> +                    boot_hwcap = temp_hwcap;
> >>>>> +            elf_hwcap = temp_hwcap;  
> >>>>
> >>>> So we always set elf_hwcap to the capabilities of the previous cpu.
> >>>>  
> >>>>> +            temp_hwcap = 0;  
> >>>>
> >>>> I think tmp_hwcap should be declared and initialized inside the outer loop
> >>>> instead having to manually reset it like this.
> >>>>  
> >>>>> +    }
> >>>>>
> >>>>> +    elf_hwcap = boot_hwcap;  
> >>>>
> >>>> And then reset it here to the boot cpu.
> >>>>
> >>>> Shoudn't we only report the features supported by all cores?  Otherwise
> >>>> we'll still have problems if the boot cpu supports a feature, but not
> >>>> others.
> >>>>  
> >>>
> >>> Hmm. The other side of the argument is boot cpu does have a feature that
> >>> is not supported by other hart that didn't even boot.
> >>> The user space may execute something based on boot cpu capability but
> >>> that won't be enabled.
> >>>
> >>> At least, in this way we know that we are compatible completely with
> >>> boot cpu capabilities. Thoughts ?  
> >>
> >> There is one example on the market, e.g., Samsung Exynos 9810.
> >>
> >> Mongoose 3 (big cores) only support ARMv8.0, while Cortex-A55
> >> (little ones) support ARMv8.2 (and that brings atomics support).
> >> I think, it's the only ARM SOC that supports different ISA extensions
> >> between cores on the same package.
> >>
> >> Kernel scheduler doesn't know that big cores are missing atomics
> >> support or that applications needs it and moves the thread
> >> resulting in illegal instruction.
> >>
> >> E.g., see Golang issue: https://github.com/golang/go/issues/28431
> >>
> >> I also recall Jon Masters (Computer Architect at Red Hat) advocating
> >> against having cores with mismatched capabilities on the server market.
> >>
> >> It just causes more problems down the line.
> > > IMO the best bet is to only put extensions in HWCAP that are supported by all  
> > the harts that userspace will be scheduled on.
> > Fair enough. Instead of setting HWCAP in setup_arch() once, we can set it only for boot cpu. It will be updated after every cpu comes up online.  
> 
> Thus, HWCAP will consists all extensions supported by all cpus that are online currently.

You must thus prevent CPUs that have a different set of capabilities
from coming up late (once userspace has started).

	M.
-- 
Without deviation from the norm, progress is not possible.
