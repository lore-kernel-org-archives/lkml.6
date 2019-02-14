Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657F1222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hn6IfzZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405461AbfBNK5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:57:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfBNK5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h87IdZdCVuSbWdFagb1UhdNLjtjBoimcYpQUS+r7AhY=; b=Hn6IfzZRhdbXf7c86Xmn0Ffst
        WuQKta1CW47PaeEOB9FAAZC2ns5vNDz4hnZJm2czo42swIoeWSYwCdXB3mMGI6Qry1J8MSDpclLXK
        kdz6ZPsaUmrFBqSyRmLRQphHRHmsnhEVDcqVMhVVkh0pqTqFxA2MBqfOixBxtAfHMIEGMA8uShynt
        gEmU77M+VEv7uQg+5zFABeAGrfdRH8lpv80oGZcQfZnVI24U0lr/Z8awzWDUObdMr0qaNEriTdPnS
        Ovp522m8/zrSzKlu0kvLWGZ6YPvbQooP80v2TnDMFGscejdP3PxIeNCzFNyJhoD0bungED7gO6LKc
        AH+tdD3Nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guEgz-00036v-MJ; Thu, 14 Feb 2019 10:56:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB8A220298375; Thu, 14 Feb 2019 11:56:31 +0100 (CET)
Date:   Thu, 14 Feb 2019 11:56:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        oao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        dave.hansen@intel.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@docker.com>,
        Marco Benatto <marco.antonio.780@gmail.com>
Subject: Re: [RFC PATCH v8 03/14] mm, x86: Add support for eXclusive Page
 Frame Ownership (XPFO)
Message-ID: <20190214105631.GJ32494@hirez.programming.kicks-ass.net>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <8275de2a7e6b72d19b1cd2ec5d71a42c2c7dd6c5.1550088114.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8275de2a7e6b72d19b1cd2ec5d71a42c2c7dd6c5.1550088114.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 05:01:26PM -0700, Khalid Aziz wrote:
>  static inline void *kmap_atomic(struct page *page)
>  {
> +	void *kaddr;
> +
>  	preempt_disable();
>  	pagefault_disable();
> +	kaddr = page_address(page);
> +	xpfo_kmap(kaddr, page);
> +	return kaddr;
>  }
>  #define kmap_atomic_prot(page, prot)	kmap_atomic(page)
>  
>  static inline void __kunmap_atomic(void *addr)
>  {
> +	xpfo_kunmap(addr, virt_to_page(addr));
>  	pagefault_enable();
>  	preempt_enable();
>  }

How is that supposed to work; IIRC kmap_atomic was supposed to be
IRQ-safe.

> +/* Per-page XPFO house-keeping data */
> +struct xpfo {
> +	unsigned long flags;	/* Page state */
> +	bool inited;		/* Map counter and lock initialized */

What's sizeof(_Bool) ? Why can't you use a bit in that flags word?

> +	atomic_t mapcount;	/* Counter for balancing map/unmap requests */
> +	spinlock_t maplock;	/* Lock to serialize map/unmap requests */
> +};

Without that bool, the structure would be 16 bytes on 64bit, which seems
like a good number.

> +void xpfo_kmap(void *kaddr, struct page *page)
> +{
> +	struct xpfo *xpfo;
> +
> +	if (!static_branch_unlikely(&xpfo_inited))
> +		return;
> +
> +	xpfo = lookup_xpfo(page);
> +
> +	/*
> +	 * The page was allocated before page_ext was initialized (which means
> +	 * it's a kernel page) or it's allocated to the kernel, so nothing to
> +	 * do.
> +	 */
> +	if (!xpfo || unlikely(!xpfo->inited) ||
> +	    !test_bit(XPFO_PAGE_USER, &xpfo->flags))
> +		return;
> +
> +	spin_lock(&xpfo->maplock);
> +
> +	/*
> +	 * The page was previously allocated to user space, so map it back
> +	 * into the kernel. No TLB flush required.
> +	 */
> +	if ((atomic_inc_return(&xpfo->mapcount) == 1) &&
> +	    test_and_clear_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags))
> +		set_kpte(kaddr, page, PAGE_KERNEL);
> +
> +	spin_unlock(&xpfo->maplock);
> +}
> +EXPORT_SYMBOL(xpfo_kmap);
> +
> +void xpfo_kunmap(void *kaddr, struct page *page)
> +{
> +	struct xpfo *xpfo;
> +
> +	if (!static_branch_unlikely(&xpfo_inited))
> +		return;
> +
> +	xpfo = lookup_xpfo(page);
> +
> +	/*
> +	 * The page was allocated before page_ext was initialized (which means
> +	 * it's a kernel page) or it's allocated to the kernel, so nothing to
> +	 * do.
> +	 */
> +	if (!xpfo || unlikely(!xpfo->inited) ||
> +	    !test_bit(XPFO_PAGE_USER, &xpfo->flags))
> +		return;
> +
> +	spin_lock(&xpfo->maplock);
> +
> +	/*
> +	 * The page is to be allocated back to user space, so unmap it from the
> +	 * kernel, flush the TLB and tag it as a user page.
> +	 */
> +	if (atomic_dec_return(&xpfo->mapcount) == 0) {
> +		WARN(test_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags),
> +		     "xpfo: unmapping already unmapped page\n");
> +		set_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags);
> +		set_kpte(kaddr, page, __pgprot(0));
> +		xpfo_flush_kernel_tlb(page, 0);
> +	}
> +
> +	spin_unlock(&xpfo->maplock);
> +}
> +EXPORT_SYMBOL(xpfo_kunmap);

And these here things are most definitely not IRQ-safe.
