Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB528C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D2320827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D2320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbeKGLTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:19:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:18979 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388849AbeKGLTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:19:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 17:51:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,473,1534834800"; 
   d="scan'208";a="94231230"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2018 17:51:21 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
To:     Alex Williamson <alex.williamson@redhat.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-7-baolu.lu@linux.intel.com>
 <20181106165356.44b59ec3@w520.home>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <edadb198-e4ab-ac23-4520-28bfcac252c3@linux.intel.com>
Date:   Wed, 7 Nov 2018 09:48:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181106165356.44b59ec3@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 11/7/18 7:53 AM, Alex Williamson wrote:
> On Mon,  5 Nov 2018 15:34:06 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> A parent device might create different types of mediated
>> devices. For example, a mediated device could be created
>> by the parent device with full isolation and protection
>> provided by the IOMMU. One usage case could be found on
>> Intel platforms where a mediated device is an assignable
>> subset of a PCI, the DMA requests on behalf of it are all
>> tagged with a PASID. Since IOMMU supports PASID-granular
>> translations (scalable mode in vt-d 3.0), this mediated
>> device could be individually protected and isolated by an
>> IOMMU.
>>
>> This patch adds two new members in struct mdev_device:
>> * iommu_device
>>    - This, if set, indicates that the mediated device could
>>      be fully isolated and protected by IOMMU via attaching
>>      an iommu domain to this device. If empty, it indicates
>>      using vendor defined isolation.
>>
>> * iommu_domain
>>    - This is a place holder for an iommu domain. A domain
>>      could be store here for later use once it has been
>>      attached to the iommu_device of this mdev.
>>
>> Below helpers are added to set and get above iommu device
>> and iommu domain pointers.
>>
>> * mdev_set/get_iommu_device(dev, iommu_device)
>>    - Set or get the iommu device which represents this mdev
>>      in IOMMU's device scope. Drivers don't need to set the
>>      iommu device if it uses vendor defined isolation.
>>
>> * mdev_set/get_iommu_domain(domain)
>>    - A iommu domain which has been attached to the iommu
>>      device in order to protect and isolate the mediated
>>      device will be kept in the mdev data structure and
>>      could be retrieved later.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/vfio/mdev/mdev_core.c    | 36 ++++++++++++++++++++++++++++++++
>>   drivers/vfio/mdev/mdev_private.h |  2 ++
>>   include/linux/mdev.h             | 23 ++++++++++++++++++++
>>   3 files changed, 61 insertions(+)
>>
>> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
>> index 0212f0ee8aea..5119809225c5 100644
>> --- a/drivers/vfio/mdev/mdev_core.c
>> +++ b/drivers/vfio/mdev/mdev_core.c
>> @@ -390,6 +390,42 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>>   	return 0;
>>   }
>>   
>> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
>> +{
>> +	struct mdev_device *mdev = to_mdev_device(dev);
>> +
>> +	mdev->iommu_device = iommu_device;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(mdev_set_iommu_device);
>> +
>> +struct device *mdev_get_iommu_device(struct device *dev)
>> +{
>> +	struct mdev_device *mdev = to_mdev_device(dev);
>> +
>> +	return mdev->iommu_device;
>> +}
>> +EXPORT_SYMBOL(mdev_get_iommu_device);
>> +
>> +int mdev_set_iommu_domain(struct device *dev, void *domain)
>> +{
>> +	struct mdev_device *mdev = to_mdev_device(dev);
>> +
>> +	mdev->iommu_domain = domain;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(mdev_set_iommu_domain);
>> +
>> +void *mdev_get_iommu_domain(struct device *dev)
>> +{
>> +	struct mdev_device *mdev = to_mdev_device(dev);
>> +
>> +	return mdev->iommu_domain;
>> +}
>> +EXPORT_SYMBOL(mdev_get_iommu_domain);
>> +
>>   static int __init mdev_init(void)
>>   {
>>   	return mdev_bus_register();
>> diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
>> index b5819b7d7ef7..c01518068e84 100644
>> --- a/drivers/vfio/mdev/mdev_private.h
>> +++ b/drivers/vfio/mdev/mdev_private.h
>> @@ -34,6 +34,8 @@ struct mdev_device {
>>   	struct list_head next;
>>   	struct kobject *type_kobj;
>>   	bool active;
>> +	struct device *iommu_device;
>> +	void *iommu_domain;
>>   };
>>   
>>   #define to_mdev_device(dev)	container_of(dev, struct mdev_device, dev)
>> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
>> index b6e048e1045f..c46777d3e568 100644
>> --- a/include/linux/mdev.h
>> +++ b/include/linux/mdev.h
>> @@ -14,6 +14,29 @@
>>   #define MDEV_H
>>   
>>   struct mdev_device;
>> +struct iommu_domain;
>> +
>> +/*
>> + * Called by the parent device driver to set the PCI device which represents
> 
> s/PCI //
> 
> There is no requirement or expectation that the device is PCI.
> 

Fair enough.

>> + * this mdev in iommu protection scope. By default, the iommu device is NULL,
>> + * that indicates using vendor defined isolation.
>> + *
>> + * @dev: the mediated device that iommu will isolate.
>> + * @iommu_device: a pci device which represents the iommu for @dev.
>> + *
>> + * Return 0 for success, otherwise negative error value.
>> + */
>> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device);
>> +
>> +struct device *mdev_get_iommu_device(struct device *dev);
>> +
>> +/*
>> + * Called by vfio iommu modules to save the iommu domain after a domain being
>> + * attached to the mediated device.
>> + */
>> +int mdev_set_iommu_domain(struct device *dev, void *domain);
>> +
>> +void *mdev_get_iommu_domain(struct device *dev);
> 
> I can't say I really understand the purpose of this, the cover letter
> indicates this is a placeholder, should we add it separately when we
> have a requirement for it?

Oh, I am sorry that I used a wrong word. It's not a placeholder for
something designed for future, but adding two members that will be used
in the following patches. Since they will be used in anther modules
(like vfio_iommu), we need function interfaces to get and set them.

mdev->iommu_device:
  -  This, if set, indicates that the mediated device could
     be fully isolated and protected by IOMMU via attaching
     an iommu domain to this device. If empty, it indicates
     using vendor defined isolation.

mdev->iommu_domain:
   - This is used to save the pointer of an iommu domain. Once
     a domain has been attached to the iommu_device, it should
     be stored here.

Sorry for the confusion.

Best regards,
Lu Baolu
