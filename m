Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DFBC282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EA920821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lXaU2h/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfBELcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:32:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfBELcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=46wwDVY6md2iRiG6auVyzKi3knUFHNtDdo8/Lph88jg=; b=lXaU2h/ZxqCOcjid8EiGGYSFO
        mY9Jts3n21eUwCTh3IeuoIyk0A4JcZRkgViDqDk3egh4n+rtfxDDmHQvMrD5vU+ADZa2V5iKBvcCq
        CrgYq375TC7S6rmOqjOOTmRhmy4BcEzDyogZc91mgNYfCm+ynlHibBKRiPl0vH4FVqXyS2ZUBZ0MS
        5nyjnG3mDfJjS7OrRX4UdMuQMhPqsliJkKq0A0F9JZgL6rXkfv8dLz2f1Yqe7WkRlnPLbWv7F9MrD
        ZcTPGlskaBftD3lFVUQJlyIUHZjafsmSbpBJAg1jQ/AePjXpMJQXQbBb4lKTlFdNzUXwQIk0m3iXR
        VZAKjLDMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqyx9-0001qD-OT; Tue, 05 Feb 2019 11:31:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19EFD2029F1D6; Tue,  5 Feb 2019 12:31:46 +0100 (CET)
Date:   Tue, 5 Feb 2019 12:31:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 06/20] x86/alternative: use temporary mm for text
 poking
Message-ID: <20190205113146.GP17528@hirez.programming.kicks-ass.net>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-7-rick.p.edgecombe@intel.com>
 <20190205095853.GJ21801@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205095853.GJ21801@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:58:53AM +0100, Borislav Petkov wrote:
> > @@ -683,41 +684,102 @@ __ro_after_init unsigned long poking_addr;
> >  
> >  static void *__text_poke(void *addr, const void *opcode, size_t len)
> >  {
> > +	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
> > +	temporary_mm_state_t prev;
> > +	struct page *pages[2] = {NULL};
> >  	unsigned long flags;
> > -	char *vaddr;
> > -	struct page *pages[2];
> > -	int i;
> > +	pte_t pte, *ptep;
> > +	spinlock_t *ptl;
> > +	pgprot_t prot;
> >  
> >  	/*
> > -	 * While boot memory allocator is runnig we cannot use struct
> > -	 * pages as they are not yet initialized.
> > +	 * While boot memory allocator is running we cannot use struct pages as
> > +	 * they are not yet initialized.
> >  	 */
> >  	BUG_ON(!after_bootmem);
> >  
> >  	if (!core_kernel_text((unsigned long)addr)) {
> >  		pages[0] = vmalloc_to_page(addr);
> > -		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
> > +		if (cross_page_boundary)
> > +			pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
> >  	} else {
> >  		pages[0] = virt_to_page(addr);
> >  		WARN_ON(!PageReserved(pages[0]));
> > -		pages[1] = virt_to_page(addr + PAGE_SIZE);
> > +		if (cross_page_boundary)
> > +			pages[1] = virt_to_page(addr + PAGE_SIZE);
> >  	}
> > -	BUG_ON(!pages[0]);
> > +	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
> 
> checkpatch fires a lot for this patchset and I think we should tone down
> the BUG_ON() use.

I've been pushing for BUG_ON() in this patch set; sod checkpatch.

Maybe not this BUG_ON in particular, but a number of them introduced
here are really situations where we can't do anything sane.

This BUG_ON() in particular is the choice between corrupted text or an
instantly dead machine; what would you do?

In general, text_poke() cannot fail:

 - suppose changing a single jump label requires poking multiple sites
   (not uncommon), we fail halfway through and then have to undo the
   first pokes, but those pokes fail again.

 - this then leaves us no way forward and no way back, we've got
   inconsistent text state -> FAIL.

So even an 'early' fail (like here) doesn't work in the rollback
scenario if you combine them.

So while in general I agree with BUG_ON() being undesirable, I think
liberal sprinking in text_poke() is fine; you really _REALLY_ want this
to work or fail loudly. Text corruption is just painful.
