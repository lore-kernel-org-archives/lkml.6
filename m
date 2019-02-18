Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC726C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCE221738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550482076;
	bh=uJf+d6intHJ/cfNnlgVy5Y+2/XBVKmch7DHaaCo9KVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fkjAFUjgvwhXzFn1vczDl/oTosY3rdXa1qWu1PGBUQpJ2fY3vH0a9ZlKFg0MvTmE+
	 w9ig1GTg/frnX4bbNzlXGsa3LGgWeSQnFeSz4UUbrTyeu2gtr6eXMKSk9S6SQovACT
	 sdvIRipX/meqtxtzgb2M/McN/Bwdrg5hjBvplZGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfBRJ1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:27:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:57574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728447AbfBRJ1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:27:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76101AF56;
        Mon, 18 Feb 2019 09:27:52 +0000 (UTC)
Date:   Mon, 18 Feb 2019 10:27:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jingxiangfeng <jingxiangfeng@huawei.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
Message-ID: <20190218092750.GF4525@dhcp22.suse.cz>
References: <1550323872-119049-1-git-send-email-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550323872-119049-1-git-send-email-jingxiangfeng@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 16-02-19 21:31:12, Jingxiangfeng wrote:
> From: Jing Xiangfeng <jingxiangfeng@huawei.com>
> 
> We can use the following command to dynamically allocate huge pages:
> 	echo NR_HUGEPAGES > /proc/sys/vm/nr_hugepages
> The count in  __nr_hugepages_store_common() is parsed from /proc/sys/vm/nr_hugepages,
> The maximum number of count is ULONG_MAX,
> the operation 'count += h->nr_huge_pages - h->nr_huge_pages_node[nid]' overflow and count will be a wrong number.

Could you be more specific of what is the runtime effect on the
overflow? I haven't checked closer but I would assume that we will
simply shrink the pool size because count will become a small number.

Is there any reason to report an error in that case? We do not report
errors when we cannot allocate the requested number of huge pages so why
is this case any different?

> So check the overflow to fix this problem.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  mm/hugetlb.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index afef616..55173c3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2423,7 +2423,12 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  		 * per node hstate attribute: adjust count to global,
>  		 * but restrict alloc/free to the specified node.
>  		 */
> +		unsigned long old_count = count;
>  		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> +		if (count < old_count) {
> +			err = -EINVAL;
> +			goto out;
> +		}
>  		init_nodemask_of_node(nodes_allowed, nid);
>  	} else
>  		nodes_allowed = &node_states[N_MEMORY];
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
