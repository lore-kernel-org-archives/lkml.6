Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBB7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC4620844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC4620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbeGXRks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:40:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54800 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388409AbeGXRkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:40:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25E9880D;
        Tue, 24 Jul 2018 09:33:31 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA5FA3F5B3;
        Tue, 24 Jul 2018 09:33:30 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9AB051AE3B5E; Tue, 24 Jul 2018 17:33:30 +0100 (BST)
Date:   Tue, 24 Jul 2018 17:33:30 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-s390@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
Message-ID: <20180724163330.GC25888@arm.com>
References: <20180716190337.26133-1-riel@surriel.com>
 <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
 <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
 <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
 <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
 <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
 <CALCETrXLMsSBChDvrms-omwYV4LHT30GenDjbnD-+LTg55yPow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXLMsSBChDvrms-omwYV4LHT30GenDjbnD-+LTg55yPow@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Sorry, I missed the arm64 question at the end of this...

On Thu, Jul 19, 2018 at 10:04:09AM -0700, Andy Lutomirski wrote:
> On Thu, Jul 19, 2018 at 9:45 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> > [I added PeterZ and Vitaly -- can you see any way in which this would
> > break something obscure?  I don't.]
> >
> > On Thu, Jul 19, 2018 at 7:14 AM, Rik van Riel <riel@surriel.com> wrote:
> >> I guess we can skip both switch_ldt and load_mm_cr4 if real_prev equals
> >> next?
> >
> > Yes, AFAICS.
> >
> >>
> >> On to the lazy TLB mm_struct refcounting stuff :)
> >>
> >>>
> >>> Which refcount?  mm_users shouldn’t be hot, so I assume you’re talking about
> >>> mm_count. My suggestion is to get rid of mm_count instead of trying to
> >>> optimize it.
> >>
> >>
> >> Do you have any suggestions on how? :)
> >>
> >> The TLB shootdown sent at __exit_mm time does not get rid of the
> >> kernelthread->active_mm
> >> pointer pointing at the mm that is exiting.
> >>
> >
> > Ah, but that's conceptually very easy to fix.  Add a #define like
> > ARCH_NO_TASK_ACTIVE_MM.  Then just get rid of active_mm if that
> > #define is set.  After some grepping, there are very few users.  The
> > only nontrivial ones are the ones in kernel/ and mm/mmu_context.c that
> > are involved in the rather complicated dance of refcounting active_mm.
> > If that field goes away, it doesn't need to be refcounted.  Instead, I
> > think the refcounting can get replaced with something like:
> >
> > /*
> >  * Release any arch-internal references to mm.  Only called when
> > mm_users is zero
> >  * and all tasks using mm have either been switch_mm()'d away or have had
> >  * enter_lazy_tlb() called.
> >  */
> > extern void arch_shoot_down_dead_mm(struct mm_struct *mm);
> >
> > which the kernel calls in __mmput() after tearing down all the page
> > tables.  The body can be something like:
> >
> > if (WARN_ON(cpumask_any_but(mm_cpumask(...), ...)) {
> >   /* send an IPI.  Maybe just call tlb_flush_remove_tables() */
> > }
> >
> > (You'll also have to fix up the highly questionable users in
> > arch/x86/platform/efi/efi_64.c, but that's easy.)
> >
> > Does all that make sense?  Basically, as I understand it, the
> > expensive atomic ops you're seeing are all pointless because they're
> > enabling an optimization that hasn't actually worked for a long time,
> > if ever.
> 
> Hmm.  Xen PV has a big hack in xen_exit_mmap(), which is called from
> arch_exit_mmap(), I think.  It's a heavier weight version of more or
> less the same thing that arch_shoot_down_dead_mm() would be, except
> that it happens before exit_mmap().  But maybe Xen actually has the
> right idea.  In other words, rather doing the big pagetable free in
> exit_mmap() while there may still be other CPUs pointing at the page
> tables, the other order might make more sense.  So maybe, if
> ARCH_NO_TASK_ACTIVE_MM is set, arch_exit_mmap() should be responsible
> for getting rid of all secret arch references to the mm.
> 
> Hmm.  ARCH_FREE_UNUSED_MM_IMMEDIATELY might be a better name.
> 
> I added some more arch maintainers.  The idea here is that, on x86 at
> least, task->active_mm and all its refcounting is pure overhead.  When
> a process exits, __mmput() gets called, but the core kernel has a
> longstanding "optimization" in which other tasks (kernel threads and
> idle tasks) may have ->active_mm pointing at this mm.  This is nasty,
> complicated, and hurts performance on large systems, since it requires
> extra atomic operations whenever a CPU switches between real users
> threads and idle/kernel threads.
> 
> It's also almost completely worthless on x86 at least, since __mmput()
> frees pagetables, and that operation *already* forces a remote TLB
> flush, so we might as well zap all the active_mm references at the
> same time.
> 
> But arm64 has real HW remote flushes.  Does arm64 actually benefit
> from the active_mm optimization?  What happens on arm64 when a process
> exits?  How about s390?  I suspect that x390 has rather larger systems
> than arm64, where the cost of the reference counting can be much
> higher.

IIRC, the TLB invalidation on task exit has the fullmm field set in the
mmu_gather structure, so we don't actually do any TLB invalidation at all.
Instead, we just don't re-allocate the ASID and invalidate the whole TLB
when we run out of ASIDs (they're 16-bit on most Armv8 CPUs).

Does that answer your question?

Will
