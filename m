Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeCMO33 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:29:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43913 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCMO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:29:28 -0400
X-Google-Smtp-Source: AG47ELs7zq2Bz+C05+tpE9bUmAaoh3o6bxg+3ZUsDljj5lrt8/6EZdh0S3Rs9VfAnibBTCGPI3czfg==
Date: Tue, 13 Mar 2018 23:29:20 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 2/2] zram: drop max_zpage_size and use
 zs_huge_class_size()
Message-ID: <20180313142920.GA100978@rodete-laptop-imager.corp.google.com>
References: <20180306070639.7389-1-sergey.senozhatsky@gmail.com>
 <20180306070639.7389-3-sergey.senozhatsky@gmail.com>
 <20180313090249.GA240650@rodete-desktop-imager.corp.google.com>
 <20180313102437.GA5114@jagdpanzerIV>
 <20180313135815.GA96381@rodete-laptop-imager.corp.google.com>
 <20180313141813.GA741@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313141813.GA741@tigerII.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:18:13PM +0900, Sergey Senozhatsky wrote:
> On (03/13/18 22:58), Minchan Kim wrote:
> > > > If it is static, we can do this in zram_init? I believe it's more readable in that
> > > > it's never changed betweens zram instances.
> > > 
> > > We need to have at least one pool, because pool decides where the
> > > watermark is. At zram_init() stage we don't have a pool yet. We
> > > zs_create_pool() in zram_meta_alloc() so that's why I put
> > > zs_huge_class_size() there. I'm not in love with it, but that's
> > > the only place where we can have it.
> > 
> > Fair enough. Then what happens if client calls zs_huge_class_size
> > without creating zs_create_pool?
> 
> Will receive 0.
> One of the version was returning SIZE_MAX in such case.
> 
> size_t zs_huge_class_size(void)
>  {
> +	if (unlikely(!huge_class_size))
> +		return SIZE_MAX;
>  	return huge_class_size;
>  }

I really don't want to have such API which returns different size on
different context.

The thing is we need to create pool first to get right value.
It means zs_huge_class_size should depend on zs_create_pool.
So, I think passing zs_pool to zs_huge_class_size is right way to
prevent such misuse and confusing. Yub, franky speaknig, zsmalloc
is not popular like slab allocator  or page allocator so this like
discussion would be waste. However, we don't need big effort to do
and this is review phase so I want to make more robust/readable. ;-)

> 
> > I think we should make zs_huge_class_size has a zs_pool as argument.
> 
> Can do, but the param will be unused. May be we can do something

Yub, param wouldn't be unused but it's the way of creating dependency
intentionally. It could make code more robust/readable.

Please, let's pass zs_pool and returns always right huge size.

> like below instead:
> 
>  size_t zs_huge_class_size(void)
>  {
> +	if (unlikely(!huge_class_size))
> +		return 3 * PAGE_SIZE / 4;
>  	return huge_class_size;
>  }
> 
> Should do no harm (unless I'm missing something).


> 
> 	-ss
