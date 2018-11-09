Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B53C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1521A20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1521A20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeKIXKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:10:39 -0500
Received: from foss.arm.com ([217.140.101.70]:60228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeKIXKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:10:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97B7080D;
        Fri,  9 Nov 2018 05:30:00 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9403F5C0;
        Fri,  9 Nov 2018 05:29:58 -0800 (PST)
Date:   Fri, 9 Nov 2018 13:29:56 +0000
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
Message-ID: <20181109132955.kqfccmqrugfj5rkl@lakrids.cambridge.arm.com>
References: <20181107180120.urnvkcrkh46ytsdb@lakrids.cambridge.arm.com>
 <20181107180829.sex54bxhd5wyqvan@lakrids.cambridge.arm.com>
 <87r2fv68us.fsf@linaro.org>
 <20181108135122.llmfsel32dbe2q7o@lakrids.cambridge.arm.com>
 <87pnvf63u2.fsf@linaro.org>
 <CAFEAcA9v+XvAJBWpDMvEQPeJ7ALM15Yz5KY+wfGPmLG2a8yPRQ@mail.gmail.com>
 <20181109115644.f4qjqnv2kogoke42@lakrids.cambridge.arm.com>
 <87lg625th2.fsf@linaro.org>
 <20181109124930.axelmyohmrcb63b4@lakrids.cambridge.arm.com>
 <CAFEAcA-xuUPukf9EPeetr_+RSU7FPDMXmyk3zbjY=FcV65CF=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-xuUPukf9EPeetr_+RSU7FPDMXmyk3zbjY=FcV65CF=g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 12:56:54PM +0000, Peter Maydell wrote:
> On 9 November 2018 at 12:49, Mark Rutland <mark.rutland@arm.com> wrote:
> > I'm not saying anything about *decisions*. I'm saying that we can make
> > the state consistent by advancing the singlestep state in the same way
> > that HW does, at the instant it advances the PC.
> >
> > i.e. do that in kvm_skip_instr(), as I've done in my local tree.
> >
> > That mirrors the HW, and we don't need to special-case any handling for
> > emulated vs non-emulated instructions.
> 
> You also need to do it in the "set PC because we're making the guest
> take an exception" code path, which doesn't go through kvm_skip_instr().

Sure.

> This corresponds to the two kinds of "step completed" in hardware as
> noted in DDI0487D.a D2.12.3 fig D2-3 footnote b:
>  * executing the instruction to be stepped without taking an exception
>  * taking an exception to an exception level that debug exceptions
>    are enabled from [ie guest EL1 in our case]

Thanks for the pointer!

Mark.
