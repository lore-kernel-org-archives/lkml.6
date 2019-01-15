Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6DEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605AD2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390513AbfAOVfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:35:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730508AbfAOVfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:35:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 066CDA12F8;
        Tue, 15 Jan 2019 21:35:01 +0000 (UTC)
Received: from [10.36.116.96] (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A654B6107F;
        Tue, 15 Jan 2019 21:34:56 +0000 (UTC)
Subject: Re: [RFC v3 04/21] vfio: VFIO_IOMMU_SET_PASID_TABLE
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@linux.intel.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com, ashok.raj@intel.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        peter.maydell@linaro.org
References: <20190108102633.17482-1-eric.auger@redhat.com>
 <20190108102633.17482-5-eric.auger@redhat.com>
 <20190111155028.4f0e2ddd@x1.home>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <7871c319-9a40-2752-c484-e89059e442f4@redhat.com>
Date:   Tue, 15 Jan 2019 22:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111155028.4f0e2ddd@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 15 Jan 2019 21:35:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 1/11/19 11:50 PM, Alex Williamson wrote:
> On Tue,  8 Jan 2019 11:26:16 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
>>
>> This patch adds VFIO_IOMMU_SET_PASID_TABLE ioctl which aims at
>> passing the virtual iommu guest configuration to the VFIO driver
>> downto to the iommu subsystem.
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v2 -> v3:
>> - s/BIND_PASID_TABLE/SET_PASID_TABLE
>>
>> v1 -> v2:
>> - s/BIND_GUEST_STAGE/BIND_PASID_TABLE
>> - remove the struct device arg
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 31 +++++++++++++++++++++++++++++++
>>  include/uapi/linux/vfio.h       |  8 ++++++++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 7651cfb14836..d9dd23f64f00 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -1644,6 +1644,24 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>>  	return ret;
>>  }
>>  
>> +static int
>> +vfio_set_pasid_table(struct vfio_iommu *iommu,
>> +		      struct vfio_iommu_type1_set_pasid_table *ustruct)
>> +{
>> +	struct vfio_domain *d;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&iommu->lock);
>> +
>> +	list_for_each_entry(d, &iommu->domain_list, next) {
>> +		ret = iommu_set_pasid_table(d->domain, &ustruct->config);
>> +		if (ret)
>> +			break;
>> +	}
> 
> There's no unwind on failure here, leaves us in an inconsistent state
> should something go wrong or domains don't have homogeneous PASID
> support.  What's expected to happen if a PASID table is already set for
> a domain, does it replace the old one or return -EBUSY?
Effectively the setting can succeed on one domain and fail on another
one, typically if one underlying SMMU does not support nested while the
others support it.

At the moment setting a new PASID table whereas one is installed does
not return any error in the SMMU code, just overwrite the associated
fields in the stream table entry. This is also the way we turn nested
off (cfg->bypass == true). Needs to be clarified anyway.
> 
>> +	mutex_unlock(&iommu->lock);
>> +	return ret;
>> +}
>> +
>>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>>  				   unsigned int cmd, unsigned long arg)
>>  {
>> @@ -1714,6 +1732,19 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>  
>>  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>>  			-EFAULT : 0;
>> +	} else if (cmd == VFIO_IOMMU_SET_PASID_TABLE) {
>> +		struct vfio_iommu_type1_set_pasid_table ustruct;
>> +
>> +		minsz = offsetofend(struct vfio_iommu_type1_set_pasid_table,
>> +				    config);
>> +
>> +		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
>> +			return -EFAULT;
>> +
>> +		if (ustruct.argsz < minsz || ustruct.flags)
>> +			return -EINVAL;
>> +
>> +		return vfio_set_pasid_table(iommu, &ustruct);
>>  	}
>>  
>>  	return -ENOTTY;
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 02bb7ad6e986..0d9f4090c95d 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -14,6 +14,7 @@
>>  
>>  #include <linux/types.h>
>>  #include <linux/ioctl.h>
>> +#include <linux/iommu.h>
>>  
>>  #define VFIO_API_VERSION	0
>>  
>> @@ -759,6 +760,13 @@ struct vfio_iommu_type1_dma_unmap {
>>  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>>  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>>  
>> +struct vfio_iommu_type1_set_pasid_table {
>> +	__u32	argsz;
>> +	__u32	flags;
>> +	struct iommu_pasid_table_config config;
>> +};
>> +#define VFIO_IOMMU_SET_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 22)
> 
> -ENOCOMMENTS  Thanks,
sure

Thanks

Eric
> 
> Alex
> 
>> +
>>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>>  
>>  /*
> 
