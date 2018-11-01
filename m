Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52862C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28BC20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28BC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeKBCNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:13:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeKBCNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:13:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB3DBAE61;
        Thu,  1 Nov 2018 17:09:49 +0000 (UTC)
Date:   Thu, 1 Nov 2018 18:09:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     miles.chen@mediatek.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
Message-ID: <20181101170948.GN23921@dhcp22.suse.cz>
References: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-11-18 01:00:07, miles.chen@mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> The page owner read might allocate a large size of memory with
> a large read count. Allocation fails can easily occur when doing
> high order allocations.
> 
> Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation
> and avoid allocation fails due to high order allocation.

It is good to mention that interface is root only so the harm due to
unbounded allocation request is somehow reduced.

I believe we want to use seq_file infrastructure in the long term
solution.
 
> Change since v3:
>   - remove the change in kvmalloc
>   - keep kmalloc in page_owner.c
> 
> Change since v2:
>   - improve kvmalloc, allow sub page allocations fallback to
>     vmalloc when CONFIG_HIGHMEM=y
> 
> Change since v1:
>   - use kvmalloc()
>   - clamp buffer size to PAGE_SIZE
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/page_owner.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 87bc0dfdb52b..b83f295e4eca 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -351,6 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		.skip = 0
>  	};
>  
> +	count = count > PAGE_SIZE ? PAGE_SIZE : count;
>  	kbuf = kmalloc(count, GFP_KERNEL);
>  	if (!kbuf)
>  		return -ENOMEM;
> -- 
> 2.18.0
> 

-- 
Michal Hocko
SUSE Labs
