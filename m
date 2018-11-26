Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B82C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4CB20659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L/THcR8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4CB20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeK0ERm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:17:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeK0ERm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YrXLbcsg2XmgU0i/pzSBkwcCVvhKDByXAH1nwf0GKtM=; b=L/THcR8hedacNTIKa/V/x4yZB
        3wTUgJHrSpt+RySQ5++41KVLeoQuxBQAcBn0mWQ8WTpSkElIMsCliFVMtMlN14ay1dXRSirxJlH6f
        LIRKRSIxuwcD8Z9I3294B02ApCUbDZoahv4nX63TkXIqEdfgVm+CBlZG9w5exa3jWapnQNibdedaf
        c88ihTBt5HbZngm7PFpY5/P2isKLUq7fR6hZaOPvvbfwOcQphqlRxRfXxIs7S3OkwBUgHLsoe8pSd
        IFRB2jujEeUj81A9GnSfX2S93oaOT4fC11ayR/DNW86XFPAdXfQz3OIF89G0URjKV+LNZnY38mv8T
        4ZC5+tkMA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRKb1-0001Gs-CM; Mon, 26 Nov 2018 17:22:55 +0000
Date:   Mon, 26 Nov 2018 09:22:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] mm: prototype: rid swapoff of quadratic complexity
Message-ID: <20181126172255.GK3065@bombadil.infradead.org>
References: <20181126165521.19777-1-vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126165521.19777-1-vpillai@digitalocean.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:55:21PM +0000, Vineeth Remanan Pillai wrote:
> +	do {
> +		XA_STATE(xas, &mapping->i_pages, start);
> +		int i;
> +		int entries = 0;
> +		struct page *page;
> +		pgoff_t indices[PAGEVEC_SIZE];
> +		unsigned long end = start + PAGEVEC_SIZE;
>  
> +		rcu_read_lock();
> +		xas_for_each(&xas, page, end) {

I think this is a mistake.  You should probably specify ULONG_MAX for the
end.  Otherwise if there are no swap entries in the first 60kB of the file,
you'll just exit.  That does mean you'll need to check 'entries' for
hitting PAGEVEC_SIZE.

> +			if (xas_retry(&xas, page))
> +				continue;
>  
> +			if (!xa_is_value(page))
> +				continue;
>  
> +			indices[entries++] = xas.xa_index;
> +
> +			if (need_resched()) {
> +				xas_pause(&xas);
> +				cond_resched_rcu();
> +			}
>  		}
> +		rcu_read_unlock();
> +
> +		if (entries == 0)
> +			break;
> +
> +		for (i = 0; i < entries; i++) {
> +			int err = 0;
> +
> +			err = shmem_getpage(inode, indices[i],
> +					    &page, SGP_CACHE);
> +			if (err == 0) {
> +				unlock_page(page);
> +				put_page(page);
> +			}
> +			if (err == -ENOMEM)
> +				goto out;
> +			else
> +				error = err;
> +		}
> +		start = xas.xa_index;
> +	} while (true);
> +
> +out:
>  	return error;
>  }

This seems terribly complicated.  You run through i_pages, record the
indices of the swap entries, then go back and look them up again by
calling shmem_getpage() which calls the incredibly complex 300 line
shmem_getpage_gfp().

Can we refactor shmem_getpage_gfp() to skip some of the checks which
aren't necessary when called from this path, and turn this into a nice
simple xas_for_each() loop which works one entry at a time?

>  /*
> - * Search through swapped inodes to find and replace swap by page.
> + * Read all the shared memory data that resides in the swap
> + * device 'type' back into memory, so the swap device can be
> + * unused.
>   */
> -int shmem_unuse(swp_entry_t swap, struct page *page)
> +int shmem_unuse(unsigned int type)
>  {
> -	struct list_head *this, *next;
>  	struct shmem_inode_info *info;
> -	struct mem_cgroup *memcg;
> +	struct inode *inode;
> +	struct inode *prev_inode = NULL;
> +	struct list_head *p;
> +	struct list_head *next;
>  	int error = 0;
>  
> -	/*
> -	 * There's a faint possibility that swap page was replaced before
> -	 * caller locked it: caller will come back later with the right page.
> -	 */
> -	if (unlikely(!PageSwapCache(page) || page_private(page) != swap.val))
> -		goto out;
> +	if (list_empty(&shmem_swaplist))
> +		return 0;
> +
> +	mutex_lock(&shmem_swaplist_mutex);
> +	p = &shmem_swaplist;
>  
>  	/*
> -	 * Charge page using GFP_KERNEL while we can wait, before taking
> -	 * the shmem_swaplist_mutex which might hold up shmem_writepage().
> -	 * Charged back to the user (not to caller) when swap account is used.
> +	 * The extra refcount on the inode is necessary to safely dereference
> +	 * p->next after re-acquiring the lock. New shmem inodes with swap
> +	 * get added to the end of the list and we will scan them all.
>  	 */
> -	error = mem_cgroup_try_charge_delay(page, current->mm, GFP_KERNEL,
> -					    &memcg, false);
> -	if (error)
> -		goto out;
> -	/* No memory allocation: swap entry occupies the slot for the page */
> -	error = -EAGAIN;
> +	list_for_each_safe(p, next, &shmem_swaplist) {
> +		info = list_entry(p, struct shmem_inode_info, swaplist);

This could use list_for_each_entry_safe(), right?

