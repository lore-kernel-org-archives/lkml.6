Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeEBHzP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:55:15 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:50750 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751087AbeEBHzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:55:12 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: neidhard.kim@lge.com
X-Original-SENDERIP: 10.178.37.74
X-Original-MAILFROM: neidhard.kim@lge.com
Subject: Re: [PATCH] watchdog: sp805: add restart handler
To: Guenter Roeck <linux@roeck-us.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Chanho Min <chanho.min@lge.com>
References: <20180430064433.28715-1-neidhard.kim@lge.com>
 <452a2320-c297-2bd2-2e98-0b71a077c065@roeck-us.net>
From: Jongsung Kim <neidhard.kim@lge.com>
Message-ID: <c8502372-da23-f113-6cbc-78ef5683c28b@lge.com>
Date: Wed, 2 May 2018 16:55:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <452a2320-c297-2bd2-2e98-0b71a077c065@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2018 08:18 PM, Guenter Roeck wrote:
> On 04/29/2018 11:44 PM, Jongsung Kim wrote:
>> Add restart handler for SP805 watchdog so that the driver can be
>> used to reboot the system.
>>
>> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
>> ---
>>   drivers/watchdog/sp805_wdt.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>> index 01d816251302..01f7b6c29f92 100644
>> --- a/drivers/watchdog/sp805_wdt.c
>> +++ b/drivers/watchdog/sp805_wdt.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/module.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/pm.h>
>> +#include <linux/reboot.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/types.h>
>> @@ -67,6 +68,7 @@ struct sp805_wdt {
>>       struct clk            *clk;
>>       struct amba_device        *adev;
>>       unsigned int            load_val;
>> +    struct notifier_block        restart;
>>   };
>>     static bool nowayout = WATCHDOG_NOWAYOUT;
>> @@ -200,6 +202,18 @@ static const struct watchdog_ops wdt_ops = {
>>       .get_timeleft    = wdt_timeleft,
>>   };
>>   +static int
>> +wdt_restart(struct notifier_block *this, unsigned long mode, void *cmd)
>> +{
>> +    struct sp805_wdt *wdt = container_of(this, struct sp805_wdt, restart);
>> +
>> +    writel_relaxed(0, wdt->base + WDTCONTROL);
>> +    writel_relaxed(0, wdt->base + WDTLOAD);
>> +    writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
>> +
>> +    return 0;
>> +}
>> +
>>   static int
>>   sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>>   {
>> @@ -241,6 +255,10 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>>       }
>>       amba_set_drvdata(adev, wdt);
>>   +    wdt->restart.notifier_call = wdt_restart;
>> +    wdt->restart.priority = 128;
>> +    register_restart_handler(&wdt->restart);
>> +
>
> Why not use the watchdog core ?

Thank you for pointing this. I didn't noticed core changes about restart function because I'm still using old v4.4.xx..

>
> Guenter
>
>>       dev_info(&adev->dev, "registration successful\n");
>>       return 0;
>>   @@ -253,6 +271,7 @@ static int sp805_wdt_remove(struct amba_device *adev)
>>   {
>>       struct sp805_wdt *wdt = amba_get_drvdata(adev);
>>   +    unregister_restart_handler(&wdt->restart);
>>       watchdog_unregister_device(&wdt->wdd);
>>       watchdog_set_drvdata(&wdt->wdd, NULL);
>>  
>
>
