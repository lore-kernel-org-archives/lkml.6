Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33458160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB68020870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="gQtJeYiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB68020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeG3RRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:17:02 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:53956 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbeG3RRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1532965289;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=mAs/gjO4iO3GBN5sGixa//mEfHrd0S3vx/I8p59mFTo=;
        b=gQtJeYiTHukMn8FrIP33KK1gP6BS6znZytenQq//17Yo0Jiz3Jstk5UIT4Hm/t2l
        yFZWONN8lKIgNHGm+eQdFrOjcbmGn+kMs51vwuKLjYbtYi6cwfH00dvMhZZk/lDDsxM
        whViy+3iYC8zyn0JAzOnBExsZGYvWtqN2MwW6oPc=
Date:   Mon, 30 Jul 2018 15:41:29 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/7] mm, slab/slub: introduce kmalloc-reclaimable
 caches
In-Reply-To: <20180718133620.6205-3-vbabka@suse.cz>
Message-ID: <01000164ebd9fc22-31811702-8b80-46c2-a249-a1960c37ae01-000000@email.amazonses.com>
References: <20180718133620.6205-1-vbabka@suse.cz> <20180718133620.6205-3-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.07.30-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Vlastimil Babka wrote:

> index 4299c59353a1..d89e934e0d8b 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -296,11 +296,12 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
>                                 (KMALLOC_MIN_SIZE) : 16)
>
>  #define KMALLOC_NORMAL	0
> +#define KMALLOC_RECLAIM	1
>  #ifdef CONFIG_ZONE_DMA
> -#define KMALLOC_DMA	1
> -#define KMALLOC_TYPES	2
> +#define KMALLOC_DMA	2
> +#define KMALLOC_TYPES	3
>  #else
> -#define KMALLOC_TYPES	1
> +#define KMALLOC_TYPES	2
>  #endif

I like enums....

Acked-by: Christoph Lameter <cl@linux.com>
