Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeEBDJ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 23:09:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:61508 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeEBDJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 23:09:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="42290114"
Subject: Re: [PATCH 6/9] iommu/vt-d: Allocate and free pasid table
To: "Liu, Yi L" <yi.l.liu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
 <1523934202-21669-7-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439BE752C@SHSMSX104.ccr.corp.intel.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AE92BF9.2090106@linux.intel.com>
Date: Wed, 2 May 2018 11:09:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BE752C@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/01/2018 05:22 PM, Liu, Yi L wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Tuesday, April 17, 2018 11:03 AM
>>
>> This patch allocates PASID table for a domain at the time when
>> it is being created (if any devices using this domain supports
>> PASID feature), and free it when the domain is freed.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>  drivers/iommu/intel-iommu.c | 13 +++++++++++++
>>  drivers/iommu/intel-svm.c   |  8 --------
>>  include/linux/intel-iommu.h | 10 ++++++++--
>>  3 files changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index caa0b5c..99c643b 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2460,6 +2460,18 @@ static struct dmar_domain
>> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>  		dev->archdata.iommu = info;
>>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>>
>> +	if (dev && dev_is_pci(dev) && info->pasid_supported) {
>> +		if (pasid_enabled(iommu)) {
>> +			size_t size, count;
>> +
>> +			size = sizeof(struct pasid_entry);
>> +			count = min_t(int,
>> +				      pci_max_pasids(to_pci_dev(dev)),
>> +				      intel_pasid_max_id);
>> +			ret = intel_pasid_alloc_table(dev, size, count);
> No check for the return value?

Nice catch. Will fix it in a v2.

>
>> +		}
>> +	}
>> +
>>  	if (dev && domain_context_mapping(domain, dev)) {
>>  		pr_err("Domain context map for %s failed\n", dev_name(dev));
>>  		dmar_remove_one_dev_info(domain, dev);
>> @@ -4826,6 +4838,7 @@ static void dmar_remove_one_dev_info(struct
>> dmar_domain *domain,
>>  	unsigned long flags;
>>
>>  	spin_lock_irqsave(&device_domain_lock, flags);
>> +	intel_pasid_free_table(dev);
>>  	info = dev->archdata.iommu;
>>  	__dmar_remove_one_dev_info(info);
>>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index 24d0ea1..3abc94f 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -34,14 +34,6 @@
>>
>>  static irqreturn_t prq_event_thread(int irq, void *d);
>>
>> -struct pasid_entry {
>> -	u64 val;
>> -};
>> -
>> -struct pasid_state_entry {
>> -	u64 val;
>> -};
>> -
>>  int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>>  {
>>  	struct page *pages;
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index bee7a3f..08e5811 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -382,8 +382,14 @@ enum {
>>  #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
>>  #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
>>
>> -struct pasid_entry;
>> -struct pasid_state_entry;
>> +struct pasid_entry {
>> +	u64 val;
>> +};
>> +
>> +struct pasid_state_entry {
>> +	u64 val;
>> +};
>> +
>>  struct page_req_dsc;
>>
>>  struct dmar_domain {
> Overall, this patch looks good to me. But need to fix the comment above.
>
> Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>
>
> Regards,
> Yi Liu

Sure.

Best regards,
Lu Baolu
