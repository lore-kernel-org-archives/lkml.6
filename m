Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AAFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE452087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="D+gJKUeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbeL1Hpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:45:49 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:39034 "EHLO owa.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbeL1Hpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:45:49 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1545983134; h=from:subject:to:date:message-id;
        bh=tfTMWdHonUAcpyICrMa3tyJtkMvHBFpQ82GdAPtnW5c=;
        b=D+gJKUeOkUfCr9jw9W5A8wEv5G88ErfV+FJZ/77NWazg1d8yKJYmGbFOusIvors72NHT14aZwFH
        ltcguKVeSon1uOgkpgWcE/Pi143Sg1waupxUjqMpR27/vXdn90kZy8dbvzHh5YUKcpmn6TkOB6zWz
        gyHOViPWXI9UqoDGYA8=
Received: from hsj-Precision-5520 (10.101.1.99) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Fri, 28 Dec 2018 15:45:33 +0800
Date:   Fri, 28 Dec 2018 15:45:32 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <sfr@canb.auug.org.au>, <alexey.skidanov@intel.com>,
        <linux-kernel@vger.kernel.org>, <shijie8@gmail.com>
Subject: Re: [PATCH 2/2] lib/genalloc.c: export symbol addr_in_gen_pool
Message-ID: <20181228074531.GA2439@hsj-Precision-5520>
References: <20181224070622.22197-1-sjhuang@iluvatar.ai>
 <20181224070622.22197-2-sjhuang@iluvatar.ai>
 <20181227214929.713f8421d1991806e8f6fe7f@linux-foundation.org>
MIME-Version: 1.0
In-Reply-To: <20181227214929.713f8421d1991806e8f6fe7f@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.1.99]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 09:49:29PM -0800, Andrew Morton wrote:
> On Mon, 24 Dec 2018 15:06:22 +0800 Huang Shijie <sjhuang@iluvatar.ai> wrote:
> 
> > We may use the addr_in_gen_pool() in the driver module.
> > So export the addr_in_gen_pool for the compiling.
> > 
> > ...
> >
> > --- a/lib/genalloc.c
> > +++ b/lib/genalloc.c
> > @@ -450,6 +450,7 @@ bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
> >  	rcu_read_unlock();
> >  	return found;
> >  }
> > +EXPORT_SYMBOL(addr_in_gen_pool);
> >  
> >  /**
> >   * gen_pool_avail - get available free space of the pool
> 
> OK, but...  The name is poor.
> 
> q:/usr/src/25> grep EXPORT_SYMBOL lib/genalloc.c
> EXPORT_SYMBOL(gen_pool_create);
> EXPORT_SYMBOL(gen_pool_add_virt);
> EXPORT_SYMBOL(gen_pool_virt_to_phys);
> EXPORT_SYMBOL(gen_pool_destroy);
> EXPORT_SYMBOL(gen_pool_alloc);
> EXPORT_SYMBOL(gen_pool_alloc_algo);
> EXPORT_SYMBOL(gen_pool_dma_alloc);
> EXPORT_SYMBOL(gen_pool_free);
> EXPORT_SYMBOL(gen_pool_for_each_chunk);
> EXPORT_SYMBOL_GPL(gen_pool_avail);
> EXPORT_SYMBOL_GPL(gen_pool_size);
> EXPORT_SYMBOL(gen_pool_set_algo);
> EXPORT_SYMBOL(gen_pool_first_fit);
> EXPORT_SYMBOL(gen_pool_first_fit_align);
> EXPORT_SYMBOL(gen_pool_fixed_alloc);
> EXPORT_SYMBOL(gen_pool_first_fit_order_align);
> EXPORT_SYMBOL(gen_pool_best_fit);
> EXPORT_SYMBOL_GPL(gen_pool_get);
> EXPORT_SYMBOL(devm_gen_pool_create);
> EXPORT_SYMBOL_GPL(of_gen_pool_get);
> 
> See?  Almost everything is called gen_pool_foo.  Which is correct as
> per kernel conventions.  We should globally rename this to
> gen_pool_has_addr or similar.
okay, I will do it right now..

Thanks
Huang Shijie
