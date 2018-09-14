Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB88ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996CE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996CE2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeINUA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:00:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34732 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbeINUA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:00:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEF9080D;
        Fri, 14 Sep 2018 07:46:08 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DA7A3F575;
        Fri, 14 Sep 2018 07:46:06 -0700 (PDT)
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
 <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
 <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c285871d-2ea0-5878-c7ac-ffa4ba8256ee@arm.com>
Date:   Fri, 14 Sep 2018 15:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2018 01:35, Tian, Kevin wrote:
>>> Let's consider it from the API point of view.
>>>
>>> We have iommu_a(de)ttach_device() APIs to attach or detach a domain
>>> to/from a device. We should avoid applying a limitation of "these are
>>> only for single domain case, for multiple domains, use another API".
>>
>> That's an idealized view of the API, the actual semantics aren't as
>> simple. For IOMMU drivers that implement IOMMU_DOMAIN_DMA in their
>> domain_alloc operation (Arm SMMU, AMD IOMMU, ...), attach_dev
>> attaches
>> an unmanaged domain, detach_dev reattaches the default DMA domain,
>> and
>> the detach_dev IOMMU op is not called. We can't change that now, so it's
>> difficult to add more functionality to attach_dev and detach_dev.
>>
> 
> Now we have four possible usages on a(de)ttach_device:
> 
> 1) Normal DMA API path i.e. IOMMU_DOMAIN_DMA, for DMA operations
> in host/parent device driver;
> 
> 2) VFIO passthru path, when the physical device is assigned to user space
> or guest driver
> 
> 3) mdev passthru path 1, when mdev is assigned to user space or guest
> driver. Here mdev is a wrap on random PCI device
> 
> 4) mdev passthru path 2, when mdev is assigned to user space or guest
> driver. Here mdev is in a smaller granularity (e.g. tagged by PASID) as
> supported by vt-d scalable mode
> 
> 1) and 2) are existing usages. What you described (unmanaged vs. default)
> falls into this category.
> 
> 3) is actually same as 2) in IOMMU layer. sort of passing through DMA
> capability to guest. Though there is still a parent driver, the parent driver
> itself should not do DMA - i.e. unmanaged in host side.
> 
> 4) is a new code path introduced in IOMMU layer, which is what
> vfio_a(de)tach_aux_domain is trying to address. In this case parent device
> can still have its own DMA capability, using existing code path 1) (thus
> default domain still applies). and the parent device can have multiple 
> aux domains (and associated structures), using code path 4).

We still have the problem that detach() doesn't propagate to the IOMMU
driver. Here's the current flow, without mdev:

1) At boot, the PF's (parent device) driver is probed, and the IOMMU
core sets up a default DMA domain, to be used by dma_alloc by the PF's
driver.
-> iommu.c calls default_domain->ops->attach_dev(default_domain, dev)

2) or 3) Later userspace wants to control the PF, replaces the PF's
driver with vfio-pci. When userspace creates a container, VFIO allocates
a new IOMMU domain, and calls iommu_attach_group.
-> iommu.c calls domain->ops->attach_dev(domain, dev)
This detaches the PF from the default domain, and attaches it to the new
domain.

1) When the container is closed, VFIO calls iommu_detach_group. This
detaches the PF from its current domain, and attaches it back to the
default domain.
-> iommu.c calls default_domain->ops->attach_dev(default_domain, dev)

-----
Now with mdev, we still attach the DMA domain in 1). Then:

4) Userspace opens an mdev and creates a container. VFIO enables aux
domain for the device. VFIO allocates a new IOMMU domain, and calls
iommu_attach_device(domain1, parent_dev).
-> iommu.c calls domain->ops->attach_dev(domain1, dev)
Because the device is in "aux domain" state, the IOMMU driver does not
detach from the default domain, but instead allocates a PASID and
attaches the aux domain. (Side note: for SMMU we couldn't detach from
the default domain, because we need it for MSI mappings.)

4) Userspace opens another mdev.
-> iommu.c calls domain->ops->attach_dev(domain2, dev)

1)? When the container is closed, VFIO calls
iommu_detach_device(domain2, parent_dev)
-> iommu.c calls default_domain->ops->attach_dev(default_domain, dev)
Given that auxiliary domains are attached, the IOMMU driver could deduce
that this actually means "detach an auxiliary domain". But which one?

So the proposed interface doesn't seem to work as is. If we want to use
iommu_attach/detach_device for auxiliary domains, the existing behavior
of iommu.c, and IOMMU drivers that rely on it, have to change. Any
change I can think of right now seems more daunting than introducing a
different path for auxiliary domains, like iommu_attach_aux_domain for
example.

Thanks,
Jean
