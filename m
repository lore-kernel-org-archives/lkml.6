Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30A4C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A36921919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OrvPN6Rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBHEYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:24:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfBHEYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=noboadxw7ctxVc/zb7Z7XXaMe+1BiHZpqiKt9p1zupE=; b=OrvPN6RrhGeIQDHv48xmpifKL
        LGlns3tGZE0+zhHmlcLAT4HRy8cIhud75ze1UDRFCyqdj+zvD324AlMcSYv5m4zSnJLJWEbLAkzma
        QDVHlr9Fg8ZQtc9+iSypOttL8Oxx8FKWaSem8IVC3qzKMAq0lqxz7dj+fHuQvmasfYl3HVsCO6RnA
        4cCDOSExnrQCefkkAh+o/syoGSfAGuHMpc+OfY8oaSD/TBSniRW87JVKeGmkh/Kt94GdcfuFHmnkK
        5N/spFta5kOVevN2BJCLuwaJw2ZAiWO5y45Tl9m6ZMBibYgJKbitcIzJJIssag/Cb75w1yZ3p8y4Q
        o1Md/gUsw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grxia-0001lm-Db; Fri, 08 Feb 2019 04:24:48 +0000
Date:   Thu, 7 Feb 2019 20:24:48 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Non standard size THP
Message-ID: <20190208042448.GB21860@bombadil.infradead.org>
References: <dcb0b2cf-ba5c-e6ef-0b05-c6006227b6a9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb0b2cf-ba5c-e6ef-0b05-c6006227b6a9@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 07:43:57AM +0530, Anshuman Khandual wrote:
> How non-standard huge pages can be supported for THP
> 
> 	- THP starts recognizing non standard huge page (exported by arch) like HPAGE_CONT_(PMD|PTE)_SIZE
> 	- THP starts operating for either on HPAGE_PMD_SIZE or HPAGE_CONT_PMD_SIZE or HPAGE_CONT_PTE_SIZE
> 	- set_pmd_at() only recognizes HPAGE_PMD_SIZE hence replace set_pmd_at() with set_huge_pmd_at()
> 	- set_huge_pmd_at() could differentiate between HPAGE_PMD_SIZE or HPAGE_CONT_PMD_SIZE
> 	- In case for HPAGE_CONT_PTE_SIZE extend page table walker till PTE level
> 	- Use set_huge_pte_at() which can operate on multiple contiguous PTE bits

I think your proposed solution reflects thinking like a hardware person
rather than like a software person.  Or maybe like an MM person rather
than a FS person.  I see the same problem with Kirill's solutions ;-)

Perhaps you don't realise that using larger pages when appropriate
would also benefit filesystems as well as CPUs.  You didn't include
linux-fsdevel on this submission, so that's a plausible explanation.

The XArray currently supports arbitrary power-of-two-naturally-aligned
page sizes, and conveniently so does the page allocator [1].  The problem
is that various bits of the MM have a very fixed mindset that pages are
PTE, PMD or PUD in size.

We should enhance routines like vmf_insert_page() to handle
arbitrary sized pages rather than having separate vmf_insert_pfn()
and vmf_insert_pfn_pmd().  We probably need to enhance the set_pxx_at()
API to pass in an order, rather than explicitly naming pte/pmd/pud/...

First, though, we need to actually get arbitrary sized pages handled
correctly in the page cache.  So if anyone's interested in talking about
this, but hasn't been reviewing or commenting on the patches I've been
sending to make this happen, I'm going to seriously question their actual
commitment to wanting this to happen, rather than wanting a nice holiday
in Puerto Rico.

Sorry to be so blunt about this, but I've only had review from Kirill,
which makes me think that nobody else actually cares about getting
this fixed.

[1] Support for arbitrary sized and aligned entries is in progress for
the XArray, but I don't think there's any appetite for changing the buddy
allocator to let us allocate "pages" that are an arbitrary extent in size.

