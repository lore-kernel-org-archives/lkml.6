Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B7C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0766B2242A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JNRVFNTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0766B2242A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934004AbeFUVdU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:33:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933664AbeFUVdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oJA8yMzD5QRVClUYJJ3+gGUlvGiMJkZn3ASr4Vbg9E8=; b=JNRVFNTy/NSTgIBmeJxSjRFzo
        1CN0f9QoEYdnR0DiLBilVyJ9l6JKSqNby5eG5S8uDtaoUtHOEngLNYmL+tN3YGV7WGX4PGzPfhs/I
        9vR3FSAVe+8mPn/sIyLC8B0EoppQ6yHNIIR1/U13ajmZBnj1ia990bieqFWJ+wuQh3OL+3dwD1Cz9
        ysRWYV2Dpbk6cJ59qadNdUAWR+xIc9dPouiQzQjmRbwqDPWzp3MegamM9JWpkT0RksSSxbwMT1WkE
        iTZnIb8mdSsbK1931qEO630XZ5VYRsX1zqHI/p50CzifjoT1Y+ldUJf6Ns3+nOEqgi4bUx7WEZZ+W
        57zrA6K4g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW7Cd-0003Pl-Jf; Thu, 21 Jun 2018 21:33:15 +0000
Subject: Re: [PATCH 1/4] lib/rhashtable: simplify bucket_table_alloc()
To:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
References: <20180621212825.3059-1-dave@stgolabs.net>
 <20180621212825.3059-2-dave@stgolabs.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ff55aedf-615e-04f0-db21-a115b3475a9d@infradead.org>
Date:   Thu, 21 Jun 2018 14:33:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621212825.3059-2-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 02:28 PM, Davidlohr Bueso wrote:
> As of ce91f6ee5 (mm: kvmalloc does not fallback to vmalloc for incompatible gfp flag),
> we can simplify the caller and trust kvzalloc() to just do the right thing.

Hi,
JFYI, we are using 12-digit (12-character) commit IDs nowadays...


> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  lib/rhashtable.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 9427b5766134..26c9cd8a985a 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -175,10 +175,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
>  	int i;
>  
>  	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
> -	if (gfp != GFP_KERNEL)
> -		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
> -	else
> -		tbl = kvzalloc(size, gfp);
> +	tbl = kvzalloc(size, gfp);
>  
>  	size = nbuckets;
>  
> 


-- 
~Randy
