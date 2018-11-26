Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FC6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27382086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27382086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeKZOAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:00:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:56608 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbeKZOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:00:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2018 19:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,280,1539673200"; 
   d="scan'208";a="98986304"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2018 19:07:58 -0800
Cc:     baolu.lu@linux.intel.com, kevin.tian@intel.com,
        ashok.raj@intel.com, tiwei.bie@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH v4 7/8] vfio/type1: Add domain at(de)taching group helpers
To:     Auger Eric <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-8-baolu.lu@linux.intel.com>
 <b5f5eda1-2dbf-dd7e-3b68-bfd9e5099c06@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <13a8bda6-1e66-66b9-6670-70d1b71ab50a@linux.intel.com>
Date:   Mon, 26 Nov 2018 11:05:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b5f5eda1-2dbf-dd7e-3b68-bfd9e5099c06@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/23/18 10:13 PM, Auger Eric wrote:
> Hi Lu,
> 
> On 11/5/18 8:34 AM, Lu Baolu wrote:
>> This adds helpers to attach or detach a domain to a
>> group. This will replace iommu_attach_group() which
>> only works for pci devices.
> s/pci/non mdev?

... which doesn't work for mdev devices.

>>
>> If a domain is attaching to a group which includes the
>> mediated devices, it should attach to the iommu device
>> (a pci device which represents the mdev in iommu scope)
>> instead. The added helper supports attaching domain to
>> groups for both pci and mdev devices.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 114 ++++++++++++++++++++++++++++++--
>>   1 file changed, 107 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index d9fd3188615d..178264b330e7 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -91,6 +91,7 @@ struct vfio_dma {
>>   struct vfio_group {
>>   	struct iommu_group	*iommu_group;
>>   	struct list_head	next;
>> +	bool			mdev_group;	/* An mdev group */
>>   };
>>   
>>   /*
>> @@ -1327,6 +1328,105 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
>>   	return ret;
>>   }
>>   
>> +static struct device *vfio_mdev_get_iommu_device(struct device *dev)
>> +{
>> +	struct device *(*fn)(struct device *dev);
>> +	struct device *iommu_parent;
>> +
>> +	fn = symbol_get(mdev_get_iommu_device);
>> +	if (fn) {
>> +		iommu_parent = fn(dev);
>> +		symbol_put(mdev_get_iommu_device);
>> +
>> +		return iommu_parent;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int vfio_mdev_set_domain(struct device *dev, struct iommu_domain *domain)
>> +{
>> +	int (*fn)(struct device *dev, void *domain);
>> +	int ret;
>> +
>> +	fn = symbol_get(mdev_set_iommu_domain);
>> +	if (fn) {
>> +		ret = fn(dev, domain);
>> +		symbol_put(mdev_set_iommu_domain);
>> +
>> +		return ret;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int vfio_mdev_attach_domain(struct device *dev, void *data)
>> +{
>> +	struct iommu_domain *domain = data;
>> +	struct device *iommu_device;
>> +	int ret;
>> +
>> +	ret = vfio_mdev_set_domain(dev, domain);
>> +	if (ret)
>> +		return ret;
>> +
>> +	iommu_device = vfio_mdev_get_iommu_device(dev);
>> +	if (iommu_device) {
>> +		bool aux_mode = false;
>> +
>> +		iommu_get_dev_attr(iommu_device,
>> +				   IOMMU_DEV_ATTR_AUXD_ENABLED, &aux_mode);
> Don' you need to test the returned value before using aux_mode?

Yes. Good catch.

>> +		if (aux_mode)
>> +			return iommu_attach_device_aux(domain, iommu_device);
>> +		else
>> +			return iommu_attach_device(domain, iommu_device);
> if for some reason the above ops fail, don't you want to call
> vfio_mdev_set_domain(dev, NULL)

Yes. Good catch.

> 
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int vfio_mdev_detach_domain(struct device *dev, void *data)
>> +{
>> +	struct iommu_domain *domain = data;
>> +	struct device *iommu_device;
>> +
>> +	vfio_mdev_set_domain(dev, NULL);
>> +	iommu_device = vfio_mdev_get_iommu_device(dev);
>> +	if (iommu_device) {
>> +		bool aux_mode = false;
>> +
>> +		iommu_get_dev_attr(iommu_device,
>> +				   IOMMU_DEV_ATTR_AUXD_ENABLED, &aux_mode);
> same here

Will fix it.

>> +		if (aux_mode)
>> +			iommu_detach_device_aux(domain, iommu_device);
>> +		else
>> +			iommu_detach_device(domain, iommu_device);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int vfio_iommu_attach_group(struct vfio_domain *domain,
>> +				   struct vfio_group *group)
>> +{
>> +	if (group->mdev_group)
>> +		return iommu_group_for_each_dev(group->iommu_group,
>> +						domain->domain,
>> +						vfio_mdev_attach_domain);
>> +	else
>> +		return iommu_attach_group(domain->domain, group->iommu_group);
>> +}
>> +
>> +static void vfio_iommu_detach_group(struct vfio_domain *domain,
>> +				    struct vfio_group *group)
>> +{
>> +	if (group->mdev_group)
>> +		iommu_group_for_each_dev(group->iommu_group, domain->domain,
>> +					 vfio_mdev_detach_domain);
>> +	else
>> +		iommu_detach_group(domain->domain, group->iommu_group);
>> +}
>> +
>>   static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   					 struct iommu_group *iommu_group)
>>   {
>> @@ -1402,7 +1502,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   			goto out_domain;
>>   	}
>>   
>> -	ret = iommu_attach_group(domain->domain, iommu_group);
>> +	ret = vfio_iommu_attach_group(domain, group);
>>   	if (ret)
>>   		goto out_domain;
>>   
>> @@ -1434,8 +1534,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   	list_for_each_entry(d, &iommu->domain_list, next) {
>>   		if (d->domain->ops == domain->domain->ops &&
>>   		    d->prot == domain->prot) {
>> -			iommu_detach_group(domain->domain, iommu_group);
>> -			if (!iommu_attach_group(d->domain, iommu_group)) {
>> +			vfio_iommu_detach_group(domain, group);
>> +			if (!vfio_iommu_attach_group(d, group)) {
>>   				list_add(&group->next, &d->group_list);
>>   				iommu_domain_free(domain->domain);
>>   				kfree(domain);
>> @@ -1443,7 +1543,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   				return 0;
>>   			}
>>   
>> -			ret = iommu_attach_group(domain->domain, iommu_group);
>> +			ret = vfio_iommu_attach_group(domain, group);
>>   			if (ret)
>>   				goto out_domain;
>>   		}
>> @@ -1469,7 +1569,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   	return 0;
>>   
>>   out_detach:
>> -	iommu_detach_group(domain->domain, iommu_group);
>> +	vfio_iommu_detach_group(domain, group);
>>   out_domain:
>>   	iommu_domain_free(domain->domain);
>>   out_free:
>> @@ -1560,7 +1660,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>   		if (!group)
>>   			continue;
>>   
>> -		iommu_detach_group(domain->domain, iommu_group);
>> +		vfio_iommu_detach_group(domain, group);
>>   		list_del(&group->next);
>>   		kfree(group);
>>   		/*
>> @@ -1625,7 +1725,7 @@ static void vfio_release_domain(struct vfio_domain *domain, bool external)
>>   	list_for_each_entry_safe(group, group_tmp,
>>   				 &domain->group_list, next) {
>>   		if (!external)
>> -			iommu_detach_group(domain->domain, group->iommu_group);
>> +			vfio_iommu_detach_group(domain, group);
>>   		list_del(&group->next);
>>   		kfree(group);
>>   	}
>>
> Thanks
> 
> Eric
> 

Best regards,
Lu Baolu
