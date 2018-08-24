Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C93C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44EA2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uVeVCq7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44EA2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeHXUwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:52:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeHXUwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z8wTjdZv0xXN6XaefqX8QX3HhVJfhqyF29/hOC3hESU=; b=uVeVCq7ug0WPhgjwLOq1Nmb4w
        zkq87V6Ib/gaXfwNcw8UtBenZ8zpO7gnyhnkloly3uHH0Wn39ylPzw77x6ZuMcLbt9kP5anbOQ7A7
        LCCgRE3OKYxNNO9FxquRbxSwy0WAuaCd/0tscKGUwddkS7WqjUGcdbR/bZahiGjw5DV6VvDKWGn7f
        cHeftwDAjusplS/yVOT3m5TfTRS4Goj2b3XDUnsQdgDIz82BDjfP3oWe1k+NGabkfJIbWJU1OSbpf
        JR6Pi/ZNA5vEJi/ml9xF4Vlm9Orz09hwiRhJ5hT5tr62Vm2PfZIJEG9NjLymER3A+CMhSicMrkEoy
        QgI2OIDIA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftFhW-0005T9-Ul; Fri, 24 Aug 2018 17:16:47 +0000
Subject: Re: [RFC PATCH 11/11] powerpc/svm: Increase SWIOTLB buffer size
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
 <20180824162535.22798-12-bauerman@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <45561478-ee75-ee62-52d6-a96d60132669@infradead.org>
Date:   Fri, 24 Aug 2018 10:16:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824162535.22798-12-bauerman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 09:25 AM, Thiago Jung Bauermann wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> SWIOTLB buffer default size (64MB) is not enough for large sequential write
> operations which eventually leads to kernel crash like here.
> 
> virtio-pci 0000:00:05.0: swiotlb buffer is full (sz: 327680 bytes)
> virtio-pci 0000:00:05.0: DMA: Out of SW-IOMMU space for 327680 bytes
> Kernel panic - not syncing: DMA: Random memory could be DMA read
> CPU: 12 PID: 3985 Comm: mkfs.ext4 Not tainted 4.18.0-rc4+ #285
> Call Trace:
> [c0000007d2a27020] [c000000000cfdffc] dump_stack+0xb0/0xf4 (unreliable)
> [c0000007d2a27060] [c000000000112a98] panic+0x140/0x328
> [c0000007d2a270f0] [c0000000001b4f88] swiotlb_full+0x108/0x130
> [c0000007d2a27180] [c0000000001b5f6c] swiotlb_map_page+0x25c/0x2c0
> [c0000007d2a271e0] [c0000000007bfaf8] vring_map_one_sg.isra.0+0x58/0x70
> [c0000007d2a27200] [c0000000007c08dc] virtqueue_add_sgs+0x1bc/0x690
> [c0000007d2a272f0] [d0000000042a1280] virtio_queue_rq+0x358/0x4a0 [virtio_blk]
> [c0000007d2a273d0] [c0000000006b5d68] blk_mq_dispatch_rq_list+0x1f8/0x6d0
> ..................
> 
> Increase the SWIOTLB size to 1GB on Ultravisor based secure guests.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig | 5 +++++
>  kernel/dma/swiotlb.c | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1466d1234723..fee7194ce9e4 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -457,6 +457,11 @@ config PPC_SVM
>  
>  	 If unsure, say "N".
>  
> +config SWIOTLB_DEFAULT_SIZE
> +       int "Size of Software I/O TLB buffer (in MiB)"
> +       default "1024"

I would add a "range" to limit (restrict) how small or large that can be.  E.g.:

	range 16 102400

or even smaller for the maximum value...

> +       depends on PPC_SVM
> +
>  config PPC_TRANSACTIONAL_MEM
>         bool "Transactional Memory support for POWERPC"
>         depends on PPC_BOOK3S_64
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 04b68d9dffac..32dc67422d8a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -146,8 +146,13 @@ void swiotlb_set_max_segment(unsigned int val)
>  		max_segment = rounddown(val, PAGE_SIZE);
>  }
>  
> +#ifdef CONFIG_SWIOTLB_DEFAULT_SIZE
> +#define IO_TLB_DEFAULT_SIZE ((unsigned long) CONFIG_SWIOTLB_DEFAULT_SIZE << 20)
> +#else
>  /* default to 64MB */
>  #define IO_TLB_DEFAULT_SIZE (64UL<<20)
> +#endif
> +
>  unsigned long swiotlb_size_or_default(void)
>  {
>  	unsigned long size;
> 


-- 
~Randy
