Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5DDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C56020862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C56020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeICQsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:48:14 -0400
Received: from foss.arm.com ([217.140.101.70]:54780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbeICQsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:48:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4BBED1;
        Mon,  3 Sep 2018 05:28:18 -0700 (PDT)
Received: from [10.4.13.76] (ostrya.emea.arm.com [10.4.13.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C59B23F614;
        Mon,  3 Sep 2018 05:28:15 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC 02/13] iommu: Introduce tlb_invalidate API
To:     Auger Eric <eric.auger@redhat.com>,
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
 <95e423a6-3f67-d101-a391-369a1493dff9@redhat.com>
Message-ID: <8a3b8fcd-48c4-7d9e-7672-e73431bcde5b@arm.com>
Date:   Mon, 3 Sep 2018 13:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <95e423a6-3f67-d101-a391-369a1493dff9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2018 15:07, Auger Eric wrote:
>> Since the ioctl will be used to combine invalidations (invalidate both
>> ATC and TLB with a single call), we need an additional ASID field for
>> the SMMU - ATC is invalidated by PASID, TLB by ASID. I used to call it
>> "tag", but I'm leaning towards "arch_id" now
>> (http://www.linux-arm.org/git?p=linux-jpb.git;a=commitdiff;h=40fdef74816dd8d8d113100b9e0162fab4cec28d)
> 
> I aknowledge I am not crystal clear about that. for a given iommu_domain
> don't you have a single asid. Can't you retrieve the asid from the
> iommu_domain/arm_smmu_domain/arm_smmu_s1_cfg/arm_smmu_ctx_desc.asid?
> Here again I am confused bout the dual iommu_domain/struct device
> parameters.

In nested mode, ASIDs are allocated by the guest and written into the CD
table. Even if there is a single CD it will still be private to the
guest. When receiving the invalidation, the host could walk the CD
tables to retrieve the ASID, but it's not guaranteed to be here anymore:
the guest could well clear a CD before sending the invalidate command.

> I have another trouble while doing the QEMU integration.
> When the guests does an NH_ALL, this propagates an invalidation on the
> whole IPA range and we must discriminate that from regular NH_VA calls.
> How would you encode the NH_ALL with this API?

I think that translates to an invalidate-all for the domain:

struct tlb_iommu_invalidate_info info = {
	.hdr.type = IOMMU_INV_TYPE_TLB,
	.granularity = IOMMU_INV_GRANU_DOMAIN_ALL_PASID,
};

Reading the spec again, I though the API was missing a way to encode
TLBI_NH_VAA, invalidate a range for all ASIDs. Although it feels
contrived, we could represent it with the following:

struct tlb_iommu_invalidate_info info = {
	.hdr.type = IOMMU_INV_TYPE_TLB,
	.granularity = IOMMU_INV_GRANU_PAGE_PASID,
	.flags = IOMMU_INVALIDATE_GLOBAL_PAGE,
	.addr = ...
};

Thanks,
Jean
