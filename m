Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B728C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0988A20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JjfXx619"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0988A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeKLAsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:48:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeKLAsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O6hKbT4rhMypQNtjVLSlaefPbzmUNTNUst1/kc+LNSw=; b=JjfXx619r8IJtFn5aTyy5h09I
        xIwI4l1gpyyulExdNrtiqXDtVC/wsf+zZsh9OQ7gNXF7b63sHf1bOCmhP5EGmW1mxBvMJkjTHsqR+
        a74hqpKf2tK89+gsOHJOigy/Fexlk0VgtQMSd80KskgVfxvuT15dmlfmICud9rrc2I2TAKOI3JBz3
        qE6KngtBX08aBzpmeGd9gnG1GMFGZrmZ8OAiUBPV0s2Npwy9Ps7QuydAO/GjCFeILM+RadEXarHo5
        9TbfbAZeVWAlnJwvHN4ijGsWra45UxaFUIhWdMOiT34S/G7vDx+gAsnBo0HIjXObs1R+0GTDnur4y
        J98AU90+w==;
Received: from [64.114.255.97] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLrD9-0000mv-FF; Sun, 11 Nov 2018 14:59:39 +0000
Received: by worktop (Postfix, from userid 1000)
        id 832506E2090; Sun, 11 Nov 2018 15:59:36 +0100 (CET)
Date:   Sun, 11 Nov 2018 15:59:36 +0100
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
Subject: Re: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Message-ID: <20181111145936.GA3021@worktop>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110231732.15060-7-namit@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 03:17:28PM -0800, Nadav Amit wrote:
> @@ -683,43 +684,108 @@ __ro_after_init unsigned long poking_addr;
>  
>  static int __text_poke(void *addr, const void *opcode, size_t len)
>  {
> +	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
> +	temporary_mm_state_t prev;
> +	struct page *pages[2] = {NULL};
>  	unsigned long flags;
> +	pte_t pte, *ptep;
> +	spinlock_t *ptl;
> +	int r = 0;
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
> +	if (!pages[0] || (cross_page_boundary && !pages[1]))
>  		return -EFAULT;
> +
>  	local_irq_save(flags);
> +
> +	/*
> +	 * The lock is not really needed, but this allows to avoid open-coding.
> +	 */
> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> +
> +	/*
> +	 * If we failed to allocate a PTE, fail. This should *never* happen,
> +	 * since we preallocate the PTE.
> +	 */
> +	if (WARN_ON_ONCE(!ptep))
> +		goto out;

Since we hard rely on init getting that right; can't we simply get rid
of this?

> +
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
> +	if (memcmp(addr, opcode, len))
> +		r = -EFAULT;

How could this ever fail? And how can we reliably recover from that?

I mean, we can move that BUG_ON() we have in text_poke() down a level,
but for example the static_key/jump_label code has no real option on
failing this.

> +
>  	local_irq_restore(flags);
>  	return r;
>  }

Other than that, this looks really good!
