Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C95C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8742120844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8742120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeIGGww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:52:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:38948 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbeIGGwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:52:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 19:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="69016940"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2018 19:14:21 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 08/12] iommu/vt-d: Pass pasid table to context mapping
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-9-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2C7A@SHSMSX101.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cbf798c6-180a-1c57-64c2-7713803eb888@linux.intel.com>
Date:   Fri, 7 Sep 2018 10:13:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2C7A@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/06/2018 11:17 AM, Tian, Kevin wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Thursday, August 30, 2018 9:35 AM
>>
>> So that the pasid related info, such as the pasid table and the
>> maximum of pasid could be used during setting up scalable mode
>> context.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 

Thank you, Kevin.

Best regards,
Lu Baolu

>> ---
>>   drivers/iommu/intel-iommu.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index c3bf2ccf094d..33642dd3d6ba 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1942,6 +1942,7 @@ static void domain_exit(struct dmar_domain
>> *domain)
>>
>>   static int domain_context_mapping_one(struct dmar_domain *domain,
>>   				      struct intel_iommu *iommu,
>> +				      struct pasid_table *table,
>>   				      u8 bus, u8 devfn)
>>   {
>>   	u16 did = domain->iommu_did[iommu->seq_id];
>> @@ -2064,6 +2065,7 @@ static int domain_context_mapping_one(struct
>> dmar_domain *domain,
>>   struct domain_context_mapping_data {
>>   	struct dmar_domain *domain;
>>   	struct intel_iommu *iommu;
>> +	struct pasid_table *table;
>>   };
>>
>>   static int domain_context_mapping_cb(struct pci_dev *pdev,
>> @@ -2072,25 +2074,31 @@ static int domain_context_mapping_cb(struct
>> pci_dev *pdev,
>>   	struct domain_context_mapping_data *data = opaque;
>>
>>   	return domain_context_mapping_one(data->domain, data-
>>> iommu,
>> -					  PCI_BUS_NUM(alias), alias & 0xff);
>> +					  data->table, PCI_BUS_NUM(alias),
>> +					  alias & 0xff);
>>   }
>>
>>   static int
>>   domain_context_mapping(struct dmar_domain *domain, struct device
>> *dev)
>>   {
>> +	struct domain_context_mapping_data data;
>> +	struct pasid_table *table;
>>   	struct intel_iommu *iommu;
>>   	u8 bus, devfn;
>> -	struct domain_context_mapping_data data;
>>
>>   	iommu = device_to_iommu(dev, &bus, &devfn);
>>   	if (!iommu)
>>   		return -ENODEV;
>>
>> +	table = intel_pasid_get_table(dev);
>> +
>>   	if (!dev_is_pci(dev))
>> -		return domain_context_mapping_one(domain, iommu, bus,
>> devfn);
>> +		return domain_context_mapping_one(domain, iommu,
>> table,
>> +						  bus, devfn);
>>
>>   	data.domain = domain;
>>   	data.iommu = iommu;
>> +	data.table = table;
>>
>>   	return pci_for_each_dma_alias(to_pci_dev(dev),
>>   				      &domain_context_mapping_cb, &data);
>> --
>> 2.17.1
> 
> 
