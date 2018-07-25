Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3870C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740FE20856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740FE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbeGYC16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:27:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:10073 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388485AbeGYC16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:27:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 18:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="74233089"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2018 18:18:25 -0700
Subject: Re: [RFC PATCH 01/10] iommu/vt-d: Get iommu device for a mediated
 device
To:     Alex Williamson <alex.williamson@redhat.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
 <20180724125056.4ae477c9@t450s.home>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        peterx@redhat.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B57CFDD.1070505@linux.intel.com>
Date:   Wed, 25 Jul 2018 09:18:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180724125056.4ae477c9@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 07/25/2018 02:50 AM, Alex Williamson wrote:
> On Sun, 22 Jul 2018 14:09:24 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
>> This patch adds the support to get the iommu device for a mediated
>> device. The assumption is that each mediated device is a minimal
>> assignable set of a physical PCI device. Hence, we should use the
>> iommu device of the parent PCI device to manage the translation.
> Hmm, is this absolutely a valid assumption?  I'm afraid there's an
> assumption throughout this series that the only way an mdev device
> could be interacting with the IOMMU is via S-IOV, but we could choose
> today to make an mdev wrapper for any device, which might provide basic
> RID granularity to the IOMMU.  So if I make an mdev wrapper for a PF
> such that I can implement migration for that device, is it valid for
> the IOMMU driver to flag me as an mdev device and base mappings on my
> parent device? 

You are right. We should not make it SIOV centric. Let me look into the
patches and identify/fix the unreasonable assumptions.

>  Perhaps in this patch we can assume that the parent of
> such an mdev device would be the PF backing it and that results in the
> correct drhd,

Okay.

>  but in the next patch we start imposing the assumption
> that because the device is an mdev, the only valid association is via
> pasid, which I'd say is incorrect.

You are right. I will find and fix it.

>  
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>  drivers/iommu/intel-iommu.c |  6 ++++++
>>  drivers/iommu/intel-pasid.h | 16 ++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 7d198ea..fc3ac1c 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -767,6 +767,12 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>>  	if (iommu_dummy(dev))
>>  		return NULL;
>>  
>> +	if (dev_is_mdev(dev)) {
>> +		dev = dev_mdev_parent(dev);
>> +		if (WARN_ON(!dev_is_pci(dev)))
>> +			return NULL;
>> +	}
>> +
>>  	if (dev_is_pci(dev)) {
>>  		struct pci_dev *pf_pdev;
>>  
>> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
>> index 518df72..46cde66 100644
>> --- a/drivers/iommu/intel-pasid.h
>> +++ b/drivers/iommu/intel-pasid.h
>> @@ -35,6 +35,22 @@ struct pasid_table {
>>  	struct list_head	dev;		/* device list */
>>  };
>>  
>> +static inline bool dev_is_mdev(struct device *dev)
>> +{
>> +	if (!dev)
>> +		return false;
>> +
>> +	return !strcmp(dev->bus->name, "mdev");
>> +}
> I assume we're not using mdev_bus_type because mdev is a loadable
> module and that symbol doesn't exist in this statically loaded driver,

Yes.

> but strcmp is a pretty ugly alternative.  Could we use symbol_get() so
> that we can use mdev_bus_type?  Thanks,

Sure.

Best regards,
Lu Baolu
