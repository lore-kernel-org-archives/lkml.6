Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96119C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BF120835
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BF120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeLLXzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:55:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43322 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeLLXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:55:39 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4E0DB55;
        Wed, 12 Dec 2018 23:55:37 +0000 (UTC)
Date:   Wed, 12 Dec 2018 15:55:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH][v6] filemap: drop the mmap_sem for all blocking
 operations
Message-Id: <20181212155536.5fb770a0c9b4f2399d4794e4@linux-foundation.org>
In-Reply-To: <20181212152757.10017-1-josef@toxicpanda.com>
References: <20181211173801.29535-4-josef@toxicpanda.com>
        <20181212152757.10017-1-josef@toxicpanda.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 10:27:57 -0500 Josef Bacik <josef@toxicpanda.com> wrote:

> v5->v6:
> - added more comments as per Andrew's suggestion.
> - fixed the fpin leaks in the two error paths that were pointed out.
> 

hm,

> --- a/mm/filemap.c~filemap-drop-the-mmap_sem-for-all-blocking-operations-v6
> +++ a/mm/filemap.c
> @@ -2461,7 +2476,8 @@ static struct file *do_sync_mmap_readahe
>  
>  /*
>   * Asynchronous readahead happens when we find the page and PG_readahead,
> - * so we want to possibly extend the readahead further..
> + * so we want to possibly extend the readahead further.  We return the file that
> + * was pinned if we have to drop the mmap_sem in order to do IO.
>   */
>  static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  					    struct page *page)
> @@ -2545,14 +2561,15 @@ retry_find:
>  		page = pagecache_get_page(mapping, offset,
>  					  FGP_CREAT|FGP_FOR_MMAP,
>  					  vmf->gfp_mask);
> -		if (!page)
> +		if (!page) {
> +			if (fpin)
> +				goto out_retry;

Is this right?  If pagecache_get_page() returns NULL we can now return
VM_FAULT_MAJOR|VM_FAULT_RETRY whereas we used to return ENOMEM.

>  			return vmf_error(-ENOMEM);
> +		}
>  	}
>  
> -	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin)) {
> -		put_page(page);
> -		return ret | VM_FAULT_RETRY;
> -	}
> +	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
> +		goto out_retry;
>  
>  	/* Did it get truncated? */
>  	if (unlikely(page->mapping != mapping)) {

