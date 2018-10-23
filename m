Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D5FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8604520665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8604520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJWSnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:43:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeJWSnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:43:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCFDA341;
        Tue, 23 Oct 2018 03:20:17 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B4DE3F6A8;
        Tue, 23 Oct 2018 03:20:14 -0700 (PDT)
Date:   Tue, 23 Oct 2018 11:20:09 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Kristina Martsenko <Kristina.Martsenko@arm.com>,
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
        Christoffer Dall <Christoffer.Dall@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, nd <nd@arm.com>
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
Message-ID: <20181023102008.GA8989@brain-police>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
 <20181019111542.6wrvjguirglzg7vg@mbp>
 <5ca5bf92-f2b7-48c9-ea41-5efeff09a799@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca5bf92-f2b7-48c9-ea41-5efeff09a799@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:36:16AM +0100, Ramana Radhakrishnan wrote:
> On 19/10/2018 12:15, Catalin Marinas wrote:
> > On Fri, Oct 05, 2018 at 09:47:44AM +0100, Kristina Martsenko wrote:
> >> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> >> new file mode 100644
> >> index 000000000000..2aefedc31d9e
> >> --- /dev/null
> >> +++ b/arch/arm64/include/asm/pointer_auth.h
> >> @@ -0,0 +1,63 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +#ifndef __ASM_POINTER_AUTH_H
> >> +#define __ASM_POINTER_AUTH_H
> >> +
> >> +#include <linux/random.h>
> >> +
> >> +#include <asm/cpufeature.h>
> >> +#include <asm/sysreg.h>
> >> +
> >> +#ifdef CONFIG_ARM64_PTR_AUTH
> >> +/*
> >> + * Each key is a 128-bit quantity which is split across a pair of 64-bit
> >> + * registers (Lo and Hi).
> >> + */
> >> +struct ptrauth_key {
> >> +	unsigned long lo, hi;
> >> +};
> >> +
> >> +/*
> >> + * We give each process its own instruction A key (APIAKey), which is shared by
> >> + * all threads. This is inherited upon fork(), and reinitialised upon exec*().
> >> + * All other keys are currently unused, with APIBKey, APDAKey, and APBAKey
> >> + * instructions behaving as NOPs.
> >> + */
> > 
> > I don't remember the past discussions but I assume the tools guys are ok
> > with a single key shared by multiple threads. Ramana, could you ack this
> > part, FTR?
> 
> Sorry about the slow response, I've been traveling.
> 
> Ack and Will's response covers the reasons why pretty well. A prctl call 
> would be a good enhancement.

One minor "gotcha" with that is that the glibc prctl() wrapper would need to
be annotated not to use pointer auth, or we'd have to issue the syscall
in-line.

Will
