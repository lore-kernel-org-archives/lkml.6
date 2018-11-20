Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF10C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C0F20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9wrckMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C0F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeKTTbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:31:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53626 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeKTTbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ctiTMw/kVCUTgb5GNBD2OPmK9uuoA2kceMgmIzDu228=; b=d9wrckMI5aXPIJ3TJb1M8917f
        R/8Blj7XI2RzMrIL4PsqgT6bLitX3We+f3FoY+IdYIqt6CSMfr9eLkdzF1fh3GktLM2EN3R2cMUzG
        yfkoBvnJo82oN2lMU0H2+M16LL6QVSRrh6GSPsZ6D/o66NH5Q/GJ6b/dwe6Ez2MFc919AOW2JLB7h
        jHRt5XUHN3zgMJW4PgoydFAzHlz7RXnCNCyojk7grbcrJJwwBkwWLTLlp8SzM+Fmi/LwU0ir5px+T
        +SstQlDEEL4KNAfUs65WKRowlqGtRXxa3Xh6kENI/JqwokRQkD0QC9o96z/0Tq1N0pAog4f/eSYYI
        S4vFZQ5iQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP1wY-0005gc-Dh; Tue, 20 Nov 2018 09:03:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC8802029FD58; Tue, 20 Nov 2018 10:03:36 +0100 (CET)
Date:   Tue, 20 Nov 2018 10:03:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
Message-ID: <20181120090336.GF2131@hirez.programming.kicks-ass.net>
References: <154266954452.2939184.974606608701109493.stgit@dwillia2-desk3.amr.corp.intel.com>
 <279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com>
 <7b1bbfd295c4709e85ca26457b460fb4d36aa276.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b1bbfd295c4709e85ca26457b460fb4d36aa276.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:59:32AM +0000, Williams, Dan J wrote:
> On Mon, 2018-11-19 at 15:43 -0800, Dave Hansen wrote:
> > On 11/19/18 3:19 PM, Dan Williams wrote:
> > > Andy wondered why a path that can sleep was using __flush_tlb_all()
> > > [1]
> > > and Dave confirmed the expectation for TLB flush is for modifying /
> > > invalidating existing pte entries, but not initial population [2].
> > 
> > I _think_ this is OK.
> > 
> > But, could we sprinkle a few WARN_ON_ONCE(p*_present()) calls in
> > there
> > to help us sleep at night?
> 
> Well, I'm having nightmares now because my naive patch to sprinkle some
> WARN_ON_ONCE() calls is leading to my VM live locking at boot... no
> backtrace. If I revert the patch below and just go with the
> __flush_tlb_all() removal it seems fine.
> 
> I'm going to set this aside for a bit, but if anyone has any thoughts
> in the meantime I'd appreciate it.

Have you tried using early_printk ?

So kernel_physical_mapping_init() has a comment that states the virtual
and physical addresses we create mappings for should be PMD aligned,
which implies pud/p4d could have overlap between the mappings.

But in that case, I would expect the new and old values to match.

So maybe you should be checking something like:

	WARN_ON_ONCE(pud_present(*pud) && !pud_same(pud, new));

> @@ -573,6 +578,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
>  					     E820_TYPE_RAM) &&
>  			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
>  					     E820_TYPE_RESERVED_KERN))
> +				WARN_ON_ONCE(pud_present(*pud));
>  				set_pud(pud, __pud(0));
>  			continue;
>  		}
> @@ -610,6 +616,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
>  		if (page_size_mask & (1<<PG_LEVEL_1G)) {
>  			pages++;
>  			spin_lock(&init_mm.page_table_lock);
> +			WARN_ON_ONCE(pud_present(*pud));
>  			set_pte((pte_t *)pud,
>  				pfn_pte((paddr & PUD_MASK) >> PAGE_SHIFT,
>  					PAGE_KERNEL_LARGE));
> @@ -623,6 +630,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
>  					   page_size_mask, prot);
>  
>  		spin_lock(&init_mm.page_table_lock);
> +		WARN_ON_ONCE(pud_present(*pud));
>  		pud_populate(&init_mm, pud, pmd);
>  		spin_unlock(&init_mm.page_table_lock);
>  	}
> @@ -657,6 +665,7 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
>  					     E820_TYPE_RAM) &&
>  			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
>  					     E820_TYPE_RESERVED_KERN))
> +				WARN_ON_ONCE(p4d_present(*p4d));
>  				set_p4d(p4d, __p4d(0));
>  			continue;
>  		}
> @@ -674,6 +683,7 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
>  					   page_size_mask);
>  
>  		spin_lock(&init_mm.page_table_lock);
> +		WARN_ON_ONCE(p4d_present(*p4d));
>  		p4d_populate(&init_mm, p4d, pud);
>  		spin_unlock(&init_mm.page_table_lock);
>  	}
