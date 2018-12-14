Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DE6C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E14320879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544777394;
	bh=IHTYE/KnkUzg1Ld604hsTP/Tocm0gG2AYPJ/RHXYDsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EBfAOsGoarnq8pmMnvAsAz6Ai8BFFygzOaCV1yN0s/FPzPuSAqvrpprJyVnXgicvO
	 FPBlpHCZUwxavWWWGYai2jZLL1xE0oJvGg3osnB4JoIaoqERWptCCIj0DaVtQxDoka
	 GdEtE1zMCe80NyYq01dLeZnAYnM+RJCgcQzg8rDY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E14320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeLNItx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:49:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:40252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeLNItw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:49:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B023AD02;
        Fri, 14 Dec 2018 08:49:50 +0000 (UTC)
Date:   Fri, 14 Dec 2018 09:49:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Liu Bo <bo.liu@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH v3] mm, memcg: fix reclaim deadlock with writeback
Message-ID: <20181214084948.GA5624@dhcp22.suse.cz>
References: <20181212155055.1269-1-mhocko@kernel.org>
 <20181213092221.27270-1-mhocko@kernel.org>
 <20181213220400.GA9829@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213220400.GA9829@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-12-18 17:04:00, Johannes Weiner wrote:
[...]
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

> Just one nit:
> 
> > @@ -2993,6 +2993,17 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
> >  	struct vm_area_struct *vma = vmf->vma;
> >  	vm_fault_t ret;
> >  
> > +	/*
> > +	 * Preallocate pte before we take page_lock because this might lead to
> > +	 * deadlocks for memcg reclaim which waits for pages under writeback.
> > +	 */
> > +	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
> > +		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm, vmf->address);
> > +		if (!vmf->prealloc_pte)
> > +			return VM_FAULT_OOM;
> > +		smp_wmb(); /* See comment in __pte_alloc() */
> > +	}
> 
> Could you be more specific in the deadlock comment? git blame will
> work fine for a while, but it becomes a pain to find corresponding
> patches after stuff gets moved around for years.
> 
> In particular the race diagram between reclaim with a page lock held
> and the fs doing SetPageWriteback batches before kicking off IO would
> be useful directly in the code, IMO.

This?

diff --git a/mm/memory.c b/mm/memory.c
index bb78e90a9b70..ece221e4da6d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2995,7 +2995,18 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 
 	/*
 	 * Preallocate pte before we take page_lock because this might lead to
-	 * deadlocks for memcg reclaim which waits for pages under writeback.
+	 * deadlocks for memcg reclaim which waits for pages under writeback:
+	 * 				lock_page(A)
+	 * 				SetPageWriteback(A)
+	 * 				unlock_page(A)
+	 * lock_page(B)
+	 * 				lock_page(B)
+	 * pte_alloc_pne
+	 *   shrink_page_list
+	 *     wait_on_page_writeback(A)
+	 *     				SetPageWriteback(B)
+	 *     				unlock_page(B)
+	 *     				# flush A, B to clear the writeback
 	 */
 	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
 		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm, vmf->address);
-- 
Michal Hocko
SUSE Labs
