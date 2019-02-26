Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A5C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0595A218E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220585;
	bh=n9ECPZi5x5DO0MxV6LWX8MS1dTaTSyQ6aEGknFohE3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZSylIrCxRwV4/XIT0yze2wyRltObNjZwRZLHSho/jJiMmgcaULh//pHX9NsK6fgW/
	 JFGy2pgLJ49Si96pLZsWpJZJhmY6dBXIGCxl5zwHAH40f8iH5o2XFJITAbOtFGTMvC
	 ebuAGDizGBomwiBLJJEhBMmdKh6ticPL7HHzSe/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfBZWgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:36:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbfBZWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:36:23 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ACC427B88;
        Tue, 26 Feb 2019 22:36:21 +0000 (UTC)
Date:   Tue, 26 Feb 2019 14:36:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Rientjes <rientjes@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>, mhocko@kernel.org,
        hughd@google.com, linux-mm@kvack.org, n-horiguchi@ah.jp.nec.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
Message-Id: <20190226143620.c6af15c7c897d3362b191e36@linux-foundation.org>
In-Reply-To: <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com>
        <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
        <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
        <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
        <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
        <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
        <5C74A2DA.1030304@huawei.com>
        <alpine.DEB.2.21.1902252220310.40851@chino.kir.corp.google.com>
        <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The number of node specific huge pages can be set via a file such as:
> /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
> When a node specific value is specified, the global number of huge
> pages must also be adjusted.  This adjustment is calculated as the
> specified node specific value + (global value - current node value).
> If the node specific value provided by the user is large enough, this
> calculation could overflow an unsigned long leading to a smaller
> than expected number of huge pages.
> 
> To fix, check the calculation for overflow.  If overflow is detected,
> use ULONG_MAX as the requested value.  This is inline with the user
> request to allocate as many huge pages as possible.
> 
> It was also noticed that the above calculation was done outside the
> hugetlb_lock.  Therefore, the values could be inconsistent and result
> in underflow.  To fix, the calculation is moved to within the routine
> set_max_huge_pages() where the lock is held.
> 
> ...
>
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2274,7 +2274,7 @@ static int adjust_pool_surplus(struct hstate *h,
> nodemask_t *nodes_allowed,

Please tweak that email client to prevent the wordwraps.

> +	/*
> +	 * Check for a node specific request.  Adjust global count, but
> +	 * restrict alloc/free to the specified node.
> +	 */
> +	if (nid != NUMA_NO_NODE) {
> +		unsigned long old_count = count;
> +		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> +		/*
> +		 * If user specified count causes overflow, set to
> +		 * largest possible value.
> +		 */
> +		if (count < old_count)
> +			count = ULONG_MAX;
> +	}

The above two comments explain the code, but do not reveal the
reasoning behind the policy decisions which that code implements.

> ...
>
> +	} else {
>  		/*
> -		 * per node hstate attribute: adjust count to global,
> -		 * but restrict alloc/free to the specified node.
> +		 * Node specific request, but we could not allocate
> +		 * node mask.  Pass in ALL nodes, and clear nid.
>  		 */

Ditto here, somewhat.

The old mantra: comments should explain "why", not "what".  Reading the
code tells us the "what".

Thanks.
