Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5401C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD0F21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbfBROmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:42:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60728 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbfBROm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:42:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6CD61684;
        Mon, 18 Feb 2019 06:30:22 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF7563F589;
        Mon, 18 Feb 2019 06:29:59 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:29:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/13] arm64: mm: Add p?d_large() definitions
Message-ID: <20190218142951.GA10145@lakrids.cambridge.arm.com>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-2-steven.price@arm.com>
 <20190218112922.GT32477@hirez.programming.kicks-ass.net>
 <fe36ed1c-b90d-8062-f7a9-e52d940733c4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe36ed1c-b90d-8062-f7a9-e52d940733c4@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 02:11:40PM +0000, Steven Price wrote:
> On 18/02/2019 11:29, Peter Zijlstra wrote:
> > On Fri, Feb 15, 2019 at 05:02:22PM +0000, Steven Price wrote:
> > 
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index de70c1eabf33..09d308921625 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -428,6 +428,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >>  				 PMD_TYPE_TABLE)
> >>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >>  				 PMD_TYPE_SECT)
> >> +#define pmd_large(x)		pmd_sect(x)
> >>  
> >>  #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
> >>  #define pud_sect(pud)		(0)
> >> @@ -435,6 +436,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >>  #else
> >>  #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
> >>  				 PUD_TYPE_SECT)
> >> +#define pud_large(x)		pud_sect(x)
> >>  #define pud_table(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
> >>  				 PUD_TYPE_TABLE)
> >>  #endif
> > 
> > So on x86 p*d_large() also matches p*d_huge() and thp, But it is not
> > clear to me this p*d_sect() thing does so, given your definitions.
> > 
> > See here why I care:
> > 
> >   http://lkml.kernel.org/r/20190201124741.GE31552@hirez.programming.kicks-ass.net
> > 
> 
> pmd_huge()/pud_huge() unfortunately are currently defined as '0' if
> !CONFIG_HUGETLB_PAGE and for this reason I was avoiding using them.

I think that Peter means p?d_huge(x) should imply p?d_large(x), e.g.

#define pmd_large(x) \
	(pmd_sect(x) || pmd_huge(x) || pmd_trans_huge(x))

... which should work regardless of CONFIG_HUGETLB_PAGE.

> While most code would reasonably not care about huge pages in that build
> configuration, the likes of the debugfs page table dump code needs to be
> able to recognise them in all build configurations. I believe the
> situation is the same on arm64 and x86.

There's a very important distinction here between:

* section mappings, which are an archtiectural construct used in
  arm64-specific code (e.g. the kernel's own page tables).

* huge mappings, which are Linux logical construct for mapping
  userspace memory. These are buillt using section mappings.

The existing arm64 debugfs pagetable dump code cares about section
mappings specifically in all cases, since it is not used to dump
userspace page tables.

The existing generic code doesn't care about section mappings
specifically, because they are not generic.

Thanks,
Mark.
