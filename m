Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502612147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P5wIHcJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBTMYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:24:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBTMYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=me4pNO26rwyoESSLvYT67P6JAcOIH6WaRv2PXlW5qoc=; b=P5wIHcJw++x9NBZ+COTzGh5uI
        YibiVWkfYoz45QhgxupEDHHGRevMJLd7+co34jvYWdWb3NkRTngZAbsO7DYJQ/CQP5ogcC4GGj1br
        fqFne0WaVqvADch1gbehMTxtnFx2gz1SS6zn/ql2C87/qbg2Ap8bHfobT4Rva4HavgBFbx3limBsB
        BlfAuCeIApATr/hPBMgdrj6F7JO8r/p1TKGdBANQMYMOgrLH6Yqxhu9cRDorGto6rS/+huOrGn/us
        Fx805Y5J2150xDmc0YtM77Uh2CnlNeP0wcjzWsAVlADl5ZBwG6vH6k1h3L3LoPgj9OD3xNhYyIoWn
        XWJYFP7GQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwQvC-0004yo-Rs; Wed, 20 Feb 2019 12:24:18 +0000
Date:   Wed, 20 Feb 2019 04:24:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190220122418.GE12668@bombadil.infradead.org>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
 <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
 <20190219222828.GA68281@google.com>
 <f7e4db43-b836-4ac2-1aea-922be585d8b1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e4db43-b836-4ac2-1aea-922be585d8b1@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:57:59PM +0530, Anshuman Khandual wrote:
> On 02/20/2019 03:58 AM, Yu Zhao wrote:
> > On Tue, Feb 19, 2019 at 11:47:12AM +0530, Anshuman Khandual wrote:
> >> On 02/19/2019 11:02 AM, Yu Zhao wrote:
> >>> On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
> >>>> On 02/19/2019 04:43 AM, Yu Zhao wrote:
> >>>>> For pte page, use pgtable_page_ctor(); for pmd page, use
> >>>>> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> >>>>> p4d and pgd), don't use any.
> >>>> pgtable_page_ctor()/dtor() is not optional for any level page table page
> >>>> as it determines the struct page state and zone statistics.
> >>>
> >>> This is not true. pgtable_page_ctor() is only meant for user pte
> >>> page. The name isn't perfect (we named it this way before we had
> >>> split pmd page table lock, and never bothered to change it).
> >>>
> >>> The commit cccd843f54be ("mm: mark pages in use for page tables")
> >>> clearly states so:
> >>>   Note that only pages currently accounted as NR_PAGETABLES are
> >>>   tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.
> >>
> >> I think the commit is the following one and it does say so. But what is
> >> the rationale of tagging only PTE page as PageTable and updating the zone
> >> stat but not doing so for higher level page table pages ? Are not they
> >> used as page table pages ? Should not they count towards NR_PAGETABLE ?
> >>
> >> 1d40a5ea01d53251c ("mm: mark pages in use for page tables")
> > 
> > Well, I was just trying to clarify how the ctor is meant to be used.
> > The rational behind it is probably another topic.
> > 
> > For starters, the number of pmd/pud/p4d/pgd is at least two orders
> > of magnitude less than the number of pte, which makes them almost
> > negligible. And some archs use kmem for them, so it's infeasible to
> > SetPageTable on or account them in the way the ctor does on those
> > archs.
> 
> I understand the kmem cases which are definitely problematic and should
> be fixed. IIRC there is a mechanism to custom init pages allocated for
> slab cache with a ctor function which in turn can call pgtable_page_ctor().
> But destructor helper support for slab has been dropped I guess.

You can't put a spinlock in the struct page if the page is allocated
through slab.  Slab uses basically all of struct page for its own
purposes.  I tried to make that clear with the new layout of struct
page where everything's in a union discriminated by what the page is
allocated for.

