Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8EBC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623A721470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623A721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbeJLAkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:40:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:16320 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeJLAkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:40:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 10:12:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="91187730"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2018 10:07:47 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gAeR7-0004lM-Jl; Thu, 11 Oct 2018 20:07:45 +0300
Date:   Thu, 11 Oct 2018 20:07:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, rppt@linux.vnet.ibm.com,
        imbrenda@linux.vnet.ibm.com, corbet@lwn.net,
        ndesaulniers@google.com, dave.jiang@intel.com, jglisse@redhat.com,
        jia.he@hxt-semitech.com, paulmck@linux.vnet.ibm.com,
        colin.king@canonical.com, jiang.biao2@zte.com.cn,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ksm: Assist buddy allocator to assemble 1-order pages
Message-ID: <20181011170745.GN15943@smile.fi.intel.com>
References: <153925511661.21256.9692370932417728663.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153925511661.21256.9692370932417728663.stgit@localhost.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 01:52:22PM +0300, Kirill Tkhai wrote:
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
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/ksm.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 5b0894b45ee5..b83ca37e28f0 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1321,6 +1321,21 @@ static struct page *try_to_merge_two_pages(struct rmap_item *rmap_item,
>  {
>  	int err;
>  
> +	if (IS_ENABLED(CONFIG_COMPACTION)) {
> +		unsigned long pfn;

+ blank line?

> +		/*
> +		 * Find neighbour of @page containing 1-order pair
> +		 * in buddy-allocator and check whether it is free.
> +		 * If it is so, try to use @tree_page as ksm page
> +		 * and to free @page.
> +		 */
> +		pfn = (page_to_pfn(page) ^ 1);

Parens are not needed.


> +		if (pfn_valid(pfn) && page_count(pfn_to_page(pfn)) == 0) {
> +			swap(rmap_item, tree_rmap_item);
> +			swap(page, tree_page);
> +		}
> +	}
> +
>  	err = try_to_merge_with_ksm_page(rmap_item, page, NULL);
>  	if (!err) {
>  		err = try_to_merge_with_ksm_page(tree_rmap_item,
> 

-- 
With Best Regards,
Andy Shevchenko


