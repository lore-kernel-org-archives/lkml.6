Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCBFC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231F4214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231F4214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJQKFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:05:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:29796 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbeJQKFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:05:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 19:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="273042535"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2018 19:12:24 -0700
Cc:     baolu.lu@linux.intel.com, kevin.tian@intel.com,
        ashok.raj@intel.com, tiwei.bie@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/8] vfio/mdev: IOMMU aware mediated device
To:     Xu Zaibo <xuzaibo@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <20181012051632.26064-1-baolu.lu@linux.intel.com>
 <5BC1AC09.1060507@huawei.com>
 <f3ffd1a3-be4b-f041-e4da-2bbf065aa065@linux.intel.com>
 <5BC454DF.6010109@huawei.com>
 <40fc685e-a0be-5e54-2de7-6cd87c36dd80@linux.intel.com>
 <5BC69830.707@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e0d0c48d-eb73-4aeb-aad2-2b2df48009c9@linux.intel.com>
Date:   Wed, 17 Oct 2018 10:10:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BC69830.707@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/17/18 10:02 AM, Xu Zaibo wrote:
> Hi,
> 
> On 2018/10/16 9:21, Lu Baolu wrote:
>> Hi,
>>
>> On 10/15/2018 04:50 PM, Xu Zaibo wrote:
>>> Hi,
>>>
>>> On 2018/10/15 10:48, Lu Baolu wrote:
>>>> Hi,
>>>>
>>>> On 10/13/2018 04:25 PM, Xu Zaibo wrote:
>>>>> Hi,
>>>>>
>>>>> On 2018/10/12 13:16, Lu Baolu wrote:
>>>>>> Hi,
>>>>>>
>>>>>> The Mediate Device is a framework for fine-grained physical device
>>>>>> sharing across the isolated domains. Currently the mdev framework
>>>>>> is designed to be independent of the platform IOMMU support. As the
>>>>>> result, the DMA isolation relies on the mdev parent device in a
>>>>>> vendor specific way.
>>>>>>
>>>>>> There are several cases where a mediated device could be protected
>>>>>> and isolated by the platform IOMMU. For example, Intel vt-d rev3.0
>>>>>> [1] introduces a new translation mode called 'scalable mode', which
>>>>>> enables PASID-granular translations. The vt-d scalable mode is the
>>>>>> key ingredient for Scalable I/O Virtualization [2] [3] which allows
>>>>>> sharing a device in minimal possible granularity (ADI - Assignable
>>>>>> Device Interface).
>>>>>>
>>>>>> A mediated device backed by an ADI could be protected and isolated
>>>>>> by the IOMMU since 1) the parent device supports tagging an unique
>>>>>> PASID to all DMA traffic out of the mediated device; and 2) the DMA
>>>>>> translation unit (IOMMU) supports the PASID granular translation.
>>>>>> We can apply IOMMU protection and isolation to this kind of devices
>>>>>> just as what we are doing with an assignable PCI device.
>>>>>>
>>>>>> In order to distinguish the IOMMU-capable mediated devices from those
>>>>>> which still need to rely on parent devices, this patch set adds two
>>>>>> new members in struct mdev_device.
>>>>>>
>>>>>> * iommu_device
>>>>>>    - This, if set, indicates that the mediated device could
>>>>>>      be fully isolated and protected by IOMMU via attaching
>>>>>>      an iommu domain to this device. If empty, it indicates
>>>>>>      using vendor defined isolation.
>>>>>>
>>>>>> * iommu_domain
>>>>>>    - This is a place holder for an iommu domain. A domain
>>>>>>      could be store here for later use once it has been
>>>>>>      attached to the iommu_device of this mdev.
>>>>>>
>>>>>> Below helpers are added to set and get above iommu device
>>>>>> and iommu domain pointers in mdev core implementation.
>>>>>>
>>>>>> * mdev_set/get_iommu_device(dev, iommu_device)
>>>>>>    - Set or get the iommu device which represents this mdev
>>>>>>      in IOMMU's device scope. Drivers don't need to set the
>>>>>>      iommu device if it uses vendor defined isolation.
>>>>>>
>>>>>> * mdev_set/get_iommu_domain(domain)
>>>>>>    - A iommu domain which has been attached to the iommu
>>>>>>      device in order to protect and isolate the mediated
>>>>>>      device will be kept in the mdev data structure and
>>>>>>      could be retrieved later.
>>>>>>
>>>>>> The mdev parent device driver could opt-in that the mdev could be
>>>>>> fully isolated and protected by the IOMMU when the mdev is being
>>>>>> created by invoking mdev_set_iommu_device() in its @create().
>>>>> I just cannot understand here, how to get an iommu_device while I 
>>>>> create mediated
>>>>> device in my parent device driver?
>>>>
>>>> When you are creating an mdev in your parent driver, you should know
>>>> which PCI device this mdev belonging to.
>>>>
>>>
>>> So, generally, I can set the parent device as mdev's iommu_device?
>>> If that, however, Mdev already holds its parent device. So, I just 
>>> figure what
>>> differences between Mdev's parent device and iommu_device are.
>>>>>
>>>>> And why not reuse the device of MDEV instread of adding a new 
>>>>> device here?
>>>>
>>>> iommu_device in the mdev_device structure represents the PCI device
>>>> that represents this mdev in iommu's device scope. IOMMU is only aware
>>>> of pci devices, it's not aware of mdev device.
>>>
>>> Could I understand like that: IOMMU can be aware of the parent device 
>>> of Mdev?
>>> And more, I am doubting the necessary of iommu_device in Mdev.
>>>
>>
>> The "mdev parent device" and "mdev iommu device" are different although
>> they might be the same in practice. "mdev parent device" represents the
>> device who created the mdev. "mdev iommu device" represents the device
>> who shares the device context entry in iommu tables.
>>
>> "mdev iommu device" is always a PCI/PCIe device since IOMMU always use
>> source id (bus:dev:func) to walk the device context table. But there is
>> no limitation on who can create an mdev, right?
>>
> Actually, I am not sure.
> 
> My understanding:
> The DMA address will be issued by the parent device with PASID or 
> something like that to IOMMU
> facilities. However, the translation units such as iommu （PASID/page 
> .etx）tables are from another
> device node.  I cannot figure out how to control this in hardware level, 
> or whether there will be
> conflicts between the DMA transation of iommu_device and parent device.


Yes. That's the reason why these two devices are same in practice. But
conceptually, they might be different.

Best regards,
Lu Baolu
