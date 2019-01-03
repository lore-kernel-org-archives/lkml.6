Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D97C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E152070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfACQvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:51:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53014 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbfACQvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:51:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67D1115AD;
        Thu,  3 Jan 2019 08:51:44 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 351063F5D4;
        Thu,  3 Jan 2019 08:51:44 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 633721AE1799; Thu,  3 Jan 2019 16:51:44 +0000 (GMT)
Date:   Thu, 3 Jan 2019 16:51:44 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "moderated list:ARM64 PORT AARCH64 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: Mirror arm for small unimplemented compat syscalls
Message-ID: <20190103165144.GA10221@edgewater-inn.cambridge.arm.com>
References: <20190103074550.217421-1-pihsun@chromium.org>
 <20190103114959.GA3529@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103114959.GA3529@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 11:50:12AM +0000, Dave Martin wrote:
> On Thu, Jan 03, 2019 at 03:45:47PM +0800, Pi-Hsun Shih wrote:
> > For syscall number smaller than 0xf0000, arm calls sys_ni_syscall
> > instead of arm_syscall in arch/arm/kernel/entry-common.S, which returns
> > -ENOSYS instead of raising SIGILL. Mirror this behavior for compat
> > syscalls in arm64.
> > 
> > Fixes: 532826f3712b607 ("arm64: Mirror arm for unimplemented compat
> > syscalls")
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> > ---
> >  arch/arm64/kernel/syscall.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index 8f3371415642ad..95fd8c7ec8a171 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -21,7 +21,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
> >  {
> >  #ifdef CONFIG_COMPAT
> >  	long ret;
> > -	if (is_compat_task()) {
> > +	if (is_compat_task() && regs->regs[7] >= __ARM_NR_COMPAT_BASE) {
> 
> compat_arm_syscall() ignores all bits r7 except for bits [15:0].
> 
> So, doesn't this mean that 0xf0000, 0x100000, 0x110000 will all do the
> same thing now?  (Previously to your patch, 0xe0000, 0xd0000 etc. would
> also match in this code I've misunderstood something.)
> 
> The gating check in arch/arm/kernel/trapc.s:arm_syscall() is
> 
> 	if ((no >> 16) != (__ARM_NR_BASE>> 16))
> 
> I would expect that arm64 needs a similar check somewhere.  Is the check
> already present?  I may have missed it.

When not using OABI, __ARM_NR_BASE is zero, so I think the 32-bit semantics
for non-OABI are:

	0       - 399		: Invoke syscall via syscall table
	400     - 0xeffff	: -ENOSYS (to be allocated in future)
	0xf0000 - 0xfffff	: Private syscall or -ENOSYS if not allocated
	> 0xfffff		: SIGILL

so for arm64 compat, we need to do the following:

	1. Ensure we only SIGILL for that last region
	2. Don't pull the syscall number directly from pt_regs, since it
	   may have been changed by a tracer
	3. Hook up compat_sys_io_pgetevents

Patches incoming...

Will
