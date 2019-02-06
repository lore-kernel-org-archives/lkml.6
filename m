Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C471AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F563218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAb3R2pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfBFWIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:08:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44987 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfBFWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:08:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so3753097plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 14:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DH1GMO7ONcewLD5Iwy3rwHZsxjWkQFcnRV0dI8v2FAY=;
        b=bAb3R2pzhlaZVEi2ZtuYpSPkafehJ9X2H+B5lbllR0bCYCb9ep9Kzy9cY7faI4Ul6G
         kvgyVwSWGenY3Z8keeJ/6dSxOFiyMLoXF7/4cg08ApAB5pGSZaIe/dfPGqi8Tmde4Bqh
         Z6TTA4YbRotltk0RfIO+eO2E5RcGlqWWJ+XbGhjISowWNhkGpJPsPa5aqz4amHOPNZxU
         Q15ruPJYNmHE47FiNv93c6w3iBmzohKq8N+hYXtAqsby0Z0gGfqXCW9VhRHXY2Gn3Wk/
         cT+01Smh9QPrJT71xtBiK7RDzdPnI8H9UpcmhF+01KtrN6ErIVew2Nk4POEGMx73twnn
         gYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=DH1GMO7ONcewLD5Iwy3rwHZsxjWkQFcnRV0dI8v2FAY=;
        b=eD2PiASfGABxD655CGtnxPsVWd9qNDb6KL2R+n2WbErMTo/Y0WN+P7pAG1e4R0hLAG
         kBXkaNL4/ovEu+2wJQ/FecayHOiJ9mcnDSiWAbt1UqmG15g7/QRSEYynWadV5xDe5oBu
         xTfplvTgY7e6pCrjbXzk/xZuWml7003hq2pWDuUM1w71svUJ1WQdfccTOao120pXlPuw
         QmAK3p/hXuVck2lwIxhkcfjaR3SnTGfzAakR4rbRiTWXoXPfB0JNUTzM7bFpUinE80mu
         Z0kPbA6StZCcolUhz1/6MSJfMuUh6HApNf5acL65yqHlarNcTzIg/dNV/E+qV/GgiW+x
         cpLw==
X-Gm-Message-State: AHQUAuYWuot+VCcYI8eTvrJRKV+fLmi2RThZgJVnTHpUNQRYGShro33O
        qlsZb1S4n7MturZeGcExakXo2Npu
X-Google-Smtp-Source: AHgI3IYGt07SOx/uLhrhBjerAnRfYPrENtDMltatD9mb9SbsxK1Nx2Ie00czr1VVLpFOTq4WbkFOGg==
X-Received: by 2002:a17:902:c05:: with SMTP id 5mr13065787pls.155.1549490916065;
        Wed, 06 Feb 2019 14:08:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h128sm9285846pgc.15.2019.02.06.14.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 14:08:34 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:08:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thierry Reding <treding@nvidia.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: Use direct DMA with IOMMU API usage
Message-ID: <20190206220833.GA20747@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 02:28:26PM +0100, Thierry Reding wrote:
> If we use the IOMMU API directly to map buffers into host1x' IOVA space,
> we must make sure that the DMA API doesn't already set up a mapping, or
> else translation will fail.
> 
> The direct DMA API allows us to allocate memory that will not be mapped
> through an IOMMU automatically.
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

arm64:defconfig:

ERROR: "dma_direct_free" [drivers/gpu/host1x/host1x.ko] undefined!
ERROR: "dma_direct_alloc" [drivers/gpu/host1x/host1x.ko] undefined!

Guenter

> ---
>  drivers/gpu/host1x/cdma.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> index 64099cc1964b..e22c1133a4c5 100644
> --- a/drivers/gpu/host1x/cdma.c
> +++ b/drivers/gpu/host1x/cdma.c
> @@ -19,6 +19,7 @@
>  
>  #include <asm/cacheflush.h>
>  #include <linux/device.h>
> +#include <linux/dma-direct.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/host1x.h>
>  #include <linux/interrupt.h>
> @@ -70,6 +71,7 @@ static void host1x_pushbuffer_destroy(struct push_buffer *pb)
>   */
>  static int host1x_pushbuffer_init(struct push_buffer *pb)
>  {
> +	unsigned long attrs = DMA_ATTR_WRITE_COMBINE;
>  	struct host1x_cdma *cdma = pb_to_cdma(pb);
>  	struct host1x *host1x = cdma_to_host1x(cdma);
>  	struct iova *alloc;
> @@ -91,8 +93,8 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
>  
>  		size = iova_align(&host1x->iova, size);
>  
> -		pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
> -					  GFP_KERNEL);
> +		pb->mapped = dma_direct_alloc(host1x->dev, size, &pb->phys,
> +					      GFP_KERNEL, attrs);
>  		if (!pb->mapped)
>  			return -ENOMEM;
>  
> @@ -127,7 +129,10 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
>  iommu_free_iova:
>  	__free_iova(&host1x->iova, alloc);
>  iommu_free_mem:
> -	dma_free_wc(host1x->dev, size, pb->mapped, pb->phys);
> +	if (host1x->domain)
> +		dma_direct_free(host1x->dev, size, pb->mapped, pb->phys, attrs);
> +	else
> +		dma_free_wc(host1x->dev, size, pb->mapped, pb->phys);
>  
>  	return err;
>  }
> -- 
> 2.7.4
