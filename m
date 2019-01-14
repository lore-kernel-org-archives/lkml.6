Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC94C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BD420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfANLp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:45:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726644AbfANLp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:45:26 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 67862C4D9E7F820EF91A;
        Mon, 14 Jan 2019 19:45:21 +0800 (CST)
Received: from localhost (10.206.48.115) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 14 Jan 2019
 19:45:15 +0800
Date:   Mon, 14 Jan 2019 11:45:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <ashok.raj@intel.com>,
        <tiwei.bie@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <sanjay.k.kumar@intel.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <Zeng@mail.linuxfoundation.org>,
        <yi.y.sun@intel.com>, <jacob.jun.pan@intel.com>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 3/8] iommu/vt-d: Move common code out of
 iommu_attch_device()
Message-ID: <20190114114503.00007eac@huawei.com>
In-Reply-To: <20190110030027.31447-4-baolu.lu@linux.intel.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
        <20190110030027.31447-4-baolu.lu@linux.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.206.48.115]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 11:00:22 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> This part of code could be used by both normal and aux
> domain specific attach entries. Hence move them into a
> common function to avoid duplication.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Another trivial one (it's going to be one of those days).
Typo in the patch title.

> ---
>  drivers/iommu/intel-iommu.c | 60 ++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ee8832d26f7e..e9119d45a29d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5058,35 +5058,14 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
>  	domain_exit(to_dmar_domain(domain));
>  }
>  
> -static int intel_iommu_attach_device(struct iommu_domain *domain,
> -				     struct device *dev)
> +static int prepare_domain_attach_device(struct iommu_domain *domain,
> +					struct device *dev)
>  {
>  	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>  	struct intel_iommu *iommu;
>  	int addr_width;
>  	u8 bus, devfn;
>  
> -	if (device_is_rmrr_locked(dev)) {
> -		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
> -		return -EPERM;
> -	}
> -
> -	/* normally dev is not mapped */
> -	if (unlikely(domain_context_mapped(dev))) {
> -		struct dmar_domain *old_domain;
> -
> -		old_domain = find_domain(dev);
> -		if (old_domain) {
> -			rcu_read_lock();
> -			dmar_remove_one_dev_info(old_domain, dev);
> -			rcu_read_unlock();
> -
> -			if (!domain_type_is_vm_or_si(old_domain) &&
> -			     list_empty(&old_domain->devices))
> -				domain_exit(old_domain);
> -		}
> -	}
> -
>  	iommu = device_to_iommu(dev, &bus, &devfn);
>  	if (!iommu)
>  		return -ENODEV;
> @@ -5119,7 +5098,40 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>  		dmar_domain->agaw--;
>  	}
>  
> -	return domain_add_dev_info(dmar_domain, dev);
> +	return 0;
> +}
> +
> +static int intel_iommu_attach_device(struct iommu_domain *domain,
> +				     struct device *dev)
> +{
> +	int ret;
> +
> +	if (device_is_rmrr_locked(dev)) {
> +		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
> +		return -EPERM;
> +	}
> +
> +	/* normally dev is not mapped */
> +	if (unlikely(domain_context_mapped(dev))) {
> +		struct dmar_domain *old_domain;
> +
> +		old_domain = find_domain(dev);
> +		if (old_domain) {
> +			rcu_read_lock();
> +			dmar_remove_one_dev_info(old_domain, dev);
> +			rcu_read_unlock();
> +
> +			if (!domain_type_is_vm_or_si(old_domain) &&
> +			    list_empty(&old_domain->devices))
> +				domain_exit(old_domain);
> +		}
> +	}
> +
> +	ret = prepare_domain_attach_device(domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	return domain_add_dev_info(to_dmar_domain(domain), dev);
>  }
>  
>  static void intel_iommu_detach_device(struct iommu_domain *domain,


