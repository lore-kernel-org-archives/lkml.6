Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37583C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEB92073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEB92073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeIDX7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:59:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbeIDX7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:59:01 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4990C96;
        Tue,  4 Sep 2018 19:32:27 +0000 (UTC)
Date:   Tue, 4 Sep 2018 21:32:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will.deacon@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.18 050/123] mm/tlb, x86/mm: Support invalidating TLB
 caches for RCU_TABLE_FREE
Message-ID: <20180904193225.GA17846@kroah.com>
References: <20180903165719.499675257@linuxfoundation.org>
 <20180903165721.576888426@linuxfoundation.org>
 <CA+G9fYsyr_AxbmuWfD6svin4Cq_5QJOYvOW_ohnS7fUobRU7ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsyr_AxbmuWfD6svin4Cq_5QJOYvOW_ohnS7fUobRU7ZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 10:08:13AM +0530, Naresh Kamboju wrote:
> On 3 September 2018 at 22:26, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > commit d86564a2f085b79ec046a5cba90188e612352806 upstream.
> >
> > Jann reported that x86 was missing required TLB invalidates when he
> > hit the !*batch slow path in tlb_remove_table().
> >
> > This is indeed the case; RCU_TABLE_FREE does not provide TLB (cache)
> > invalidates, the PowerPC-hash where this code originated and the
> > Sparc-hash where this was subsequently used did not need that. ARM
> > which later used this put an explicit TLB invalidate in their
> > __p*_free_tlb() functions, and PowerPC-radix followed that example.
> >
> > But when we hooked up x86 we failed to consider this. Fix this by
> > (optionally) hooking tlb_remove_table() into the TLB invalidate code.
> >
> > NOTE: s390 was also needing something like this and might now
> >       be able to use the generic code again.
> >
> > [ Modified to be on top of Nick's cleanups, which simplified this patch
> >   now that tlb_flush_mmu_tlbonly() really only flushes the TLB - Linus ]
> >
> > Fixes: 9e52fc2b50de ("x86/mm: Enable RCU based page table freeing (CONFIG_HAVE_RCU_TABLE_FREE=y)")
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Rik van Riel <riel@surriel.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Miller <davem@davemloft.net>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: stable@kernel.org
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > ---
> >  arch/Kconfig     |    3 +++
> >  arch/x86/Kconfig |    1 +
> >  mm/memory.c      |   18 ++++++++++++++++++
> >  3 files changed, 22 insertions(+)
> >
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -354,6 +354,9 @@ config HAVE_ARCH_JUMP_LABEL
> >  config HAVE_RCU_TABLE_FREE
> >         bool
> >
> > +config HAVE_RCU_TABLE_INVALIDATE
> > +       bool
> > +
> >  config ARCH_HAVE_NMI_SAFE_CMPXCHG
> >         bool
> >
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -179,6 +179,7 @@ config X86
> >         select HAVE_PERF_REGS
> >         select HAVE_PERF_USER_STACK_DUMP
> >         select HAVE_RCU_TABLE_FREE
> > +       select HAVE_RCU_TABLE_INVALIDATE        if HAVE_RCU_TABLE_FREE
> >         select HAVE_REGS_AND_STACK_ACCESS_API
> >         select HAVE_RELIABLE_STACKTRACE         if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
> >         select HAVE_STACKPROTECTOR              if CC_HAS_SANE_STACKPROTECTOR
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -330,6 +330,21 @@ bool __tlb_remove_page_size(struct mmu_g
> >   * See the comment near struct mmu_table_batch.
> >   */
> >
> > +/*
> > + * If we want tlb_remove_table() to imply TLB invalidates.
> > + */
> > +static inline void tlb_table_invalidate(struct mmu_gather *tlb)
> > +{
> > +#ifdef CONFIG_HAVE_RCU_TABLE_INVALIDATE
> > +       /*
> > +        * Invalidate page-table caches used by hardware walkers. Then we still
> > +        * need to RCU-sched wait while freeing the pages because software
> > +        * walkers can still be in-flight.
> > +        */
> > +       tlb_flush_mmu_tlbonly(tlb);
> > +#endif
> > +}
> > +
> >  static void tlb_remove_table_smp_sync(void *arg)
> >  {
> >         /* Simply deliver the interrupt */
> > @@ -366,6 +381,7 @@ void tlb_table_flush(struct mmu_gather *
> >         struct mmu_table_batch **batch = &tlb->batch;
> >
> >         if (*batch) {
> > +               tlb_table_invalidate(tlb);
> >                 call_rcu_sched(&(*batch)->rcu, tlb_remove_table_rcu);
> >                 *batch = NULL;
> >         }
> > @@ -387,11 +403,13 @@ void tlb_remove_table(struct mmu_gather
> >         if (*batch == NULL) {
> >                 *batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> >                 if (*batch == NULL) {
> > +                       tlb_table_invalidate(tlb);
> >                         tlb_remove_table_one(table);
> >                         return;
> >                 }
> >                 (*batch)->nr = 0;
> >         }
> > +
> >         (*batch)->tables[(*batch)->nr++] = table;
> >         if ((*batch)->nr == MAX_TABLE_BATCH)
> >                 tlb_table_flush(tlb);
> >
> >
> 
> Kernel crashed on x86 device running LTP fcntl34 test case on 4.18.6-rc1,
> fcntl34.c:58: INFO: waiting for '12' threads
> 
> [ 1075.624862] BUG: stack guard page was hit at 0000000079c81098
> (stack is 000000002c7d6db4..00000000d386d6df)
> [ 1075.634606] kernel stack overflow (double-fault): 0000 [#2] SMP PTI
> [ 1075.640871] CPU: 3 PID: 17735 Comm: fcntl34_64 Tainted: G      D W
>        4.18.6-rc1 #1
> [ 1075.648954] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [ 1075.656428] RIP: 0010:flush_tlb_func_common.constprop.14+0x29c/0x4d0
> [ 1075.662776] Code: 03 1d 70 e3 da 4e 83 c2 01 0f b7 d2 49 0f ab 13
> eb b5 0f 1f 44 00 00 e9 70 fe ff ff 65 ff 05 6b 40 db 4e 48 8b 05 bc
> e8 8f 01 <e8> ff 95 08 00 85 c0 74 0d 80 3d ee c5 8f 01 00 0f 84 4a 01
> 00 00
> [ 1075.681645] RSP: 0018:ffffbd2482cbc000 EFLAGS: 00010083
> [ 1075.686863] RAX: 0000000000000000 RBX: ffff98915adf0002 RCX: ffffbd2482cbc010
> [ 1075.693986] RDX: 0000000000000803 RSI: 00007f5aae00a000 RDI: ffffbd2482cbc080
> [ 1075.701124] RBP: ffffbd2482cbc060 R08: ffffffffb2b86c00 R09: 0000008000000000
> [ 1075.708287] R10: 000000000002161a R11: 2008188a00000121 R12: 0000000000000162
> [ 1075.715410] R13: 0000000000000003 R14: 00007f5aae00a000 R15: 00007f5aae000000
> [ 1075.722536] FS:  00007f5aaeff3740(0000) GS:ffff98916fd80000(0000)
> knlGS:0000000000000000
> [ 1075.730619] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1075.736357] CR2: ffffbd2482cbbff8 CR3: 000000045368c003 CR4: 00000000003606e0
> [ 1075.743481] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1075.750606] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1075.757730] Call Trace:
> [ 1075.760176]  flush_tlb_mm_range+0x119/0x130
> [ 1075.764358]  ? flush_tlb_mm_range+0x119/0x130
> [ 1075.768711]  tlb_flush_mmu_tlbonly+0x6e/0xd0
> [ 1075.772984]  ? tlb_flush_mmu_tlbonly+0x6e/0xd0
> [ 1075.777428]  tlb_table_flush.part.113+0x12/0x30
> [ 1075.781954]  tlb_flush_mmu_tlbonly+0x4b/0xd0
> [ 1075.786224]  tlb_table_flush.part.113+0x12/0x30
> [ 1075.790749]  tlb_flush_mmu_tlbonly+0x4b/0xd0
> 
> Full test log link,
> https://lkft.validation.linaro.org/scheduler/job/404027#L4051

I have pushed out a -rc2 that should fix this problem.

thanks,

greg k-h
