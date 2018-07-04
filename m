Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B18C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DBB243D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DBB243D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeGDN3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:29:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:55638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752712AbeGDN3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:29:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA6A5AD89;
        Wed,  4 Jul 2018 13:29:05 +0000 (UTC)
Date:   Wed, 4 Jul 2018 15:29:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
Message-ID: <20180704132905.GS22503@dhcp22.suse.cz>
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180704130500.GP22503@dhcp22.suse.cz>
 <20180704132410.GH4352@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704132410.GH4352@rapoport-lnx>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-07-18 16:24:11, Mike Rapoport wrote:
> On Wed, Jul 04, 2018 at 03:05:00PM +0200, Michal Hocko wrote:
> > On Tue 03-07-18 20:05:06, Mike Rapoport wrote:
> > > Most functions in memblock already use phys_addr_t to represent a physical
> > > address with __memblock_free_late() being an exception.
> > > 
> > > This patch replaces u64 with phys_addr_t in __memblock_free_late() and
> > > switches several format strings from %llx to %pa to avoid casting from
> > > phys_addr_t to u64.
> > > 
> > > CC: Michal Hocko <mhocko@kernel.org>
> > > CC: Matthew Wilcox <willy@infradead.org>
> > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > > ---
> > >  mm/memblock.c | 46 +++++++++++++++++++++++-----------------------
> > >  1 file changed, 23 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 03d48d8..20ad8e9 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -330,7 +330,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
> > >  {
> > >  	struct memblock_region *new_array, *old_array;
> > >  	phys_addr_t old_alloc_size, new_alloc_size;
> > > -	phys_addr_t old_size, new_size, addr;
> > > +	phys_addr_t old_size, new_size, addr, new_end;
> > >  	int use_slab = slab_is_available();
> > >  	int *in_slab;
> > >  
> > > @@ -391,9 +391,9 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
> > >  		return -1;
> > >  	}
> > >  
> > > -	memblock_dbg("memblock: %s is doubled to %ld at [%#010llx-%#010llx]",
> > > -			type->name, type->max * 2, (u64)addr,
> > > -			(u64)addr + new_size - 1);
> > > +	new_end = addr + new_size - 1;
> > > +	memblock_dbg("memblock: %s is doubled to %ld at [%pa-%pa]",
> > > +			type->name, type->max * 2, &addr, &new_end);
> > 
> > I didn't get to check this carefully but this surely looks suspicious. I
> > am pretty sure you wanted to print the value here rather than address of
> > the local variable, right?
> 
> It's the semantics of %pa:
> 
> Physical address types phys_addr_t
> ----------------------------------
> 
> ::
> 
> 	%pa[p]	0x01234567 or 0x0123456789abcdef
> 
> For printing a phys_addr_t type (and its derivatives, such as
> resource_size_t) which can vary based on build options, regardless of the
> width of the CPU data path.
> 
> Passed by reference.

I wasn't aware of that. Thanks for the clarification!

-- 
Michal Hocko
SUSE Labs
