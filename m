Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA638C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB4620883
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB4620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbeGYDQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:16:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:47049 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388461AbeGYDQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:16:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 19:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="67299639"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2018 19:06:44 -0700
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
 <5B568D5B.5050606@linux.intel.com>
 <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B57DB30.6070306@linux.intel.com>
Date:   Wed, 25 Jul 2018 10:06:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

Pull Kevin in. Not sure why he was removed from cc list.

On 07/24/2018 07:30 PM, Jean-Philippe Brucker wrote:
> Hi Baolu,
>
> On 24/07/18 03:22, Lu Baolu wrote:
>> Hi,
>>
>> On 07/23/2018 12:44 PM, Liu, Yi L wrote:
>>>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>>>> Sent: Sunday, July 22, 2018 2:09 PM
>>>>
>>>> With the Intel IOMMU supporting PASID granularity isolation and protection, a
>>>> mediated device could be isolated and protected by an IOMMU unit. We need to
>>>> allocate a new group instead of a PCI group.
>>> Existing vfio mdev framework also allocates an iommu group for mediate device.
>>>
>>> mdev_probe()
>>>   |_ mdev_attach_iommu()
>>>        |_ iommu_group_alloc()
>> When external components ask iommu to allocate a group for a device,
>> it will call pci_device_group in Intel IOMMU driver's @device_group
>> callback. In another word, current Intel IOMMU driver doesn't aware
>> the mediated device and treat all devices as PCI ones. This patch
>> extends the @device_group call back to make it aware of a mediated
>> device.
> I agree that allocating two groups for an mdev seems strange, and in my
> opinion we shouldn't export the notion of mdev to IOMMU drivers.
> Otherwise each driver will have to add its own "dev_is_mdev()" special
> cases, which will get messy in the long run. Besides, the macro is
> currently private, and to be exported it should be wrapped in
> symbol_get/put(mdev_bus_type).

I agree with you.

It should be better if we can make it in a driver agnostic way.

>
> There is another way: as we're planning to add a generic pasid_alloc()
> function to the IOMMU API, the mdev module itself could allocate a
> default PASID for each mdev by calling pasid_alloc() on the mdev's
> parent, and then do map()/unmap() with that PASID. This way we don't
> have to add IOMMU ops to the mdev bus, everything can still be done
> using the ops of the parent. And IOMMU drivers "only" have to implement
> PASID ops, which will be reused by drivers other than mdev.

A quick question when I thinking about this is how to allocate a domain
for the mediated device who uses the default pasid for DMA transactions?

Best regards,
Lu Baolu

>
> The allocated PASID also needs to be installed into the parent device.
> If the mdev module knows the PASID, we can do that by adding
> set_pasid(mdev, pasid) and clear_pasid(mdev, pasid) operations to
> mdev_parent_ops.
>
> Thanks,
> Jean
>
>

