Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78128C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6BE20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaIumE2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6BE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeKEUGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:06:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33169 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKEUGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:06:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id f19-v6so6081629wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=83JBiHkJUogcG2xRvm16Iv+0IU5LY0uKKBHZhVcaePo=;
        b=KaIumE2N+Sv5IZDz8XusC0AuYaFwHxM6EWK5MJiIozJ7B7YcWBzObYHyZ6aynEJfB2
         IXYIQCIybLDHybMzuWfYg+aCrBBcwlbXTK34CAjJoZNRH4bRgZtIMoDDD9sO0tzCRMZC
         EA/CkX4Xh3kSMcwDJoS6CTBD9s+oLmUesAjus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=83JBiHkJUogcG2xRvm16Iv+0IU5LY0uKKBHZhVcaePo=;
        b=Wz8xZWi8+Kw0KKiSveAPwzee85/aQl9g12/I564dBXaclXbzzBTQq21FY5i53Di8xG
         OJkPf8FJWLRXFNchqWRD2FCMzW3Jd1Z3hBsw6WVCpdKC9E2XAQl40rtiHuXVSWgMwSWq
         0jU3IcCkqjF5xW/bm3iecMeRiKfWH7KVleHTHQ9A1SaefG6y1g3PuaOkk+rOWik577l/
         8OQfQIw/bH82D/J7L8Kfyk3k0a/nl/F9ZKRztNeB0YWt+hQW/CQTamk0c+2mEx7lvGdR
         CPCKyK5PPgsbUwwO4zUEI/sdxf9IQcFlBYu7oKL6iw0H5Uo/LvS0WFb0rRQKbCQanoFu
         2HHw==
X-Gm-Message-State: AGRZ1gKP/B9DDiWjVEG87q8HJVjSPFAJ5RDlz2pPnC4uiYZc7w4RoE6u
        zUQlCbCvOuNnUVwWvt9D3g2UDQ==
X-Google-Smtp-Source: AJdET5eqJbnutZfUaNepyZEWHR5gxIjyoaqrE68KN8ZEnAQhoajLORKJyNbf5aoIvZzAuUf6qMORzQ==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr6032676wma.121.1541414823775;
        Mon, 05 Nov 2018 02:47:03 -0800 (PST)
Received: from apalos (ppp-94-65-93-8.home.otenet.gr. [94.65.93.8])
        by smtp.gmail.com with ESMTPSA id j129-v6sm8932815wmb.47.2018.11.05.02.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:47:03 -0800 (PST)
Date:   Mon, 5 Nov 2018 12:46:59 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?UGF3ZcWC?= Staszewski <pstaszewski@itcare.pl>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 1/2] mm/page_alloc: free order-0 pages through PCP in
 page_frag_free()
Message-ID: <20181105104659.GA5347@apalos>
References: <20181105085820.6341-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181105085820.6341-1-aaron.lu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,
> page_frag_free() calls __free_pages_ok() to free the page back to
> Buddy. This is OK for high order page, but for order-0 pages, it
> misses the optimization opportunity of using Per-Cpu-Pages and can
> cause zone lock contention when called frequently.
> 
> Paweł Staszewski recently shared his result of 'how Linux kernel
> handles normal traffic'[1] and from perf data, Jesper Dangaard Brouer
> found the lock contention comes from page allocator:
> 
>   mlx5e_poll_tx_cq
>   |
>    --16.34%--napi_consume_skb
>              |
>              |--12.65%--__free_pages_ok
>              |          |
>              |           --11.86%--free_one_page
>              |                     |
>              |                     |--10.10%--queued_spin_lock_slowpath
>              |                     |
>              |                      --0.65%--_raw_spin_lock
>              |
>              |--1.55%--page_frag_free
>              |
>               --1.44%--skb_release_data
> 
> Jesper explained how it happened: mlx5 driver RX-page recycle
> mechanism is not effective in this workload and pages have to go
> through the page allocator. The lock contention happens during
> mlx5 DMA TX completion cycle. And the page allocator cannot keep
> up at these speeds.[2]
> 
> I thought that __free_pages_ok() are mostly freeing high order
> pages and thought this is an lock contention for high order pages
> but Jesper explained in detail that __free_pages_ok() here are
> actually freeing order-0 pages because mlx5 is using order-0 pages
> to satisfy its page pool allocation request.[3]
> 
> The free path as pointed out by Jesper is:
> skb_free_head()
>   -> skb_free_frag()
>     -> skb_free_frag()
>       -> page_frag_free()
> And the pages being freed on this path are order-0 pages.
> 
> Fix this by doing similar things as in __page_frag_cache_drain() -
> send the being freed page to PCP if it's an order-0 page, or
> directly to Buddy if it is a high order page.
> 
> With this change, Paweł hasn't noticed lock contention yet in
> his workload and Jesper has noticed a 7% performance improvement
> using a micro benchmark and lock contention is gone.
I did the same tests on a 'low' speed 1Gbit interface on an cortex-a53.
I used socionext's netsec driver and switched buffer allocation from the 
current scheme to using page_pool API (which by default allocates order0 
pages).

Running 'perf top' pre and post patch got me the same results.
__free_pages_ok() disappeared from perf top and i got an ~11% 
performance boost testing with 64byte packets.

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
