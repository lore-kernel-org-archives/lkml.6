Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5DEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1141320865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1141320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeKZNGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:06:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:52483 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbeKZNGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:06:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2018 18:13:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,280,1539673200"; 
   d="scan'208";a="98970849"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2018 18:13:40 -0800
Cc:     baolu.lu@linux.intel.com, kevin.tian@intel.com,
        ashok.raj@intel.com, tiwei.bie@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH v4 2/8] iommu/vt-d: Add multiple domains per device query
To:     Auger Eric <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-3-baolu.lu@linux.intel.com>
 <929c8ce3-94f5-bcd5-89ff-71758b808b50@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <36911a68-ee47-20b7-c2a7-7a9c8d4d88f5@linux.intel.com>
Date:   Mon, 26 Nov 2018 10:10:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <929c8ce3-94f5-bcd5-89ff-71758b808b50@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/23/18 6:49 PM, Auger Eric wrote:
> Hi,
> 
> On 11/5/18 8:34 AM, Lu Baolu wrote:
>> Add the response to IOMMU_DEV_ATTR_AUXD_CAPABILITY capability query
>> through iommu_get_dev_attr().
> 
> commit title: Advertise auxiliary domain capability?

Yes. I should make it consistent. Thanks.

>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 38 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 5e149d26ea9b..298f7a3fafe8 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5167,6 +5167,24 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>>   	return phys;
>>   }
>>   
>> +static inline bool scalable_mode_support(void)
>> +{
>> +	struct dmar_drhd_unit *drhd;
>> +	struct intel_iommu *iommu;
>> +	bool ret = true;
>> +
>> +	rcu_read_lock();
>> +	for_each_active_iommu(iommu, drhd) {
>> +		if (!sm_supported(iommu)) {
>> +			ret = false;
>> +			break;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	return ret;
>> +}
>> +
>>   static bool intel_iommu_capable(enum iommu_cap cap)
>>   {
>>   	if (cap == IOMMU_CAP_CACHE_COHERENCY)
>> @@ -5331,6 +5349,25 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
>>   }
>>   #endif /* CONFIG_INTEL_IOMMU_SVM */
>>   
>> +static int intel_iommu_get_dev_attr(struct device *dev,
>> +				    enum iommu_dev_attr attr, void *data)
>> +{
>> +	int ret = 0;
>> +	bool *auxd_capable;
> nit: could be local to the case as other cases may use other datatypes.

I have thought about this. Making it local to the case needs extra "{}".
That's the reason I put it here. We can change it later when we need
other datatypes.

>> +
>> +	switch (attr) {
>> +	case IOMMU_DEV_ATTR_AUXD_CAPABILITY:
>> +		auxd_capable = data;
>> +		*auxd_capable = scalable_mode_support();
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   const struct iommu_ops intel_iommu_ops = {
>>   	.capable		= intel_iommu_capable,
>>   	.domain_alloc		= intel_iommu_domain_alloc,
>> @@ -5345,6 +5382,7 @@ const struct iommu_ops intel_iommu_ops = {
>>   	.get_resv_regions	= intel_iommu_get_resv_regions,
>>   	.put_resv_regions	= intel_iommu_put_resv_regions,
>>   	.device_group		= pci_device_group,
>> +	.get_dev_attr		= intel_iommu_get_dev_attr,
>>   	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>>   };
>>   
>>
> Thanks
> 
> Eric
> 
> 

Best regards,
Lu Baolu
