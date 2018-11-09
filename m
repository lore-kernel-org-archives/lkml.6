Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD09C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A35E20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A35E20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeKJGvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:51:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJGvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:51:18 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 94221B5D;
        Fri,  9 Nov 2018 21:08:58 +0000 (UTC)
Date:   Fri, 9 Nov 2018 13:08:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     hughd@google.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mhocko@suse.com, rppt@linux.vnet.ibm.com,
        imbrenda@linux.vnet.ibm.com, corbet@lwn.net,
        ndesaulniers@google.com, dave.jiang@intel.com, jglisse@redhat.com,
        jia.he@hxt-semitech.com, paulmck@linux.vnet.ibm.com,
        colin.king@canonical.com, jiang.biao2@zte.com.cn,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ksm: Assist buddy allocator to assemble 1-order
 pages
Message-Id: <20181109130857.54a1f383629e771b4f3888c4@linux-foundation.org>
In-Reply-To: <153995241537.4096.15189862239521235797.stgit@localhost.localdomain>
References: <153995241537.4096.15189862239521235797.stgit@localhost.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 15:33:39 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> v3: Comment improvements.
> v2: Style improvements.
> 
> try_to_merge_two_pages() merges two pages, one of them
> is a page of currently scanned mm, the second is a page
> with identical hash from unstable tree. Currently, we
> merge the page from unstable tree into the first one,
> and then free it.
> 
> The idea of this patch is to prefer freeing that page
> of them, which has a free neighbour (i.e., neighbour
> with zero page_count()). This allows buddy allocator
> to assemble at least 1-order set from the freed page
> and its neighbour; this is a kind of cheep passive
> compaction.
> 
> AFAIK, 1-order pages set consists of pages with PFNs
> [2n, 2n+1] (odd, even), so the neighbour's pfn is
> calculated via XOR with 1. We check the result pfn
> is valid and its page_count(), and prefer merging
> into @tree_page if neighbour's usage count is zero.
> 
> There a is small difference with current behavior
> in case of error path. In case of the second
> try_to_merge_with_ksm_page() is failed, we return
> from try_to_merge_two_pages() with @tree_page
> removed from unstable tree. It does not seem to matter,
> but if we do not want a change at all, it's not
> a problem to move remove_rmap_item_from_tree() from
> try_to_merge_with_ksm_page() to its callers.
>

Seems sensible.

> 
> ...
>
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1321,6 +1321,23 @@ static struct page *try_to_merge_two_pages(struct rmap_item *rmap_item,
>  {
>  	int err;
>  
> +	if (IS_ENABLED(CONFIG_COMPACTION)) {
> +		unsigned long pfn;
> +
> +		/*
> +		 * Find neighbour of @page containing 1-order pair in buddy
> +		 * allocator and check whether its count is 0. If so, we
> +		 * consider the neighbour as a free page (this is more
> +		 * probable than it's freezed via page_ref_freeze()), and
> +		 * we try to use @tree_page as ksm page and to free @page.
> +		 */
> +		pfn = page_to_pfn(page) ^ 1;
> +		if (pfn_valid(pfn) && page_count(pfn_to_page(pfn)) == 0) {
> +			swap(rmap_item, tree_rmap_item);
> +			swap(page, tree_page);
> +		}
> +	}
> +

A few thoughts

- if tree_page's neighbor is unused, there was no point in doing this
  swapping?

- if both *page and *tree_page have unused neighbors we could go
  further and look for an opportunity to create an order-2 page. 
  etcetera.  This may b excessive ;)

- are we really sure that this optimization causes desirable results?
  If we always merge from one tree into the other, we maximise the
  opportunities for page coalescing in the long term.  But if we
  sometimes merge one way and sometimes merge the other way, we might
  end up with less higher-order page coalescing?  Or am I confusing
  myself?

