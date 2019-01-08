Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2BBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59872089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546941074;
	bh=YVt8ZDSmaXPNs8JOErogGN4VdocRH1zdHAOP4dAREoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kEwaRK9qYsy3APjxm4Zj00Zfe2Ky31XyZpkR0vYsAiMqblqY29xd93YZWfYsGndtW
	 iYS8oTT+axIwTLSweoteQlOE2vgTcnGl6nunJHN+Tz4O6yl0EJ9t1QBxWQG6Q/e2X9
	 hWmzioXAOHq9Rbf3BMtLaq4m5nfHW8iiP0JqLqKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfAHJvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfAHJvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:51:13 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D73820827;
        Tue,  8 Jan 2019 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546941072;
        bh=YVt8ZDSmaXPNs8JOErogGN4VdocRH1zdHAOP4dAREoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CB3CeXeRzD7Nhcxy0pm174qUAnrw68etZNUhmgp5J+xgRzszOE/cLJCpxfcNj5YmM
         oxTSOtSsdwvJ4HrNYZP//HvgcTAyRrYARDfi7SURqE3p/DLYRoy/CDEsb5CcezpQw3
         vG120LLWC4STq1utVimGgtOenl3y8pRu66y55teE=
Date:   Tue, 8 Jan 2019 17:51:07 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.0-rc1 (test results)
Message-ID: <20190108095107.GA25409@guoren-Inspiron-7460>
References: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
 <20190107192648.GA10789@roeck-us.net>
 <CAHk-=wjt6oKtYuJ-EOGSO1m8vBdPa+g2_6WZ6MKCwfu4afoSrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjt6oKtYuJ-EOGSO1m8vBdPa+g2_6WZ6MKCwfu4afoSrw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
On Mon, Jan 07, 2019 at 03:21:45PM -0800, Linus Torvalds wrote:
> On Mon, Jan 7, 2019 at 11:26 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Bisect points to commit 4cf58924951ef ("mm: treewide: remove unused address
> > argument from pte_alloc functions"). Interesting - wasn't that supposed
> > to be automatic ?
> >
> > csky does use the the removed address argument, so I won't even try to
> > provide a patch. Copying csky maintainer instead.
> 
> Hmm. Interesting. The csky code seems to have some odd "poison pte
> contents with ones if the address has the high bit set".
PTE contents is the only _PAGE_GLOBAL bit which could let mmu ignore the
ASID. One tlb entry is composed of 2 pfns and there is one GLOBAL bit in
the tlb entry. When C-SKY MMU hard-refill a tlb entry into the TLB buffer,
it will get pfn0-GLOBAL & pfn1-GLOBAL from the memory and put the result
into the TLB buffer.

If pfn0 is valid & pfn1 is invalid, we also must keep invalid pte_t with GLOBAL
bit set for C-SKY MMU.

Also see pte_clear() and pte_none() in pgtable.h.

> 
> Which makes little or no sense. The "high bit set" case is for kernel
> page tables, but that's exactly the "pte_alloc_one()" vs
> "pte_alloc_one_kernel()" distinction.
> 
> So testing the address seems entirely wrong.
Yes, testing address is no necessary, I'll remove it.

> 
> But there's other strangeness in there too. For example,
> pte_alloc_one_kernel() will just write directly to the page. And
> pte_alloc_one() will do a "kmap_atomic()" on the page it allocates,
> except since it uses GFP_KERNEL, that's entirely pointless.
> 
> Is the alloc_pages() in pte_alloc_one() perhaps meant to use
> GFP_HIGHUSER instead?
No GFP_HIGHUSER, kmap_atomic should be removed and I'll use __GFP_ZERO
instead.

> Is this perhaps some copy-paste issue?
:P

> 
> So I *think* the removal of the 'address' use in csky should be
> simple, but yes, this needs a csky maintainer to look at.
> 
Here is my new implementation:

static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
{
	pte_t *pte;
	unsigned long i;

	pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL);
						     ^^^^^^^^^^^^^^^^^^^
						     It's necessary ?
						     x86 & arm don't use
						     it.
	if (!pte)
		return NULL;

	for (i = 0; i < PAGE_SIZE/sizeof(pte_t); i++)
		(pte + i)->pte_low = _PAGE_GLOBAL;

	return pte;
}

static inline struct page *pte_alloc_one(struct mm_struct *mm)
{
	struct page *pte;

	pte = alloc_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO, 0);
	if (!pte)
		return NULL;

	if (!pgtable_page_ctor(pte)) {
		__free_page(pte);
		return NULL;
	}

	return pte;
}

Best Regards
 Guo Ren
