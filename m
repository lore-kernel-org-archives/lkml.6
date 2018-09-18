Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B31C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CDC214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CDC214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeIRVT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:19:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46856 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbeIRVT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:19:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 350747A9;
        Tue, 18 Sep 2018 08:46:49 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFB5A3F5BD;
        Tue, 18 Sep 2018 08:46:46 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
 <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
 <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
 <03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
 <20180914140433.6891a90c@jacob-builder>
Message-ID: <a92a6077-226f-5d38-cdfa-ec5e06a5d532@arm.com>
Date:   Tue, 18 Sep 2018 16:46:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180914140433.6891a90c@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2018 22:04, Jacob Pan wrote:
>> This example only needs to modify first-level translation, and works
>> with SMMUv3. The kernel here could be the host, in which case
>> second-level translation is disabled in the SMMU, or it could be the
>> guest, in which case second-level mappings are created by QEMU and
>> first-level translation is managed by assigning PASID tables to the
>> guest.
> There is a difference in case of guest SVA. VT-d v3 will bind guest
> PASID and guest CR3 instead of the guest PASID table. Then turn on
> nesting. In case of mdev, the second level is obtained from the aux
> domain which was setup for the default PASID. Or in case of PCI device,
> second level is harvested from RID2PASID.

Right, though I wasn't talking about the host managing guest SVA here,
but a kernel binding the address space of one of its userspace drivers
to the mdev.

>> So (2) would use iommu_sva_bind_device(), 
> We would need something different than that for guest bind, just to show
> the two cases:>
> int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int
> *pasid, unsigned long flags, void *drvdata)
> 
> (WIP)
> int sva_bind_gpasid(struct device *dev, struct gpasid_bind_data *data)
> where:
> /**
>  * struct gpasid_bind_data - Information about device and guest PASID
> binding
>  * @pasid:       Process address space ID used for the guest mm
>  * @addr_width:  Guest address width. Paging mode can also be derived.
>  * @gcr3:        Guest CR3 value from guest mm
>  */
> struct gpasid_bind_data {
>         __u32 pasid;
>         __u64 gcr3;
>         __u32 addr_width;
>         __u32 flags;
> #define IOMMU_SVA_GPASID_SRE    BIT(0) /* supervisor request */
> };
> Perhaps there is room to merge with io_mm but the life cycle management
> of guest PASID and host PASID will be different if you rely on mm
> release callback than FD.

I think gpasid management should stay separate from io_mm, since in your
case VFIO mechanisms are used for life cycle management of the VM,
similarly to the former bind_pasid_table proposal. For example closing
the container fd would unbind all guest page tables. The QEMU process'
address space lifetime seems like the wrong thing to track for gpasid.

>> but (1) needs something
>> else. Aren't auxiliary domains suitable for (1)? Why limit auxiliary
>> domain to second-level or nested translation? It seems silly to use a
>> different API for first-level, since the flow in userspace and VFIO
>> is the same as your second-level case as far as MAP_DMA ioctl goes.
>> The difference is that in your case the auxiliary domain supports an
>> additional operation which binds first-level page tables. An
>> auxiliary domain that only supports first-level wouldn't support this
>> operation, but it can still implement iommu_map/unmap/etc.
>> 
> I think the intention is that when a mdev is created, we don;t
> know whether it will be used for SVA or IOVA. So aux domain is here to
> "hold a spot" for the default PASID such that MAP_DMA calls can work as
> usual, which is second level only. Later, if SVA is used on the mdev
> there will be another PASID allocated for that purpose.
> Do we need to create an aux domain for each PASID? the translation can
> be looked up by the combination of parent dev and pasid.

When allocating a new PASID for the guest, I suppose you need to clone
the second-level translation config? In which case a single aux domain
for the mdev might be easier to implement in the IOMMU driver. Entirely
up to you since we don't have this case on SMMUv3

Thanks,
Jean
