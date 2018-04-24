Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933188AbeDXMva (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:51:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:47766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757207AbeDXMv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:51:27 -0400
Date: Tue, 24 Apr 2018 06:51:21 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        eric.dumazet@gmail.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] kvmalloc: always use vmalloc if CONFIG_DEBUG_SG
Message-ID: <20180424125121.GA17484@dhcp22.suse.cz>
References: <alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com>
 <20180420130852.GC16083@dhcp22.suse.cz>
 <alpine.LRH.2.02.1804201635180.25408@file01.intranet.prod.int.rdu2.redhat.com>
 <20180420210200.GH10788@bombadil.infradead.org>
 <alpine.LRH.2.02.1804201704580.25408@file01.intranet.prod.int.rdu2.redhat.com>
 <20180421144757.GC14610@bombadil.infradead.org>
 <alpine.LRH.2.02.1804221733520.7995@file01.intranet.prod.int.rdu2.redhat.com>
 <20180423151545.GU17484@dhcp22.suse.cz>
 <alpine.LRH.2.02.1804232003100.2299@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804232003100.2299@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-04-18 20:06:16, Mikulas Patocka wrote:
[...]
> @@ -404,6 +405,12 @@ void *kvmalloc_node(size_t size, gfp_t f
>  	 */
>  	WARN_ON_ONCE((flags & GFP_KERNEL) != GFP_KERNEL);
>  
> +#ifdef CONFIG_DEBUG_SG
> +	/* Catch bugs when the caller uses DMA API on the result of kvmalloc. */
> +	if (!(prandom_u32_max(2) & 1))
> +		goto do_vmalloc;
> +#endif

I really do not think there is anything DEBUG_SG specific here. Why you
simply do not follow should_failslab path or even reuse the function?

> +
>  	/*
>  	 * We want to attempt a large physically contiguous block first because
>  	 * it is less likely to fragment multiple larger blocks and therefore
> @@ -427,6 +434,9 @@ void *kvmalloc_node(size_t size, gfp_t f
>  	if (ret || size <= PAGE_SIZE)
>  		return ret;
>  
> +#ifdef CONFIG_DEBUG_SG
> +do_vmalloc:
> +#endif
>  	return __vmalloc_node_flags_caller(size, node, flags,
>  			__builtin_return_address(0));
>  }

-- 
Michal Hocko
SUSE Labs
