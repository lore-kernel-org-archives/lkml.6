Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98BFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5495C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5495C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeICRBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:01:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbeICRBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:01:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E20287916;
        Mon,  3 Sep 2018 12:41:51 +0000 (UTC)
Received: from [10.36.116.60] (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 370A8A9EA1;
        Mon,  3 Sep 2018 12:41:46 +0000 (UTC)
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
 <95e423a6-3f67-d101-a391-369a1493dff9@redhat.com>
 <8a3b8fcd-48c4-7d9e-7672-e73431bcde5b@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <8c06530b-afad-1c13-4c42-f97b650f8e5b@redhat.com>
Date:   Mon, 3 Sep 2018 14:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a3b8fcd-48c4-7d9e-7672-e73431bcde5b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 03 Sep 2018 12:41:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 03 Sep 2018 12:41:51 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,
On 09/03/2018 02:28 PM, Jean-Philippe Brucker wrote:
> On 31/08/2018 15:07, Auger Eric wrote:
>>> Since the ioctl will be used to combine invalidations (invalidate both
>>> ATC and TLB with a single call), we need an additional ASID field for
>>> the SMMU - ATC is invalidated by PASID, TLB by ASID. I used to call it
>>> "tag", but I'm leaning towards "arch_id" now
>>> (http://www.linux-arm.org/git?p=linux-jpb.git;a=commitdiff;h=40fdef74816dd8d8d113100b9e0162fab4cec28d)
>>
>> I aknowledge I am not crystal clear about that. for a given iommu_domain
>> don't you have a single asid. Can't you retrieve the asid from the
>> iommu_domain/arm_smmu_domain/arm_smmu_s1_cfg/arm_smmu_ctx_desc.asid?
>> Here again I am confused bout the dual iommu_domain/struct device
>> parameters.
> 
> In nested mode, ASIDs are allocated by the guest and written into the CD
> table. Even if there is a single CD it will still be private to the
> guest. When receiving the invalidation, the host could walk the CD
> tables to retrieve the ASID, but it's not guaranteed to be here anymore:
> the guest could well clear a CD before sending the invalidate command.

That's fully correct. I messed up at the beginning with this asid and
that's perfectly true the asid needs to be passed. I will respin
accordingly.

> 
>> I have another trouble while doing the QEMU integration.
>> When the guests does an NH_ALL, this propagates an invalidation on the
>> whole IPA range and we must discriminate that from regular NH_VA calls.
>> How would you encode the NH_ALL with this API?
> 
> I think that translates to an invalidate-all for the domain:
> 
> struct tlb_iommu_invalidate_info info = {
> 	.hdr.type = IOMMU_INV_TYPE_TLB,
> 	.granularity = IOMMU_INV_GRANU_DOMAIN_ALL_PASID,
OK
> };
> 
> Reading the spec again, I though the API was missing a way to encode
> TLBI_NH_VAA, invalidate a range for all ASIDs. Although it feels
> contrived, we could represent it with the following:
> 
> struct tlb_iommu_invalidate_info info = {
> 	.hdr.type = IOMMU_INV_TYPE_TLB,
> 	.granularity = IOMMU_INV_GRANU_PAGE_PASID,
> 	.flags = IOMMU_INVALIDATE_GLOBAL_PAGE,
> 	.addr = ...
OK

Also what about CMD_CFI_CD(_ALL) propagation. Is it an
IOMMU_INV_TYPE_PASID invalidation?

Thanks

Eric
> };
> 
> Thanks,
> Jean
> 
