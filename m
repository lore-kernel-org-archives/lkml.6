Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeEQMia (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:38:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40930 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQMi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:38:28 -0400
X-Google-Smtp-Source: AB8JxZptg67Nj1TbVLHEiliuKCf2YK+s6KvwekJIpJSKOCBaeLq/Yfyt1ZPP5Lo5A926yZvBPz4lfA==
Subject: Re: [PATCH 0/3] Add support to disable sensor groups in P9
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        stewart@linux.vnet.ibm.com
References: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180515150205.GA29321@roeck-us.net>
 <2ceb6b30-60b7-d985-ee0d-6c5784eda273@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56bba97b-c6ee-e7a1-136c-a2236437484a@roeck-us.net>
Date: Thu, 17 May 2018 05:38:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2ceb6b30-60b7-d985-ee0d-6c5784eda273@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 11:10 PM, Shilpasri G Bhat wrote:
> 
> 
> On 05/15/2018 08:32 PM, Guenter Roeck wrote:
>> On Thu, Mar 22, 2018 at 04:24:32PM +0530, Shilpasri G Bhat wrote:
>>> This patch series adds support to enable/disable OCC based
>>> inband-sensor groups at runtime. The environmental sensor groups are
>>> managed in HWMON and the remaining platform specific sensor groups are
>>> managed in /sys/firmware/opal.
>>>
>>> The firmware changes required for this patch is posted below:
>>> https://lists.ozlabs.org/pipermail/skiboot/2018-March/010812.html
>>>
>>
>> Sorry for not getting back earlier. This is a tough one.
>>
> 
> Thanks for the reply. I have tried to answer your questions according to my
> understanding below:
> 
>> Key problem is that you are changing the ABI with those new attributes.
>> On top of that, the attributes _do_ make some sense (many chips support
>> enabling/disabling of individual sensors), suggesting that those or
>> similar attributes may or even should at some point be added to the ABI.
>>
>> At the same time, returning "0" as measurement values when sensors are
>> disabled does not seem like a good idea, since "0" is a perfectly valid
>> measurement, at least for most sensors.
> 
> I agree.
> 
>>
>> Given that, we need to have a discussion about adding _enable attributes to
>> the ABI
> 
>> what is the scope,
> IIUC the scope should be RW and the attribute is defined for each supported
> sensor group
> 

That is _your_ need. I am not aware of any other chip where a per-sensor group
attribute would make sense. The discussion we need has to extend beyond the need
of a single chip.

Guenter

>> when should the attributes exist and when not,
> We control this currently via device-tree
> 
>> do we want/need power_enable or powerX_enable or both, and so on), and
> We need power_enable right now
> 
>> what to return if a sensor is disabled (such as -ENODATA).
> -ENODATA sounds good.
> 
> Thanks and Regards,
> Shilpa
> 
>   Once we have an
>> agreement, we can continue with an implementation.
>>
>> Guenter
>>
>>> Shilpasri G Bhat (3):
>>>    powernv:opal-sensor-groups: Add support to enable sensor groups
>>>    hwmon: ibmpowernv: Add attributes to enable/disable sensor groups
>>>    powernv: opal-sensor-groups: Add attributes to disable/enable sensors
>>>
>>>   .../ABI/testing/sysfs-firmware-opal-sensor-groups  |  34 ++++++
>>>   Documentation/hwmon/ibmpowernv                     |  31 ++++-
>>>   arch/powerpc/include/asm/opal-api.h                |   4 +-
>>>   arch/powerpc/include/asm/opal.h                    |   2 +
>>>   .../powerpc/platforms/powernv/opal-sensor-groups.c | 104 ++++++++++++-----
>>>   arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
>>>   drivers/hwmon/ibmpowernv.c                         | 127 +++++++++++++++++++--
>>>   7 files changed, 265 insertions(+), 38 deletions(-)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
>>>
>>> -- 
>>> 1.8.3.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
