Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFFDC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9C720851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9C720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeLJO7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:59:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55820 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbeLJO7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:59:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01D7C1596;
        Mon, 10 Dec 2018 06:59:36 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 586983F59C;
        Mon, 10 Dec 2018 06:59:34 -0800 (PST)
Date:   Mon, 10 Dec 2018 14:59:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     peterz@infradead.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        james.morse@arm.com, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
Message-ID: <20181210145931.GE4048@arrakis.emea.arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
 <20181206182551.GB37411@arrakis.emea.arm.com>
 <6424e0f6-7755-c19a-5bc4-a70be5839644@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6424e0f6-7755-c19a-5bc4-a70be5839644@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 08:38:11AM +0000, Julien Thierry wrote:
> 
> 
> On 12/06/2018 06:25 PM, Catalin Marinas wrote:
> > On Mon, Dec 03, 2018 at 01:55:18PM +0000, Julien Thierry wrote:
> > > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > > index 07c3408..cabfcae 100644
> > > --- a/arch/arm64/include/asm/uaccess.h
> > > +++ b/arch/arm64/include/asm/uaccess.h
> > > @@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
> > >   	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
> > >   }
> > > +#define unsafe_user_region_active	uaccess_region_active
> > > +static inline bool uaccess_region_active(void)
> > > +{
> > > +	if (system_uses_ttbr0_pan()) {
> > > +		u64 ttbr;
> > > +
> > > +		ttbr = read_sysreg(ttbr1_el1);
> > > +		return ttbr & TTBR_ASID_MASK;
> > 
> > Nitpick: could write this in 1-2 lines.
> 
> True, I can do that in 1 line.
> 
> > > +	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
> > > +		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
> > > +				false :
> > > +				!read_sysreg_s(SYS_PSTATE_PAN);
> > > +	}
> > 
> > ARM64_ALT_PAN_NOT_UAO implies ARM64_HAS_PAN which implies SCTLR_EL1.SPAN
> > is 0 at run-time. Is this to cope with the case of being called prior to
> > cpu_enable_pan()?
> > 
> 
> Yes, the issue I can into is that for cpufeatures, .cpu_enable() callbacks
> are called inside stop_machine() which obviously might_sleep and so attempts
> to check whether user_access is on. But for features that get enabled before
> PAN, the PAN bit will be set.

OK, so the PSTATE.PAN bit only makes sense when SCTLR_EL1.SPAN is 0, IOW
the PAN hardware feature has been enabled. Maybe you could write it
(together with some comment):

	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO) &&
		 !(read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN)) {
		 /* only if PAN is present and enabled */
		return !read_sysreg_s(SYS_PSTATE_PAN)
	}

On the cpufeature.c side of things, it seems that we enable the
static_branch before calling the cpu_enable. I wonder whether changing
the order here would help with avoid the SCTLR_EL1 read (not sure what
else it would break; cc'ing Suzuki).

-- 
Catalin
