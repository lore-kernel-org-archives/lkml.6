Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E66ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DBA214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DBA214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeIQRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:00:05 -0400
Received: from foss.arm.com ([217.140.101.70]:57758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbeIQRAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:00:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D59380D;
        Mon, 17 Sep 2018 04:33:10 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E3913F5BD;
        Mon, 17 Sep 2018 04:33:10 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 979D01AE2F82; Mon, 17 Sep 2018 12:33:28 +0100 (BST)
Date:   Mon, 17 Sep 2018 12:33:28 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] ioremap: Rework pXd_free_pYd_page() API
Message-ID: <20180917113328.GC22717@arm.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
 <1536747974-25875-2-git-send-email-will.deacon@arm.com>
 <71baefb8e0838fba89ee06262bbb2456e9091c7a.camel@hpe.com>
 <db3f513bf3bfafb85b99f57f741f5bb07952af70.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db3f513bf3bfafb85b99f57f741f5bb07952af70.camel@hpe.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 09:10:49PM +0000, Kani, Toshi wrote:
> On Fri, 2018-09-14 at 14:36 -0600, Toshi Kani wrote:
> > On Wed, 2018-09-12 at 11:26 +0100, Will Deacon wrote:
> > > The recently merged API for ensuring break-before-make on page-table
> > > entries when installing huge mappings in the vmalloc/ioremap region is
> > > fairly counter-intuitive, resulting in the arch freeing functions
> > > (e.g. pmd_free_pte_page()) being called even on entries that aren't
> > > present. This resulted in a minor bug in the arm64 implementation, giving
> > > rise to spurious VM_WARN messages.
> > > 
> > > This patch moves the pXd_present() checks out into the core code,
> > > refactoring the callsites at the same time so that we avoid the complex
> > > conjunctions when determining whether or not we can put down a huge
> > > mapping.
> > > 
> > > Cc: Chintan Pandya <cpandya@codeaurora.org>
> > > Cc: Toshi Kani <toshi.kani@hpe.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > 
> > Yes, this looks nicer.
> > 
> > Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
> 
> Sorry, I take it back since I got a question...
> 
> +static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
> > +				unsigned long end, phys_addr_t
> phys_addr,
> > +				pgprot_t prot)
> > +{
> > +	if (!ioremap_pmd_enabled())
> > +		return 0;
> > +
> > +	if ((end - addr) != PMD_SIZE)
> > +		return 0;
> > +
> > +	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
> > +		return 0;
> > +
> > +	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
> > +		return 0;
> 
> Is pm_present() a proper check here?  We probably do not have this case
> for iomap, but I wonder if one can drop p-bit while it has a pte page
> underneath.

For ioremap/vunmap the pXd_present() check is correct, yes. The vunmap()
code only ever clears leaf entries, leaving table entries intact. If it
did clear table entries, you'd be stuck here because you wouldn't have
the address of the table to free.

If somebody called pmd_mknotpresent() on a table entry, we may run into
problems, but it's only used for huge mappings afaict.

Will
