Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E0FC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7672920685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C1egZHW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7672920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeI3TXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 15:23:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbeI3TXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 15:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DjUZGSScEpQLqDmJD+VJ5m38dox3hRnNG/K6lMNqylg=; b=C1egZHW+JU3PUhMXkotpxaxoe
        HsTdy73LUAppDgJP5R7XPXsB6tjZwmkZXU2gkkEFgoU/rxU1DIuzdqrKSdqYTRyP3PWXD65f1gY2x
        hCR/oPGRU/pnD59Sxzf4i7QA+Mf14D0FyE92VPfn/niIB+el2zYKxY/o/VP/sKeWlEaf9bRfKb5PZ
        wTmTaRoqHHNwqkO4rbrDoclRrvfZBeyMWiXrM7utEl+7Nxpj2ezF0cOaqM6G2wLIWajb4psVPhDzx
        XUdCEffa1l8ST8KmbJzan23o1wfI+L8EmydXP0Fr7ErQml7AoutzKDervgj26ose/sM3JFz0iiE0J
        s50K4ToSQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g6bBG-0000vy-Sr; Sun, 30 Sep 2018 12:50:38 +0000
Date:   Sun, 30 Sep 2018 05:50:38 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     gregkh@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, mhocko@kernel.org, mgorman@suse.de,
        vbabka@suse.cz, andrea@kernel.org, kirill@shutemov.name,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [STABLE PATCH] slub: make ->cpu_partial unsigned int
Message-ID: <20180930125038.GA2533@bombadil.infradead.org>
References: <1538303301-61784-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538303301-61784-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 06:28:21PM +0800, zhong jiang wrote:
> From: Alexey Dobriyan <adobriyan@gmail.com>
> 
> [ Upstream commit e5d9998f3e09359b372a037a6ac55ba235d95d57 ]
> 
>         /*
>          * cpu_partial determined the maximum number of objects
>          * kept in the per cpu partial lists of a processor.
>          */
> 
> Can't be negative.
> 
> I hit a real issue that it will result in a large number of memory leak.
> Becuase Freeing slabs are in interrupt context. So it can trigger this issue.
> put_cpu_partial can be interrupted more than once.
> due to a union struct of lru and pobjects in struct page, when other core handles
> page->lru list, for eaxmple, remove_partial in freeing slab code flow, It will
> result in pobjects being a negative value(0xdead0000). Therefore, a large number
> of slabs will be added to per_cpu partial list.
> 
> I had posted the issue to community before. The detailed issue description is as follows.
> 
> https://www.spinics.net/lists/kernel/msg2870979.html
> 
> After applying the patch, The issue is fixed. So the patch is a effective bugfix.
> It should go into stable.
> 
> Link: http://lkml.kernel.org/r/20180305200730.15812-15-adobriyan@gmail.com
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> Acked-by: Christoph Lameter <cl@linux.com>

Hang on.  Christoph acked the _original_ patch going into upstream.
When he reviewed this patch for _stable_ last week, he asked for more
investigation.  Including this patch in stable is misleading.

> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: <stable@vger.kernel.org> # 4.4.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  include/linux/slub_def.h | 3 ++-
>  mm/slub.c                | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 3388511..9b681f2 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -67,7 +67,8 @@ struct kmem_cache {
>  	int size;		/* The size of an object including meta data */
>  	int object_size;	/* The size of an object without meta data */
>  	int offset;		/* Free pointer offset. */
> -	int cpu_partial;	/* Number of per cpu partial objects to keep around */
> +	/* Number of per cpu partial objects to keep around */
> +	unsigned int cpu_partial;
>  	struct kmem_cache_order_objects oo;
>  
>  	/* Allocation and freeing of slabs */
> diff --git a/mm/slub.c b/mm/slub.c
> index 2284c43..c33b0e1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1661,7 +1661,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  {
>  	struct page *page, *page2;
>  	void *object = NULL;
> -	int available = 0;
> +	unsigned int available = 0;
>  	int objects;
>  
>  	/*
> @@ -4674,10 +4674,10 @@ static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
>  static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
>  				 size_t length)
>  {
> -	unsigned long objects;
> +	unsigned int objects;
>  	int err;
>  
> -	err = kstrtoul(buf, 10, &objects);
> +	err = kstrtouint(buf, 10, &objects);
>  	if (err)
>  		return err;
>  	if (objects && !kmem_cache_has_cpu_partial(s))
> -- 
> 1.7.12.4
> 
