Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E216C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98A520843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98A520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeIDMfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:35:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbeIDMfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:35:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7F718010FDF;
        Tue,  4 Sep 2018 08:11:02 +0000 (UTC)
Received: from [10.36.116.210] (ovpn-116-210.ams2.redhat.com [10.36.116.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 210CC2026988;
        Tue,  4 Sep 2018 08:10:57 +0000 (UTC)
Subject: Re: [RFC 01/13] iommu: Introduce bind_guest_stage API
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@linux.intel.com" <yi.l.liu@linux.intel.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Cc:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-2-git-send-email-eric.auger@redhat.com>
 <22c01a4d-c74a-7279-d4ae-39e29a3bc942@redhat.com>
 <b7909f1b-57ce-f4db-d916-140a63283232@arm.com>
 <4309832b-27ed-597a-b5a1-f439fbea9843@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912EFB76@SHSMSX101.ccr.corp.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <220e4c2a-d31c-d8fb-2d77-d902d2f13bb2@redhat.com>
Date:   Tue, 4 Sep 2018 10:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912EFB76@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 04 Sep 2018 08:11:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 04 Sep 2018 08:11:02 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,
On 09/04/2018 09:57 AM, Tian, Kevin wrote:
>> From: Auger Eric
>> Sent: Friday, August 31, 2018 9:52 PM
>>
>> Hi Jean-Philippe,
>>
>> On 08/31/2018 03:11 PM, Jean-Philippe Brucker wrote:
>>> Hi Eric,
>>>
>>> On 23/08/18 16:25, Auger Eric wrote:
>>>>> +int iommu_bind_guest_stage(struct iommu_domain *domain, struct
>> device *dev,
>>>>> +			   struct iommu_guest_stage_config *cfg)
>>>
>>> About the name change from iommu_bind_pasid_table: is the intent to
>>> reuse this API for SMMUv2, which supports nested but not PASID? Seems
>>> like a good idea but "iommu_bind_table" may be better since "stage" is
>>> only used by Arm.
>>
>> At the moment I don't target SMUv2 but just SMMUv3. My focus was on
>> nested stage enablement without enabling the multi-CD feature (PASID),
>> whish is not supported by the QEMU vSMMUv3. Afterwards I realized that
>> basically we are pointing to a CD or PASID table and that's about the
>> same. I don't have a strong opinion on the name, iommu_bind_guest_table
>> or iommu_bind_pasid_table would be fine with me. Indeed "stage" is ARM
>> vocable (level for Intel?)
> 
> Intel uses first level/second level. 
> 
> iommu_bind_table is a bit confusing. what should people take table as?
> there is PASID table. there is also page table linked in each stage/level. and
> maybe other tables in vendor-specific definition.
> 
> to me iommu_bind_pasid_table is still clearer. anyway in other places
> we've used pasid explicitly in vfio/iommu APIs, then it should be general
> enough to represent various implementations.

Fine for me.

However I I would suggest to rename the original iommu_sva_invalidate
into something that is SVA unrelated. iommu_tlb_invalidate is not OK as
this API also is used to invalidate context caches - which are not
iotlbs -. What about iommu_cache_invalidate?

At least we must clarify that this API can be used for something else
than SVA enablement.

Thanks

Eric
> 
> Thanks
> Kevin
> 
> 
> 
