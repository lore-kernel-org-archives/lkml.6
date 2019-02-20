Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EAF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WzFThoOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBTPmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:42:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42242 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfBTPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:42:51 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C29E62D1;
        Wed, 20 Feb 2019 16:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550677368;
        bh=YhxvAFkolvLn268p1eu9ujULBb6L7/qCzXE6g6jrB4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzFThoOIH7QsN7rMzA5yA0xwV8lWzyPIE9DBOXdiT9UxkZy1apdIBzLqkgbir6iwO
         /wb3lTfhqjMpSXmN0wAma8XlNX0PuUrd9yJnUXuA5kMKiVc9oRS6YImAP08OScw1DF
         PSRbelzoyqEWtqxl05kOsdFA+x16DoHvbM3CIhyY=
Date:   Wed, 20 Feb 2019 17:42:44 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific
 features
Message-ID: <20190220154244.GJ3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-6-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220150531.2462-6-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:29PM +0100, Geert Uytterhoeven wrote:
> The maximum number of micro-TLBs per IPMMU instance is not fixed, but
> depends on the SoC type.  Hence move it from struct ipmmu_vmsa_device to
> struct ipmmu_features, and set up the correct value for both R-Car Gen2
> and Gen3 SoCs.
> 
> Note that currently no code uses this value.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 4e3134a9a52f8d87..0a21e734466eb1bd 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -42,6 +42,7 @@ struct ipmmu_features {
>  	bool use_ns_alias_offset;
>  	bool has_cache_leaf_nodes;
>  	unsigned int number_of_contexts;
> +	unsigned int num_utlbs;
>  	bool setup_imbuscr;
>  	bool twobit_imttbcr_sl0;
>  	bool reserved_context;
> @@ -53,7 +54,6 @@ struct ipmmu_vmsa_device {
>  	struct iommu_device iommu;
>  	struct ipmmu_vmsa_device *root;
>  	const struct ipmmu_features *features;
> -	unsigned int num_utlbs;
>  	unsigned int num_ctx;
>  	spinlock_t lock;			/* Protects ctx and domains[] */
>  	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
> @@ -972,6 +972,7 @@ static const struct ipmmu_features ipmmu_features_default = {
>  	.use_ns_alias_offset = true,
>  	.has_cache_leaf_nodes = false,
>  	.number_of_contexts = 1, /* software only tested with one context */
> +	.num_utlbs = 32,
>  	.setup_imbuscr = true,
>  	.twobit_imttbcr_sl0 = false,
>  	.reserved_context = false,
> @@ -981,6 +982,7 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
>  	.use_ns_alias_offset = false,
>  	.has_cache_leaf_nodes = true,
>  	.number_of_contexts = 8,
> +	.num_utlbs = 48,
>  	.setup_imbuscr = false,
>  	.twobit_imttbcr_sl0 = true,
>  	.reserved_context = true,
> @@ -1033,7 +1035,6 @@ static int ipmmu_probe(struct platform_device *pdev)
>  	}
>  
>  	mmu->dev = &pdev->dev;
> -	mmu->num_utlbs = 48;
>  	spin_lock_init(&mmu->lock);
>  	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>  	mmu->features = of_device_get_match_data(&pdev->dev);

-- 
Regards,

Laurent Pinchart
