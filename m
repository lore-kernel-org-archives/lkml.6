Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEACC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LXL8g+vH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfBTPZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:25:12 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42076 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfBTPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:25:11 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B792F2D1;
        Wed, 20 Feb 2019 16:25:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550676309;
        bh=0TJgsLFgG2RQpD7sXwK5x2fdqgOVzse8WJ7zf1h5eF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXL8g+vHEKactp5pc2PjLcS1MJTnj8L9Eg32PMIFUUk4yjchPHAh4Iw79WM8mWiyO
         0HgLxYorSd1/L1doPb04/445ISd2YYU//BJ77pOT9R38idaSB+lcYh3OjBEqBtEy2t
         yk0UZKZHFYC8XhdPbX5PC4ef+UgrYgoyjNtyJwps=
Date:   Wed, 20 Feb 2019 17:25:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
Message-ID: <20190220152505.GD3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220150531.2462-2-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:25PM +0100, Geert Uytterhoeven wrote:
> As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
> iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
> /sys/class/iommus/, but their "devices" subdirectories are empty.
> Likewise, devices tied to an IOMMU do not have an "iommu" backlink.
> 
> Make sure all links are created, on both arm32 and arm64.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9a380c10655e182d..9f2b781e20a0eba6 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
>  
>  static int ipmmu_add_device(struct device *dev)
>  {
> +	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
>  	struct iommu_group *group;
> +	int ret;
>  
>  	/*
>  	 * Only let through devices that have been verified in xlate()
>  	 */
> -	if (!to_ipmmu(dev))
> +	if (!mmu)
>  		return -ENODEV;
>  
> -	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
> -		return ipmmu_init_arm_mapping(dev);
> +	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
> +		ret = ipmmu_init_arm_mapping(dev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		group = iommu_group_get_for_dev(dev);
> +		if (IS_ERR(group))
> +			return PTR_ERR(group);
>  
> -	group = iommu_group_get_for_dev(dev);
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> +		iommu_group_put(group);
> +	}
>  
> -	iommu_group_put(group);
> +	iommu_device_link(&mmu->iommu, dev);
>  	return 0;
>  }
>  
>  static void ipmmu_remove_device(struct device *dev)
>  {
> +	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> +
> +	iommu_device_unlink(&mmu->iommu, dev);
>  	arm_iommu_detach_device(dev);
>  	iommu_group_remove_device(dev);
>  }

-- 
Regards,

Laurent Pinchart
