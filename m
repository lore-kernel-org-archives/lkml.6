Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B849DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E9F2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E9F2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbeIUPoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:44:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbeIUPoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:44:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED44980D;
        Fri, 21 Sep 2018 02:56:11 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.Emea.Arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E8C93F5C0;
        Fri, 21 Sep 2018 02:56:10 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:56:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chintan Pandya <cpandya@codeaurora.org>
Cc:     mark.rutland@arm.com, toshi.kani@hpe.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 3/3] arm64: Implement page table free interfaces
Message-ID: <20180921095607.GA166997@arrakis.emea.arm.com>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
 <20180920172527.GB18934@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920172527.GB18934@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:25:29PM +0100, Catalin Marinas wrote:
> On Wed, Jun 06, 2018 at 12:31:21PM +0530, Chintan Pandya wrote:
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 8ae5d7a..65f8627 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -45,6 +45,7 @@
> >  #include <asm/memblock.h>
> >  #include <asm/mmu_context.h>
> >  #include <asm/ptdump.h>
> > +#include <asm/tlbflush.h>
> >  
> >  #define NO_BLOCK_MAPPINGS	BIT(0)
> >  #define NO_CONT_MAPPINGS	BIT(1)
> > @@ -977,12 +978,51 @@ int pmd_clear_huge(pmd_t *pmdp)
> >  	return 1;
> >  }
> >  
> > -int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> > +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
> >  {
> > -	return pud_none(*pud);
> > +	pte_t *table;
> > +	pmd_t pmd;
> > +
> > +	pmd = READ_ONCE(*pmdp);
> > +
> > +	/* No-op for empty entry and WARN_ON for valid entry */
> > +	if (!pmd_present(pmd) || !pmd_table(pmd)) {
> > +		VM_WARN_ON(!pmd_table(pmd));
> > +		return 1;
> > +	}
> 
> What's this VM_WARN_ON supposed to do here? If the pmd is 0, we trigger
> it all the time. Did you actually mean something like:
> 
> 		VM_WARN_ON(!pmd_none(pmd));
> 
> or pmd_present(pmd)?
> 
> Since the comment mentions empty entry, I'd rather make it explicit:
> 
> 	if (pmd_none(pmd) || !pmd_table(pmd))
> 		VM_WARN_ON(!pmd_none(pmd));
> 		return 1;
> 	}

Ignore this, fixed in -rc4 (fac880c7d074 "arm64: fix erroneous warnings
in page freeing functions").

-- 
Catalin
