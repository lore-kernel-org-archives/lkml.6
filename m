Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADCFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F58A2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeL1Ftb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 00:49:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeL1Ftb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 00:49:31 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7034F72A;
        Fri, 28 Dec 2018 05:49:30 +0000 (UTC)
Date:   Thu, 27 Dec 2018 21:49:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     <sfr@canb.auug.org.au>, <alexey.skidanov@intel.com>,
        <linux-kernel@vger.kernel.org>, <shijie8@gmail.com>
Subject: Re: [PATCH 2/2] lib/genalloc.c: export symbol addr_in_gen_pool
Message-Id: <20181227214929.713f8421d1991806e8f6fe7f@linux-foundation.org>
In-Reply-To: <20181224070622.22197-2-sjhuang@iluvatar.ai>
References: <20181224070622.22197-1-sjhuang@iluvatar.ai>
        <20181224070622.22197-2-sjhuang@iluvatar.ai>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2018 15:06:22 +0800 Huang Shijie <sjhuang@iluvatar.ai> wrote:

> We may use the addr_in_gen_pool() in the driver module.
> So export the addr_in_gen_pool for the compiling.
> 
> ...
>
> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -450,6 +450,7 @@ bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
>  	rcu_read_unlock();
>  	return found;
>  }
> +EXPORT_SYMBOL(addr_in_gen_pool);
>  
>  /**
>   * gen_pool_avail - get available free space of the pool

OK, but...  The name is poor.

q:/usr/src/25> grep EXPORT_SYMBOL lib/genalloc.c
EXPORT_SYMBOL(gen_pool_create);
EXPORT_SYMBOL(gen_pool_add_virt);
EXPORT_SYMBOL(gen_pool_virt_to_phys);
EXPORT_SYMBOL(gen_pool_destroy);
EXPORT_SYMBOL(gen_pool_alloc);
EXPORT_SYMBOL(gen_pool_alloc_algo);
EXPORT_SYMBOL(gen_pool_dma_alloc);
EXPORT_SYMBOL(gen_pool_free);
EXPORT_SYMBOL(gen_pool_for_each_chunk);
EXPORT_SYMBOL_GPL(gen_pool_avail);
EXPORT_SYMBOL_GPL(gen_pool_size);
EXPORT_SYMBOL(gen_pool_set_algo);
EXPORT_SYMBOL(gen_pool_first_fit);
EXPORT_SYMBOL(gen_pool_first_fit_align);
EXPORT_SYMBOL(gen_pool_fixed_alloc);
EXPORT_SYMBOL(gen_pool_first_fit_order_align);
EXPORT_SYMBOL(gen_pool_best_fit);
EXPORT_SYMBOL_GPL(gen_pool_get);
EXPORT_SYMBOL(devm_gen_pool_create);
EXPORT_SYMBOL_GPL(of_gen_pool_get);

See?  Almost everything is called gen_pool_foo.  Which is correct as
per kernel conventions.  We should globally rename this to
gen_pool_has_addr or similar.
