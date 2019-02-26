Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE60520C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfBZOw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:52:27 -0500
Received: from foss.arm.com ([217.140.101.70]:48598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfBZOw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:52:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20F27A78;
        Tue, 26 Feb 2019 06:52:26 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAC4F3F703;
        Tue, 26 Feb 2019 06:52:23 -0800 (PST)
Date:   Tue, 26 Feb 2019 14:52:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peng Fan <peng.fan@nxp.com>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH] mm/cma: cma_declare_contiguous: correct err handling
Message-ID: <20190226145218.GA124603@arrakis.emea.arm.com>
References: <20190214125704.6678-1-peng.fan@nxp.com>
 <20190214123824.fe95cc2e603f75382490bfb4@linux-foundation.org>
 <b78470e8-b204-4a7e-f9cc-eff9c609f480@suse.cz>
 <20190219174610.GA32749@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219174610.GA32749@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 07:46:11PM +0200, Mike Rapoport wrote:
> On Tue, Feb 19, 2019 at 05:55:33PM +0100, Vlastimil Babka wrote:
> > On 2/14/19 9:38 PM, Andrew Morton wrote:
> > > On Thu, 14 Feb 2019 12:45:51 +0000 Peng Fan <peng.fan@nxp.com> wrote:
> > > 
> > >> In case cma_init_reserved_mem failed, need to free the memblock allocated
> > >> by memblock_reserve or memblock_alloc_range.
> > >>
> > >> ...
> > >>
> > >> --- a/mm/cma.c
> > >> +++ b/mm/cma.c
> > >> @@ -353,12 +353,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
> > >>  
> > >>  	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
> > >>  	if (ret)
> > >> -		goto err;
> > >> +		goto free_mem;
> > >>  
> > >>  	pr_info("Reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
> > >>  		&base);
> > >>  	return 0;
> > >>  
> > >> +free_mem:
> > >> +	memblock_free(base, size);
> > >>  err:
> > >>  	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
> > >>  	return ret;
> > > 
> > > This doesn't look right to me.  In the `fixed==true' case we didn't
> > > actually allocate anything and in the `fixed==false' case, the
> > > allocated memory is at `addr', not at `base'.
> > 
> > I think it's ok as the fixed==true path has "memblock_reserve()", but
> > better leave this to the memblock maintainer :)
> 
> As Peng Fan noted in the other e-mail, fixed==true has memblock_reserve()
> and fixed==false resets base = addr, so this is Ok.
>  
> > There's also 'kmemleak_ignore_phys(addr)' which should probably be
> > undone (or not called at all) in the failure case. But it seems to be
> > missing from the fixed==true path?
> 
> Well, memblock and kmemleak interaction does not seem to have clear
> semantics anyway. memblock_free() calls kmemleak_free_part_phys() which
> does not seem to care about ignored objects.
> As for the fixed==true path, memblock_reserve() does not register the area
> with kmemleak, so there would be no object to free in memblock_free().
> AFAIU, kmemleak simply ignores this.

Kmemleak is supposed to work with the memblock_{alloc,free} pair and it
ignores the memblock_reserve() as a memblock_alloc() implementation
detail. It is, however, tolerant to memblock_free() being called on a
sub-range or just a different range from a previous memblock_alloc(). So
the original patch looks fine to me. FWIW:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
