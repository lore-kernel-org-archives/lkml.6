Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DFEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE3F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeKAT01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:26:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:57754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727880AbeKAT01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:26:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7F1CAA7C;
        Thu,  1 Nov 2018 10:24:05 +0000 (UTC)
Date:   Thu, 1 Nov 2018 11:24:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2] mm/kvmalloc: do not call kmalloc for size >
 KMALLOC_MAX_SIZE
Message-ID: <20181101102405.GE23921@dhcp22.suse.cz>
References: <154106356066.887821.4649178319705436373.stgit@buzz>
 <154106695670.898059.5301435081426064314.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154106695670.898059.5301435081426064314.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-11-18 13:09:16, Konstantin Khlebnikov wrote:
> Allocations over KMALLOC_MAX_SIZE could be served only by vmalloc.

I would go on and say that allocations with sizes too large can actually
trigger a warning (once you have posted in the previous version outside
of the changelog area) because that might be interesting to people -
there are deployments to panic on warning and then a warning is much
more important.

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/util.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 8bf08b5b5760..f5f04fa22814 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -392,6 +392,9 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  	gfp_t kmalloc_flags = flags;
>  	void *ret;
>  
> +	if (size > KMALLOC_MAX_SIZE)
> +		goto fallback;
> +
>  	/*
>  	 * vmalloc uses GFP_KERNEL for some internal allocations (e.g page tables)
>  	 * so the given set of flags has to be compatible.
> @@ -422,6 +425,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  	if (ret || size <= PAGE_SIZE)
>  		return ret;
>  
> +fallback:
>  	return __vmalloc_node_flags_caller(size, node, flags,
>  			__builtin_return_address(0));
>  }
> 

-- 
Michal Hocko
SUSE Labs
