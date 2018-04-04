Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDDSOW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:14:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34980 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDDSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:14:21 -0400
Date: Wed, 4 Apr 2018 20:14:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Nadav Amit <namit@vmware.com>
cc: Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        Hugh Dickins <hughd@google.com>, Juergen Gross <jgross@suse.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 09/11] x86/pti: enable global pages for shared areas
In-Reply-To: <2D4AE288-DD01-416B-9633-1BC9B6A20BFF@vmware.com>
Message-ID: <alpine.DEB.2.21.1804042011550.1492@nanos.tec.linutronix.de>
References: <20180404010946.6186729B@viggo.jf.intel.com> <20180404011007.A381CC8A@viggo.jf.intel.com> <5DEE9F6E-535C-4DBF-A513-69D9FD5C0235@vmware.com> <50385d91-58a9-4b14-06bc-2340b99933c3@linux.intel.com> <2D4AE288-DD01-416B-9633-1BC9B6A20BFF@vmware.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018, Nadav Amit wrote:
> Dave Hansen <dave.hansen@linux.intel.com> wrote:
> > On 04/03/2018 09:45 PM, Nadav Amit wrote:
> >> Dave Hansen <dave.hansen@linux.intel.com> wrote:
> >>> void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
> >>> {
> >>> 	unsigned long va = (unsigned long) cea_vaddr;
> >>> +	pte_t pte = pfn_pte(pa >> PAGE_SHIFT, flags);
> >>> 
> >>> -	set_pte_vaddr(va, pfn_pte(pa >> PAGE_SHIFT, flags));
> >>> +	/*
> >>> +	 * The cpu_entry_area is shared between the user and kernel
> >>> +	 * page tables.  All of its ptes can safely be global.
> >>> +	 */
> >>> +	if (boot_cpu_has(X86_FEATURE_PGE))
> >>> +		pte = pte_set_flags(pte, _PAGE_GLOBAL);
> >> 
> >> I think it would be safer to check that the PTE is indeed present before
> >> setting _PAGE_GLOBAL. For example, percpu_setup_debug_store() sets PAGE_NONE
> >> for non-present entries. In this case, since PAGE_NONE and PAGE_GLOBAL use
> >> the same bit, everything would be fine, but it might cause bugs one day.
> > 
> > That's a reasonable safety thing to add, I think.
> > 
> > But, looking at it, I am wondering why we did this in
> > percpu_setup_debug_store():
> > 
> >        for (; npages; npages--, cea += PAGE_SIZE)
> >                cea_set_pte(cea, 0, PAGE_NONE);
> > 
> > Did we really want that to be PAGE_NONE, or was it supposed to create a
> > PTE that returns true for pte_none()?
> 
> I yield it to others to answer...

My bad. I should have used pgprot(0).

Thanks,

	tglx
