Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C970DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D71A206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D71A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeIFF2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:28:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:11119 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeIFF2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:28:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 17:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="68722543"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2018 17:55:05 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH v2 02/10] iommu/vt-d: Add multiple domains per device
 query
To:     Alex Williamson <alex.williamson@redhat.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-3-baolu.lu@linux.intel.com>
 <20180905133540.5d7a7ea3@t450s.home>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ab3262a3-ab50-c107-e63f-17d17754c539@linux.intel.com>
Date:   Thu, 6 Sep 2018 08:54:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905133540.5d7a7ea3@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/06/2018 03:35 AM, Alex Williamson wrote:
> On Thu, 30 Aug 2018 12:09:14 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Add the response to IOMMU_CAP_AUX_DOMAIN capability query
>> through iommu_capable(). Return true if IOMMUs support the
>> scalable mode, return false otherwise.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 31 +++++++++++++++++++++++++++++--
>>   1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 3e49d4029058..891ae70e7bf2 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5193,12 +5193,39 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
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
>> -	if (cap == IOMMU_CAP_CACHE_COHERENCY)
>> +	switch (cap) {
>> +	case IOMMU_CAP_CACHE_COHERENCY:
>>   		return domain_update_iommu_snooping(NULL) == 1;
>> -	if (cap == IOMMU_CAP_INTR_REMAP)
>> +	case IOMMU_CAP_INTR_REMAP:
>>   		return irq_remapping_enabled == 1;
>> +	case IOMMU_CAP_AUX_DOMAIN:
>> +		return scalable_mode_support();
>> +	case IOMMU_CAP_NOEXEC:
>> +	/* PASSTHROUGH */
>> +	default:
>> +		pr_info("Unsupported capability query %d\n", cap);
>> +		break;
> 
> Please don't do this, there's no reason to be noisy about a query of a
> capability that VT-d doesn't know about.  We implement capabilities
> exactly so that relevant drivers can expose a feature and others can
> happily (and quietly) ignore them.  Thanks,

Fair enough. I will remove it in the next version.

Best regards,
Lu Baolu
