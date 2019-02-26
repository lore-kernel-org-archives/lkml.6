Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE70C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADC92184C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfBZCWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 21:22:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbfBZCWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 21:22:42 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 87861A41F452FCD66313;
        Tue, 26 Feb 2019 10:22:39 +0800 (CST)
Received: from [127.0.0.1] (10.184.39.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Feb 2019
 10:22:36 +0800
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
To:     David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com>
 <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
 <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
 <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
 <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
 <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
CC:     <mhocko@kernel.org>, <akpm@linux-foundation.org>,
        <hughd@google.com>, <linux-mm@kvack.org>,
        <n-horiguchi@ah.jp.nec.com>, <aarcange@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5C74A2DA.1030304@huawei.com>
Date:   Tue, 26 Feb 2019 10:22:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/26 3:17, David Rientjes wrote:
> On Mon, 25 Feb 2019, Mike Kravetz wrote:
> 
>> Ok, what about just moving the calculation/check inside the lock as in the
>> untested patch below?
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 34 ++++++++++++++++++++++++++--------
>>  1 file changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 1c5219193b9e..5afa77dc7bc8 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2274,7 +2274,7 @@ static int adjust_pool_surplus(struct hstate *h,
>> nodemask_t *nodes_allowed,
>>  }
>>
>>  #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
>> -static int set_max_huge_pages(struct hstate *h, unsigned long count,
>> +static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>>  						nodemask_t *nodes_allowed)
>>  {
>>  	unsigned long min_count, ret;
>> @@ -2289,6 +2289,23 @@ static int set_max_huge_pages(struct hstate *h, unsigned
>> long count,
>>  		goto decrease_pool;
>>  	}
>>
>> +	spin_lock(&hugetlb_lock);
>> +
>> +	/*
>> +	 * Check for a node specific request.  Adjust global count, but
>> +	 * restrict alloc/free to the specified node.
>> +	 */
>> +	if (nid != NUMA_NO_NODE) {
>> +		unsigned long old_count = count;
>> +		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
>> +		/*
>> +		 * If user specified count causes overflow, set to
>> +		 * largest possible value.
>> +		 */
>> +		if (count < old_count)
>> +			count = ULONG_MAX;
>> +	}
>> +
>>  	/*
>>  	 * Increase the pool size
>>  	 * First take pages out of surplus state.  Then make up the
>> @@ -2300,7 +2317,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned
>> long count,
>>  	 * pool might be one hugepage larger than it needs to be, but
>>  	 * within all the constraints specified by the sysctls.
>>  	 */
>> -	spin_lock(&hugetlb_lock);
>>  	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
>>  		if (!adjust_pool_surplus(h, nodes_allowed, -1))
>>  			break;
>> @@ -2421,16 +2437,18 @@ static ssize_t __nr_hugepages_store_common(bool
>> obey_mempolicy,
>>  			nodes_allowed = &node_states[N_MEMORY];
>>  		}
>>  	} else if (nodes_allowed) {
>> +		/* Node specific request */
>> +		init_nodemask_of_node(nodes_allowed, nid);
>> +	} else {
>>  		/*
>> -		 * per node hstate attribute: adjust count to global,
>> -		 * but restrict alloc/free to the specified node.
>> +		 * Node specific request, but we could not allocate
>> +		 * node mask.  Pass in ALL nodes, and clear nid.
>>  		 */
>> -		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
>> -		init_nodemask_of_node(nodes_allowed, nid);
>> -	} else
>> +		nid = NUMA_NO_NODE;
>>  		nodes_allowed = &node_states[N_MEMORY];
>> +	}
>>
>> -	err = set_max_huge_pages(h, count, nodes_allowed);
>> +	err = set_max_huge_pages(h, count, nid, nodes_allowed);
>>  	if (err)
>>  		goto out;
>>
> 
> Looks good; Jing, could you test that this fixes your case?

Yes, I have tested this patch, it can also fix my case.
> 
> .
> 


