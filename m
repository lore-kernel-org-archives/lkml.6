Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4395EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1419E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbfAKPJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:09:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389239AbfAKPI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:08:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8AE619D00C;
        Fri, 11 Jan 2019 15:08:56 +0000 (UTC)
Received: from redhat.com (ovpn-125-134.rdu2.redhat.com [10.10.125.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F11BE381A9;
        Fri, 11 Jan 2019 15:08:55 +0000 (UTC)
Date:   Fri, 11 Jan 2019 10:08:53 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with Linus'
 tree
Message-ID: <20190111150852.GA3190@redhat.com>
References: <20190111135100.487a1896@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190111135100.487a1896@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 11 Jan 2019 15:08:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:51:00PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm-current tree got a conflict in:
> 
>   mm/rmap.c
> 
> between commit:
> 
>   ba422731316d ("mm/mmu_notifier: mm/rmap.c: Fix a mmu_notifier range bug in try_to_unmap_one")
> 
> from Linus' tree and commit:
> 
>   f955d5dda846 ("mm/mmu_notifier: contextual information for event triggering invalidation v2")
> 
> from the akpm-current tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This looks good to me.

Thank you,
Jérôme

> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc mm/rmap.c
> index 0454ecc29537,62e47f3462cf..000000000000
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@@ -1371,9 -1372,10 +1372,10 @@@ static bool try_to_unmap_one(struct pag
>   	 * Note that the page can not be free in this function as call of
>   	 * try_to_unmap() must hold a reference on the page.
>   	 */
>  -	mmu_notifier_range_init(&range, vma->vm_mm, vma->vm_start,
>  -				min(vma->vm_end, vma->vm_start +
>  +	mmu_notifier_range_init(&range, vma->vm_mm, address,
>  +				min(vma->vm_end, address +
> - 				    (PAGE_SIZE << compound_order(page))));
> + 				    (PAGE_SIZE << compound_order(page))),
> + 				MMU_NOTIFY_CLEAR);
>   	if (PageHuge(page)) {
>   		/*
>   		 * If sharing is possible, start and end will be adjusted


