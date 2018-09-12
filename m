Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD238C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C3720866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C3720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeILHqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 03:46:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:15478 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeILHqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 03:46:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 19:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="69302811"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2018 19:44:03 -0700
Cc:     baolu.lu@linux.intel.com, kevin.tian@intel.com,
        ashok.raj@intel.com, tiwei.bie@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, jacob.jun.pan@intel.com, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
Date:   Wed, 12 Sep 2018 10:42:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/11/2018 12:22 AM, Jean-Philippe Brucker wrote:
> Hi,
> 
> On 30/08/2018 05:09, Lu Baolu wrote:
>> Below APIs are introduced in the IOMMU glue for device drivers to use
>> the finer granularity translation.
>>
>> * iommu_capable(IOMMU_CAP_AUX_DOMAIN)
>>    - Represents the ability for supporting multiple domains per device
>>      (a.k.a. finer granularity translations) of the IOMMU hardware.
> 
> iommu_capable() cannot represent hardware capabilities, we need
> something else for systems with multiple IOMMUs that have different
> caps. How about iommu_domain_get_attr on the device's domain instead?

Domain is not a good choice for per iommu cap query. A domain might be
attached to devices belonging to different iommu's.

How about an API with device structure as parameter? A device always
belongs to a specific iommu. This API is supposed to be used the
device driver.

> 
>> * iommu_en(dis)able_aux_domain(struct device *dev)
>>    - Enable/disable the multiple domains capability for a device
>>      referenced by @dev.
>>
>> * iommu_auxiliary_id(struct iommu_domain *domain)
>>    - Return the index value used for finer-granularity DMA translation.
>>      The specific device driver needs to feed the hardware with this
>>      value, so that hardware device could issue the DMA transaction with
>>      this value tagged.
> 
> This could also reuse iommu_domain_get_attr.
> 
> 
> More generally I'm having trouble understanding how auxiliary domains
> will be used. So VFIO allocates PASIDs like this:

As I wrote in the cover letter, "auxiliary domain" is just a name to
ease discussion. It's actually has no special meaning (we think a domain
as an isolation boundary which could be used by the IOMMU to isolate
the DMA transactions out of a PCI device or partial of it).

So drivers like vfio should see no difference when use an auxiliary
domain. The auxiliary domain is not aware out of iommu driver.

> 
> * iommu_enable_aux_domain(parent_dev)
> * iommu_domain_alloc() -> dom1
> * iommu_domain_alloc() -> dom2
> * iommu_attach_device(dom1, parent_dev)
>    -> dom1 gets PASID #1
> * iommu_attach_device(dom2, parent_dev)
>    -> dom2 gets PASID #2
> 
> Then I'm not sure about the next steps, when userspace does
> VFIO_IOMMU_MAP_DMA or VFIO_IOMMU_BIND on an mdev's container. Is the
> following use accurate?
> 
> For the single translation level:
> * iommu_map(dom1, ...) updates first-level/second-level pgtables for
> PASID #1
> * iommu_map(dom2, ...) updates first-level/second-level pgtables for
> PASID #2
> 
> Nested translation:
> * iommu_map(dom1, ...) updates second-level pgtables for PASID #1
> * iommu_bind_table(dom1, ...) binds first-level pgtables, provided by
> the guest, for PASID #1
> * iommu_map(dom2, ...) updates second-level pgtables for PASID #2
> * iommu_bind_table(dom2, ...) binds first-level pgtables for PASID #2
> >
> I'm trying to understand how to implement this with SMMU and other

This is proposed for architectures which support finer granularity
second level translation with no impact on architectures which only
support Source ID or the similar granularity.

> IOMMUs. It's not a clean fit since we have a single domain to hold the
> second-level pgtables. 

Do you mind explaining why a domain holds multiple second-level
pgtables? Shouldn't that be multiple domains?

> Then again, the nested case probably doesn't
> matter for us - we might as well assign the parent directly, since all
> mdevs have the same second-level and can only be assigned to the same VM.
> 
> 
> Also, can non-VFIO device drivers use auxiliary domains to do map/unmap
> on PASIDs? They are asking to do that and I'm proposing the private
> PASID thing, but since aux domains provide a similar feature we should
> probably converge somehow.

Yes, any non-VFIO device driver could use aux domain as well. The use
model is:

iommu_enable_aux_domain(dev)
-- enables aux domain support for this device

iommu_domain_alloc(dev)
-- allocate an iommu domain

iommu_attach_device(domain, dev)
-- attach the domain to device

iommu_auxiliary_id(domain)
-- retrieve the pasid id used by this domain

The device driver then

iommu_map(domain, ...)

set the pasid id to hardware register and start to do dma.

Best regards,
Lu Baolu
