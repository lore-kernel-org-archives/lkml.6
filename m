Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89007C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC52085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FC52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbeKFTcv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:32:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:53788 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387480AbeKFTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:32:51 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id uk-mta-5-pdxC1B2ZMQ-NsC89g71rTA-1;
 Tue, 06 Nov 2018 10:08:20 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 6 Nov 2018 10:08:26 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 6 Nov 2018 10:08:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bart Van Assche' <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Christoph Lameter" <cl@linux.com>, Roman Gushchin <guro@fb.com>
Subject: RE: [PATCH] slab.h: Avoid using & for logical and of booleans
Thread-Topic: [PATCH] slab.h: Avoid using & for logical and of booleans
Thread-Index: AQHUdUfJjxPqMWIPVkCDxWbeIJk+/6VCg0ZQ
Date:   Tue, 6 Nov 2018 10:08:26 +0000
Message-ID: <62188a351f2249188ce654ee03c894b1@AcuMS.aculab.com>
References: <20181105204000.129023-1-bvanassche@acm.org>
In-Reply-To: <20181105204000.129023-1-bvanassche@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: pdxC1B2ZMQ-NsC89g71rTA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche
> Sent: 05 November 2018 20:40
> 
> This patch suppresses the following sparse warning:
> 
> ./include/linux/slab.h:332:43: warning: dubious: x & !y
> 
> Fixes: 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable caches")
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 918f374e7156..97d0599ddb7b 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -329,7 +329,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
>  	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
>  	 */
> -	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
> +	return type_dma + is_reclaimable * !is_dma * KMALLOC_RECLAIM;

ISTM that changing is_dma and is_reclaimable from int to bool will stop the bleating.

It is also strange that this code is trying so hard here to avoid conditional instructions
and then uses several to generate the boolean values in the first place.

OTOH I'd probably write:
	int gfp_dma = 0;

#ifdef CONFIG_ZONE_DMA
	gfp_dma = __GFP_DMA;
#endif

	return flags & gfp_dma ? KMALLOC_DMA : flags & __GFP_RECLAIMABLE ? KMALLOC_RECLAIM : 0;

That might generate cmovs, but is may be better to put unlikely() around both
conditional expressions. Or redo as:

	return !unlikely(flags & (dfp_dma | __GFP_RECLAIMABLE)) ? 0 : flags & gfp_dma ? KMALLOC_DMA : KMALLOC_RECLAIM;

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

