Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B15C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41E3222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kh3oP1lS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfBOXOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:14:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfBOXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oErxAKugs8/zcnFnYZgoS+lm/mW509WGX1wdEHmoOsE=; b=Kh3oP1lSmOr+ioW7gBuMGgtDS
        7ebucg8qY8aeSRxBMbQD6oIeMhnB33BDaVtgxMIpLB5wPrf/j8RvMxrQbBSy9aWO8aUbIeG7Budgm
        JUs2NIYvLQEMb6iRfxbW4wHz+haWRuF/QLAF5cS0h87aE16inlRDgPJEXFY10kfeiMCo8ZDi6M3DC
        DI9yMWX6R7siaeN34xgMbvTm+eqvIzOq/QGkz91h/0mMxdARgbvQ0vdxBkfqC01JkLM//eghUwnrh
        1mu+ydkpw6b+FYIOHpsDxmOLsduxD84bCCQ51/LsC7ZOGwzs2GLNfbFNW4ah0nQzvx7rg+l3tOKJM
        1lG2MWeyw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gumgR-0003Ck-01; Fri, 15 Feb 2019 23:14:15 +0000
Subject: Re: [PATCH 1/2] misc: fastrpc: select CONFIG_DMA_SHARED_BUFFER
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
References: <20190215104007.27103-1-srinivas.kandagatla@linaro.org>
 <20190215104007.27103-2-srinivas.kandagatla@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <92483887-d10c-9ee0-3e75-192286c4a66f@infradead.org>
Date:   Fri, 15 Feb 2019 15:14:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190215104007.27103-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 2:40 AM, Srinivas Kandagatla wrote:
> Fastrpc is a dma buf exporter as well, so select the corresponding
> DMA_SHARED_BUFFER config to fix below compilation errors on platforms
> without this config.
> 
> ld: drivers/misc/fastrpc.o: in function 'fastrpc_free_map':
> fastrpc.c:(.text+0xbe): undefined reference to 'dma_buf_unmap_attachment'
> ld: fastrpc.c:(.text+0xcb): undefined reference to 'dma_buf_detach'
> ld: fastrpc.c:(.text+0xd4): undefined reference to 'dma_buf_put'
> ld: drivers/misc/fastrpc.o: in function 'fastrpc_map_create':
> fastrpc.c:(.text+0xb2b): undefined reference to 'dma_buf_get'
> ld: fastrpc.c:(.text+0xb47): undefined reference to 'dma_buf_attach'
> ld: fastrpc.c:(.text+0xb61): undefined reference to 'dma_buf_map_attachment'
> ld: fastrpc.c:(.text+0xc36): undefined reference to 'dma_buf_put'
> ld: fastrpc.c:(.text+0xc48): undefined reference to 'dma_buf_detach'
> ld: drivers/misc/fastrpc.o: in function 'fastrpc_device_ioctl':
> fastrpc.c:(.text+0x1756): undefined reference to 'dma_buf_get'
> ld: fastrpc.c:(.text+0x1776): undefined reference to 'dma_buf_put'
> ld: fastrpc.c:(.text+0x1780): undefined reference to 'dma_buf_put'
> ld: fastrpc.c:(.text+0x1abf): undefined reference to 'dma_buf_export'
> ld: fastrpc.c:(.text+0x1ae7): undefined reference to 'dma_buf_fd'
> ld: fastrpc.c:(.text+0x1cb5): undefined reference to 'dma_buf_put'
> ld: fastrpc.c:(.text+0x1cca): undefined reference to 'dma_buf_put'
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/misc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 7e0726253755..53cd16f795d6 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -299,6 +299,7 @@ config QCOM_FASTRPC
>  	tristate "Qualcomm FastRPC"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on RPMSG
> +	select DMA_SHARED_BUFFER
>  	help
>  	  Provides a communication mechanism that allows for clients to
>  	  make remote method invocations across processor boundary to
> 


-- 
~Randy
