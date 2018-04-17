Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeDQSFw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 14:05:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46554 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbeDQSFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 14:05:51 -0400
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: "Hook, Gary" <ghook@amd.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
 <1523926423.2747.19.camel@intel.com>
 <823c10d2-e9ab-0f17-22c7-c2eea312bef8@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7d0e1612-40ce-3091-733f-b553b6c325fe@arm.com>
Date: Tue, 17 Apr 2018 19:05:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <823c10d2-e9ab-0f17-22c7-c2eea312bef8@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 18:42, Hook, Gary wrote:
> On 4/16/2018 8:52 PM, Mehta, Sohil wrote:
>> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>>
>>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>>> index 5eb1121d54b9..0ca250f626d9 100644
>>> --- a/drivers/iommu/Makefile
>>> +++ b/drivers/iommu/Makefile
>>> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>>   obj-$(CONFIG_OF_IOMMU) += of_iommu.o
>>>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>>>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>>> +obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
>>
>> Compiling amd_iommu_debugfs.c seems to depend only
>> on CONFIG_IOMMU_DEBUG. Can we prevent the code within
>> amd_iommu_debugfs.c from getting compiled when either CONFIG_AMD_IOMMU
>> or CONFIG_IOMMU_DEBUG is disabled?
> 
> That's a good point. My intention was that only one switch was required 
> to incorporate any DebugFS support, but I see now that I didn't consider 
> all of the cases.
> 
> It appears that a per-device switch is also necessary. Unless someone 
> has a better idea.

Well, you could do a makefile-level dependency i.e.:

ifeq ($(CONFIG_IOMMU_DEBUG), y)
obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
obj-$(CONFIG_BLAH_IOMMU) += blah_iommu_debugfs.o
...
endif

Or alternatively have an intermediate silent Kconfig option:

config AMD_IOMMU_DEBUG
	def_bool y
	depends on AMD_IOMMU && IOMMU_DEBUG

The makefile option is arguably ugly, but does at least scale better ;)

Robin.

>>>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>>>   obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
