Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B2C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014452054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014452054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbeJ2Qym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:54:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbeJ2Qym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:54:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20383B00A;
        Mon, 29 Oct 2018 08:07:09 +0000 (UTC)
Date:   Mon, 29 Oct 2018 09:07:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     miles.chen@mediatek.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
Message-ID: <20181029080708.GA32673@dhcp22.suse.cz>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-10-18 13:16:16, miles.chen@mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> The kbuf used by page owner is allocated by kmalloc(), which means it
> can use only normal memory and there might be a "out of memory"
> issue when we're out of normal memory.
> 
> To solve this problem, use kvmalloc() to allocate kbuf
> from normal/highmem. But there is one problem here: kvmalloc()
> does not fallback to vmalloc for sub page allocations. So sub
> page allocation fails due to out of normal memory cannot fallback
> to vmalloc.
> 
> Modify kvmalloc() to allow sub page allocations fallback to
> vmalloc when CONFIG_HIGHMEM=y and use kvmalloc() to allocate
> kbuf.
> 
> Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation.
> 
> Change since v2:
>   - improve kvmalloc, allow sub page allocations fallback to
>     vmalloc when CONFIG_HIGHMEM=y

Matthew has suggested a much more viable way to go around this. We do
not really want to allow an unbound kernel allocation - even if the
interface is root only.

Besides that, the following doesn't make much sense to me. It simply
makes no sense to use vmalloc for sub page allocation regardless of
HIGHMEM.

> diff --git a/mm/util.c b/mm/util.c
> index 8bf08b5b5760..7b1c59b9bfbf 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -416,10 +416,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  	ret = kmalloc_node(size, kmalloc_flags, node);
>  
>  	/*
> -	 * It doesn't really make sense to fallback to vmalloc for sub page
> -	 * requests
> +	 * It only makes sense to fallback to vmalloc for sub page
> +	 * requests if we might be able to allocate highmem pages.
>  	 */
> -	if (ret || size <= PAGE_SIZE)
> +	if (ret || (!IS_ENABLED(CONFIG_HIGHMEM) && size <= PAGE_SIZE))
>  		return ret;
>  
>  	return __vmalloc_node_flags_caller(size, node, flags,
> -- 
> 2.18.0
> 

-- 
Michal Hocko
SUSE Labs
