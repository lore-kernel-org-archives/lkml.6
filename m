Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7319C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0A82081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0A82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeLESta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:49:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33420 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeLESta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:49:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDAB780D;
        Wed,  5 Dec 2018 10:49:29 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6D093F575;
        Wed,  5 Dec 2018 10:49:28 -0800 (PST)
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-4-joro@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <41d06767-fe6e-a746-d76a-557259af3034@arm.com>
Date:   Wed, 5 Dec 2018 18:49:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205143646.4876-4-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2018 14:36, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make sure to invoke this call-back through the proper
> function of the IOMMU-API.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/of_iommu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index c5dd63072529..4d4847de727e 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -218,10 +218,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   		ops = dev->iommu_fwspec->ops;
>   	/*
>   	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * add_device callback for dev, replay it to get things in order.
> +	 * probe for dev, replay it to get things in order.
>   	 */
> -	if (ops && ops->add_device && dev->bus && !dev->iommu_group)

Ugh, code I wrote...

I think that first ops test is serving double-duty - it's not just an 
"is ops->add_device safe to call?" check, but also the specific "do we 
need to try doing this at all?" check, since ops is only (potentially) 
set in the !err case at the top of this context.

> -		err = ops->add_device(dev);
> +	if (dev->bus && !dev->iommu_group)

Thus to avoid calling add_device erroneously in either of the "no valid 
IOMMU" cases (since dev->bus->iommu_ops may well be non-NULL), this 
still needs to be at least:

	if (ops && dev->bus && !dev->iommu_group)

What I can't quite remember just now is whether it's actually valid to 
get here with err == 0 but dev->iommu_fwspec->ops == NULL, so it *might* 
be OK to use "!err" instead of "ops" to make things slightly more 
obvious - I'll work through the flow tomorrow to double-check.

Robin.

> +		err = iommu_probe_device(dev);
>   
>   	/* Ignore all other errors apart from EPROBE_DEFER */
>   	if (err == -EPROBE_DEFER) {
> 
