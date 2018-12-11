Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ABFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27BF2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545318;
	bh=NrEDMK7QXC1BmTMt1j8ftf4jKBF1tGWEiFNPkdJfJ34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U33EzavG6pqla0S4+uIUFVk7ks27ZYPjfKRHq2xh3YFT20eUIB849Y2fNhU+D+sz+
	 gt0SHNKYcZvgzlmCLZNaDsjcRzBj3a4tVDDIVqA9prh2cZswWCmWxUl9q6wB7DgMrV
	 rhH/wI5wTytye1YKtgJ8RACTkCfbkSbxSVuEVx34=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27BF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbeLKQVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:21:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:42124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727062AbeLKQVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:21:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF727B0AD;
        Tue, 11 Dec 2018 16:21:51 +0000 (UTC)
Date:   Tue, 11 Dec 2018 17:21:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liu Bo <bo.liu@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, memcg: fix reclaim deadlock with writeback
Message-ID: <20181211162149.GL1286@dhcp22.suse.cz>
References: <20181211132645.31053-1-mhocko@kernel.org>
 <20181211151542.2rjti4glj75honje@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211151542.2rjti4glj75honje@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-12-18 18:15:42, Kirill A. Shutemov wrote:
> On Tue, Dec 11, 2018 at 02:26:45PM +0100, Michal Hocko wrote:
[...]
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2993,6 +2993,17 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
> >  	struct vm_area_struct *vma = vmf->vma;
> >  	vm_fault_t ret;
> >  
> > +	/*
> > +	 * Preallocate pte before we take page_lock because this might lead to
> > +	 * deadlocks for memcg reclaim which waits for pages under writeback.
> > +	 */
> > +	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
> > +		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm>mm, vmf->address);
> > +		if (!vmf->prealloc_pte)
> > +			return VM_FAULT_OOM;
> > +		smp_wmb(); /* See comment in __pte_alloc() */
> > +	}
> > +
> >  	ret = vma->vm_ops->fault(vmf);
> >  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
> >  			    VM_FAULT_DONE_COW)))
> 
> Sorry, but I don't think it fixes anything. Just hides it a level deeper.
> 
> The trick with ->prealloc_pte works for faultaround because we can rely on
> ->map_pages() to not sleep and we know how it will setup page table entry.
> Basically, core controls most of the path.
> 
> It's not the case with ->fault(). It is free to sleep and allocate
> whatever it wants.

Yeah, but if the fault callback wants to allocate then it has to
consider the usual allocation restrictions. e.g. NOFS if the allocation
itself can trip over fs locks.

> For instance, DAX page fault will setup page table entry on its own and
> return VM_FAULT_NOPAGE. It uses vmf_insert_mixed() to setup the page table
> and ignores your pre-allocated page table.

Does this happen with a page locked and with __GFP_ACCOUNT allocation. I
am not familiar with that code but I do not see it from a quick look.
 
> But it's just an example. The problem is that ->fault() is not bounded on
> what it can do, unlike ->map_pages().

That is a fair point but the primary issue here is that the generic #PF
code breaks the underlying assumption and performs
__GFP_ACCOUNT|GFP_KERNEL allocation from within a fs owned locked page.
-- 
Michal Hocko
SUSE Labs
