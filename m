Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeBHTxv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:53:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49336 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeBHTxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:53:50 -0500
Subject: Re: [PATCH] coresight replicator: set default y after Kconfig rename
To: Kim Phillips <kim.phillips@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
 <4ed2bf14-206a-20c6-40a6-3ab9a2ec07b4@arm.com>
 <20180208132354.5d66ab91234bd7c7d971c1b1@arm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8cdc4fe6-faf6-412e-51af-a65d576ecc3f@infradead.org>
Date: Thu, 8 Feb 2018 11:53:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180208132354.5d66ab91234bd7c7d971c1b1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 11:23 AM, Kim Phillips wrote:
> On Thu, 8 Feb 2018 16:13:16 +0000
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 07/02/18 21:03, Kim Phillips wrote:
>>> Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
>>> replicator naming") changed the Kconfig symbol name from
>>> QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
>>> was being set in my juno build script, which left the new symbol unset,
>>> causing the following unexpected grief:
>>>
>>>   # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
>>>   ..<snip>..
>>>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>>   mmap size 528384B
>>>   AUX area mmap length 4194304
>>>   perf event ring buffer mmapped per cpu
>>>   failed to mmap AUX area
>>>   failed to mmap with 12 (Cannot allocate memory)
>>>
>>> Make it default y to help not surprise unsuspecting users.
>>
>> How many users are there relying on your Juno build script? :P
> 
> This shouldn't be that uncommon for coresight users:
> 
> make defconfig
> scripts/config -e CONFIG_CORESIGHT
> scripts/config -e CONFIG_CORESIGHT_LINK_AND_SINK_TMC
> scripts/config -e CONFIG_CORESIGHT_SINK_TPIU
> scripts/config -e CONFIG_CORESIGHT_SINK_ETBV10
> scripts/config -e CONFIG_CORESIGHT_LINKS_AND_SINKS
> scripts/config -e CONFIG_CORESIGHT_SOURCE_ETM3X
> scripts/config -e CONFIG_CORESIGHT_SOURCE_ETM4X
> #scripts/config -e CONFIG_CORESIGHT_QCOM_REPLICATOR
> scripts/config -e CONFIG_CORESIGHT_DYNAMIC_REPLICATOR
> scripts/config -e CONFIG_CORESIGHT_STM
> scripts/config -e CONFIG_CORESIGHT_CPU_DEBUG
> 
> FWIW, Mathieu - who helped me track the cannot allocate memory problem
> down to this config symbol - has also benn caught by this issue.
> 
>>> Fixes: 1c8859848dbb ("coresight replicator: Cleanup programmable replicator naming")
>>
>> Before that commit, CORESIGHT_QCOM_REPLICATOR was not "default y", nor 
>> selected by any in-tree configs, so whatever the problem may be this is 
>> clearly not the correct fix.
> 
> Well, there's only one defconfig for arm64.  I don't know why it
> doesn't set CORESIGHT, but you're right, this is taking the build fix
> one step further to facilitate user coresight configuration.  I can
> change the patch to make the change to the arm64 defconfig, but I still
> believe CORESIGHT_DYNAMIC_REPLICATOR should be default=y, and the
> defconfig just set CORESIGHT.
> 
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/Kconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>>> index ef9cb3c164e1..b94bbd95efa6 100644
>>> --- a/drivers/hwtracing/coresight/Kconfig
>>> +++ b/drivers/hwtracing/coresight/Kconfig
>>> @@ -73,6 +73,7 @@ config CORESIGHT_SOURCE_ETM4X
>>>   config CORESIGHT_DYNAMIC_REPLICATOR
>>>   	bool "CoreSight Programmable Replicator driver"
>>>   	depends on CORESIGHT_LINKS_AND_SINKS
>>> +	default y
>>
>> CORESIGHT_LINKS_AND_SINKS is "default n" (as indeed is CORESIGHT), and 
>> not selected by any defconfigs, so in general this doesn't really help 
>> anyway.
> 
> Yeah, CORESIGHT_LINKS_AND_SINKS should probably be default y too.

Are they required for system operation?  If not, they should not default to y.

and if they are required, it seems odd that they are in drivers/hwtracing/.


-- 
~Randy
