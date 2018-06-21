Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE094C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E13320693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PBRyPbYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E13320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbeFUDip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:38:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754157AbeFUDio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jz6InbLPNtLdi9oExyf6Hd0WwaSMbu7MCe0lMz3eOCs=; b=PBRyPbYpHs+kd1G84r/b/zwaD
        2lj6P7LQF1YHjQuxr951Qgd7TrYxMEeuwXisKDkUhLgpx2PKSI9SNfg2nF+6j0dIEl2mRXTU4PGZ5
        slyMwbDbFQPjlI+BW5o2uijPwogCyVnTANS6TgXpdh4GFoJG8AjFvqZVTzMhs2JgCIPllzjYHPWEO
        vEdFu+gcW85hztT9LH/eQ4+Xpq2Nm1ySpWM/RUF6L6HFSvFMl8FvQ8KsdTEb/8s+945RL9LVLzA3j
        GVNKgAUszSt0he9OTuKPAnZR4lVt6W0qwvrB7+QCIyVn+kxuRMbxOZd52Rfdbb17srWjdrof8/wgY
        v8B4K2B8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVqQi-0008G5-5O; Thu, 21 Jun 2018 03:38:40 +0000
Date:   Wed, 20 Jun 2018 20:38:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     akpm@linux-foundation.org, dvyukov@google.com,
        gregkh@linuxfoundation.org, jthumshirn@suse.de,
        pombredanne@nexb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempool: Fix a possible sleep-in-atomic-context bug
 in mempool_resize()
Message-ID: <20180621033839.GB12608@bombadil.infradead.org>
References: <20180621030714.10368-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621030714.10368-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:07:14AM +0800, Jia-Ju Bai wrote:
> The kernel may sleep with holding a spinlock.
> The function call path (from bottom to top) in Linux-4.16.7 is:
> 
> [FUNC] remove_element(GFP_KERNEL)
> mm/mempool.c, 250: remove_element in mempool_resize
> mm/mempool.c, 247: _raw_spin_lock_irqsave in mempool_resize
> 
> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> This bug is found by my static analysis tool (DSAC-2) and checked by
> my code review.

But ... we don't use the flags argument.

static void *remove_element(mempool_t *pool, gfp_t flags)
{
        void *element = pool->elements[--pool->curr_nr];

        BUG_ON(pool->curr_nr < 0);
        kasan_unpoison_element(pool, element, flags);
        check_element(pool, element);
        return element;
}

...

static void kasan_unpoison_element(mempool_t *pool, void *element, gfp_t flags)
{
        if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
                kasan_unpoison_slab(element);
        if (pool->alloc == mempool_alloc_pages)
                kasan_alloc_pages(element, (unsigned long)pool->pool_data);
}

So the correct patch would just remove this argument to remove_element() and
kasan_unpoison_element()?
