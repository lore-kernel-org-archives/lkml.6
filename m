Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E6CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43A320851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43A320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeKTUKY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:10:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbeKTUKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:10:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B80C307DAC0;
        Tue, 20 Nov 2018 09:42:11 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AECC18E56;
        Tue, 20 Nov 2018 09:42:10 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 96830181AAB1;
        Tue, 20 Nov 2018 09:42:09 +0000 (UTC)
Date:   Tue, 20 Nov 2018 04:42:09 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Pawe=C5=82?= Staszewski <pstaszewski@itcare.pl>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Ian Kumlien <ian.kumlien@gmail.com>
Message-ID: <683236105.35259866.1542706929529.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181120014544.GB10657@intel.com>
References: <20181119134834.17765-1-aaron.lu@intel.com> <20181119134834.17765-2-aaron.lu@intel.com> <20181120014544.GB10657@intel.com>
Subject: Re: [PATCH v2 RESEND update 1/2] mm/page_alloc: free order-0 pages
 through PCP in page_frag_free()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.67.116.119, 10.4.195.6]
Thread-Topic: mm/page_alloc: free order-0 pages through PCP in page_frag_free()
Thread-Index: vlSeekjqFLNNlIX5GbvvfvYHef1EEA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 20 Nov 2018 09:42:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
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
>     -> page_frag_free()
> And the pages being freed on this path are order-0 pages.
> 
> Fix this by doing similar things as in __page_frag_cache_drain() -
> send the being freed page to PCP if it's an order-0 page, or
> directly to Buddy if it is a high order page.
> 
> With this change, Paweł hasn't noticed lock contention yet in
> his workload and Jesper has noticed a 7% performance improvement
> using a micro benchmark and lock contention is gone. Ilias' test
> on a 'low' speed 1Gbit interface on an cortex-a53 shows ~11%
> performance boost testing with 64byte packets and __free_pages_ok()
> disappeared from perf top.
> 
> [1]: https://www.spinics.net/lists/netdev/msg531362.html
> [2]: https://www.spinics.net/lists/netdev/msg531421.html
> [3]: https://www.spinics.net/lists/netdev/msg531556.html
> 
> Reported-by: Paweł Staszewski <pstaszewski@itcare.pl>
> Analysed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Acked-by: Tariq Toukan <tariqt@mellanox.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
> update: fix Tariq's email tag.
> 
>  mm/page_alloc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 421c5b652708..8f8c6b33b637 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4677,8 +4677,14 @@ void page_frag_free(void *addr)
>  {
>  	struct page *page = virt_to_head_page(addr);
>  
> -	if (unlikely(put_page_testzero(page)))
> -		__free_pages_ok(page, compound_order(page));
> +	if (unlikely(put_page_testzero(page))) {
> +		unsigned int order = compound_order(page);
> +
> +		if (order == 0)
> +			free_unref_page(page);
> +		else
> +			__free_pages_ok(page, order);
> +	}
>  }
>  EXPORT_SYMBOL(page_frag_free);
>  
> --
> 2.17.2

A good optimization for zero order allocations.  
Acked-by: Pankaj gupta <pagupta@redhat.com>
 
Thanks,
Pankaj
