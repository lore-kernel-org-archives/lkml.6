Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38480C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95432086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95432086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeKJEmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:42:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbeKJEmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:42:14 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5CA057A9;
        Fri,  9 Nov 2018 19:00:20 +0000 (UTC)
Date:   Fri, 9 Nov 2018 11:00:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "'Bart Van Assche'" <bvanassche@acm.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        "Darryl T. Agostinelli" <dagostinelli@gmail.com>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
Message-Id: <20181109110019.c82fba8125d4e2891fbe4a6c@linux-foundation.org>
In-Reply-To: <cbc1fc52-dc8c-aa38-8f29-22da8bcd91c1@suse.cz>
References: <20181105204000.129023-1-bvanassche@acm.org>
        <62188a351f2249188ce654ee03c894b1@AcuMS.aculab.com>
        <e44e6c8b-e4e4-e7cb-a5ca-88e9559eb0d7@suse.cz>
        <3c9adab0f1f74c46a60b3d4401030337@AcuMS.aculab.com>
        <60deb90d-e521-39e5-5072-fc9efb98e365@suse.cz>
        <9af3ac1d43bb422cb3c41e7e8e422e6e@AcuMS.aculab.com>
        <cbc1fc52-dc8c-aa38-8f29-22da8bcd91c1@suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 09:12:09 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> Multiple people have reported the following sparse warning:
> 
> ./include/linux/slab.h:332:43: warning: dubious: x & !y
> 
> The minimal fix would be to change the logical & to boolean &&, which emits the
> same code, but Andrew has suggested that the branch-avoiding tricks are maybe
> not worthwile. David Laight provided a nice comparison of disassembly of
> multiple variants, which shows that the current version produces a 4 deep
> dependency chain, and fixing the sparse warning by changing logical and to
> multiplication emits an IMUL, making it even more expensive.
> 
> The code as rewritten by this patch yielded the best disassembly, with a single
> predictable branch for the most common case, and a ternary operator for the
> rest, which gcc seems to compile without a branch or cmov by itself.
> 
> The result should be more readable, without a sparse warning and probably also
> faster for the common case.
> 
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Reported-by: Darryl T. Agostinelli <dagostinelli@gmail.com>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Fixes: 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable caches")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 918f374e7156..18c6920c2803 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -304,6 +304,8 @@ enum kmalloc_cache_type {
>  	KMALLOC_RECLAIM,
>  #ifdef CONFIG_ZONE_DMA
>  	KMALLOC_DMA,
> +#else
> +	KMALLOC_DMA = KMALLOC_NORMAL,
>  #endif
>  	NR_KMALLOC_TYPES
>  };

I don't think this works correctly.  Resetting KMALLOC_DMA to 0 will
cause NR_KMALLOC_TYPES to have value 1.


enum foo {
	a = 0,
	b,
	c = 0,
	d
}

main()
{
	printf("%d %d %d %d\n", a, b, c, d);
}

akpm3> ./a.out
0 1 0 1

