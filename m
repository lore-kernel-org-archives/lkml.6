Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51A0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24FE20869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbfAaOze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:55:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45370 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfAaOze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:55:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2A4C80D;
        Thu, 31 Jan 2019 06:55:33 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1B43F59C;
        Thu, 31 Jan 2019 06:55:32 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] iommu: set the default iommu-dma mode as
 non-strict
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>
References: <20190131135211.6732-1-thunder.leizhen@huawei.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
Date:   Thu, 31 Jan 2019 14:55:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131135211.6732-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/01/2019 13:52, Zhen Lei wrote:
> Currently, many peripherals are faster than before. For example, the top
> speed of the older netcard is 10Gb/s, and now it's more than 25Gb/s. But
> when iommu page-table mapping enabled, it's hard to reach the top speed
> in strict mode, because of frequently map and unmap operations. In order
> to keep abreast of the times, I think it's better to set non-strict as
> default.

Most users won't be aware of this relaxation and will have their system
vulnerable to e.g. thunderbolt hotplug. See for example 4.3 Deferred
Invalidation in
http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/2018/MSC/MSC-2018-21.pdf

Why not keep the policy to secure by default, as we do for
iommu.passthrough? And maybe add something similar to
CONFIG_IOMMU_DEFAULT_PASSTRHOUGH? It's easy enough for experts to pass a
command-line argument or change the default config.

Thanks,
Jean

> 
> Below it's our iperf performance data of 25Gb netcard:
> strict mode: 18-20 Gb/s
> non-strict mode: 23.5 Gb/s
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++--
>  drivers/iommu/iommu.c                           | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b799bcf..667221f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1779,13 +1779,13 @@
> 
>  	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
>  			Format: { "0" | "1" }
> -			0 - Lazy mode.
> +			0 - Lazy mode (default).
>  			  Request that DMA unmap operations use deferred
>  			  invalidation of hardware TLBs, for increased
>  			  throughput at the cost of reduced device isolation.
>  			  Will fall back to strict mode if not supported by
>  			  the relevant IOMMU driver.
> -			1 - Strict mode (default).
> +			1 - Strict mode.
>  			  DMA unmap operations invalidate IOMMU hardware TLBs
>  			  synchronously.
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3ed4db3..10e0b49 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -43,7 +43,7 @@
>  #else
>  static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>  #endif
> -static bool iommu_dma_strict __read_mostly = true;
> +static bool iommu_dma_strict __read_mostly;
> 
>  struct iommu_callback_data {
>  	const struct iommu_ops *ops;
> --
> 1.8.3
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

