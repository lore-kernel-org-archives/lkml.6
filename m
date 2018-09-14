Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EAFECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923C120882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923C120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeINWD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:03:59 -0400
Received: from foss.arm.com ([217.140.101.70]:36482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbeINWD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:03:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8E7C80D;
        Fri, 14 Sep 2018 09:48:39 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B92713F557;
        Fri, 14 Sep 2018 09:48:39 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 57C361AE2F82; Fri, 14 Sep 2018 17:48:57 +0100 (BST)
Date:   Fri, 14 Sep 2018 17:48:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180914164857.GG6236@arm.com>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913092811.894806629@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Sep 13, 2018 at 11:21:11AM +0200, Peter Zijlstra wrote:
> Write a comment explaining some of this..

This comment is much-needed, thanks! Some comments inline.

> + * The mmu_gather API consists of:
> + *
> + *  - tlb_gather_mmu() / tlb_finish_mmu(); start and finish a mmu_gather
> + *
> + *    Finish in particular will issue a (final) TLB invalidate and free
> + *    all (remaining) queued pages.
> + *
> + *  - tlb_start_vma() / tlb_end_vma(); marks the start / end of a VMA
> + *
> + *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
> + *    there's large holes between the VMAs.
> + *
> + *  - tlb_remove_page() / __tlb_remove_page()
> + *  - tlb_remove_page_size() / __tlb_remove_page_size()
> + *
> + *    __tlb_remove_page_size() is the basic primitive that queues a page for
> + *    freeing. __tlb_remove_page() assumes PAGE_SIZE. Both will return a
> + *    boolean indicating if the queue is (now) full and a call to
> + *    tlb_flush_mmu() is required.
> + *
> + *    tlb_remove_page() and tlb_remove_page_size() imply the call to
> + *    tlb_flush_mmu() when required and has no return value.
> + *
> + *  - tlb_change_page_size()

This doesn't seem to exist in my tree.
[since realised you rename to it in the next patch]

> + *
> + *    call before __tlb_remove_page*() to set the current page-size; implies a
> + *    possible tlb_flush_mmu() call.
> + *
> + *  - tlb_flush_mmu() / tlb_flush_mmu_tlbonly() / tlb_flush_mmu_free()
> + *
> + *    tlb_flush_mmu_tlbonly() - does the TLB invalidate (and resets
> + *                              related state, like the range)
> + *
> + *    tlb_flush_mmu_free() - frees the queued pages; make absolutely
> + *			     sure no additional tlb_remove_page()
> + *			     calls happen between _tlbonly() and this.
> + *
> + *    tlb_flush_mmu() - the above two calls.
> + *
> + *  - mmu_gather::fullmm
> + *
> + *    A flag set by tlb_gather_mmu() to indicate we're going to free
> + *    the entire mm; this allows a number of optimizations.
> + *
> + *    XXX list optimizations

On arm64, we can elide the invalidation altogether because we won't
re-allocate the ASID. We also have an invalidate-by-ASID (mm) instruction,
which we could use if we needed to.

> + *
> + *  - mmu_gather::need_flush_all
> + *
> + *    A flag that can be set by the arch code if it wants to force
> + *    flush the entire TLB irrespective of the range. For instance
> + *    x86-PAE needs this when changing top-level entries.
> + *
> + * And requires the architecture to provide and implement tlb_flush().
> + *
> + * tlb_flush() may, in addition to the above mentioned mmu_gather fields, make
> + * use of:
> + *
> + *  - mmu_gather::start / mmu_gather::end
> + *
> + *    which (when !need_flush_all; fullmm will have start = end = ~0UL) provides
> + *    the range that needs to be flushed to cover the pages to be freed.

I don't understand the mention of need_flush_all here -- I didn't think it
was used by the core code at all.

> + *
> + *  - mmu_gather::freed_tables
> + *
> + *    set when we freed page table pages
> + *
> + *  - tlb_get_unmap_shift() / tlb_get_unmap_size()
> + *
> + *    returns the smallest TLB entry size unmapped in this range
> + *
> + * Additionally there are a few opt-in features:
> + *
> + *  HAVE_MMU_GATHER_PAGE_SIZE
> + *
> + *  This ensures we call tlb_flush() every time tlb_change_page_size() actually
> + *  changes the size and provides mmu_gather::page_size to tlb_flush().

Ah, you add this later in the series. I think Nick reckoned we could get rid
of this (the page_size field) eventually...

Will
