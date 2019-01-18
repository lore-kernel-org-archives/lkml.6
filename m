Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A669C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F1B2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfARNv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:51:29 -0500
Received: from foss.arm.com ([217.140.101.70]:57386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfARNv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:51:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 866BBEBD;
        Fri, 18 Jan 2019 05:51:28 -0800 (PST)
Received: from [10.1.196.128] (ostrya.cambridge.arm.com [10.1.196.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C0623F5C1;
        Fri, 18 Jan 2019 05:51:27 -0800 (PST)
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
To:     pmorel@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>,
        gerald.schaefer@de.ibm.com
Cc:     linux-s390@vger.kernel.org, walling@linux.ibm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
 <cc070df1-e7dc-8cce-f443-879e0e5e2903@arm.com>
 <3cd790d6-aa6f-e817-27ce-56d7a9b6b6e5@linux.ibm.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <668fe734-e4bf-0342-ab8c-df54d9022db4@arm.com>
Date:   Fri, 18 Jan 2019 13:51:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3cd790d6-aa6f-e817-27ce-56d7a9b6b6e5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 18/01/2019 13:29, Pierre Morel wrote:
> On 17/01/2019 14:02, Robin Murphy wrote:
>> On 15/01/2019 17:37, Pierre Morel wrote:
>>> The s390 iommu can only allow DMA transactions between the zPCI device
>>> entries start_dma and end_dma.
>>>
>>> Let's declare the regions before start_dma and after end_dma as
>>> reserved regions using the appropriate callback in iommu_ops.
>>>
>>> The reserved region may later be retrieved from sysfs or from
>>> the vfio iommu internal interface.
>>
>> For this particular case, I think the best solution is to give VFIO
>> the ability to directly interrogate the domain geometry (which s390
>> appears to set correctly already). The idea of reserved regions was
>> really for 'unexpected' holes inside the usable address space - using
>> them to also describe places that are entirely outside that address
>> space rather confuses things IMO.
>>
>> Furthermore, even if we *did* end up going down the route of actively
>> reserving addresses beyond the usable aperture, it doesn't seem
>> sensible for individual drivers to do it themselves when the core API
>> already describes the relevant information generically.
>>
>> Robin.
> 
> Robin,
> 
> I already posted a patch retrieving the geometry through
> VFIO_IOMMU_GET_INFO using a specific capability for the geometry [1],
> and AFAIU, Alex did not agree with this.

On arm we also need to report the IOMMU geometry to userspace (max IOVA
size in particular). Shameer has been working on a solution [2] that
presents a unified view of both geometry and reserved regions into the
VFIO_IOMMU_GET_INFO call, and I think we should go with that. If I
understand correctly it's currently blocked on the RMRR problem and
we're waiting for Jacob or Ashok to take a look at it, as Kevin pinged
them on thread [1]?

[2] https://lkml.org/lkml/2018/4/18/293

Thanks,
Jean

> 
> What is different in what you propose?
> 
> @Alex: I was hoping that this patch goes in your direction. What do you
> think?
> 
> Thanks,
> Pierre
> 
> [1]: https://lore.kernel.org/patchwork/patch/1030369/
> 
>>
>>>
>>> This seems to me related with the work Shameer has started on
>>> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
>>>
>>>
>>> Pierre Morel (1):
>>>    iommu/s390: Declare s390 iommu reserved regions
>>>
>>>   drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>>>   1 file changed, 29 insertions(+)
>>>
>>
> 
> 

