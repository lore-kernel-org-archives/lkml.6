Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4833EC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171D92073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171D92073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeI2Xdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:33:40 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33400 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728377AbeI2Xdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:33:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07670777|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07423;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CxVngT6_1538240657;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CxVngT6_1538240657)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 30 Sep 2018 01:04:17 +0800
Date:   Sun, 30 Sep 2018 01:04:16 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 07/33] csky: MMU and page table management
Message-ID: <20180929170415.GD27796@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <ed7dcac1e0f3a858fa75735fa881818bc4ab1468.1538058840.git.ren_guo@c-sky.com>
 <20180927154733.GA15985@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927154733.GA15985@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 08:47:33AM -0700, Christoph Hellwig wrote:
> > +static void *csky_dma_alloc_atomic(
> > +	struct device *dev,
> > +	size_t size,
> > +	dma_addr_t *dma_handle
> > +	)
> 
> Can you please use normal kernel coding style?  Closing brace on the
> same line, either two tab indents for the arguments or align them to the
> first argument:
> 
> static void *csky_dma_alloc_atomic(struct device *dev, size_t size,
> 		dma_addr_t *dma_handle)
> 
> or:
> 
> static void *csky_dma_alloc_atomic(struct device *dev, size_t size,
> 				   dma_addr_t *dma_handle)
OK, I like 2th.

> > +	if (DMA_ATTR_NON_CONSISTENT & attrs)
> > +		BUG();
> 
> Please don't bug on unknown attributs, they can be safely ignored.
No BUG(), return NULL.

> 
> > +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> > +			      size_t size, enum dma_data_direction dir)
> > +{
> > +	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> > +	unsigned long offset = paddr & ~PAGE_MASK;
> > +	unsigned long vaddr;
> > +
> > +	if (PageHighMem(page))
> > +		vaddr = (unsigned long) kmap_atomic(page);
> 
> This isn't going to work as the size might be larger than PAGE_SIZE.
Ops ... BIG BUG, must be fixed immediately, thank you.

Best Regards
 Guo Ren
