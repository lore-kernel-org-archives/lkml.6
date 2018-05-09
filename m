Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeEICkZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 22:40:25 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:41313 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933457AbeEICkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 22:40:22 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: neidhard.kim@lge.com
X-Original-SENDERIP: 10.178.37.74
X-Original-MAILFROM: neidhard.kim@lge.com
Subject: Re: [PATCH v3] watchdog: sp805: add restart handler
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chanho Min <chanho.min@lge.com>
References: <cf2f151a-06d7-368e-7ae5-68e992dfc3ea@roeck-us.net>
 <1525413903-7066-1-git-send-email-neidhard.kim@lge.com>
 <1b084bff-84fd-18fa-7bee-dd00e33405a2@roeck-us.net>
From: Jongsung Kim <neidhard.kim@lge.com>
Message-ID: <6d09e8c6-d6b9-d0ea-2496-1b1cd1487808@lge.com>
Date: Wed, 9 May 2018 11:40:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1b084bff-84fd-18fa-7bee-dd00e33405a2@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 10:11 PM, Guenter Roeck wrote:
> On 05/03/2018 11:05 PM, Jongsung Kim wrote:
>> Add restart handler for SP805 watchdog so that the driver can be
>> used to reboot the system.
>>
>> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
>> ---
>
> For future patches: change log goes here, please.
>
> Thanks,
> Guenter

Thank you for your review and kind comments.
JS

>
>>   drivers/watchdog/sp805_wdt.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>> index 03805bc..9849db0 100644
>> --- a/drivers/watchdog/sp805_wdt.c
>> +++ b/drivers/watchdog/sp805_wdt.c
>> @@ -121,6 +121,18 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>       return div_u64(load, rate);
>>   }
>>   +static int
>> +wdt_restart(struct watchdog_device *wdd, unsigned long mode, void *cmd)
>> +{
>> +    struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +    writel_relaxed(0, wdt->base + WDTCONTROL);
>> +    writel_relaxed(0, wdt->base + WDTLOAD);
>> +    writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
>> +
>> +    return 0;
>> +}
>> +
>>   static int wdt_config(struct watchdog_device *wdd, bool ping)
>>   {
>>       struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>> @@ -197,6 +209,7 @@ static const struct watchdog_ops wdt_ops = {
>>       .ping        = wdt_ping,
>>       .set_timeout    = wdt_setload,
>>       .get_timeleft    = wdt_timeleft,
>> +    .restart    = wdt_restart,
>>   };
>>     static int
>> @@ -230,6 +243,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>>       spin_lock_init(&wdt->lock);
>>       watchdog_set_nowayout(&wdt->wdd, nowayout);
>>       watchdog_set_drvdata(&wdt->wdd, wdt);
>> +    watchdog_set_restart_priority(&wdt->wdd, 128);
>>       wdt_setload(&wdt->wdd, DEFAULT_TIMEOUT);
>>         ret = watchdog_register_device(&wdt->wdd);
>>
>
>
