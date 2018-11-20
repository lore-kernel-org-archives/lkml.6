Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D48C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEB8208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEB8208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeKTMpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:45:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbeKTMpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:45:03 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 66F0CE3842D95;
        Tue, 20 Nov 2018 10:18:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 10:18:17 +0800
Message-ID: <5BF36EE9.9090808@huawei.com>
Date:   Tue, 20 Nov 2018 10:18:17 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Wengang Wang <wen.gang.wang@oracle.com>
CC:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: use this_cpu_cmpxchg_double in put_cpu_partial
References: <20181117013335.32220-1-wen.gang.wang@oracle.com>
In-Reply-To: <20181117013335.32220-1-wen.gang.wang@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/17 9:33, Wengang Wang wrote:
> The this_cpu_cmpxchg makes the do-while loop pass as long as the
> s->cpu_slab->partial as the same value. It doesn't care what happened to
> that slab. Interrupt is not disabled, and new alloc/free can happen in the
> interrupt handlers. Theoretically, after we have a reference to the it,
> stored in _oldpage_, the first slab on the partial list on this CPU can be
> moved to kmem_cache_node and then moved to different kmem_cache_cpu and
> then somehow can be added back as head to partial list of current
> kmem_cache_cpu, though that is a very rare case. If that rare case really
> happened, the reading of oldpage->pobjects may get a 0xdead0000
> unexpectedly, stored in _pobjects_, if the reading happens just after
> another CPU removed the slab from kmem_cache_node, setting lru.prev to
> LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
> prevents slabs from being moved to kmem_cache_node and being finally freed.
>
> We see in a vmcore, there are 375210 slabs kept in the partial list of one
> kmem_cache_cpu, but only 305 in-use objects in the same list for
> kmalloc-2048 cache. We see negative values for page.pobjects, the last page
> with negative _pobjects_ has the value of 0xdead0004, the next page looks
> good (_pobjects is 1).
>
> For the fix, I wanted to call this_cpu_cmpxchg_double with
> oldpage->pobjects, but failed due to size difference between
> oldpage->pobjects and cpu_slab->partial. So I changed to call
> this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
> happen in between, but just want to make sure the first slab did expereince
> a remove and re-add. This patch is more to call for ideas.
Have you hit the really issue or just review the code ?

I did hit the issue and fixed in the upstream patch unpredictably by the following patch.
e5d9998f3e09 ("slub: make ->cpu_partial unsigned int")

Thanks,
zhong jiang
> Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
> ---
>  mm/slub.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index e3629cd..26539e6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2248,6 +2248,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>  {
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	struct page *oldpage;
> +	unsigned long tid;
>  	int pages;
>  	int pobjects;
>  
> @@ -2255,8 +2256,12 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>  	do {
>  		pages = 0;
>  		pobjects = 0;
> -		oldpage = this_cpu_read(s->cpu_slab->partial);
>  
> +		tid = this_cpu_read(s->cpu_slab->tid);
> +		/* read tid before reading oldpage */
> +		barrier();
> +
> +		oldpage = this_cpu_read(s->cpu_slab->partial);
>  		if (oldpage) {
>  			pobjects = oldpage->pobjects;
>  			pages = oldpage->pages;
> @@ -2283,8 +2288,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
>  		page->pobjects = pobjects;
>  		page->next = oldpage;
>  
> -	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
> -								!= oldpage);
> +		/* we dont' change tid, but want to make sure it didn't change
> +		 * in between. We don't really hope alloc/free not happen on
> +		 * this CPU, but don't want the first slab be removed from and
> +		 * then re-added as head to this partial list. If that case
> +		 * happened, pobjects may read 0xdead0000 when this slab is just
> +		 * removed from kmem_cache_node by other CPU setting lru.prev
> +		 * to LIST_POISON2.
> +		 */
> +	} while (this_cpu_cmpxchg_double(s->cpu_slab->partial, s->cpu_slab->tid,
> +					 oldpage, tid, page, tid) == 0);
> +
>  	if (unlikely(!s->cpu_partial)) {
>  		unsigned long flags;
>  


