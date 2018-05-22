Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeEVXYd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:24:33 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44868 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeEVXYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:24:31 -0400
X-Google-Smtp-Source: AB8JxZperppmLePYGq9etUJQ1iyLReotRAi2VpwfJVW/J7GPh/RRIEpARWhIIm9RFqqprrG3CFkv3A==
Subject: Re: [PATCH 3/5] watchdog: sp805: set WDOG_HW_RUNNING when appropriate
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-4-git-send-email-ray.jui@broadcom.com>
 <20180522205457.GA16363@roeck-us.net>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <0d92b9e9-a3d1-6e91-8371-b5ed3a83e399@broadcom.com>
Date: Tue, 22 May 2018 16:24:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180522205457.GA16363@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 5/22/2018 1:54 PM, Guenter Roeck wrote:
> On Tue, May 22, 2018 at 11:47:18AM -0700, Ray Jui wrote:
>> If the watchdog hardware is already enabled during the boot process,
>> when the Linux watchdog driver loads, it should reset the watchdog and
>> tell the watchdog framework. As a result, ping can be generated from
>> the watchdog framework, until the userspace watchdog daemon takes over
>> control
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/watchdog/sp805_wdt.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>> index 1484609..408ffbe 100644
>> --- a/drivers/watchdog/sp805_wdt.c
>> +++ b/drivers/watchdog/sp805_wdt.c
>> @@ -42,6 +42,7 @@
>>   	/* control register masks */
>>   	#define	INT_ENABLE	(1 << 0)
>>   	#define	RESET_ENABLE	(1 << 1)
>> +	#define	ENABLE_MASK	(INT_ENABLE | RESET_ENABLE)
>>   #define WDTINTCLR		0x00C
>>   #define WDTRIS			0x010
>>   #define WDTMIS			0x014
>> @@ -74,6 +75,18 @@ module_param(nowayout, bool, 0);
>>   MODULE_PARM_DESC(nowayout,
>>   		"Set to 1 to keep watchdog running after device release");
>>   
>> +/* returns true if wdt is running; otherwise returns false */
>> +static bool wdt_is_running(struct watchdog_device *wdd)
>> +{
>> +	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +	if ((readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK) ==
>> +	    ENABLE_MASK)
>> +		return true;
>> +	else
>> +		return false;
> 
> 	return !!(readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK));
> 

Note ENABLE_MASK contains two bits (INT_ENABLE and RESET_ENABLE); 
therefore, a simple !!(expression) would not work? That is, the masked 
result needs to be compared against the mask again to ensure both bits 
are set, right?

Thanks,

Ray
