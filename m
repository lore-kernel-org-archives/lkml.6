Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC95AECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31C020875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31C020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbeGXD0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:26:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:35964 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388233AbeGXD0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:26:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 19:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,396,1526367600"; 
   d="scan'208";a="69658700"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jul 2018 19:22:23 -0700
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B568D5B.5050606@linux.intel.com>
Date:   Tue, 24 Jul 2018 10:22:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/23/2018 12:44 PM, Liu, Yi L wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Sunday, July 22, 2018 2:09 PM
>>
>> With the Intel IOMMU supporting PASID granularity isolation and protection, a
>> mediated device could be isolated and protected by an IOMMU unit. We need to
>> allocate a new group instead of a PCI group.
> Existing vfio mdev framework also allocates an iommu group for mediate device.
>
> mdev_probe()
>   |_ mdev_attach_iommu()
>        |_ iommu_group_alloc()

When external components ask iommu to allocate a group for a device,
it will call pci_device_group in Intel IOMMU driver's @device_group
callback. In another word, current Intel IOMMU driver doesn't aware
the mediated device and treat all devices as PCI ones. This patch
extends the @device_group call back to make it aware of a mediated
device.

Best regards,
Lu Baolu

>
> IMHO, this patch actually do a wrapper to the group allocation API. The reason is: it
> is not necessary to apply the group allocation rules when the allocation is for mediated
> device. Instead, just allocate a new one for it. :)
>
> Thanks,
> Yi Liu
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>  drivers/iommu/intel-iommu.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
>> 3ede34a..57ccfc4 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5276,6 +5276,17 @@ static void intel_iommu_put_resv_regions(struct device
>> *dev,
>>  	}
>>  }
>>
>> +static struct iommu_group *intel_iommu_device_group(struct device *dev)
>> +{
>> +	if (dev_is_pci(dev))
>> +		return pci_device_group(dev);
>> +
>> +	if (dev_is_mdev(dev))
>> +		return iommu_group_alloc();
>> +
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev
>> *sdev)  { @@ -5370,7 +5381,7 @@ const struct iommu_ops intel_iommu_ops = {
>>  	.remove_device		= intel_iommu_remove_device,
>>  	.get_resv_regions	= intel_iommu_get_resv_regions,
>>  	.put_resv_regions	= intel_iommu_put_resv_regions,
>> -	.device_group		= pci_device_group,
>> +	.device_group		= intel_iommu_device_group,
>>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>>  };
>>
>> --
>> 2.7.4
>

