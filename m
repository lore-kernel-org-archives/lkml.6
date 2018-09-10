Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1EFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325C620865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325C620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIJMJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:09:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeIJMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:09:08 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01D41CAB;
        Mon, 10 Sep 2018 07:16:31 +0000 (UTC)
Date:   Mon, 10 Sep 2018 09:16:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Hocko <mhocko@suse.cz>, stable@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 41/43] x86/mm/pat: Make set_memory_np() L1TF safe
Message-ID: <20180910071629.GA21671@kroah.com>
References: <20180814171517.014285600@linuxfoundation.org>
 <20180814171519.769320295@linuxfoundation.org>
 <1536511561.3024.115.camel@codethink.co.uk>
 <5438e0f8-f5e0-99ef-fbdd-b5f4a079f254@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5438e0f8-f5e0-99ef-fbdd-b5f4a079f254@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 10:06:06AM -0700, Guenter Roeck wrote:
> On 09/09/2018 09:46 AM, Ben Hutchings wrote:
> > On Tue, 2018-08-14 at 19:18 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream
> > [...]
> > > --- a/arch/x86/include/asm/pgtable.h
> > > +++ b/arch/x86/include/asm/pgtable.h
> > > @@ -378,12 +378,39 @@ static inline pmd_t pfn_pmd(unsigned lon
> > > >   	return __pmd(pfn | massage_pgprot(pgprot));
> > >   }
> > > +static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
> > > +{
> > > +	phys_addr_t pfn = page_nr << PAGE_SHIFT;
> > > +	pfn ^= protnone_mask(pgprot_val(pgprot));
> > > +	pfn &= PHYSICAL_PUD_PAGE_MASK;
> > > +	return __pud(pfn | massage_pgprot(pgprot));
> > > +}
> > [...]
> > 
> > This (and the backport to 4.9) are missing the fix from commit
> > e14d7dfb41f5 "x86/speculation/l1tf: Fix up pte->pfn conversion for
> > PAE", as that was applied earlier in the series.  But since PAE implies
> > only 3-level paging I don't know how the PUD functions get used or
> > whether this actually matters.
> > 
> Excellent find.
> 
> e14d7dfb41f5 (re-)applies cleanly to both 4.4.y and 4.9.y. Since most of its
> changes are already applied, the only remaining change is
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index c535012bdb56..5736306bdaab 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -420,7 +420,7 @@ static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
> 
>  static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
>  {
> -       phys_addr_t pfn = page_nr << PAGE_SHIFT;
> +       phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
>         pfn ^= protnone_mask(pgprot_val(pgprot));
>         pfn &= PHYSICAL_PUD_PAGE_MASK;
>         return __pud(pfn | massage_pgprot(pgprot));
> 
> after cherry-picking it into both branches.
> 
> I think we should re-apply it to both 4.4.y and 4.9.y be on the safe side.

Thanks for finding and figuring out the fix.  Now queued up to both
trees.

greg k-h
