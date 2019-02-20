Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACB0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F084D2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UJg0dHA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfBTPbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:31:40 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42144 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfBTPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:31:39 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E3992D1;
        Wed, 20 Feb 2019 16:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550676697;
        bh=JoraJcQ6MqFsIgkh7YJkuacZR5K+y+Q9v1vqMYM9Zjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJg0dHA38oxMH01UF9s+L+XcJNji1Fmx4Ngr2zrR9CAT38XURb+snR2AdHEGn7pQS
         WQPRoaFYqOzRIHdFvOUKhmzLKCjm3ysaZ+p1aEwqVf5GMznizWq4/kBuaux21TLb20
         r40IFHd8bw6+3gE1mhzPU7CHb9PLimEP4SswlYjA=
Date:   Wed, 20 Feb 2019 17:31:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
Message-ID: <20190220153133.GG3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220150531.2462-5-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:28PM +0100, Geert Uytterhoeven wrote:
> Make the IPMMU_CTX_MAX constant unsigned, to match the type of
> ipmmu_features.number_of_contexts.
> 
> This allows to use plain min() instead of type-casting min_t().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 4d07c26c97848b65..4e3134a9a52f8d87 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -36,7 +36,7 @@
>  #define arm_iommu_detach_device(...)	do {} while (0)
>  #endif
>  
> -#define IPMMU_CTX_MAX 8
> +#define IPMMU_CTX_MAX 8U
>  
>  struct ipmmu_features {
>  	bool use_ns_alias_offset;
> @@ -1060,8 +1060,7 @@ static int ipmmu_probe(struct platform_device *pdev)
>  	if (mmu->features->use_ns_alias_offset)
>  		mmu->base += IM_NS_ALIAS_OFFSET;
>  
> -	mmu->num_ctx = min_t(unsigned int, IPMMU_CTX_MAX,
> -			     mmu->features->number_of_contexts);
> +	mmu->num_ctx = min(IPMMU_CTX_MAX, mmu->features->number_of_contexts);
>  
>  	irq = platform_get_irq(pdev, 0);
>  

-- 
Regards,

Laurent Pinchart
