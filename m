Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DF0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D040820827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D040820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeKIVhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:37:32 -0500
Received: from foss.arm.com ([217.140.101.70]:58152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeKIVhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:37:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C612A80D;
        Fri,  9 Nov 2018 03:57:13 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0708E3F718;
        Fri,  9 Nov 2018 03:57:11 -0800 (PST)
Date:   Fri, 9 Nov 2018 11:56:44 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        kvm-devel <kvm@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
Message-ID: <20181109115644.f4qjqnv2kogoke42@lakrids.cambridge.arm.com>
References: <20181107171031.22573-1-alex.bennee@linaro.org>
 <20181107180120.urnvkcrkh46ytsdb@lakrids.cambridge.arm.com>
 <20181107180829.sex54bxhd5wyqvan@lakrids.cambridge.arm.com>
 <87r2fv68us.fsf@linaro.org>
 <20181108135122.llmfsel32dbe2q7o@lakrids.cambridge.arm.com>
 <87pnvf63u2.fsf@linaro.org>
 <CAFEAcA9v+XvAJBWpDMvEQPeJ7ALM15Yz5KY+wfGPmLG2a8yPRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9v+XvAJBWpDMvEQPeJ7ALM15Yz5KY+wfGPmLG2a8yPRQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 02:38:43PM +0000, Peter Maydell wrote:
> On 8 November 2018 at 14:28, Alex Bennée <alex.bennee@linaro.org> wrote:
> >
> > Mark Rutland <mark.rutland@arm.com> writes:
> >> One problem is that I couldn't spot when we advance the PC for an MMIO
> >> trap. I presume we do that in the kernel, *after* the MMIO trap, but I
> >> can't see where that happens.
> >
> > Nope it gets done before during decode_hsr in mmio.c:
> >
> >         /*
> >          * The MMIO instruction is emulated and should not be re-executed
> >          * in the guest.
> >          */
> >         kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> 
> I think that this attempt to do the PC-advance early is
> probably an underlying problem that is not helping the
> code structure here.
> 
> An enhancement that's been floated previously is that the
> MMIO emulation in userspace should be able to report back
> to KVM "nope, that access should generate a guest synchronous
> external abort (with ESR_EL1.EA = 0/1)".
> If we have that, then we definitely need to not advance the
> PC until after userspace has done the emulation and told
> us whether the memory access succeeded or not...

Yup.

I think that we absolutely want to do all the CPU state advancement (PC,
SS bit, etc) at the point we apply the effects of the instruction. Not
before we emulate the instruction, and not higher/lower in the call
stack.

We have a big problem in that guest-directed singlestep and
host-directed singlestep don't compose, and given that host-directed
singlestep doesn't work reliably today I'd be tempted to rip that out
until we've fixed guest-directed singlestep.

We should have a story for how host-directed debug is handled
transparently from the PoV of a guest using guest-directed debug.

Thanks,
Mark.
