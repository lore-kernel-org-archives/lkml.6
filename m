Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18991C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83B420891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/eo940W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83B420891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934097AbeFQSw0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 14:52:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933681AbeFQSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 14:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RtBpPFWU7Z1ankEmh9L4Q2xmPwM/ri+SlSKPS3gzeqQ=; b=s/eo940WY8UecJBu2ULdYD3Au
        4G7ia6+5N1MSWmg9rCgHOxI9foOJHHp49mtuevWZfAGCXxzb832V2L6edAcfvcK40t8Z6pszF3wNq
        PSK0Z3Y7j2I3quRPrEvchbDTzIx2Ixs5adcei8/tJ2zBdR3KacPt6lJ83Pk1iCV6qso+vgyNJ3Eyc
        pBOUAILl1gsOCo5sUjfwVRZ9s5JjP/yhEcE/+KsH9eHgl+0T7amj57BwBQVBhQR0Nbjs4yvmYz/jl
        JDh9FSya3dtGG9uWKZzjqTFZeR/IhOLqLKByYMONcFuc7svW5a+sXziVWebIkC2LiWQ7Fs7urwiuG
        Tz7hpOqfg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUcmk-0001Vw-FU; Sun, 17 Jun 2018 18:52:22 +0000
Date:   Sun, 17 Jun 2018 11:52:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] mm: Mark pages in use for page tables
Message-ID: <20180617185222.GA21805@bombadil.infradead.org>
References: <20180307134443.32646-1-willy@infradead.org>
 <20180307134443.32646-5-willy@infradead.org>
 <20180617150931.GB24595@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617150931.GB24595@lianli.shorne-pla.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:09:31AM +0900, Stafford Horne wrote:
> On Wed, Mar 07, 2018 at 05:44:43AM -0800, Matthew Wilcox wrote:
> > Define a new PageTable bit in the page_type and use it to mark pages in
> > use as page tables.  This can be helpful when debugging crashdumps or
> > analysing memory fragmentation.  Add a KPF flag to report these pages
> > to userspace and update page-types.c to interpret that flag.
> 
> I have bisected a regression on OpenRISC in v4.18-rc1 to this commit.  Using
> our defconfig after boot I am getting:

Hi Stafford.  Thanks for the report!

>     BUG: Bad page state in process hostname  pfn:00b5c
>     page:c1ff0b80 count:0 mapcount:-1024 mapping:00000000 index:0x0
>     flags: 0x0()
>     raw: 00000000 00000000 00000000 fffffbff 00000000 00000100 00000200 00000000
>     page dumped because: nonzero mapcount
>     Modules linked in:
>     CPU: 1 PID: 38 Comm: hostname Tainted: G    B
>     4.17.0-simple-smp-07461-g1d40a5ea01d5-dirty #993
>     Call trace:
>     [<(ptrval)>] show_stack+0x44/0x54
>     [<(ptrval)>] dump_stack+0xb0/0xe8
>     [<(ptrval)>] bad_page+0x138/0x174
>     [<(ptrval)>] ? ipi_icache_page_inv+0x0/0x24
>     [<(ptrval)>] ? cpumask_next+0x24/0x34
>     [<(ptrval)>] free_pages_check_bad+0x6c/0xd0
>     [<(ptrval)>] free_pcppages_bulk+0x174/0x42c
>     [<(ptrval)>] free_unref_page_commit.isra.17+0xb8/0xc8
>     [<(ptrval)>] free_unref_page_list+0x10c/0x190
>     [<(ptrval)>] ? set_reset_devices+0x0/0x2c
>     [<(ptrval)>] release_pages+0x3a0/0x414
>     [<(ptrval)>] tlb_flush_mmu_free+0x5c/0x90
>     [<(ptrval)>] tlb_flush_mmu+0x90/0xa4
>     [<(ptrval)>] arch_tlb_finish_mmu+0x50/0x94
>     [<(ptrval)>] tlb_finish_mmu+0x30/0x64
>     [<(ptrval)>] exit_mmap+0x110/0x1e0
>     [<(ptrval)>] mmput+0x50/0xf0
>     [<(ptrval)>] do_exit+0x274/0xa94
>     [<(ptrval)>] ? _raw_spin_unlock_irqrestore+0x1c/0x2c
>     [<(ptrval)>] ? __up_read+0x70/0x88
>     [<(ptrval)>] do_group_exit+0x50/0x110
>     [<(ptrval)>] __wake_up_parent+0x0/0x38
>     [<(ptrval)>] _syscall_return+0x0/0x4
> 
> 
> In this series we are overloading mapcount with page_type, the above is caused
> due to this check in mm/page_alloc.c (free_pages_check_bad):
> 
>         if (unlikely(atomic_read(&page->_mapcount) != -1))
>                 bad_reason = "nonzero mapcount";
> 
> We can see in the dump above that _mapcount is fffffbff, this corresponds to the
> 'PG_table' flag.  Which was added here.  But it seems for some case in openrisc
> its not getting cleared during page free.
> 
> This is as far as I got tracing it.  It might be an issue with OpenRISC, but our
> implementation is mostly generic.  I will look into it more in the next few days
> but I figured you might be able to spot something more quickly.

More than happy to help.  You've done a great job of debugging this.
I think the problem is in your __pte_free_tlb definition.  Most other
architectures are doing:

#define __pte_free_tlb(tlb, pte, address) pte_free((tlb)->mm, pte)

while you're doing:

#define __pte_free_tlb(tlb, pte, addr) tlb_remove_page((tlb), (pte))

and that doesn't call pgtable_page_dtor().

Up to you how you want to fix this ;-)  x86 defines a ___pte_free_tlb which
calls pgtable_page_dtor() before calling tlb_remove_table() as an example.
