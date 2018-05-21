Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeEUVcS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:32:18 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:27027 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754477AbeEUVcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:32:13 -0400
Subject: Re: [PATCH v7 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20180521180927.18472-1-dmurphy@ti.com>
 <20180521180927.18472-2-dmurphy@ti.com>
 <CAHp75VcShgaFoJVqbTGBXrrgEr-7JQcCLK4Qy-jydE5++f4VAQ@mail.gmail.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <e0ab0db2-2922-fde0-55f5-1d84d0505878@ti.com>
Date: Mon, 21 May 2018 16:32:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcShgaFoJVqbTGBXrrgEr-7JQcCLK4Qy-jydE5++f4VAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy

Thanks for the review.  I was pretty sure I missed somethings.

On 05/21/2018 03:44 PM, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 9:09 PM, Dan Murphy <dmurphy@ti.com> wrote:
>> Introduce the family of LED devices that can
>> drive a torch, strobe or IR LED.
>>
>> The LED driver can be configured with a strobe
>> timer to execute a strobe flash.  The IR LED
>> brightness is controlled via the torch brightness
>> register.
>>
>> The data sheet for each the LM36010 and LM36011
>> LED drivers can be found here:
>> http://www.ti.com/product/LM36010
>> http://www.ti.com/product/LM36011
> 
> Thanks for an update. My comments below.
> 
>> +config LEDS_LM3601X
>> +       tristate "LED support for LM3601x Chips"
>> +       depends on LEDS_CLASS && I2C && OF
> 
> Now OF here is superfluous.

This is the first one I missed.

ACK

> 
>> +       depends on LEDS_CLASS_FLASH
>> +       select REGMAP_I2C
>> +       help
>> +         This option enables support for the TI LM3601x family
>> +         of flash, torch and indicator classes.
> 
>> +#define LM3601X_TIMEOUT_MASK   0x1e
>> +#define LM3601X_ENABLE_MASK    0x03
> 
> I dunno if GENMASK() will be better here.

I could probably make it more readable as well.

I am thinking

#define LM3601X_ENABLE_MASK (LM3601X_MODE_TORCH | LM3601X_MODE_IR_DRV)

> 
>> +#define LM3601X_LOWER_STEP_US  40000
>> +#define LM3601X_UPPER_STEP_US  200000
>> +#define LM3601X_MIN_TIMEOUT_US 40000
>> +#define LM3601X_MAX_TIMEOUT_US 1600000
> 
>> +#define LM3601X_TIMEOUT_XOVER  400000
> 
> Missed unit?

Ack

> 
>> +       ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
>> +                               LM3601X_MODE_TORCH | LM3601X_MODE_IR_DRV,
>> +                               led_mode_val);
> 
>> +               ret = regmap_update_bits(led->regmap, LM3601X_ENABLE_REG,
>> +                                       LM3601X_MODE_TORCH | LM3601X_MODE_IR_DRV,
>> +                                       LM3601X_MODE_STROBE);
> 
> Perhaps
> #define ..._MODE_TORCH_WITH_IR   (..._TOCRH | ..._IR_DRV)
> ?
> 

This was defined already I just did not use the #define but I will probably
replace this with the LM3601X_ENABLE_MASK #define

>> +static int lm3601x_probe(struct i2c_client *client,
>> +                       const struct i2c_device_id *id)
>> +{
>> +       struct lm3601x_led *led;
>> +       int err;
> 
>> +       err = lm3601x_parse_node(led, client->dev.of_node);
>> +       if (err < 0)
> 
>> +               return -ENODEV;
> 
> Shouldn't be
> 
> return err;

Ack.  But I might just get rid of err altogether when I make the change below to
return the status of the register.

> 
> ?
> 
>> +       err = lm3601x_register_leds(led);
>> +
>> +       return err;
> 
> I will leave this to maintainers since you seems have strong
> objections against more or less standard pattern, i.e.
> 
> return lm3601x_register_leds();

ACk.  I was going to change that but I was concerned about loosing err.
But I can change it.

> 
>> +}
> 


-- 
------------------
Dan Murphy
