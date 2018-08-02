Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09199C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC23B208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC23B208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeHBILt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:11:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbeHBILs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:11:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 46A3FADF8AC39;
        Thu,  2 Aug 2018 14:22:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 14:22:06 +0800
Message-ID: <5B62A30B.9000008@huawei.com>
Date:   Thu, 2 Aug 2018 14:22:03 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Matthew Wilcox <willy@infradead.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Laura Abbott <labbott@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] A novel case happened when using mempool allocate
 memory.
References: <5B61D243.9050608@huawei.com> <20180801153713.GA4039@bombadil.infradead.org>
In-Reply-To: <20180801153713.GA4039@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/1 23:37, Matthew Wilcox wrote:
> On Wed, Aug 01, 2018 at 11:31:15PM +0800, zhong jiang wrote:
>> Hi,  Everyone
>>
>>  I ran across the following novel case similar to memory leak in linux-4.1 stable when allocating
>>  memory object by kmem_cache_alloc.   it rarely can be reproduced.
>>
>> I create a specific  mempool with 24k size based on the slab.  it can not be merged with
>> other kmem cache.  I  record the allocation and free usage by atomic_add/sub.    After a while,
>> I watch the specific slab consume most of total memory.   After halting the code execution.
>> The counter of allocation and free is equal.  Therefore,  I am sure that module have released
>> all meory resource.  but the statistic of specific slab is very high but stable by checking /proc/slabinfo.
> Please post the code.
>
> .
>

when module is loaded. we create the specific mempool. The code flow is as follows.

mem_pool_create() {

slab_cache = kmem_cache_create(name, item_size, 0, 0 , NULL);

mempoll_create(min_pool_size, mempool_alloc_slab, mempool_free_slab, slab_cache);   //min_pool_size is assigned to 1024
atomic_set(pool->statistics, 0);
}

we allocate memory from specific mempool , The code flow is as follows.

mem_alloc() {
mempool_alloc(pool, gfp_flags);

atomic_inc(pool->statistics);
}

we release memory to specific mempool . The code flow is as follows.
mem_free() {
mempool_free(object_ptr, pool);

atomic_dec(pool->statistics);
}


when we unregister the module,  the memory has been taken up will get back the system.
the code flow is as follows.

mem_pool_destroy() {
 mempool_destroy(pool);
kmem_cache_destroy(slab_cache);
}

From the above information.  I assume the specific kmem_cache will not take up overmuch memory
when halting the execution and pool->statistics is equal to 0.

I have no idea about the issue. 

Thanks
zhong jiang



