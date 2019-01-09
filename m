Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFE2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4574820675
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfAINQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:16:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56432 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfAINQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:16:09 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ghDiG-0000mJ-Kx; Wed, 09 Jan 2019 14:16:05 +0100
Date:   Wed, 9 Jan 2019 14:16:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     Jiri Kosina <jikos@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
In-Reply-To: <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1901091410500.1755@nanos.tec.linutronix.de>
References: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de> <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm> <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Wed, 9 Jan 2019, Paul Menzel wrote:
> I get the same with microcode updates applied.
> 
>     $ dmesg | grep 'microcode: CPU0: patch_level'
>     [    3.809210] microcode: CPU0: patch_level=0x0600063e
>     $ sudo modprobe msr
>     $ sudo ./wrmsr 0x49 0x1
>     wrmsr: CPU 0 cannot set MSR 0x00000049 to 0x0000000000000001
> 
> > Could you please post /proc/cpuinfo from such a boot as well?

/proc/cpuinfo unfortunately does not contain the amd specific IBPB flag,
but the dmesg of the original report says:

  Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier

which means, that the CPUID bit is set.

Can you please provide the output of:

  cpuid -1 -l 0x80000008 -r

On my AMD Opteron(TM) Processor 6276 with microcode 0x600063d loaded I get:

   0x80000008 0x00: eax=0x00003030 ebx=0x00000000 ecx=0x0000500f edx=0x00000000

EBX is 0, which means that X86_FEATURE_AMD_IBPB is not enabled. So the
kernel does not try to use the speculation control MSR (0x49).

Thanks,

	tglx
