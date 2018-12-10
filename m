Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E013C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E013C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbeLJO3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:29:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeLJO3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:29:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDEDA1596;
        Mon, 10 Dec 2018 06:29:22 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CC053F575;
        Mon, 10 Dec 2018 06:29:22 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 319921AE0CFD; Mon, 10 Dec 2018 14:29:45 +0000 (GMT)
Date:   Mon, 10 Dec 2018 14:29:45 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Dave P Martin <dave.martin@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Steve Capper <Steve.Capper@arm.com>
Subject: Re: [PATCH v6 08/13] arm64: expose user PAC bit positions via ptrace
Message-ID: <20181210142944.GA13100@edgewater-inn.cambridge.arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-9-kristina.martsenko@arm.com>
 <a31ca10a-ee1a-71fb-2c3d-a6184e12b543@linaro.org>
 <20181210120330.GB4048@arrakis.emea.arm.com>
 <ba48e082-3e47-43bc-77d1-97d741c59284@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba48e082-3e47-43bc-77d1-97d741c59284@linaro.org>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 08:22:06AM -0600, Richard Henderson wrote:
> On 12/10/18 6:03 AM, Catalin Marinas wrote:
> >> However, it won't be too long before someone implements support for
> >> ARMv8.2-LVA, at which point, without changes to mandatory pointer tagging, we
> >> will only have 3 authentication bits: [54:52].  This seems useless and easily
> >> brute-force-able.
> > 
> > Such support is already here (about to be queued):
> > 
> > https://lore.kernel.org/linux-arm-kernel/20181206225042.11548-1-steve.capper@arm.com/
> 
> Thanks for the pointer.
> 
> >> Unfortunately, there is no obvious path to making this optional that does not
> >> break compatibility with Documentation/arm64/tagged-pointers.txt.
> > 
> > There is also the ARMv8.5 MTE (memory tagging) which relies on tagged
> > pointers.
> 
> So it does.  I hadn't read through that extension completely before.
> 
> > An alternative would be to allow the opt-in to 52-bit VA, leaving it at
> > 48-bit by default. However, it has the problem of changing the PAC size
> > and not being able to return.
> 
> Perhaps the opt-in should be at exec time, with ELF flags (or equivalent) on
> the application.  Because, as you say, changing the shape of the PAC in the
> middle of execution is in general not possible.

I think we'd still have a potential performance problem with that approach,
since we'd end up having to context-switch TCR.T0SZ, which is permitted to
be cached in a TLB and would therefore force us to introduce TLB
invalidation when context-switching between tasks using 52-bit VAs and tasks
using 48-bit VAs.

There's a chance we could get the architecture tightened here, but it's
not something we've pushed for so far and it depends on what's already been
built.

Will
