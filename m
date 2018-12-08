Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC57C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238D62083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gBZPktyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238D62083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeLHFST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 00:18:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeLHFSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 00:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DV65j/+cvgp6KDKauxvi5l+HnbBz/7Yx70T2JIdtQBM=; b=gBZPktyK4TG6hOLlBFB8InWrV
        FtKbQieoLLb6BqCNkvxY+RCVkUN4Z8RGwRWpQ4wZpAvK2dhAciUvPjuF7MvNaJTlCkc1Qoc4+ZJyQ
        kxIzfAas6VKxq/9Wv7EKWDrQHTWg7YWRcqAc3FBrT9PK6YLzDjervvvMWha4Re1yd3PAApM/l9+PP
        yZlNMrzT87vkHD99X62vfuYRBSYytdGhLNS+KZ+yClEOFFG7W23TRNI0cgiMo0UG+TLiTh/tO3B4Q
        hCK+qtleW27SYQ4BBT4SQTGNB3tYDRTPBvDSJkz54uBKt6OYx9Z/JqRU48JVNWpJTyHqXi2zlua9I
        G2OBCWmSA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVV0E-00040l-JZ; Sat, 08 Dec 2018 05:18:10 +0000
Date:   Fri, 7 Dec 2018 21:18:10 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181208051810.GA24118@bombadil.infradead.org>
References: <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
 <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
 <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:52:42PM -0800, John Hubbard wrote:
> I see. OK, HMM has done an efficient job of mopping up unused fields, and now we are
> completely out of space. At this point, after thinking about it carefully, it seems clear
> that it's time for a single, new field:

Sorry for not replying earlier; I'm travelling and have had trouble
keeping on top of my mail.

Adding this field will grow struct page by 4-8 bytes, so it will no
longer be 64 bytes.  This isn't an acceptable answer.

We have a few options for bits.  One is that we have (iirc) two
bits available in page->flags on 32-bit.  That'll force a few more
configurations into using _last_cpupid and/or page_ext.  I'm not a huge
fan of this approach.

The second is to use page->lru.next bit 1.  This requires some care
because m68k allows misaligned pointers.  If the list_head that it's
joined to is misaligned, we'll be in trouble.  This can get tricky because
some pages are attached to list_heads which are on the stack ... and I
don't think gcc guarantees __aligned attributes work for stack variables.

The third is to use page->lru.prev bit 0.  We'd want to switch pgmap
and hmm_data around to make this work, and we'd want to record this
in mm_types.h so nobody tries to use a field which aliases with
page->lru.prev and has bit 0 set on a page which can be mapped to
userspace (which I currently believe to be true).

The fourth is to use a bit in page->flags for 64-bit and a bit in
page_ext->flags for 32-bit.  Or we could get rid of page_ext and grow
struct page with a ->flags2 on 32-bit.

Fifth, it isn't clear to me how many bits might be left in ->_last_cpupid
at this point, and perhaps there's scope for using a bit in there.

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ed8f6292a53..1c789e324da8 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -182,6 +182,9 @@ struct page {
>         /* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
>         atomic_t _refcount;
>  
> +       /* DMA usage count. See get_user_pages*(), put_user_page*(). */
> +       atomic_t _dma_pinned_count;
> +
>  #ifdef CONFIG_MEMCG
>         struct mem_cgroup *mem_cgroup;
>  #endif
> 
> 
> ...because after all, the reason this is so difficult is that this fix has to work
> in pretty much every configuration. get_user_pages() use is widespread, it's a very
> general facility, and...it needs fixing.  And we're out of space. 
> 
> I'm going to send out an updated RFC that shows the latest, and I think it's going
> to include the above.
> 
> -- 
> thanks,
> John Hubbard
> NVIDIA
> 
