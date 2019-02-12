Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC83BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5142084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfBLOyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:54:40 -0500
Received: from foss.arm.com ([217.140.101.70]:38570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfBLOyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:54:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A77C580D;
        Tue, 12 Feb 2019 06:54:39 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70D073F575;
        Tue, 12 Feb 2019 06:54:38 -0800 (PST)
Subject: Re: [PATCH v2] mm/memory-hotplug: Add sysfs hot-remove trigger
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, osalvador@suse.de
References: <49ef5e6c12f5ede189419d4dcced5dc04957c34d.1549906631.git.robin.murphy@arm.com>
 <20190212083310.GM15609@dhcp22.suse.cz>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <faca65d7-6d4b-7e4f-5b36-4fdf3710b0e3@arm.com>
Date:   Tue, 12 Feb 2019 14:54:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212083310.GM15609@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2019 08:33, Michal Hocko wrote:
> On Mon 11-02-19 17:50:46, Robin Murphy wrote:
>> ARCH_MEMORY_PROBE is a useful thing for testing and debugging hotplug,
>> but being able to exercise the (arguably trickier) hot-remove path would
>> be even more useful. Extend the feature to allow removal of offline
>> sections to be triggered manually to aid development.
>>
>> Since process dictates the new sysfs entry be documented, let's also
>> document the existing probe entry to match - better 13-and-a-half years
>> late than never, as they say...
> 
> The probe sysfs is quite dubious already TBH. Apart from testing, is
> anybody using it for something real? Do we need to keep an API for
> something testing only? Why isn't a customer testing module enough for
> such a purpose?

 From the arm64 angle, beyond "conventional" servers where we can 
hopefully assume ACPI, I can imagine there being embedded/HPC setups 
(not all as esoteric as that distributed-memory dRedBox thing), as well 
as virtual machines, that are DT-based with minimal runtime firmware. 
I'm none too keen on the idea either, but if such systems want to 
support physical hotplug then driving it from userspace might be the 
only reasonable approach. I'm just loath to actually document it as 
anything other than a developer feature so as not to give the impression 
that I consider it anything other than a last resort for production use. 
I do note that my x86 distro kernel has ARCH_MEMORY_PROBE enabled 
despite it being "for testing".

> In other words, why do we have to add an API that has to be maintained
> for ever for a testing only purpose?

There's already half the API being maintained, though, so adding the 
corresponding other half alongside it doesn't seem like that great an 
overhead, regardless of how it ends up getting used. Ultimately, though, 
it's a patch I wrote because I needed it, and if everyone else is 
adamant that it's not useful enough then fair enough - it's at least in 
the list archives now so I can sleep happy that I've done my 
"contributing back" bit as best I could :)

> Besides that, what is the reason to use __remove_memory rather than the
> exported remove_memory which does an additional locking.

For the same reason that probe uses __add_memory() rather than 
add_memory() - I can't claim to understand *exactly* why 
lock_device_hotplug_sysfs() does what it does compared to 
lock_device_hotplug() (even after reading 5e33bc4165f3), but I can only 
assume it's safest to be consistent with the other attributes here.

> Also, we do
> trust root to do sane things but are we sure that the current BUG-land
> mines in the hotplug code are ready enough to be exported for playing?

Well, the point of this particular implementation as opposed to other 
approaches is that it's impossible by construction to even attempt to 
remove something which isn't an exact, valid memory_block. AFAICS that 
should make it at least as robust as any other hot-remove caller.

Robin.

>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v2: Use is_memblock_offlined() helper, write up documentation
>>
>>   .../ABI/testing/sysfs-devices-memory          | 25 +++++++++++
>>   drivers/base/memory.c                         | 42 ++++++++++++++++++-
>>   2 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
>> index deef3b5723cf..02a4250964e0 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-memory
>> +++ b/Documentation/ABI/testing/sysfs-devices-memory
>> @@ -91,3 +91,28 @@ Description:
>>   		memory section directory.  For example, the following symbolic
>>   		link is created for memory section 9 on node0.
>>   		/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
>> +
>> +What:		/sys/devices/system/memory/probe
>> +Date:		October 2005
>> +Contact:	Linux Memory Management list <linux-mm@kvack.org>
>> +Description:
>> +		The file /sys/devices/system/memory/probe is write-only, and
>> +		when written will simulate a physical hot-add of a memory
>> +		section at the given address. For example, assuming a section
>> +		of unused memory exists at physical address 0x80000000, it can
>> +		be introduced to the kernel with the following command:
>> +		# echo 0x80000000 > /sys/devices/system/memory/probe
>> +Users:		Memory hotplug testing and development
>> +
>> +What:		/sys/devices/system/memory/memoryX/remove
>> +Date:		February 2019
>> +Contact:	Linux Memory Management list <linux-mm@kvack.org>
>> +Description:
>> +		The file /sys/devices/system/memory/memoryX/remove is
>> +		write-only, and when written with a boolean 'true' value will
>> +		simulate a physical hot-remove of that memory section. For
>> +		example, assuming a 1GB section size, the section added by the
>> +		above "probe" example could be removed again with the following
>> +		command:
>> +		# echo 1 > /sys/devices/system/memory/memory2/remove
>> +Users:		Memory hotplug testing and development
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 048cbf7d5233..1ba9d1a6ba5e 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -521,7 +521,44 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
>>   }
>>   
>>   static DEVICE_ATTR_WO(probe);
>> -#endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>> +			    const char *buf, size_t count)
>> +{
>> +	struct memory_block *mem = to_memory_block(dev);
>> +	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>> +	bool remove;
>> +	int ret;
>> +
>> +	ret = kstrtobool(buf, &remove);
>> +	if (ret)
>> +		return ret;
>> +	if (!remove)
>> +		return count;
>> +
>> +	if (!is_memblock_offlined(mem))
>> +		return -EBUSY;
>> +
>> +	ret = lock_device_hotplug_sysfs();
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (device_remove_file_self(dev, attr)) {
>> +		__remove_memory(pfn_to_nid(start_pfn), PFN_PHYS(start_pfn),
>> +				MIN_MEMORY_BLOCK_SIZE * sections_per_block);
>> +		ret = count;
>> +	} else {
>> +		ret = -EBUSY;
>> +	}
>> +
>> +	unlock_device_hotplug();
>> +	return ret;
>> +}
>> +
>> +static DEVICE_ATTR_WO(remove);
>> +#endif /* CONFIG_MEMORY_HOTREMOVE */
>> +#endif /* CONFIG_ARCH_MEMORY_PROBE */
>>   
>>   #ifdef CONFIG_MEMORY_FAILURE
>>   /*
>> @@ -615,6 +652,9 @@ static struct attribute *memory_memblk_attrs[] = {
>>   	&dev_attr_removable.attr,
>>   #ifdef CONFIG_MEMORY_HOTREMOVE
>>   	&dev_attr_valid_zones.attr,
>> +#ifdef CONFIG_ARCH_MEMORY_PROBE
>> +	&dev_attr_remove.attr,
>> +#endif
>>   #endif
>>   	NULL
>>   };
>> -- 
>> 2.20.1.dirty
> 
