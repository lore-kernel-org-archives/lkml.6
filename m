Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6DFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02D92081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E+FdetKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02D92081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeKEWjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:39:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeKEWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/OLOO5Zok4S8eGLp8jIIphgDQ1B8/c9xnTTyyaUI/fQ=; b=E+FdetKQOff66bGJ1q05N2wgk
        NtrEEmUIyeXj4HuL20vERKPQRLNu3+j5AN3DoQ9XIbEQ4szGeN9kcT/s9FEXb5tRg0ajgddFLrsh/
        +7RWg1l8dwrJ2XFOkh/0Sh03DrNiOxOnuMwihs/83C4mJF7NoRb88zPBfGsxhu6SKLBmR+zAmyKln
        0yDKXYD+mwhO2wEnZBKZVWsWEObP7oLe+MMXtEceU3hVJ+ZNDVekSDpwR1aPvWQdZ+EuWCRm4Ne5q
        9ijY8Fj9Vni8E83sznxJqGLx6q3KI+WgSLGLorK5gUFBVFD1FnjSQvNe7QJynIFd5L/DTv8FTxxAH
        bBoRs5HHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJemx-0003uO-SJ; Mon, 05 Nov 2018 13:19:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A58A2029F9FF; Mon,  5 Nov 2018 14:19:30 +0100 (CET)
Date:   Mon, 5 Nov 2018 14:19:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 6/7] x86/alternatives: use temporary mm for text poking
Message-ID: <20181105131930.GB22467@hirez.programming.kicks-ass.net>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-7-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102232946.98461-7-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:29:45PM -0700, Nadav Amit wrote:
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 9ceae28db1af..1a40df4db450 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c

> @@ -699,41 +700,110 @@ __ro_after_init unsigned long poking_addr;
>   */
>  void *text_poke(void *addr, const void *opcode, size_t len)
>  {
> +	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
> +	temporary_mm_state_t prev;
>  	struct page *pages[2];
> +	unsigned long flags;
> +	pte_t pte, *ptep;
> +	spinlock_t *ptl;
>  
>  	/*
> +	 * While boot memory allocator is running we cannot use struct pages as
> +	 * they are not yet initialized.
>  	 */
>  	BUG_ON(!after_bootmem);
>  
>  	if (!core_kernel_text((unsigned long)addr)) {
>  		pages[0] = vmalloc_to_page(addr);
> +		if (cross_page_boundary)
> +			pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
>  	} else {
>  		pages[0] = virt_to_page(addr);
>  		WARN_ON(!PageReserved(pages[0]));
> +		if (cross_page_boundary)
> +			pages[1] = virt_to_page(addr + PAGE_SIZE);
>  	}
> +
> +	/* TODO: let the caller deal with a failure and fail gracefully. */
>  	BUG_ON(!pages[0]);
> +	BUG_ON(cross_page_boundary && !pages[1]);
>  	local_irq_save(flags);
> +
> +	/*
> +	 * The lock is not really needed, but this allows to avoid open-coding.
> +	 */
> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> +
> +	/*
> +	 * If we failed to allocate a PTE, fail silently. The caller (text_poke)

we _are_ text_poke()..

> +	 * will detect that the write failed when it compares the memory with
> +	 * the new opcode.
> +	 */
> +	if (unlikely(!ptep))
> +		goto out;

This is the one site I'm a little uncomfortable with; OTOH it really
never should happen, since we explicitily instantiate these page-tables
earlier.

Can't we simply assume ptep will not be zero here? Like with so many
boot time memory allocations, we mostly assume they'll work.

> +	pte = mk_pte(pages[0], PAGE_KERNEL);
> +	set_pte_at(poking_mm, poking_addr, ptep, pte);
> +
> +	if (cross_page_boundary) {
> +		pte = mk_pte(pages[1], PAGE_KERNEL);
> +		set_pte_at(poking_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
> +	}
> +
> +	/*
> +	 * Loading the temporary mm behaves as a compiler barrier, which
> +	 * guarantees that the PTE will be set at the time memcpy() is done.
> +	 */
> +	prev = use_temporary_mm(poking_mm);
> +
> +	kasan_disable_current();
> +	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
> +	kasan_enable_current();
> +
> +	/*
> +	 * Ensure that the PTE is only cleared after the instructions of memcpy
> +	 * were issued by using a compiler barrier.
> +	 */
> +	barrier();
> +
> +	pte_clear(poking_mm, poking_addr, ptep);
> +
> +	/*
> +	 * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
> +	 * as it also flushes the corresponding "user" address spaces, which
> +	 * does not exist.
> +	 *
> +	 * Poking, however, is already very inefficient since it does not try to
> +	 * batch updates, so we ignore this problem for the time being.
> +	 *
> +	 * Since the PTEs do not exist in other kernel address-spaces, we do
> +	 * not use __flush_tlb_one_kernel(), which when PTI is on would cause
> +	 * more unwarranted TLB flushes.
> +	 *
> +	 * There is a slight anomaly here: the PTE is a supervisor-only and
> +	 * (potentially) global and we use __flush_tlb_one_user() but this
> +	 * should be fine.
> +	 */
> +	__flush_tlb_one_user(poking_addr);
> +	if (cross_page_boundary) {
> +		pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
> +		__flush_tlb_one_user(poking_addr + PAGE_SIZE);
> +	}
> +
> +	/*
> +	 * Loading the previous page-table hierarchy requires a serializing
> +	 * instruction that already allows the core to see the updated version.
> +	 * Xen-PV is assumed to serialize execution in a similar manner.
> +	 */
> +	unuse_temporary_mm(prev);
> +
> +	pte_unmap_unlock(ptep, ptl);
> +out:
> +	/*
> +	 * TODO: allow the callers to deal with potential failures and do not
> +	 * panic so easily.
> +	 */
> +	BUG_ON(memcmp(addr, opcode, len));
>  	local_irq_restore(flags);
>  	return addr;
>  }
