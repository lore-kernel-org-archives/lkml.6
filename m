Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE06CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D33821BC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D33821BC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeHIPLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:11:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53474 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730664AbeHIPLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:11:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E163580D;
        Thu,  9 Aug 2018 05:47:04 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D27EA3F5D4;
        Thu,  9 Aug 2018 05:47:03 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:47:01 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Trap WFI executed in userspace
Message-ID: <20180809124701.GO9097@e103592.cambridge.arm.com>
References: <20180807093326.5090-1-marc.zyngier@arm.com>
 <20180807100437.GA9097@e103592.cambridge.arm.com>
 <9af8bb9a-7c6c-2560-5965-118dfadf8141@arm.com>
 <20180808123408.GC24736@iMac.local>
 <20180809123457.GN9097@e103592.cambridge.arm.com>
 <20180809123812.GB29785@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809123812.GB29785@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 01:38:12PM +0100, Will Deacon wrote:
> On Thu, Aug 09, 2018 at 01:34:57PM +0100, Dave Martin wrote:
> > On Wed, Aug 08, 2018 at 01:34:09PM +0100, Catalin Marinas wrote:
> > > On Tue, Aug 07, 2018 at 11:24:34AM +0100, Marc Zyngier wrote:
> > > > On 07/08/18 11:05, Dave Martin wrote:
> > > > > On Tue, Aug 07, 2018 at 10:33:26AM +0100, Marc Zyngier wrote:
> > > > >> It recently came to light that userspace can execute WFI, and that
> > > > >> the arm64 kernel doesn trap this event. This sounds rather benign,
> > > 
> > > Nitpick: "doesn't".
> > > 
> > > > >> but the kernel should decide when it wants to wait for an interrupt,
> > > > >> and not userspace.
> > > > >>
> > > > >> Let's trap WFI and treat it as a way to yield the CPU to another
> > > > >> process.
> > > [...]
> > > > > I can't think of a legitimate reason for userspace to execute WFI
> > > > > however.  Userspace doesn't have interrupts under Linux, so it makes
> > > > > no sense to wait for one.
> > > > > 
> > > > > Have we seen anybody using WFI in userspace?  It may be cleaner to
> > > > > map this to SIGILL rather than be permissive and regret it later.
> > > > 
> > > > I couldn't find any user, and I'm happy to just send userspace to hell
> > > > in that case. But it could also been said that since it was never
> > > > prevented, it is a de-facto ABI.
> > > 
> > > I wouldn't really go as far as SIGILL on WFI. I think the patch is fine
> > > as it is. In case Will plans to merge it:
> > 
> > For practical purposes I agree, because we can't control the binary
> > blobs out there: I just wanted to bang the drum because we are creating
> > semantics here and there is not an obvious correct answer to what they
> > should be.
> > 
> > I'd still like to see rationale for why this should map to schedule()
> > (which userspace currently has no direct way to trigger) as opposed to
> > sched_yield() or something like that.
> 
> A better idea might just be to do pc +=4 and return. If there's work
> pending, we'll hit it on the return path (just like any other ret_to_user
> call).
> 
> I initially thought about sched_yield(), but it's not clear whether that
> creates a problem if, e.g. seccomp has been used to restrict that syscall.

Indeed.  I can't see why that might be restricted, but there's presumably
nothing to stop people doing that today.

Other than putting the task to sleep for 1ms or something, I don't know
what to suggest ;)

Perhaps we can patch a NOP into .text, like Marc's BX trick :P

Cheers
---Dave
