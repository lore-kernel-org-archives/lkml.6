Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F25F21841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U+fyuYgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfBZNye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:54:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52640 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfBZNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ApI7uZCGExBqpKLg2Rlr6XR9LkoMfgsFnCmf0EFObto=; b=U+fyuYgIf5oUsS2fGyYUrd2Zg
        lx97ZPl0aIEbsOSs7f4pBFqMcFBGeOK5zoI1TWNMc6hTbYRriI7sTQ1PWlzHCuoVltlp4ArDCfs7T
        zbOO/kK9FpGAiQg7OQmpIVXqz266UID4V8cDRxRW8x4OKy6w3F5Rc242hGAQXztB/T68rkM+ihaKw
        BMaYqu29wxIqA+JoXgm2+U+sCBdeEf4n2z0cTfnzUs2AFeogC1XorWUsOgkjMlAlHlmPyYEyaL7sH
        Uow/Ac9JdTO1EQgU40b25AM3iuPNicG39AYdsYY9pUXV+qKyX9QX+LLuMOoet1R5Xv/p7xyT0ItHJ
        0jICfgnpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gydBl-0006EI-1d; Tue, 26 Feb 2019 13:54:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7908F20269AFA; Tue, 26 Feb 2019 14:54:26 +0100 (CET)
Date:   Tue, 26 Feb 2019 14:54:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package
 support
Message-ID: <20190226135426.GU32477@hirez.programming.kicks-ass.net>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com>
 <20190220105542.GB17969@hirez.programming.kicks-ass.net>
 <CAJvTdK=+Lw1_WFE4_aGqxtRPK_JafmmzcmGSqScMOB4EK-xH5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvTdK=+Lw1_WFE4_aGqxtRPK_JafmmzcmGSqScMOB4EK-xH5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:08:48AM -0500, Len Brown wrote:
> Thanks for the comments, Peter. I'll update the patch to address the
> syntax points.  (Maybe checkpatch.pl should be updated to reflect your
> preferences?).

Don't know about checkpatch; I ignore plenty of its output. I think tglx
started a document somewhere for what tip prefers, but I'm not sure
where that went.

> About macros vs C.  I agree with your preference.
> I used macros to be consistent with the existing code, and to be as
> backport friendly as possible.
> (a number of distros need to pull these patches into their supported kernels)
> Sure, I'm willing to write in a cosmetic-only patch, after the
> functional changes are upstream.

Fair enough.

> > It would've been nice to have the CPUID instruction 1F leaf reference
> > 3B-3.9 in the SDM, and maybe mention this here too.
> 
> I didn't mention SDM sections because they change -- leaving stale
> pointers in our commit messages.  The SDM is re-published 4 times per
> year.

Yah, I know. Which is why I keep all SDMs. So if you say, book 3 section
8 of Jul'17, I can find it :-)

> > You haven't explained, and I can't readily find it in the SDM either,
> > how these topology bits relate to caches and interconnects.
> >
> > Will these die thingies share LLC, or will LLC be per die. Will NUMA
> > span dies or not.
> 
> Excellent question.
> Cache enumeration in Leaf-4 is totally unchanged.
> ACPI NUMA tables are totally unchanged.

Sure; and yet Sub-NUMA-Clustering broke stuff in interesting ways. I'm
trying to get a feel for how these levels will interact with all that.

Before that SNC stuff, caches had never spanned NODEs (and I still
think that is 'creative' at best).

> From a scheduler point of view, imagine that a SKX system with 4 die
> in 4 packages was mechanically re-designed so that those 4 die resided
> in 2 double-sized packages.
> 
> They may have tweaked the links between the die, but logically it is
> identical and compatible, and the legacy kernel will function
> properly.

This example has LLC in die and yes that works.

But I can imagine things like L2 in tile and L3 across tiles but within
DIE and then it _might_ make sense to still consider the tile for
scheduling.

Another option is having the LLC off die; also not unheard of.

And then there's many creative and slightly crazy ways this can all be
combined :/

> So the effect of Leaf B,1F is that it defines the scope of MSRs.  eg.
> what processors does a die-scope MSR cover.  That is why the rest of
> the patch is about sysfs topology, and about package MSR scope.
> 
> Yes, there will be more exotic MSR situations in future products --
> the first ones are pretty simple -- something  called a
> package-scope-MSR  in the SDM today becomes a die-scope-MSR in this
> generation on a multi-die/package system.

Yes :-(

> It also reflects how many packages appear in sysfs, and this can
> effect licensing of some kinds of software.

That's just plain insanity and we should not let that affect our sysfs
interfaces.
