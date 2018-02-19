Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeBSBHU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 20:07:20 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40382 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeBSBHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 20:07:18 -0500
X-Google-Smtp-Source: AH8x224als2ddOQpX1fy5pGtfq8kJpSzoWLiN96dKDM5AUPHz6iM5/c5ZOkWTZRntzXkHGgtIFoHIA==
Subject: Re: [PATCH v3 3/7] watchdog: sirfsoc: allow setting timeout in
 devicetree
To: Rob Herring <robh@kernel.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180211200847.25000-3-marcus.folkesson@gmail.com>
 <20180219000735.i5i3gne4idzzhxot@rob-hp-laptop>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e318fd7a-f855-d0c0-ae6f-86bd48f58e1f@roeck-us.net>
Date: Sun, 18 Feb 2018 17:07:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219000735.i5i3gne4idzzhxot@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/2018 04:07 PM, Rob Herring wrote:
> On Sun, Feb 11, 2018 at 09:08:43PM +0100, Marcus Folkesson wrote:
>> watchdog_init_timeout() will allways pick timeout_param since it
>> defaults to a valid timeout.
>>
>> By following best practice described in
>> Documentation/watchdog/watchdog-kernel-api.txt, it also
>> let us to set timout-sec property in devicetree.
> 
> typo
> 
>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt | 4 ++++
>>   drivers/watchdog/sirfsoc_wdt.c                             | 2 +-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
>> index 9cbc76c89b2b..0dce5e3100b4 100644
>> --- a/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.txt
>> @@ -5,10 +5,14 @@ Required properties:
>>   - reg: Address range of tick timer/WDT register set
>>   - interrupts: interrupt number to the cpu
>>   
>> +Optional properties:
>> +- timeout-sec : Contains the watchdog timeout in seconds
>> +
>>   Example:
>>   
>>   timer@b0020000 {
>>   	compatible = "sirf,prima2-tick";
>>   	reg = <0xb0020000 0x1000>;
>>   	interrupts = <0>;
>> +	timeout-sec = <30>;
>>   };
>> diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
>> index 4eea351e09b0..ac0c9d2c4aee 100644
>> --- a/drivers/watchdog/sirfsoc_wdt.c
>> +++ b/drivers/watchdog/sirfsoc_wdt.c
>> @@ -29,7 +29,7 @@
>>   #define SIRFSOC_WDT_MAX_TIMEOUT		(10 * 60)	/* 10 mins */
>>   #define SIRFSOC_WDT_DEFAULT_TIMEOUT	30		/* 30 secs */
>>   
>> -static unsigned int timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT;
>> +static unsigned int timeout;
> 
> If you have an old dtb, then you still need the default.
> 

No. It is optional to start with, and the driver already has

static struct watchdog_device sirfsoc_wdd = {
         .info = &sirfsoc_wdt_ident,
         .ops = &sirfsoc_wdt_ops,
         .timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT,			<------
         .min_timeout = SIRFSOC_WDT_MIN_TIMEOUT,
         .max_timeout = SIRFSOC_WDT_MAX_TIMEOUT,
};

Guenter

>>   static bool nowayout = WATCHDOG_NOWAYOUT;
>>   
>>   module_param(timeout, uint, 0);
>> -- 
>> 2.15.1
>>
> 
