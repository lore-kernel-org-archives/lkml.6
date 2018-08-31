Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CB22077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CB22077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeHaSPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:15:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727404AbeHaSPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:15:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D20C4804B4DB;
        Fri, 31 Aug 2018 14:07:37 +0000 (UTC)
Received: from [10.36.116.26] (ovpn-116-26.ams2.redhat.com [10.36.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96AF3202706B;
        Fri, 31 Aug 2018 14:07:33 +0000 (UTC)
Subject: Re: [RFC 02/13] iommu: Introduce tlb_invalidate API
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        "yi.l.liu\""@linux.intel.com, will.deacon@arm.com,
        robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        christoffer.dall@arm.com
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-3-git-send-email-eric.auger@redhat.com>
 <11279859-08f8-6d9d-7aa7-7a5de4cfd3fb@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <95e423a6-3f67-d101-a391-369a1493dff9@redhat.com>
Date:   Fri, 31 Aug 2018 16:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <11279859-08f8-6d9d-7aa7-7a5de4cfd3fb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 31 Aug 2018 14:07:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 31 Aug 2018 14:07:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On 08/31/2018 03:17 PM, Jean-Philippe Brucker wrote:
> On 23/08/18 13:17, Eric Auger wrote:
>> +/**
>> + * Translation cache invalidation information, contains generic IOMMU
>> + * data which can be parsed based on model ID by model specific drivers.
>> + * Since the invalidation of second level page tables are included in the
>> + * unmap operation, this info is only applicable to the first level
>> + * translation caches, i.e. DMA request with PASID.
>> + *
>> + * @granularity:	requested invalidation granularity, type dependent
>> + * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
>> + * @nr_pages:		number of pages to invalidate
>> + * @pasid:		processor address space ID value per PCI spec.
>> + * @addr:		page address to be invalidated
>> + * @flags		IOMMU_INVALIDATE_ADDR_LEAF: leaf paging entries
>> + *			IOMMU_INVALIDATE_GLOBAL_PAGE: global pages
>> + *
>> + */
>> +struct iommu_tlb_invalidate_info {
>> +	struct iommu_tlb_invalidate_hdr	hdr;
>> +	enum iommu_inv_granularity	granularity;
>> +	__u32		flags;
>> +#define IOMMU_INVALIDATE_ADDR_LEAF	(1 << 0)
>> +#define IOMMU_INVALIDATE_GLOBAL_PAGE	(1 << 1)
>> +	__u8		size;
>> +	__u64		nr_pages;
>> +	__u32		pasid;
>> +	__u64		addr;
>> +};
>>  #endif /* _UAPI_IOMMU_H */
> 
> Since the ioctl will be used to combine invalidations (invalidate both
> ATC and TLB with a single call), we need an additional ASID field for
> the SMMU - ATC is invalidated by PASID, TLB by ASID. I used to call it
> "tag", but I'm leaning towards "arch_id" now
> (http://www.linux-arm.org/git?p=linux-jpb.git;a=commitdiff;h=40fdef74816dd8d8d113100b9e0162fab4cec28d)

I aknowledge I am not crystal clear about that. for a given iommu_domain
don't you have a single asid. Can't you retrieve the asid from the
iommu_domain/arm_smmu_domain/arm_smmu_s1_cfg/arm_smmu_ctx_desc.asid?
Here again I am confused bout the dual iommu_domain/struct device
parameters.

I have another trouble while doing the QEMU integration.
When the guests does an NH_ALL, this propagates an invalidation on the
whole IPA range and we must discriminate that from regular NH_VA calls.
How would you encode the NH_ALL with this API?

Besides I discover you work on virtio-iommu/stage2 enablement ;-)

Thanks

Eric
> 
> Thanks,
> Jean
> 
