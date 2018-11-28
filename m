Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B728C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6CA20660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6CA20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeK1Xvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:51:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38738 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeK1Xvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:51:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49C8C37D8;
        Wed, 28 Nov 2018 04:50:15 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C0C73F59C;
        Wed, 28 Nov 2018 04:50:14 -0800 (PST)
Subject: Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-6-git-send-email-paul.gortmaker@windriver.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cdded4c3-4bc5-39b3-ebc9-64fa145c9242@arm.com>
Date:   Wed, 28 Nov 2018 12:50:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543271498-28966-6-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2018 22:31, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/iommu/Kconfig:config IPMMU_VMSA
> drivers/iommu/Kconfig:        bool "Renesas VMSA-compatible IPMMU"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init was not even used by this driver, the init ordering
> remains unchanged with this commit.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9e2655f1c1bf..de39ef992d8a 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * IPMMU VMSA

Nit: this line doesn't convey any information that the module 
description below doesn't also say far more clearly, so you may as well 
just replace it entirely.

Robin.

> + * IOMMU API for Renesas VMSA-compatible IPMMU
> + * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>    *
>    * Copyright (C) 2014 Renesas Electronics Corporation
>    */
> @@ -14,7 +16,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/iommu.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/of_iommu.h>
> @@ -968,7 +970,6 @@ static const struct of_device_id ipmmu_of_ids[] = {
>   	},
>   };
>   
> -MODULE_DEVICE_TABLE(of, ipmmu_of_ids);
>   
>   static int ipmmu_probe(struct platform_device *pdev)
>   {
> @@ -1140,15 +1141,4 @@ static int __init ipmmu_init(void)
>   	setup_done = true;
>   	return 0;
>   }
> -
> -static void __exit ipmmu_exit(void)
> -{
> -	return platform_driver_unregister(&ipmmu_driver);
> -}
> -
>   subsys_initcall(ipmmu_init);
> -module_exit(ipmmu_exit);
> -
> -MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
> -MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
> -MODULE_LICENSE("GPL v2");
> 
