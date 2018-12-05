Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56902C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292EC2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292EC2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeLERR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:17:57 -0500
Received: from foss.arm.com ([217.140.101.70]:59490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeLERR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:17:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5305CA78;
        Wed,  5 Dec 2018 09:17:56 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 667DE3F575;
        Wed,  5 Dec 2018 09:17:55 -0800 (PST)
Subject: Re: [PATCH 2/5] iommu/of: Use device_iommu_mapped()
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-3-joro@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <44c82503-bc36-e8de-6932-7c4fd2b597f8@arm.com>
Date:   Wed, 5 Dec 2018 17:17:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204172504.19708-3-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 17:25, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use Use device_iommu_mapped() to check if the device is
> already mapped by an IOMMU.

FWIW, this check (and its ACPI equivalent in patch #3) is specifically 
asking "has .add_device() already been called?", rather than the more 
general "is this device managed by an IOMMU?" (to which the exact answer 
at this point is "yes, provided we return successfully from here").

I have no objection to the change as-is - especially if that usage is 
within the intended scope of this API - I just wanted to call it out in 
case you're also planning to introduce something else which would be 
even more appropriate for that.

Robin.

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/of_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index c5dd63072529..bfcf139503f0 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -220,7 +220,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   	 * If we have reason to believe the IOMMU driver missed the initial
>   	 * add_device callback for dev, replay it to get things in order.
>   	 */
> -	if (ops && ops->add_device && dev->bus && !dev->iommu_group)
> +	if (ops && ops->add_device && dev->bus && !device_iommu_mapped(dev))
>   		err = ops->add_device(dev);
>   
>   	/* Ignore all other errors apart from EPROBE_DEFER */
> 
