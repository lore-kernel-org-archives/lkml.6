Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935183AbeE2Oi5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:38:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:9810 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934608AbeE2Oiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:38:55 -0400
X-IronPort-AV: E=Sophos;i="5.49,456,1520924400";
   d="scan'208";a="12552008"
Subject: Re: [PATCH v4 5/6] spi: at91-usart: add driver for at91-usart as spi
To: Radu Pirea <radu.pirea@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Mark Brown <broonie@kernel.org>, <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-6-radu.pirea@microchip.com>
 <CAHp75Vc0e=+2YptoFAUuPSpAyxaCUJJqjQPPY5VZHV=MEMOqHQ@mail.gmail.com>
 <110bb353-b131-348c-8e26-9863b074142d@microchip.com>
 <0c529082-722c-14d8-7a04-dfeb63d5de92@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <7ac6e7ba-1f92-22c4-c989-b64107b8644a@microchip.com>
Date: Tue, 29 May 2018 16:36:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0c529082-722c-14d8-7a04-dfeb63d5de92@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2018 at 16:34, Nicolas Ferre wrote:
> On 29/05/2018 at 16:28, Radu Pirea wrote:
>>
>>
>> On 05/28/2018 11:21 AM, Andy Shevchenko wrote:
>>> On Fri, May 25, 2018 at 8:19 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
>>>> This is the driver for at91-usart in spi mode. The USART IP can be configured
>>>> to work in many modes and one of them is SPI.
> 
> [..]
> 
>>>> +static int at91_usart_gpio_setup(struct platform_device *pdev)
>>>> +{
>>>
>>>> +       struct device_node      *np = pdev->dev.parent->of_node;
>>>
>>> Your driver is not OF specific as far as I can see. Drop all these
>>> device_node stuff and change API calls respectively.
>>
>> Ok. What do you suggest to use instead of OF API to get the count of
>> cs-gpios and to read their values one by one?
> 
> As Alexandre said, we can make this driver OF specific.
> 
> What could be interesting is to use the gpio descriptors API and not the
> older one. This would allow us to have far more control over the gpio
> that we use in our drivers (Ludovic is converting our drivers to only
> use gpiod structures).

Oh, but we already said that we cannot.
Disregard my comment then, sorry for the noise.

> Regards,
>     Nicolas
> 
>>
>>>
>>>> +       int                     i;
>>>
>>>> +       int                     ret = 0;
>>>> +       int                     nb = 0;
>>>
>>> What happened to indentation?
>>>
>>> Redundnant assignment for both.
>>>
>>>> +       if (!np)
>>>> +               return -EINVAL;
>>>> +
>>>> +       nb = of_gpio_named_count(np, "cs-gpios");
>>>> +       for (i = 0; i < nb; i++) {
>>>> +               int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
>>>> +
>>>> +               if (cs_gpio < 0)
>>>> +                       return cs_gpio;
>>>> +
>>>> +               if (gpio_is_valid(cs_gpio)) {
>>>> +                       ret = devm_gpio_request_one(&pdev->dev, cs_gpio,
>>>> +                                                   GPIOF_DIR_OUT,
>>>> +                                                   dev_name(&pdev->dev));
>>>> +                       if (ret)
>>>> +                               return ret;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
> [..]
> 


-- 
Nicolas Ferre
