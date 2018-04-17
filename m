Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeDQSNz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 14:13:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeDQSNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 14:13:55 -0400
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
To: "Hook, Gary" <ghook@amd.com>, Gary R Hook <gary.hook@amd.com>,
        iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
 <9123cd44-e01f-bff6-8441-792acbde10bc@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a24f9f4c-0c65-a77c-a18b-7a6bf5a33b85@arm.com>
Date: Tue, 17 Apr 2018 19:13:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9123cd44-e01f-bff6-8441-792acbde10bc@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 18:46, Hook, Gary wrote:
> On 4/6/2018 9:17 AM, Gary R Hook wrote:
>> Provide base enablement for using debugfs to expose internal data of
>> an IOMMU driver. When called, create the /sys/kernel/debug/iommu
>> directory.  Emit a strong warning at boot time to indicate that this
>> feature is enabled.
>>
>> This patch adds a top-level function that will create the (above)
>> directory, under which a driver may create a hw-specific directory for
>> its use. The function
>>
>>     iommu_debugfs_setup()
>>
>> returns a pointer to the new dentry structure created for
>> /sys/kernel/debug/iommu, or NULL in the event of a failure. An IOMMU
>> driver should call this function first, and then create a directory
>> beneath it. A driver implementation might look something like:
>>
>> static struct dentry *my_debugfs;
>>
>>     struct dentry *d_top;
>>     if (!my_debugfs) {
>>         d_top = iommu_debugfs_setup();
>>         if (d_top)
>>             my_debugfs = debugfs_create_dir("vendor", d_top);
>>     }
>>
>> Since the IOMMU driver can not be removed from the running system, this
>> patch only provides an "on" function.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>   drivers/iommu/Kconfig         |   11 ++++++++
>>   drivers/iommu/Makefile        |    1 +
>>   drivers/iommu/iommu-debugfs.c |   58 
>> +++++++++++++++++++++++++++++++++++++++++
>>   include/linux/iommu.h         |    4 +++
>>   4 files changed, 74 insertions(+)
>>   create mode 100644 drivers/iommu/iommu-debugfs.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index f3a21343e636..c1e39dabfec2 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>>   endmenu
>> +config IOMMU_DEBUG
>> +    bool "Enable IOMMU internals in DebugFS"
>> +    depends on DEBUG_FS
>> +    default n
>> +    help
>> +      Allows exposure of IOMMU device internals. This option enables
>> +      the use of debugfs by IOMMU drivers as required. Devices can,
>> +      at initialization time, cause the IOMMU code to create a top-level
>> +      debug/iommu directory, and then populate a subdirectory with
>> +      entries as required.
> 
> I should explicitly ask about this:
> 
> Joerg had suggested IOMMU_DEBUGFS, but here I've changed to IOMMU_DEBUG. 
> I'm not seeing a lot of CONFIG options that use DEBUGFS for debugfs 
> options, so I chose to follow an implied convention.
> 
> Question: should this indeed be IOMMU_DEBUGFS?
>                                  ^^^^^^^^^^^^^

Personally I'd say yes, since there is at least some precedent for 
*_DEBUGFS already, and it does help make the intent that much clearer 
(*_DEBUG often just means lots of dmesg spam rather than an actual 
debugfs interface).

Robin.
