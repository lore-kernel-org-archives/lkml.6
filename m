Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933723AbeEIDns (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 23:43:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43014 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbeEIDnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 23:43:46 -0400
X-Google-Smtp-Source: AB8JxZogjGflFIIR2hjtu7Int0/YBMhQAUqMoK6uzxcxtKOX3fwU5UX7uG+yi5wfgaR9ZXWzv4NBow==
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Use 24MHz clock
To: Lei YU <mine260309@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
 <8a801894-4293-d2e8-4673-3d9ff5c2a5bb@roeck-us.net>
 <CAARXrtmO=wsPK6bfO0E7fvAkqEJUV1kQSYK1gWXkUhmKytq42A@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c5770e4a-9445-d4ef-cc1f-a7a84599c4a1@roeck-us.net>
Date: Tue, 8 May 2018 20:43:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAARXrtmO=wsPK6bfO0E7fvAkqEJUV1kQSYK1gWXkUhmKytq42A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 08:18 PM, Lei YU wrote:
> On Tue, May 8, 2018 at 9:51 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> No mixed C/C++ comments in hwmon drivers.
>>
>>>          aspeed_set_clock_source(priv->regmap, 0);
>>> +       priv->clk_freq = 24000000;
>>>
>>
>>
>> Are you saying that clk_get_rate() is wrong ? Anyway, if the DT is bad, it
>> should be fixed.
> Nope, clk_get_rate() is OK.
> The reason I make this change is because the PWM supports two types of clock
> source, the 24MHz or the clock from memory controller.
> If the DT uses 24MHz clock, this code is OK.
> But if the DT configs this pwm to use mclk (memory controller clk), this piece
> of code becomes wrong, because the code
> `aspeed_set_clock_source(priv->regmap, 0)` configs the device to use the 24MHz
> clock.
> So no matter what DT configs the clk, this driver *always* uses 24MHz clock.
> 
> That's why I want to make this change.
> 
>> I am not a friend of hacking drivers to fix up bad DTs, and much less so
>> without explanation.
>> Plus, how do we know that the next chip supported by the driver doesn't have
>> a 32MHz clock ?
> This driver currently supports ast2400 and ast2500, and they both use 24MHz
> clock.
> In case future device uses a different clock, we can update this code, right?
> 

I am not going to accept this change, period. This is not one, it is five steps
backward. If "aspeed_set_clock_source(priv->regmap, 0)" changes the clock speed,
or the clock source, read it later, and attach to the correct clock. If that
doesn't work, fix the problem in the clock subsystem. Hacking the driver is just
plain wrong.

Also, if the idea in DT is to provide a different clock to the watchdog on purpose,
maybe the call to "aspeed_set_clock_source(priv->regmap, 0)" is wrong.

Guenter

>> Really, please fix the DT.
> Sure, I will send patch to config the clock to use fixed 24MHz clock as well.
> 
>>
>> Guenter
>>
>>>          aspeed_create_type(priv);
>>>
>>
>>
> 
