Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69A3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7952252C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHsaFDo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7952252C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbeKOIaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:30:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43896 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388739AbeKOIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:30:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so8004568pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=L4pSjUmIOTE0zfl+uSAhUu8uxkMsgvMqkVu4l5PVJLM=;
        b=bHsaFDo+/Xp1Htf7bc1MJT/ArLhDCAld3LslMWj8wWkw2iq2Hj4HSgGXQ1hOcxtuqj
         frLf0ZITUxUtUnAVmaH5mKdkiVVU1CKRwgk/rjkYH1dYSaRu84QaNUuKdbbdL7WtBxSz
         i1naaE6Jc+P12tjPIVdSzNNkgfdX0spxF9goubowf9W8DADQkS+X5dqncBactkDOYJxT
         BVPiqih4MIMS2LW4llPzcKoJJ6P3ifg/+EQ3lwNTS7IuBZPuO7azI345cvUL1P0gLUSg
         +dMHcuClYt7LNu+vUC/So8dEwyoiPWRhCtldDkuXIqB65KEKdFCHS2vxsVL1QZePRuFV
         s2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=L4pSjUmIOTE0zfl+uSAhUu8uxkMsgvMqkVu4l5PVJLM=;
        b=olXDj9hrbq7uBUhWPIKv93dvoVj9dGt/dOG3HeX5qKAh2N7++JeRtzEIZeZwqf0BMb
         OK8Gm7I7vHH0cHvoZd8sfGV2b974oc5JDgl5dPrl+3WqC9viBIIR39h/oZllKHxpL9um
         6OnFdJRrXrGY92YpTMB0HC+UMdG0EMYFspFniRpRRwRj/4faN/MVAwoSPA8tMVleQq8w
         52vaj7/TfPPfm1l4tJwdRMf9BQ2nAh8qtQ0pNZ7dGCNQF5AqP2yNTZ9m49SpgIubQw6J
         n8PhmLd8bJuPi9suMn5PqJtcMRgWkcVEuq7PdwJDYMJdVKnwSFjLuAY9THhJVY2sgDsv
         d6Lg==
X-Gm-Message-State: AGRZ1gIDfE/WO3Zvip3qTrLLE//LkjBcR75IyaZZQI/q4f47pNYvKbkk
        2UKZzVbpYD9x84pJLyoXwQS73w==
X-Google-Smtp-Source: AJdET5fAT58x/BzMQd2RtKEsTOQKGn2dh+ZUdO8Xh6ZSiV+6B35HlgHIK+tYZDU/bvxv4sMqdXYLhw==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr3429999pgh.6.1542234306779;
        Wed, 14 Nov 2018 14:25:06 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r81-v6sm54878447pfa.110.2018.11.14.14.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 14:25:06 -0800 (PST)
Date:   Wed, 14 Nov 2018 14:25:05 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Darryl T. Agostinelli" <dagostinelli@gmail.com>
cc:     linux-mm@kvack.org, cl@linux.com, bvanassche@acm.org,
        akpm@linux-foundation.org, penberg@kernel.org, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Suppress the sparse warning ./include/linux/slab.h:332:43:
 warning: dubious: x & !y
In-Reply-To: <20181109022801.29979-1-dagostinelli@gmail.com>
Message-ID: <alpine.DEB.2.21.1811141424130.212061@chino.kir.corp.google.com>
References: <20181109022801.29979-1-dagostinelli@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018, Darryl T. Agostinelli wrote:

> Signed-off-by: Darryl T. Agostinelli <dagostinelli@gmail.com>
> ---
>  include/linux/slab.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 918f374e7156..883b7f56bf35 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -317,6 +317,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  	int is_dma = 0;
>  	int type_dma = 0;
>  	int is_reclaimable;
> +	int y;
>  
>  #ifdef CONFIG_ZONE_DMA
>  	is_dma = !!(flags & __GFP_DMA);
> @@ -329,7 +330,10 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
>  	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
>  	 */
> -	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
> +
> +	y = (is_reclaimable & (is_dma == 0 ? 1 : 0));
> +
> +	return type_dma + y * KMALLOC_RECLAIM;
>  }
>  
>  /*

I agree with you that the function as written is less than pretty :)  How 
does the assembly change as a result of this code change, however?  This 
will be in the kmalloc() path so impacting the assembly to fix a sparse 
warning may not be warranted.
