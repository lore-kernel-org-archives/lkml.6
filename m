Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6090C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5196720866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5196720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeIMUNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:13:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49798 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbeIMUNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:13:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26CE57A9;
        Thu, 13 Sep 2018 08:03:18 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.Emea.Arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D79C13F557;
        Thu, 13 Sep 2018 08:03:15 -0700 (PDT)
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
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
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
 <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
 <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
Date:   Thu, 13 Sep 2018 16:03:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2018 01:19, Tian, Kevin wrote:
>>> This is proposed for architectures which support finer granularity
>>> second level translation with no impact on architectures which only
>>> support Source ID or the similar granularity.
>>
>> Just to be clear, in this paragraph you're only referring to the
>> Nested/second-level translation for mdev, which is specific to vt-d
>> rev3? Other architectures can still do first-level translation with
>> PASID, to support some use-cases of IOMMU aware mediated device
>> (assigning mdevs to userspace drivers, for example)
> 
> yes. aux domain concept applies only to vt-d rev3 which introduces
> scalable mode. Care is taken to avoid breaking usages on existing
> architectures.
> 
> one note. Assigning mdevs to user space alone doesn't imply IOMMU
> aware. All existing mdev usages use software or proprietary methods to
> isolate DMA. There is only one potential IOMMU aware mdev usage 
> which we talked not rely on vt-d rev3 scalable mode - wrap a random 
> PCI device into a single mdev instance (no sharing). In that case mdev 
> inherits RID from parent PCI device, thus is isolated by IOMMU in RID 
> granular. Our RFC supports this usage too. In VFIO two usages (PASID-
> based and RID-based) use same code path, i.e. always binding domain to
> the parent device of mdev. But within IOMMU they go different paths.
> PASID-based will go to aux-domain as iommu_enable_aux_domain
> has been called on that device. RID-based will follow existing 
> unmanaged domain path, as if it is parent device assignment.

For Arm SMMU we're more interested in the PASID-granular case than the
RID-granular one. It doesn't necessarily require vt-d rev3 scalable
mode, the following example can be implemented with an SMMUv3, since it
only needs PASID-granular first-level translation:

We have a PCI function that supports PASID, and can be partitioned into
multiple isolated entities, mdevs. Each mdev has an MMIO frame, an MSI
vector and a PASID.

Different processes (userspace drivers, not QEMU) each open one mdev. A
process controlling one mdev has two ways of doing DMA:

(1) Classically, the process uses a VFIO_TYPE1v2_IOMMU container. This
creates an auxiliary domain for the mdev, with PASID #35. The process
creates DMA mappings with VFIO_IOMMU_MAP_DMA. VFIO calls iommu_map on
the auxiliary domain. The IOMMU driver populates the pgtables associated
with PASID #35.

(2) SVA. One way of doing it: the process uses a new
"VFIO_TYPE1_SVA_IOMMU" type of container. VFIO binds the process address
space to the device, gets PASID #35. Simpler, but not everyone wants to
use SVA, especially not userspace drivers which need the highest
performance.


This example only needs to modify first-level translation, and works
with SMMUv3. The kernel here could be the host, in which case
second-level translation is disabled in the SMMU, or it could be the
guest, in which case second-level mappings are created by QEMU and
first-level translation is managed by assigning PASID tables to the guest.

So (2) would use iommu_sva_bind_device(), but (1) needs something else.
Aren't auxiliary domains suitable for (1)? Why limit auxiliary domain to
second-level or nested translation? It seems silly to use a different
API for first-level, since the flow in userspace and VFIO is the same as
your second-level case as far as MAP_DMA ioctl goes. The difference is
that in your case the auxiliary domain supports an additional operation
which binds first-level page tables. An auxiliary domain that only
supports first-level wouldn't support this operation, but it can still
implement iommu_map/unmap/etc.


Another note: if for some reason you did want to allow userspace to
choose between first-level or second-level, you could implement the
VFIO_TYPE1_NESTING_IOMMU container. It acts like a VFIO_TYPE1v2_IOMMU,
but also sets the DOMAIN_ATTR_NESTING on the IOMMU domain. So DMA_MAP
ioctl on a NESTING container would populate second-level, and DMA_MAP on
a normal container populates first-level. But if you're always going to
use second-level by default, the distinction isn't necessary.


>> Sounds good, I'll drop the private PASID patch if we can figure out a
>> solution to the attach/detach_dev problem discussed on patch 8/10
>>
> 
> Can you elaborate a bit on private PASID usage? what is the
> high level flow on it? 
> 
> Again based on earlier explanation, aux domain is specific to IOMMU
> architecture supporting vtd scalable mode-like capability, which allows
> separate 2nd/1st level translations per PASID. Need a better understanding
> how private PASID is relevant here.

Private PASIDs are used for doing iommu_map/iommu_unmap on PASIDs
(first-level translation):
https://www.spinics.net/lists/dri-devel/msg177003.html As above, some
people don't want SVA, some can't do it, some may even want a few
private address spaces just for their kernel driver. They need a way to
allocate PASIDs and do iommu_map/iommu_unmap on them, without binding to
a process. I was planning to add the private PASID patch to my SVA
series, but in my opinion the feature overlaps with auxiliary domains.

Thanks,
Jean
