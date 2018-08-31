Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D58FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FD120839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FD120839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeHaRS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:18:59 -0400
Received: from foss.arm.com ([217.140.101.70]:57806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbeHaRS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:18:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90BFA7A9;
        Fri, 31 Aug 2018 06:11:33 -0700 (PDT)
Received: from [10.4.13.35] (ostrya.emea.arm.com [10.4.13.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D04D3F5BC;
        Fri, 31 Aug 2018 06:11:30 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC 01/13] iommu: Introduce bind_guest_stage API
To:     Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, will.deacon@arm.com, robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        christoffer.dall@arm.com
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-2-git-send-email-eric.auger@redhat.com>
 <22c01a4d-c74a-7279-d4ae-39e29a3bc942@redhat.com>
Message-ID: <b7909f1b-57ce-f4db-d916-140a63283232@arm.com>
Date:   Fri, 31 Aug 2018 14:11:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <22c01a4d-c74a-7279-d4ae-39e29a3bc942@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 23/08/18 16:25, Auger Eric wrote:
>> +int iommu_bind_guest_stage(struct iommu_domain *domain, struct device *dev,
>> +			   struct iommu_guest_stage_config *cfg)

About the name change from iommu_bind_pasid_table: is the intent to
reuse this API for SMMUv2, which supports nested but not PASID? Seems
like a good idea but "iommu_bind_table" may be better since "stage" is
only used by Arm.

>> +/**
>> + * PASID table data used to bind guest PASID table to the host IOMMU. This will
>> + * enable guest managed first level page tables.
>> + * @version: for future extensions and identification of the data format
>> + * @bytes: size of this structure
>> + * @base_ptr:	PASID table pointer
>> + * @pasid_bits:	number of bits supported in the guest PASID table, must be less
>> + *		or equal than the host supported PASID size.
>> + */
>> +struct iommu_pasid_table_config {
>> +	__u32 version;
>> +#define PASID_TABLE_CFG_VERSION_1 1
>> +	__u32 bytes;
>> +	__u64 base_ptr;
>> +	__u8 pasid_bits;
>> +};
>> +
>> +/**
>> + * Stream Table Entry S1 info
>> + * @disabled: the smmu is disabled
>> + * @bypassed: stage 1 is bypassed
>> + * @aborted: aborted
>> + * @cdptr_dma: GPA of the Context Descriptor
>> + * @asid: address space identified associated to the CD
>> + */
>> +struct iommu_smmu_s1_config {
>> +	__u8 disabled;
>> +	__u8 bypassed;
>> +	__u8 aborted;
>> +	__u64 cdptr_dma;
>> +	__u16 asid;
> This asid field is a leftover. asid is part of the CD (owned by the
> guest) and cannot be conveyed through this API. What is relevant is to
> pass is the guest asid_bits (vSMMU IDR1 info), to be compared with the
> host one. So we end up having something similar to the base_ptr and
> pasid_bits of iommu_pasid_table_config.

That part seems strange. Userspace wouldn't try arbitrary ASID sizes
until one fits, especially since ASID size isn't the only parameter:
there will be SSID, IOVA, IPA sizes, HTTU features and I guess any other
SMMU_IDRx bit that corresponds to a field in the CD or STE. Doesn't
vSMMU need to tailor its IDR registers to whatever is supported by the
host SMMU, in order to use nested translation?

Before creating the virtual ID registers, userspace will likely want to
know more about the physical IOMMU, by querying the kernel. I wrote
something about that interface recently:
https://www.spinics.net/lists/iommu/msg28039.html

And if you provide this interface, checking the parameters again in
BIND_GUEST_STAGE isn't very useful, it only tells you that userspace
read your values. Once the guest writes the CD, it could still use the
wrong ASID size or some other invalid config. That would be caught by
the SMMU walker and cause a C_BAD_CD error report.

> Otherwise, the other fields (disable, bypassed, aborted) can be packed
> as masks in a _u8 flag.

What's the difference between aborted and disabled? I'm also not sure we
should give such fine tweaks to userspace, since the STE code is already
pretty complicated and has to deal with several state transitions.
Existing behavior (1) (2) (5) probably needs to be preserved:

(1) Initially no container is set, s1-translate s2-bypass with the
default domain (non-VFIO)
(2) A VFIO_TYPE1_NESTING_IOMMU container is set, s1-bypass s2-translate
(3) BIND_GUEST_STAGE, s1-translate s2-translate
(4) UNBIND_GUEST_STAGE, s1-bypass s2-translate
(5) Remove container, s1-translate s2-bypass with the default domain

That said, when instantiating a vSMMU, QEMU may want to switch from (2)
to an intermediate "s1-abort s2-translate" state. At the moment with
virtio-iommu I only create the stage-2 mappings at (3). This ensures
that transactions abort until the guest configures the vIOMMU and it
keeps the host driver simple, but it has the downside of pinning guest
memory lazily (necessary with virtio-iommu since the guest falls back to
the map/unmap interface, which doesn't pin all memory upfront, if it
can't support nested).

> Anyway this API still is at the stage of proof of concept. At least it
> shows the similarities between that use case and the PASID one and
> should encourage to discuss about the relevance to have a unified API to
> pass the guest stage info.
Other required fields in the BIND_GUEST_STAGE ioctl are at least s1dss,
s1cdmax and s1fmt. It's not for sanity-check, they describe the guest
configuration. The guest selects a PASID table format (1-level, 2-level
4k/64k) which is written into STE.s1fmt. It also selects the behavior of
requests-without-pasid, which is written into STE.s1dss. s1cdmax
corresponds to pasid_bits.

Thanks,
Jean
