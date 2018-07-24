Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484DAECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6C220685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6C220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbeGXDKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:10:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:59447 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388233AbeGXDKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:10:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 19:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="69656121"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jul 2018 19:06:49 -0700
Subject: Re: [RFC PATCH 01/10] iommu/vt-d: Get iommu device for a mediated
 device
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA141D@SHSMSX104.ccr.corp.intel.com>
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
Message-ID: <5B5689B4.2080706@linux.intel.com>
Date:   Tue, 24 Jul 2018 10:06:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439CA141D@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

Thank you for reviewing my patch.

On 07/23/2018 12:44 PM, Liu, Yi L wrote:
> Hi Baolu,
>
> Per my understanding, the subject is not accurate. I think this patch is
> to get parent device structure for a mediate device instead of iommu
> device. This may be misleading for reviewers.

Please check below.

>
> Thanks,
> Yi Liu
>
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Sunday, July 22, 2018 2:09 PM
>>
>> This patch adds the support to get the iommu device for a mediated device. The
>> assumption is that each mediated device is a minimal assignable set of a physical PCI
>> device. Hence, we should use the iommu device of the parent PCI device to manage
>> the translation.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>  drivers/iommu/intel-iommu.c |  6 ++++++  drivers/iommu/intel-pasid.h | 16
>> ++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
>> 7d198ea..fc3ac1c 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -767,6 +767,12 @@ static struct intel_iommu *device_to_iommu(struct device
>> *dev, u8 *bus, u8 *devf
>>  	if (iommu_dummy(dev))
>>  		return NULL;
>>
>> +	if (dev_is_mdev(dev)) {
>> +		dev = dev_mdev_parent(dev);
>> +		if (WARN_ON(!dev_is_pci(dev)))
>> +			return NULL;
>> +	}
>> +

This gets the parent of a mediated device. And an iommu device will be
found which services the parent device. A mediated device should in the
same iommu scope as its parent.

Best regards,
Lu Baolu

>>  	if (dev_is_pci(dev)) {
>>  		struct pci_dev *pf_pdev;
>>
>> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h index
>> 518df72..46cde66 100644
>> --- a/drivers/iommu/intel-pasid.h
>> +++ b/drivers/iommu/intel-pasid.h
>> @@ -35,6 +35,22 @@ struct pasid_table {
>>  	struct list_head	dev;		/* device list */
>>  };
>>
>> +static inline bool dev_is_mdev(struct device *dev) {
>> +	if (!dev)
>> +		return false;
>> +
>> +	return !strcmp(dev->bus->name, "mdev"); }
>> +
>> +static inline struct device *dev_mdev_parent(struct device *dev) {
>> +	if (WARN_ON(!dev_is_mdev(dev)))
>> +		return NULL;
>> +
>> +	return dev->parent;
>> +}
>> +
>>  extern u32 intel_pasid_max_id;
>>  int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);  void
>> intel_pasid_free_id(int pasid);
>> --
>> 2.7.4
>

