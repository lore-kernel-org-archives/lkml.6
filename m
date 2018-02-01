Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeBAMRa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:17:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752450AbeBAMRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:17:25 -0500
Subject: Re: [PATCH 1/2] iommu: Fix iommu_unmap and iommu_unmap_fast return
 type
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: jroedel@suse.de
References: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1517363285-89304-2-git-send-email-suravee.suthikulpanit@amd.com>
 <eaa33cb6-3df0-6f95-59ea-e563076d7f76@arm.com>
 <de21de51-1589-edb1-3dd1-b7065eb8fb3c@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <19766001-07c9-7b67-ae10-8b5467fff748@arm.com>
Date: Thu, 1 Feb 2018 12:17:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <de21de51-1589-edb1-3dd1-b7065eb8fb3c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 05:03, Suravee Suthikulpanit wrote:
> Hi Robin,
> 
> On 2/1/18 1:02 AM, Robin Murphy wrote:
>> Hi Suravee,
>>
>> On 31/01/18 01:48, Suravee Suthikulpanit wrote:
>>> Currently, iommu_unmap and iommu_unmap_fast return unmapped
>>> pages with size_t.  However, the actual value returned could
>>> be error codes (< 0), which can be misinterpreted as large
>>> number of unmapped pages. Therefore, change the return type to ssize_t.
>>>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>> ---
>>>   drivers/iommu/amd_iommu.c   |  6 +++---
>>>   drivers/iommu/intel-iommu.c |  4 ++--
>>
>> Er, there are a few more drivers than that implementing iommu_ops ;)
> 
> Ahh right.
>>
>> It seems like it might be more sensible to fix the single instance of 
>> a driver returning -EINVAL (which appears to be a "should never happen 
>> if used correctly" kinda thing anyway) and leave the API-internal 
>> callback prototype as-is. I do agree the inconsistency of 
>> iommu_unmap() itself wants sorting, though (particularly the 
>> !IOMMU_API stubs which are wrong either way).
>>
>> Robin.
> 
> Make sense. I'll leave the API alone, and change the code to not 
> returning error then.

Actually, on a second look I think that check in amd_iommu is 99% 
redundant anyway, since PAGE_MODE_NONE is only normally set for 
IOMMU_DOMAIN_IDENTITY domains, thus iommu_unmap() would have bailed out 
from the __IOMMU_DOMAIN_PAGING check before ops->unmap could be called. 
AFAICS the only way to hit it at all is if a caller somehow managed to 
get hold of the dev_state->domain set up in amd_iommu_init_device(), 
then tried to unmap something from that, which seems such a very wrong 
thing to do it should probably just crash and burn with extreme 
prejudice anyway.

Cheers,
Robin.
