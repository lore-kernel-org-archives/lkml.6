Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFBF160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9008920870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PN7/UBaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9008920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeG3RO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:14:27 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:51356 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbeG3RO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1532965134;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=oo7GGMffmAEmf/lnUhdZCphNmPvwdr62jem/OMa8y3g=;
        b=PN7/UBaqLKd1I3YzSWFBIFvvGukc9FVI8ImmI/fi8j0yUa/TgFrMHteMGJty5ioU
        obEMK6xSat7+d30/PfyayzlPGOleO944xOTAshHurlIpwuf/0hxYY5RDdOOqA1mzLRx
        nD+cXwMU0kF3t0UI4RFKgvYfkXtSbUvIVPO1SZiE=
Date:   Mon, 30 Jul 2018 15:38:54 +0000
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
Subject: Re: [PATCH v3 1/7] mm, slab: combine kmalloc_caches and
 kmalloc_dma_caches
In-Reply-To: <20180718133620.6205-2-vbabka@suse.cz>
Message-ID: <01000164ebd7a137-093f1337-e0b0-4ea9-81dd-2e37b6adadb9-000000@email.amazonses.com>
References: <20180718133620.6205-1-vbabka@suse.cz> <20180718133620.6205-2-vbabka@suse.cz>
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

> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -295,12 +295,28 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
>  #define SLAB_OBJ_MIN_SIZE      (KMALLOC_MIN_SIZE < 16 ? \
>                                 (KMALLOC_MIN_SIZE) : 16)
>
> +#define KMALLOC_NORMAL	0
> +#ifdef CONFIG_ZONE_DMA
> +#define KMALLOC_DMA	1
> +#define KMALLOC_TYPES	2
> +#else
> +#define KMALLOC_TYPES	1
> +#endif

An emum would be better here I think.

But the patch is ok

Acked-by: Christoph Lameter <cl@linux.com>
