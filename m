Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BB6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678DE20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aOuNuUD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678DE20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbeKFHgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:36:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33372 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeKFHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:36:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so3350176ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CXCsmVprvztUr6DCUcgdzdTxAMwUMFuKdomf2wItwVA=;
        b=aOuNuUD0gA1p75nggL3/MAWGDiTQqMv+I4foYrGDx3gtHol6gfZw7pfrhF+X/DZ+w6
         53exIHwCmHfXIJqbJLJXsW6zjiH9+Edfj9kT850krPm58RYLxCkD3M4f28V1h2eGIXwW
         sBDakINT0kqSu263ANIe4YDWYugDYUdDHbXic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CXCsmVprvztUr6DCUcgdzdTxAMwUMFuKdomf2wItwVA=;
        b=TC/t9GAu/kMPMw5ikeivitwdgS9bMgm9LVxLke3/czUq3npIkrf2XUhyDxXPXtPDS6
         iE890iGsy1B33THIJGNPIkv1h2EGcyAL4VhulSMPlq7fJEz737YW1i/UHYo6/QH1LJEg
         jli4KvpsEc2RIPtd0uF53az8dDkm5S69+K1BNJx/bRcx0ZkVd6m0mMuoECCqRDgTgg0u
         fWtjnL/uDZ8OtdyEmQG4DrCIPcE/71hHO08KmwBhDTBzlWv4WGttdrIr0q6LXhBu/dtI
         ron8Zcdz7fwd30HdO9I2aZv6qOki4dg/TCRLZWq6Y9XL+eVRdO/Lh2i3fz0JPPEzSKsQ
         0jnQ==
X-Gm-Message-State: AGRZ1gKC1WdMQfOc/OYIRjTN6t+zK/ftX+L3FGDJk1Djx/Qb3DDOoLIo
        M64zrjr4wYLTtz0X2piHLzXwgg==
X-Google-Smtp-Source: AJdET5cT4h4RmBw9e6Y5DYh+tBuPB7d0l4kdbbIPOUPTHeGy4sAUrE/ryF1Zi51fSWarMhYps5yZow==
X-Received: by 2002:a2e:12c1:: with SMTP id 62-v6mr17080193ljs.74.1541456049640;
        Mon, 05 Nov 2018 14:14:09 -0800 (PST)
Received: from [10.60.17.127] (31-208-49-160.cust.bredband2.com. [31.208.49.160])
        by smtp.gmail.com with ESMTPSA id j20sm4332287lfg.69.2018.11.05.14.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:14:08 -0800 (PST)
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
To:     Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
References: <20181105204000.129023-1-bvanassche@acm.org>
 <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
 <1541454489.196084.157.camel@acm.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
Date:   Mon, 5 Nov 2018 23:14:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541454489.196084.157.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-05 22:48, Bart Van Assche wrote:
> On Mon, 2018-11-05 at 13:13 -0800, Andrew Morton wrote:
>> On Mon,  5 Nov 2018 12:40:00 -0800 Bart Van Assche <bvanassche@acm.org> wrote:
>>
>>> This patch suppresses the following sparse warning:
>>>
>>> ./include/linux/slab.h:332:43: warning: dubious: x & !y
>>>
>>> ...
>>>
>>> --- a/include/linux/slab.h
>>> +++ b/include/linux/slab.h
>>> @@ -329,7 +329,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>>>  	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
>>>  	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
>>>  	 */
>>> -	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
>>> +	return type_dma + is_reclaimable * !is_dma * KMALLOC_RECLAIM;
>>>  }
>>>  
>>>  /*
>>
>> I suppose so.
>>
>> That function seems too clever for its own good :(.  I wonder if these
>> branch-avoiding tricks are really worthwhile.
> 
> From what I have seen in gcc disassembly it seems to me like gcc uses the
> cmov instruction to implement e.g. the ternary operator (?:). So I think none
> of the cleverness in kmalloc_type() is really necessary to avoid conditional
> branches. I think this function would become much more readable when using a
> switch statement or when rewriting it as follows (untested):
> 
>  static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  {
> -	int is_dma = 0;
> -	int type_dma = 0;
> -	int is_reclaimable;
> -
> -#ifdef CONFIG_ZONE_DMA
> -	is_dma = !!(flags & __GFP_DMA);
> -	type_dma = is_dma * KMALLOC_DMA;
> -#endif
> -
> -	is_reclaimable = !!(flags & __GFP_RECLAIMABLE);
> -
>  	/*
>  	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
>  	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
>  	 */
> -	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
> +	static const enum kmalloc_cache_type flags_to_type[2][2] = {
> +		{ 0,		KMALLOC_RECLAIM },
> +		{ KMALLOC_DMA,	KMALLOC_DMA },
> +	};
> +#ifdef CONFIG_ZONE_DMA
> +	bool is_dma = !!(flags & __GFP_DMA);
> +#endif
> +	bool is_reclaimable = !!(flags & __GFP_RECLAIMABLE);
> +
> +	return flags_to_type[is_dma][is_reclaimable];
>  }
> 

Won't that pessimize the cases where gfp is a constant to actually do
the table lookup, and add 16 bytes to every translation unit?

Another option is to add a fake KMALLOC_DMA_RECLAIM so the
kmalloc_caches[] array has size 4, then assign the same dma
kmalloc_cache pointer to [2][i] and [3][i] (so that costs perhaps a
dozen pointers in .data), and then just compute kmalloc_type() as

((flags & __GFP_RECLAIMABLE) >> someshift) | ((flags & __GFP_DMA) >>
someothershift).

Perhaps one could even shuffle the GFP flags so the two shifts are the same.

Rasmus
