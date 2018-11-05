Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839D6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA922084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA922084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbeKFGen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:34:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39402 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:34:42 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C284C5A8;
        Mon,  5 Nov 2018 21:13:06 +0000 (UTC)
Date:   Mon, 5 Nov 2018 13:13:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
Message-Id: <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
In-Reply-To: <20181105204000.129023-1-bvanassche@acm.org>
References: <20181105204000.129023-1-bvanassche@acm.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 12:40:00 -0800 Bart Van Assche <bvanassche@acm.org> wrote:

> This patch suppresses the following sparse warning:
> 
> ./include/linux/slab.h:332:43: warning: dubious: x & !y
> 
> ...
>
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -329,7 +329,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
>  	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
>  	 */
> -	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
> +	return type_dma + is_reclaimable * !is_dma * KMALLOC_RECLAIM;
>  }
>  
>  /*

I suppose so.

That function seems too clever for its own good :(.  I wonder if these
branch-avoiding tricks are really worthwhile.

