Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934572AbeEWTfa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:35:30 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42434 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934239AbeEWTf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:35:26 -0400
X-Google-Smtp-Source: ADUXVKLEUTi16uz9VB8O/axwczK46O6Dwh4vKDanxKEhrl0KIZVdRaXvH/GrBgN7tDcWkqEb1BYrXw==
Subject: Re: [PATCH 3/5] watchdog: sp805: set WDOG_HW_RUNNING when appropriate
To: Guenter Roeck <linux@roeck-us.net>,
        Robin Murphy <robin.murphy@arm.com>
Cc: Scott Branden <scott.branden@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-4-git-send-email-ray.jui@broadcom.com>
 <20180522205457.GA16363@roeck-us.net>
 <0d92b9e9-a3d1-6e91-8371-b5ed3a83e399@broadcom.com>
 <00c121ea-d197-93b8-2f56-bcca963f70fb@broadcom.com>
 <76d47e02-7a5f-3fc2-3905-cd4aa03ac69c@arm.com>
 <5a996888-d3d3-9ae6-e438-5de4d5e3ea32@broadcom.com>
 <ef3539fd-c95c-f364-93c7-680aabd1eea3@arm.com>
 <20180523180920.GB27570@roeck-us.net>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <4da7f930-2698-3ab5-4fce-50af1eba8af5@broadcom.com>
Date: Wed, 23 May 2018 12:35:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523180920.GB27570@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter/Robin,

On 5/23/2018 11:09 AM, Guenter Roeck wrote:
> On Wed, May 23, 2018 at 06:15:14PM +0100, Robin Murphy wrote:
>> On 23/05/18 17:29, Ray Jui wrote:
>>> Hi Robin,
>>>
>>> On 5/23/2018 4:48 AM, Robin Murphy wrote:
>>>> On 23/05/18 08:52, Scott Branden wrote:
>>>>>
>>>>>
>>>>> On 18-05-22 04:24 PM, Ray Jui wrote:
>>>>>> Hi Guenter,
>>>>>>
>>>>>> On 5/22/2018 1:54 PM, Guenter Roeck wrote:
>>>>>>> On Tue, May 22, 2018 at 11:47:18AM -0700, Ray Jui wrote:
>>>>>>>> If the watchdog hardware is already enabled during the boot process,
>>>>>>>> when the Linux watchdog driver loads, it should reset the
>>>>>>>> watchdog and
>>>>>>>> tell the watchdog framework. As a result, ping can be generated from
>>>>>>>> the watchdog framework, until the userspace watchdog daemon
>>>>>>>> takes over
>>>>>>>> control
>>>>>>>>
>>>>>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>>>>>> Reviewed-by: Vladimir Olovyannikov
>>>>>>>> <vladimir.olovyannikov@broadcom.com>
>>>>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>>>>> ---
>>>>>>>>    drivers/watchdog/sp805_wdt.c | 22 ++++++++++++++++++++++
>>>>>>>>    1 file changed, 22 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/watchdog/sp805_wdt.c
>>>>>>>> b/drivers/watchdog/sp805_wdt.c
>>>>>>>> index 1484609..408ffbe 100644
>>>>>>>> --- a/drivers/watchdog/sp805_wdt.c
>>>>>>>> +++ b/drivers/watchdog/sp805_wdt.c
>>>>>>>> @@ -42,6 +42,7 @@
>>>>>>>>        /* control register masks */
>>>>>>>>        #define    INT_ENABLE    (1 << 0)
>>>>>>>>        #define    RESET_ENABLE    (1 << 1)
>>>>>>>> +    #define    ENABLE_MASK    (INT_ENABLE | RESET_ENABLE)
>>>>>>>>    #define WDTINTCLR        0x00C
>>>>>>>>    #define WDTRIS            0x010
>>>>>>>>    #define WDTMIS            0x014
>>>>>>>> @@ -74,6 +75,18 @@ module_param(nowayout, bool, 0);
>>>>>>>>    MODULE_PARM_DESC(nowayout,
>>>>>>>>            "Set to 1 to keep watchdog running after device release");
>>>>>>>>    +/* returns true if wdt is running; otherwise returns false */
>>>>>>>> +static bool wdt_is_running(struct watchdog_device *wdd)
>>>>>>>> +{
>>>>>>>> +    struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>>>>>> +
>>>>>>>> +    if ((readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK) ==
>>>>>>>> +        ENABLE_MASK)
>>>>>>>> +        return true;
>>>>>>>> +    else
>>>>>>>> +        return false;
>>>>>>>
>>>>>>>      return !!(readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK));
>>>>>>>
>>>>>>
>>>>>> Note ENABLE_MASK contains two bits (INT_ENABLE and RESET_ENABLE);
>>>>>> therefore, a simple !!(expression) would not work? That is, the
>>>>>> masked result needs to be compared against the mask again to ensure
>>>>>> both bits are set, right?
>>>>> Ray - your original code looks correct to me.  Easier to read and less
>>>>> prone to errors as shown in the attempted translation to a single
>>>>> statement.
>>>>
>>>>       if (<boolean condition>)
>>>>           return true;
>>>>       else
>>>>           return false;
>>>>
>>>> still looks really dumb, though, and IMO is actually harder to read than
>>>> just "return <boolean condition>;" because it forces you to stop and
>>>> double-check that the logic is, in fact, only doing the obvious thing.
>>>
>>> If you can propose a way to modify my original code above to make it more
>>> readable, I'm fine to make the change.
>>
>> Well,
>>
>> 	return readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK == ENABLE_MASK;
>>
>> would probably be reasonable to anyone other than the 80-column zealots, but
>> removing the silly boolean-to-boolean translation idiom really only
>> emphasises the fact that it's fundamentally a big complex statement; for
>> maximum clarity I'd be inclined to separate the two logical operations (read
>> and comparison), e.g.:
>>
>> 	u32 wdtcontrol = readl_relaxed(wdt->base + WDTCONTROL);
>>
>> 	return wdtcontrol & ENABLE_MASK == ENABLE_MASK;
> 
> == has higher precendence than bitwise &, so this will need ( ),
> but otherwise I agree.
> 

Sure. Let me change the code to the following:

       u32 wdtcontrol = readl_relaxed(wdt->base + WDTCONTROL);

       return (wdtcontrol & ENABLE_MASK) == ENABLE_MASK;

Thanks.

Ray

>>
>> which is still -3 lines vs. the original.
>>
>>> As I mentioned, I don't think the following change proposed by Guenter
>>> will work due to the reason I pointed out:
>>>
>>> return !!(readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK));
>>
>> FWIW, getting the desired result should only need one logical not swapping
>> for a bitwise one there:
>>
>> 	return !(~readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK);
>>
>> but that's well into "too clever for its own good" territory ;)
> 
> Yes, that would be confusing.
> 
>>
>> Robin.
