Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37837C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E329820868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qb+zoClE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E329820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeH2NYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:24:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50484 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeH2NYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZuvDphvR9zJcIvuqk5DeTx/wlQ/E96+zd0XrCqUjqdE=; b=Qb+zoClEiVsv8HSfZ1djxAhXX
        ni+4deDkvpATmJ62LgY1wiTDP2vgTFcvJAVQtn0AuwWPE6y8mIE8bVb9KaM97G0F7bTH2jZMYzCiC
        s17m0TBoXqhVxa3ry26BatWUP1a9EezcffpUlfI37h08YaWt1/K3EKfREWU4/H6eyfmZn+3KsHT3R
        XslQhPG9UR4Bp9rbxriiolZD25l98pjY77RD5aqIVeUq65JbCiydU5fRKSsslf9NvTKENibsM9kg8
        MujXbV+6145IlTSEYdl7G4oBdtjc4ZrVJvmZWOj2OadGDXxUMmd9YCF03norM3d2Ne4Bqk5DSZEWU
        LqhWhDYJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuwmH-00009L-Fo; Wed, 29 Aug 2018 09:28:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC0FA2024D707; Wed, 29 Aug 2018 11:28:39 +0200 (CEST)
Date:   Wed, 29 Aug 2018 11:28:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text
 poking
Message-ID: <20180829092839.GP24124@hirez.programming.kicks-ass.net>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-6-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829081147.184610-6-namit@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 01:11:46AM -0700, Nadav Amit wrote:
> +static void text_poke_fixmap(void *addr, const void *opcode, size_t len,
> +			     struct page *pages[2])
> +{
> +	u8 *vaddr;
> +
> +	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
> +	if (pages[1])
> +		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
> +	vaddr = (u8 *)fix_to_virt(FIX_TEXT_POKE0);
> +	memcpy(vaddr + offset_in_page(addr), opcode, len);
> +
> +	/*
> +	 * clear_fixmap() performs a TLB flush, so no additional TLB
> +	 * flush is needed.
> +	 */
> +	clear_fixmap(FIX_TEXT_POKE0);
> +	if (pages[1])
> +		clear_fixmap(FIX_TEXT_POKE1);
> +	sync_core();
> +	/* Could also do a CLFLUSH here to speed up CPU recovery; but
> +	   that causes hangs on some VIA CPUs. */

Please take this opportunity to fix that comment style.

> +}
> +
> +__ro_after_init struct mm_struct *poking_mm;
> +__ro_after_init unsigned long poking_addr;
> +
> +/**
> + * text_poke_safe() - Pokes the text using a separate address space.
> + *
> + * This is the preferable way for patching the kernel after boot, as it does not
> + * allow other cores to accidentally or maliciously modify the code using the
> + * temporary PTEs.
> + */
> +static void text_poke_safe(void *addr, const void *opcode, size_t len,
> +			   struct page *pages[2])
> +{
> +	temporary_mm_state_t prev;
> +	pte_t pte, *ptep;
> +	spinlock_t *ptl;
> +
> +	/*
> +	 * The lock is not really needed, but this allows to avoid open-coding.
> +	 */
> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> +
> +	pte = mk_pte(pages[0], PAGE_KERNEL);
> +	set_pte_at(poking_mm, poking_addr, ptep, pte);
> +
> +	if (pages[1]) {
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
> +	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
> +
> +	/*
> +	 * Ensure that the PTE is only cleared after copying is done by using a
> +	 * compiler barrier.
> +	 */
> +	barrier();

I tripped over the use of 'done', because even with TSO the store isn't
done once the instruction retires.

All we want to ensure is that the pte_clear() store is issued after the
copy, and that is indeed guaranteed by this.

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
> +	 */

yuck :-), but yeah.

> +	__flush_tlb_one_user(poking_addr);
> +	if (pages[1]) {
> +		pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
> +		__flush_tlb_one_user(poking_addr + PAGE_SIZE);
> +	}
> +	/*
> +	 * Loading the previous page-table hierarchy requires a serializing
> +	 * instruction that already allows the core to see the updated version.
> +	 * Xen-PV is assumed to serialize execution in a similar manner.
> +	 */
> +	unuse_temporary_mm(prev);
> +
> +	pte_unmap_unlock(ptep, ptl);
> +}
