Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2605EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD80E20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD80E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeHaRZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:25:05 -0400
Received: from foss.arm.com ([217.140.101.70]:57928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbeHaRZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:25:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5283E7A9;
        Fri, 31 Aug 2018 06:17:38 -0700 (PDT)
Received: from [10.4.13.35] (ostrya.emea.arm.com [10.4.13.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B7813F5BC;
        Fri, 31 Aug 2018 06:17:35 -0700 (PDT)
Subject: Re: [RFC 02/13] iommu: Introduce tlb_invalidate API
To:     Eric Auger <eric.auger@redhat.com>, "\"eric.auger.pro"@gmail.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jean-philippe.brucker@arm.com,
        jacob.jun.pan@linux.intel.com, "yi.l.liu\""@linux.intel.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        christoffer.dall@arm.com
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-3-git-send-email-eric.auger@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <11279859-08f8-6d9d-7aa7-7a5de4cfd3fb@arm.com>
Date:   Fri, 31 Aug 2018 14:17:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535026656-8450-3-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/18 13:17, Eric Auger wrote:
> +/**
> + * Translation cache invalidation information, contains generic IOMMU
> + * data which can be parsed based on model ID by model specific drivers.
> + * Since the invalidation of second level page tables are included in the
> + * unmap operation, this info is only applicable to the first level
> + * translation caches, i.e. DMA request with PASID.
> + *
> + * @granularity:	requested invalidation granularity, type dependent
> + * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
> + * @nr_pages:		number of pages to invalidate
> + * @pasid:		processor address space ID value per PCI spec.
> + * @addr:		page address to be invalidated
> + * @flags		IOMMU_INVALIDATE_ADDR_LEAF: leaf paging entries
> + *			IOMMU_INVALIDATE_GLOBAL_PAGE: global pages
> + *
> + */
> +struct iommu_tlb_invalidate_info {
> +	struct iommu_tlb_invalidate_hdr	hdr;
> +	enum iommu_inv_granularity	granularity;
> +	__u32		flags;
> +#define IOMMU_INVALIDATE_ADDR_LEAF	(1 << 0)
> +#define IOMMU_INVALIDATE_GLOBAL_PAGE	(1 << 1)
> +	__u8		size;
> +	__u64		nr_pages;
> +	__u32		pasid;
> +	__u64		addr;
> +};
>  #endif /* _UAPI_IOMMU_H */

Since the ioctl will be used to combine invalidations (invalidate both
ATC and TLB with a single call), we need an additional ASID field for
the SMMU - ATC is invalidated by PASID, TLB by ASID. I used to call it
"tag", but I'm leaning towards "arch_id" now
(http://www.linux-arm.org/git?p=linux-jpb.git;a=commitdiff;h=40fdef74816dd8d8d113100b9e0162fab4cec28d)

Thanks,
Jean
