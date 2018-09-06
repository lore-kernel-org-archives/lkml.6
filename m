Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC85C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8CC2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8CC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeIFGDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:03:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:60497 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbeIFGDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:03:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 18:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="68728726"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2018 18:30:45 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
To:     Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F128F@SHSMSX101.ccr.corp.intel.com>
 <20180905131534.1e638e3e@t450s.home>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b3971adc-1df2-94b0-1fc8-79cc93316c67@linux.intel.com>
Date:   Thu, 6 Sep 2018 09:29:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905131534.1e638e3e@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/06/2018 03:15 AM, Alex Williamson wrote:
> On Wed, 5 Sep 2018 03:01:39 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
>>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>>> Sent: Thursday, August 30, 2018 12:09 PM
>>>    
>> [...]
>>>
>>> In order to distinguish the IOMMU-capable mediated devices from those
>>> which still need to rely on parent devices, this patch set adds a
>>> domain type attribute to each mdev.
>>>
>>> enum mdev_domain_type {
>>> 	DOMAIN_TYPE_NO_IOMMU,	/* Don't need any IOMMU support.
>>> 				 * All isolation and protection
>>> 				 * are handled by the parent
>>> 				 * device driver with a device
>>> 				 * specific mechanism.
>>> 				 */
>>> 	DOMAIN_TYPE_ATTACH_PARENT, /* IOMMU can isolate and
>>> protect
>>> 				    * the mdev, and the isolation
>>> 				    * domain should be attaced with
>>> 				    * the parent device.
>>> 				    */
>>> };
>>>    
>>
>> ATTACH_PARENT is not like a good counterpart to NO_IOMMU.
> 
> Please do not use NO_IOMMU, we already have a thing called
> vfio-noiommu, enabled through CONFIG_VFIO_NOIOMMU and module parameter
> enable_unsafe_noiommu_mode.  This is much, much too similar and will
> generate confusion.

Sure. Will remove this confusion.

> 
>> what about DOMAIN_TYPE_NO_IOMMU/DOMAIN_TYPE_IOMMU? whether
>> to attach parent device is just internal logic.
>>
>> Alternatively DOMAIN_TYPE_SOFTWARE/DOMAIN_TYPE_HARDWARE,
>> where software means iommu_domain is managed by software while
>> the other means managed by hardware.
> 
> I haven't gotten deep enough into the series to see how it's used, but
> my gut reaction is that we don't need an enum, we just need some sort
> of pointer on the mdev that points to an iommu_parent, which indicates
> the root of our IOMMU based isolation, or is NULL, which indicates we
> use vendor defined isolation as we have now.

It works as long as we can distinguish IOMMU based isolation and the
vendor defined isolation.

How about making the iommu_parent points the device structure who
created the mdev? If this pointer is NOT NULL we will bind the domain
to the device pointed to by it, otherwise, handle it in the vendor
defined way?

Best regards,
Lu Baolu

> 
>> One side note to Alex - with multiple domain extension in IOMMU layer,
>> this version combines IOMMU-capable usages in VFIO: PASID-based (as
>> in scalable iov) and RID-based (as the usage of mdev wrapper on any
>> device). Both cases share the common path - just binding the domain to the
>> parent device of mdev. IOMMU layer will handle two cases differently later.
> 
> Good, I'm glad you've considered the regular (RID) IOMMU domain and not
> just the new aux domain.  Thanks,
> 
> Alex
> 
