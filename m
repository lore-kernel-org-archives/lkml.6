Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A4EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBED2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbfBROrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:47:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58352 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731302AbfBRNpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290FCA78;
        Mon, 18 Feb 2019 05:45:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FF3B3F720;
        Mon, 18 Feb 2019 05:45:13 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:45:07 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] arm64: mm: Add p?d_large() definitions
Message-ID: <20190218134507.GA9603@lakrids.cambridge.arm.com>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-2-steven.price@arm.com>
 <20190218112922.GT32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218112922.GT32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:29:22PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 15, 2019 at 05:02:22PM +0000, Steven Price wrote:
> 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index de70c1eabf33..09d308921625 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -428,6 +428,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >  				 PMD_TYPE_TABLE)
> >  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >  				 PMD_TYPE_SECT)
> > +#define pmd_large(x)		pmd_sect(x)
> >  
> >  #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
> >  #define pud_sect(pud)		(0)
> > @@ -435,6 +436,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >  #else
> >  #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
> >  				 PUD_TYPE_SECT)
> > +#define pud_large(x)		pud_sect(x)
> >  #define pud_table(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
> >  				 PUD_TYPE_TABLE)
> >  #endif
> 
> So on x86 p*d_large() also matches p*d_huge() and thp, But it is not
> clear to me this p*d_sect() thing does so, given your definitions.
> 
> See here why I care:
> 
>   http://lkml.kernel.org/r/20190201124741.GE31552@hirez.programming.kicks-ass.net

I believe it does not.

IIUC our p?d_huge() helpers implicitly handle contiguous entries. That's
where you have $N entries in the current level of table that the TLB can
cache together as one.

Our p?d_sect() helpers only match section entries. That's where we map
an entire next-level-table's worth of VA space with a single entry at
the current level.

Thanks,
Mark.
