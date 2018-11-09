Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2178DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DCA20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DCA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeKJEfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:35:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJEfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:35:07 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF73389B;
        Fri,  9 Nov 2018 18:53:15 +0000 (UTC)
Date:   Fri, 9 Nov 2018 10:53:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 3/3] slab: use logical instead of bitwise operation
 in kmalloc_type()
Message-Id: <20181109105314.c6a6acfa9badba6733c3f72e@linux-foundation.org>
In-Reply-To: <20181109093534.15121-3-johannes@sipsolutions.net>
References: <20181109093534.15121-1-johannes@sipsolutions.net>
        <20181109093534.15121-3-johannes@sipsolutions.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 10:35:34 +0100 Johannes Berg <johannes@sipsolutions.net> wrote:

> The operation here really is more logical than bitwise, even if
> due to the setup the bitwise operation works fine. However, this
> causes a complaint from sparse that the operation doesn't really
> make sense due to the not.
> 
> Use a logical and instead of bitwise.
> 
> In my (somewhat unscientific) test this caused no differences in
> the generated code.
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
> +	return type_dma + (is_reclaimable && !is_dma) * KMALLOC_RECLAIM;
>  }
>  
>  /*

Thanks.  There's presently a bit of head-scratching going on over this.
http://lkml.kernel.org/r/20181105204000.129023-1-bvanassche@acm.org -
please feel free to weigh in ;)

