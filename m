Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA67ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DAE21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DAE21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJSTlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:41:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50846 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbeJSTln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:41:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B023180D;
        Fri, 19 Oct 2018 04:36:02 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8268E3F71D;
        Fri, 19 Oct 2018 04:35:59 -0700 (PDT)
Date:   Fri, 19 Oct 2018 12:35:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     Ramana Radhakrishnan <ramana.radhakrishnan@foss.arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 11/17] arm64: docs: document pointer authentication
Message-ID: <20181019113556.ljbdmjo5pdw7muvz@mbp>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-12-kristina.martsenko@arm.com>
 <9acb0cd2-66b0-1c41-b1a8-7c70608e9a9b@foss.arm.com>
 <7b0de19b-45b9-f4df-25d1-c7e80fab49dc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0de19b-45b9-f4df-25d1-c7e80fab49dc@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:14:39PM +0100, Kristina Martsenko wrote:
> On 05/10/2018 10:04, Ramana Radhakrishnan wrote:
> > On 05/10/2018 09:47, Kristina Martsenko wrote:
> >> +Virtualization
> >> +--------------
> >> +
> >> +Pointer authentication is not currently supported in KVM guests. KVM
> >> +will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
> >> +the feature will result in an UNDEFINED exception being injected into
> >> +the guest.
> > 
> > However applications using instructions from the hint space will
> > continue to work albeit without any protection (as they would just be
> > nops) ?
> 
> Mostly, yes. If the guest leaves SCTLR_EL1.EnIA unset (and
> EnIB/EnDA/EnDB), then PAC* and AUT* instructions in the HINT space will
> execute as NOPs. If the guest sets EnIA, then PAC*/AUT* instructions
> will trap and KVM will inject an "Unknown reason" exception into the
> guest (which will cause a Linux guest to send a SIGILL to the application).

I think that part is fine. If KVM (a fairly recent version with CPUID
sanitisation) does not enable ptr auth, the CPUID should not advertise
this feature either so the guest kernel should not enable it. For the
above instructions in the HINT space, they will just be NOPs. If the
guest kernel enables the feature regardless of the CPUID information, it
deserves to get an "Unknown reason" exception.

> In the latter case we could instead pretend the instruction was a NOP
> and not inject an exception, but trapping twice per every function would
> probably be terrible for performance. The guest shouldn't be setting
> EnIA anyway if ID_AA64ISAR1_EL1 reports that pointer authentication is
> not present (because KVM has hidden it).

I don't think we should. The SCTLR_EL1 bits are RES0 unless you know
that the feature is present via CPUID.

> The other special case is the XPACLRI instruction, which is also in the
> HINT space. Currently it will trap and KVM will inject an exception into
> the guest. We should probably change this to NOP instead, as that's what
> applications will expect. Unfortunately there is no EnIA-like control to
> make it NOP.

Very good catch. Basically if EL2 doesn't know about ptr auth (older
distro), EL1 may or may not know but leaves SCTLR_EL1 disabled (based on
CPUID), the default HCR_EL2 is to trap (I'm ignoring EL3 as that's like
to have ptr auth enabled, being built for the specific HW). So a user
app considering XPACLRI a NOP (or inoffensive) will get a SIGILL
(injected by the guest kernel following the injection of "Unknown
reason" exception by KVM).

Ramana, is XPACLRI commonly generated by gcc and expects it to be a NOP?
Could we restrict it to only being used at run-time if the corresponding
HWCAP is set? This means redefining this instruction as no longer in the
NOP space.

> One option is for KVM to pretend the instruction was a NOP and return to
> the guest. But if XPACLRI gets executed frequently, then the constant
> trapping might hurt performance. I don't know how frequently it might
> get used, as I don't know of any applications currently using it. From
> what I understand, it may be used by userspace stack unwinders.
> 
> (Also worth noting - as far as I can tell there is no easy way for KVM
> to know which pointer authentication instruction caused the trap, so we
> may have to do something unusual like use "at s12e1r" to read guest
> memory and check for XPACLRI.)

Indeed, it's not an easy fix. As discussed (in the office), we can't
even guarantee that the guest stage 1 translation is stable and points
to the actual XPACLRI instruction.

> The other option is to turn off trapping entirely. However then on a
> big.LITTLE system with mismatched pointer authentication support
> instructions will work intermittently on some CPUs but not others.

That's another case but let's assume we never see such configurations ;).

-- 
Catalin
