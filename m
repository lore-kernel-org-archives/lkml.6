Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED02BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE40E2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="egldZYVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBTP1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:27:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42104 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfBTP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:27:50 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 500EC2D1;
        Wed, 20 Feb 2019 16:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550676468;
        bh=b2pip1/suCF+mHqkWBmO8CCbcXzJCfy5FmSJWlzZSgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egldZYVCaSKujZL2o78xqajKqBzfnP1XvK5OZVF8XMLkfkS7dQRBOQJC40NI9Nfm1
         sEo3nvbiKQipgcAMCda4bAGfc83qBo951ud/+iRS3kjFvr0LcP9GWqpKod+84ZFqF1
         IwaaxT6655p1JlBOuL5qIQg/GmvFnMK4VWT9uO5o=
Date:   Wed, 20 Feb 2019 17:27:44 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] iommu/ipmmu-vmsa: Call ipmmu_ctx_write_root()
 instead of open coding
Message-ID: <20190220152744.GE3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220150531.2462-3-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:26PM +0100, Geert Uytterhoeven wrote:
> There is a helper to write to the root IPMMU instance's registers, so
> let's use it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9f2b781e20a0eba6..ac70cb967ff821c6 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -280,8 +280,7 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
>  		ipmmu_write(domain->mmu,
>  			    domain->context_id * IM_CTX_SIZE + reg, data);
>  
> -	ipmmu_write(domain->mmu->root,
> -		    domain->context_id * IM_CTX_SIZE + reg, data);
> +	ipmmu_ctx_write_root(domain, reg, data);

This makes the code harder to read in my opinion, and I don't think it
bring much optimization.

>  }
>  
>  /* -----------------------------------------------------------------------------

-- 
Regards,

Laurent Pinchart
