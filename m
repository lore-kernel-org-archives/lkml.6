Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C718C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5AA20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5AA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeLESUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:20:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32782 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeLESUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:20:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44BD280D;
        Wed,  5 Dec 2018 10:20:53 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DC983F575;
        Wed,  5 Dec 2018 10:20:52 -0800 (PST)
Subject: Re: [PATCH 2/4] iommu: Consolitate ->add/remove_device() calls
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-3-joro@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ca13757-edf8-95cb-6316-73d202f97dbf@arm.com>
Date:   Wed, 5 Dec 2018 18:20:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205143646.4876-3-joro@8bytes.org>
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
> Put them into separate functions and call those where the
> plain ops have been called before.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/iommu.c | 54 ++++++++++++++++++++++---------------------
>   include/linux/iommu.h |  3 +++
>   2 files changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index edbdf5d6962c..ad4dc51eb69c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -110,6 +110,26 @@ void iommu_device_unregister(struct iommu_device *iommu)
>   	spin_unlock(&iommu_device_lock);
>   }
>   
> +int iommu_probe_device(struct device *dev)
> +{
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +
> +	if (!ops->add_device)
> +		return 0;

Is there any good reason to let .add_device/.remove_device be optional 
still? Everyone's implemented them for a while now, and on a practical 
level I don't really see how else we could expect devices to be taken in 
and out of their appropriate groups correctly.

Robin.

> +
> +	WARN_ON(dev->iommu_group);
> +
> +	return ops->add_device(dev);
> +}
> +
> +void  iommu_release_device(struct device *dev)
> +{
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +
> +	if (ops->remove_device && dev->iommu_group)
> +		ops->remove_device(dev);
> +}
> +
>   static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>   						 unsigned type);
>   static int __iommu_attach_device(struct iommu_domain *domain,
> @@ -1117,16 +1137,7 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
>   
>   static int add_iommu_group(struct device *dev, void *data)
>   {
> -	struct iommu_callback_data *cb = data;
> -	const struct iommu_ops *ops = cb->ops;
> -	int ret;
> -
> -	if (!ops->add_device)
> -		return 0;
> -
> -	WARN_ON(dev->iommu_group);
> -
> -	ret = ops->add_device(dev);
> +	int ret = iommu_probe_device(dev);
>   
>   	/*
>   	 * We ignore -ENODEV errors for now, as they just mean that the
> @@ -1141,11 +1152,7 @@ static int add_iommu_group(struct device *dev, void *data)
>   
>   static int remove_iommu_group(struct device *dev, void *data)
>   {
> -	struct iommu_callback_data *cb = data;
> -	const struct iommu_ops *ops = cb->ops;
> -
> -	if (ops->remove_device && dev->iommu_group)
> -		ops->remove_device(dev);
> +	iommu_release_device(dev);
>   
>   	return 0;
>   }
> @@ -1153,27 +1160,22 @@ static int remove_iommu_group(struct device *dev, void *data)
>   static int iommu_bus_notifier(struct notifier_block *nb,
>   			      unsigned long action, void *data)
>   {
> +	unsigned long group_action = 0;
>   	struct device *dev = data;
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>   	struct iommu_group *group;
> -	unsigned long group_action = 0;
>   
>   	/*
>   	 * ADD/DEL call into iommu driver ops if provided, which may
>   	 * result in ADD/DEL notifiers to group->notifier
>   	 */
>   	if (action == BUS_NOTIFY_ADD_DEVICE) {
> -		if (ops->add_device) {
> -			int ret;
> +		int ret;
>   
> -			ret = ops->add_device(dev);
> -			return (ret) ? NOTIFY_DONE : NOTIFY_OK;
> -		}
> +		ret = iommu_probe_device(dev);
> +		return (ret) ? NOTIFY_DONE : NOTIFY_OK;
>   	} else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
> -		if (ops->remove_device && dev->iommu_group) {
> -			ops->remove_device(dev);
> -			return 0;
> -		}
> +		iommu_release_device(dev);
> +		return NOTIFY_OK;
>   	}
>   
>   	/*
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a1d28f42cb77..2357841845bb 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -398,6 +398,9 @@ void iommu_fwspec_free(struct device *dev);
>   int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
>   const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
>   
> +int iommu_probe_device(struct device *dev);
> +void  iommu_release_device(struct device *dev);
> +
>   #else /* CONFIG_IOMMU_API */
>   
>   struct iommu_ops {};
> 
