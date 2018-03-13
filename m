Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933137AbeCMN63 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:58:29 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40405 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCMN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:58:25 -0400
X-Google-Smtp-Source: AG47ELvH1juvzXICc33Bp6M1oaBPz4yPtbrh3cX9Ntf2gqLRnCwv8JMO82KWQmN0j1nyHtBvDCbYoQ==
Date: Tue, 13 Mar 2018 22:58:15 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 2/2] zram: drop max_zpage_size and use
 zs_huge_class_size()
Message-ID: <20180313135815.GA96381@rodete-laptop-imager.corp.google.com>
References: <20180306070639.7389-1-sergey.senozhatsky@gmail.com>
 <20180306070639.7389-3-sergey.senozhatsky@gmail.com>
 <20180313090249.GA240650@rodete-desktop-imager.corp.google.com>
 <20180313102437.GA5114@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313102437.GA5114@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 07:24:37PM +0900, Sergey Senozhatsky wrote:
> Hello Minchan,
> 
> On (03/13/18 18:02), Minchan Kim wrote:
> > Sorry for being late.
> > I love this patchset! Just a minor below.
> 
> :)
> 
> [..]
> > > +	if (!huge_class_size)
> > > +		huge_class_size = zs_huge_class_size();
> > 
> > If it is static, we can do this in zram_init? I believe it's more readable in that
> > it's never changed betweens zram instances.
> 
> We need to have at least one pool, because pool decides where the
> watermark is. At zram_init() stage we don't have a pool yet. We
> zs_create_pool() in zram_meta_alloc() so that's why I put
> zs_huge_class_size() there. I'm not in love with it, but that's
> the only place where we can have it.

Fair enough. Then what happens if client calls zs_huge_class_size
without creating zs_create_pool?
I think we should make zs_huge_class_size has a zs_pool as argument.
