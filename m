Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033773AbeEXQgl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:36:41 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44596 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033756AbeEXQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:36:32 -0400
X-Google-Smtp-Source: AB8JxZqbbtBZ4deyN1Q9EEqrQuwawiI6T18SLFRPGBlS/B7WbzckZNIYB2hSX04jRnjiMugiiCtIVA==
Subject: Re: [PATCH v3 4/6] watchdog: sp805: set WDOG_HW_RUNNING when
 appropriate
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
 <1527120924-12131-5-git-send-email-ray.jui@broadcom.com>
 <20180524161901.GB28425@roeck-us.net>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <5e3d05f2-d526-9108-e2fd-13573458be85@broadcom.com>
Date: Thu, 24 May 2018 09:36:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524161901.GB28425@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2018 9:19 AM, Guenter Roeck wrote:
> On Wed, May 23, 2018 at 05:15:22PM -0700, Ray Jui wrote:
>> If the watchdog hardware is already enabled during the boot process,
>> when the Linux watchdog driver loads, it should reset the watchdog and
>> tell the watchdog framework. As a result, ping can be generated from
>> the watchdog framework, until the userspace watchdog daemon takes over
>> control
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> I have one question, though: Is it really correct that both
> INT_ENABLE _and_ RESET_ENABLE have to be set to enable the watdog ?
> What if only RESET_ENABLE is set ?

According to the SP805 TRM, INT_ENABLE needs to be set to high to enable 
the counter and the interrupt. Counter will be stopped if INT_ENABLE is 
cleared. So yes, INT_ENABLE needs to be set.

Thanks,

Ray

> 
> Thanks,
> Guenter
> 
>> ---
>>   drivers/watchdog/sp805_wdt.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>> index 1484609..d662a6f 100644
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
>> @@ -74,6 +75,15 @@ module_param(nowayout, bool, 0);
>>   MODULE_PARM_DESC(nowayout,
>>   		"Set to 1 to keep watchdog running after device release");
>>   
>> +/* returns true if wdt is running; otherwise returns false */
>> +static bool wdt_is_running(struct watchdog_device *wdd)
>> +{
>> +	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>> +	u32 wdtcontrol = readl_relaxed(wdt->base + WDTCONTROL);
>> +
>> +	return (wdtcontrol & ENABLE_MASK) == ENABLE_MASK;
>> +}
>> +
>>   /* This routine finds load value that will reset system in required timout */
>>   static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>>   {
>> @@ -239,6 +249,15 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>>   	watchdog_init_timeout(&wdt->wdd, 0, &adev->dev);
>>   	wdt_setload(&wdt->wdd, wdt->wdd.timeout);
>>   
>> +	/*
>> +	 * If HW is already running, enable/reset the wdt and set the running
>> +	 * bit to tell the wdt subsystem
>> +	 */
>> +	if (wdt_is_running(&wdt->wdd)) {
>> +		wdt_enable(&wdt->wdd);
>> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>> +	}
>> +
>>   	ret = watchdog_register_device(&wdt->wdd);
>>   	if (ret) {
>>   		dev_err(&adev->dev, "watchdog_register_device() failed: %d\n",
>> -- 
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
