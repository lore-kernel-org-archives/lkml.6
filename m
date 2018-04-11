Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeDKHO4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:14:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42227 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeDKHOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:14:53 -0400
X-Google-Smtp-Source: AIpwx4+tmaklNXqrZQAVQ8UudzjUitNkpcvEDmp75518bxhf16ufWpxn1U4VF+8Jx098xBziRzqWvA==
Subject: Re: [PATCH] net: dsa: b53: Replace mdelay with msleep in
 b53_switch_reset_gpio
To: Phil Reid <preid@electromag.com.au>, f.fainelli@gmail.com,
        andrew@lunn.ch, vivien.didelot@savoirfairelinux.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523411485-2030-1-git-send-email-baijiaju1990@gmail.com>
 <11d079ab-3c07-a10d-c321-f873c53e9690@electromag.com.au>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <7c9dffb7-d55a-98f5-4024-7e2f0c704a56@gmail.com>
Date: Wed, 11 Apr 2018 15:14:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <11d079ab-3c07-a10d-c321-f873c53e9690@electromag.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/4/11 13:30, Phil Reid wrote:
> On 11/04/2018 09:51, Jia-Ju Bai wrote:
>> b53_switch_reset_gpio() is never called in atomic context.
>>
>> The call chain ending up at b53_switch_reset_gpio() is:
>> [1] b53_switch_reset_gpio() <- b53_switch_reset() <-
>>     b53_reset_switch() <- b53_setup()
>>
>> b53_switch_reset_gpio() is set as ".setup" in struct dsa_switch_ops.
>> This function is not called in atomic context.
>>
>> Despite never getting called from atomic context, 
>> b53_switch_reset_gpio()
>> calls mdelay() to busily wait.
>> This is not necessary and can be replaced with msleep() to
>> avoid busy waiting.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/net/dsa/b53/b53_common.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/dsa/b53/b53_common.c 
>> b/drivers/net/dsa/b53/b53_common.c
>> index 274f367..e070ff6 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -597,10 +597,10 @@ static void b53_switch_reset_gpio(struct 
>> b53_device *dev)
>>       /* Reset sequence: RESET low(50ms)->high(20ms)
>>        */
>>       gpio_set_value(gpio, 0);
>> -    mdelay(50);
>> +    msleep(50);
>>         gpio_set_value(gpio, 1);
>> -    mdelay(20);
>> +    msleep(20);
>>         dev->current_page = 0xff;
>>   }
>>
> Would that also imply gpio_set_value could be gpio_set_value_cansleep?
>

Yes, I think gpio_set_value_cansleep() is okay here?
Do I need to send a V2 patch to replace gpio_set_value()?


Best wishes,
Jia-Ju Bai
