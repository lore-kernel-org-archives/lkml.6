Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DBCC2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58CF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfAUMti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:49:38 -0500
Received: from foss.arm.com ([217.140.101.70]:33418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbfAUMth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:49:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 317CB80D;
        Mon, 21 Jan 2019 04:49:37 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963913F614;
        Mon, 21 Jan 2019 04:49:35 -0800 (PST)
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
To:     pmorel@linux.ibm.com, gerald.schaefer@de.ibm.com
Cc:     linux-s390@vger.kernel.org, walling@linux.ibm.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
 <cc070df1-e7dc-8cce-f443-879e0e5e2903@arm.com>
 <3cd790d6-aa6f-e817-27ce-56d7a9b6b6e5@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <70a30a0a-cee6-ac59-61fc-b4b018467179@arm.com>
Date:   Mon, 21 Jan 2019 12:49:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3cd790d6-aa6f-e817-27ce-56d7a9b6b6e5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> What is different in what you propose?

I didn't mean to imply that aperture and reserved regions are mutually 
exclusive, just that they are conceptually distinct things, i.e. there 
is a fundamental difference between "address which could in theory be 
mapped but wouldn't work as expected" and "address which is physically 
impossible to map at all".

Admittedly I hadn't closely followed all of the previous discussions, 
and Alex has a fair point - for VFIO users who will mostly care about 
checking whether two address maps are compatible, it probably is more 
useful to just describe a single list of usable regions, rather than the 
absolute bounds plus a list of unusable holes within them. That still 
doesn't give us any need to conflate things throughout the kernel 
internals, though - the typical usage there is to size an IOVA allocator 
or page table based on the aperture, then carve out any necessary 
reservations. In that context, having to be aware of and handle 
'impossible' reservations outside the aperture just invites bugs and 
adds complexity that would be better avoided.

Robin.

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
