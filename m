Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF06D206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/On8PSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfACK3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:29:34 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40873 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfACK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:29:33 -0500
Received: by mail-ed1-f48.google.com with SMTP id g22so28507716edr.7;
        Thu, 03 Jan 2019 02:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7gMhTHumHX1j3bxXEO+qKRuikANOndmLEVS+DnmY0ts=;
        b=R/On8PSBG5hSx5Dr0QWWyU7ISZI7yVLiQvUBGF9+IMZPEXqibuNWEesZrvK1U7eARJ
         Fk3QVG+tWsBv28DmtpShfVUfoqKB2eXj5JSRFze9XyJLjYT/LzAN3Jczr9r3hZEsCSMX
         1jl3QCqvtXbC4j3bxls2swqEm9B08Tux41GbNeuQr64i1jOHbQAFf4GRypsfB0nO1Vsj
         q1ng00tr/n6diwtiyfXGbU0VNyUO0PZ76cdxgGW1kvdTcZJ7C0AAYBj59OJYoNnurS6a
         atIqWUd+SONsNBt1WVQwBLjsG7umPhzxLeTQ54noF5zBLBBJwXuUbD6TXktO+hqlnm5K
         2MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7gMhTHumHX1j3bxXEO+qKRuikANOndmLEVS+DnmY0ts=;
        b=eJ0J6l9ue2qynfaa0ry+630ODK999Qy5Dv6XBwoMMbsAmWAGHe2lUCvfSVwTS23i/J
         ij1CFoqVbrLZd+cpkpjmwoZmY2AsaJ83PpZS6+FPuEN5WX9KmDJVco6AMxfQzXI7JTX7
         0hMtf2/IeF1puTcTcxvN79uSulK62o5lC06IDCNQTxUPRtM/QtXGg4oK4h4mE1v2ebzD
         nfTjQ39J6ELLDKv92HzcQYEi6RRWcShaExwEzUz/axS0CQIftixaGrvu2sErY/ID7Fng
         5Vvqrr4T8BEBqQ4gj2guKReTTg7paX1rVs5nK+Tqy14wKOc17LMsXVC0wKcbI/t9rvYN
         j+hA==
X-Gm-Message-State: AA+aEWZ2BEerXFyZDrkAQsUoxvTynfUcNjvhc5CGzBboKM0N/0CnNnqk
        NcUU074jrovGFq3Zfz5lqtJgvO1D
X-Google-Smtp-Source: AFSGD/UCsfkSqRIKgXCe9EivQxXoNbgniBAo474UntbFZY/gGVuVCwZ1PS+Mbvlp9deCpVhi5tdgJw==
X-Received: by 2002:a17:906:1001:: with SMTP id 1-v6mr35000441ejm.91.1546511371258;
        Thu, 03 Jan 2019 02:29:31 -0800 (PST)
Received: from [192.168.8.147] (205.17.136.77.rev.sfr.net. [77.136.17.205])
        by smtp.gmail.com with ESMTPSA id s36sm21572124edb.43.2019.01.03.02.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 02:29:30 -0800 (PST)
Subject: Re: [patch] net, skbuff: do not prefer skb allocation fails early
To:     David Rientjes <rientjes@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Willem de Bruijn <willemb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.1901021300420.62853@chino.kir.corp.google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <948700b2-993b-e17f-67df-e8517e87998d@gmail.com>
Date:   Thu, 3 Jan 2019 02:29:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901021300420.62853@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2019 01:01 PM, David Rientjes wrote:
> Commit dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by 
> __GFP_RETRY_MAYFAIL with more useful semantic") replaced __GFP_REPEAT in
> alloc_skb_with_frags() with __GFP_RETRY_MAYFAIL when the allocation may
> directly reclaim.
> 
> The previous behavior would require reclaim up to 1 << order pages for
> skb aligned header_len of order > PAGE_ALLOC_COSTLY_ORDER before failing,
> otherwise the allocations in alloc_skb() would loop in the page allocator
> looking for memory.  __GFP_RETRY_MAYFAIL makes both allocations failable
> under memory pressure, including for the HEAD allocation.
> 
> This can cause, among many other things, write() to fail with ENOTCONN
> during RPC when under memory pressure.  
> 
> These allocations should succeed as they did previous to dcda9b04713c
> even if it requires calling the oom killer and additional looping in the
> page allocator to find memory.  There is no way to specify the previous
> behavior of __GFP_REPEAT, but it's unlikely to be necessary since the
> previous behavior only guaranteed that 1 << order pages would be reclaimed
> before failing for order > PAGE_ALLOC_COSTLY_ORDER.  That reclaim is not
> guaranteed to be contiguous memory, so repeating for such large orders is
> usually not beneficial.
> 
> Removing the setting of __GFP_RETRY_MAYFAIL to restore the previous
> behavior, specifically not allowing alloc_skb() to fail for small orders
> and oom kill if necessary rather than allowing RPCs to fail.
> 
> Fixes: dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by
> __GFP_RETRY_MAYFAIL with more useful semantic") 
> Signed-off-by: David Rientjes <rientjes@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks David.

