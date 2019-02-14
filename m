Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AD3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923CD2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406541AbfBNKe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:34:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388126AbfBNKe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:34:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E9CEBD;
        Thu, 14 Feb 2019 02:34:56 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38CC23F575;
        Thu, 14 Feb 2019 02:34:55 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:34:52 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190214103449.GN3567@e103592.cambridge.arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
 <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
 <20190213165227.7ekekkxazhbaqxoe@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213165227.7ekekkxazhbaqxoe@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 05:52:27PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-02-13 16:40:00 [+0100], Ard Biesheuvel wrote:
> > > > This is equal what x86 is currently doing. The naming is slightly
> > > > different, there is irq_fpu_usable().
> > >
> > > Yes, I think it's basically the same idea.
> > >
> > > It's been evolving a bit on both sides, but is quite similar now.
> > >
> > 
> > may_use_simd() only exists because we have a generic crypto SIMD
> > helper, and so we needed something arch agnostic to wrap around
> > irq_fpu_usable()
> 
> My question was more if this is helpful and we want to keep or if
> it would be better to remove it and always disable BH as part of SIMD
> operations.

Wouldn't this arbitrarily increase softirq latency?  Unconditionally
forbidding SIMD in softirq might make more sense.  It depends on how
important the use cases are...

Cheers
---Dave
