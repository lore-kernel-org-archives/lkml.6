Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFDDECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AE020685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AE020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeKETO2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:14:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKETO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:14:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 756C7394D2C;
        Mon,  5 Nov 2018 09:55:34 +0000 (UTC)
Received: from localhost (ovpn-200-39.brq.redhat.com [10.40.200.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9955B60BE5;
        Mon,  5 Nov 2018 09:55:26 +0000 (UTC)
Date:   Mon, 5 Nov 2018 10:55:25 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?UGF3ZcWC?= Staszewski <pstaszewski@itcare.pl>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>, brouer@redhat.com
Subject: Re: [PATCH 1/2] mm/page_alloc: free order-0 pages through PCP in
 page_frag_free()
Message-ID: <20181105105525.1f78c661@redhat.com>
In-Reply-To: <20181105085820.6341-1-aaron.lu@intel.com>
References: <20181105085820.6341-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 05 Nov 2018 09:55:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 16:58:19 +0800
Aaron Lu <aaron.lu@intel.com> wrote:

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

Nitpick: you added skb_free_frag() two times, else correct.
(All this stuff gets inlined by the compiler, which makes it hard to
spot with perf report).

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
> 
> [1]: https://www.spinics.net/lists/netdev/msg531362.html
> [2]: https://www.spinics.net/lists/netdev/msg531421.html
> [3]: https://www.spinics.net/lists/netdev/msg531556.html
> Reported-by: Paweł Staszewski <pstaszewski@itcare.pl>
> Analysed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---

It is REALLY great that Aaron spotted this! (based on my analysis).
This have likely been causing scalability issues on real-life network
traffic, but have been hiding behind the driver level recycle tricks
for micro-benchmarking.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

>  mm/page_alloc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ae31839874b8..91a9a6af41a2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4555,8 +4555,14 @@ void page_frag_free(void *addr)
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

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
