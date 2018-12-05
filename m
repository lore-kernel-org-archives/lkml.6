Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D12BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401FB2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401FB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeLERlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:41:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60194 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbeLERly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:41:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 527D780D;
        Wed,  5 Dec 2018 09:41:54 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7727B3F575;
        Wed,  5 Dec 2018 09:41:53 -0800 (PST)
Subject: Re: [PATCH 7/9] iommu/of: Use helper functions to access
 dev->iommu_fwspec
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
References: <20181204163002.15800-1-joro@8bytes.org>
 <20181204163002.15800-8-joro@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b78ab1d9-1f24-f792-04dd-26958a0739d3@arm.com>
Date:   Wed, 5 Dec 2018 17:41:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204163002.15800-8-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 16:30, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use the new helpers dev_iommu_fwspec_get()/set() to access
> the dev->iommu_fwspec pointer. This makes it easier to move
> that pointer later into another struct.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/of_iommu.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index c5dd63072529..38232250b5f4 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -164,7 +164,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					   struct device_node *master_np)
>   {
>   	const struct iommu_ops *ops = NULL;
> -	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	int err = NO_IOMMU;
>   
>   	if (!master_np)
> @@ -208,6 +208,9 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   		}
>   	}
>   
> +	/* The fwspec pointer changed, read it again */
> +	fwspec = dev_iommu_fwspec_get(dev);

Nit: I think it makes sense to put this inside the "if (!err)" condition 
below rather than out here where it may or may not be relevant. The 
comment for that case is already supposed to imply that it's dealing 
with a fresh fwspec.

Robin.

> +
>   	/*
>   	 * Two success conditions can be represented by non-negative err here:
>   	 * >0 : there is no IOMMU, or one was unavailable for non-fatal reasons
> @@ -215,7 +218,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   	 * <0 : any actual error
>   	 */
>   	if (!err)
> -		ops = dev->iommu_fwspec->ops;
> +		ops = fwspec->ops;
>   	/*
>   	 * If we have reason to believe the IOMMU driver missed the initial
>   	 * add_device callback for dev, replay it to get things in order.
> 
