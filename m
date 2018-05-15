Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeEOWIm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:08:42 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:45981 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeEOWIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:08:40 -0400
Subject: Re: [PATCH v6 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20180515154352.20263-1-dmurphy@ti.com>
 <20180515154352.20263-2-dmurphy@ti.com>
 <CAHp75VegjkiiD1qTGpi9rr6cg=72t9kSwDrG=sUpUWFVO58M4A@mail.gmail.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <08dda10d-f865-9cf2-b9a5-c79cbab5da98@ti.com>
Date: Tue, 15 May 2018 17:08:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VegjkiiD1qTGpi9rr6cg=72t9kSwDrG=sUpUWFVO58M4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy

Thanks for the review

On 05/15/2018 04:56 PM, Andy Shevchenko wrote:
> On Tue, May 15, 2018 at 6:43 PM, Dan Murphy <dmurphy@ti.com> wrote:
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
>> +       depends on LEDS_CLASS && I2C && OF
> 
> What is OF specific in this driver?

as3645a_led_class_setup has a "of" dependency

> 
> 
>> +#define LM3601X_STRB_LVL_TRIG  ~BIT(3)
> 
>> +#define LM36010_BOOST_LIMIT_19 ~BIT(5)
> 
>> +#define LM36010_BOOST_FREQ_2MHZ        ~BIT(6)
> 
>> +#define LM36010_BOOST_MODE_NORM        ~BIT(7)
> 
> These looks rather strange. Shouldn't be just 0:s?

I don't actually use these so I can just remove them

> 
>> +struct lm3601x_led {
>> +       struct mutex lock;
>> +       struct regmap *regmap;
>> +       struct i2c_client *client;
> 
>> +       struct device_node *led_node;
> 
> Why do you need this?

I don't but I can store it locally.  I was using the nodes in the register
functions in previous versions.

> 
>> +};
> 
>> +static const struct lm3601x_max_timeouts strobe_timeouts[] = {
>> +       { 40000, 0x00 },
>> +       { 80000, 0x01 },
>> +       { 120000, 0x02 },
>> +       { 160000, 0x03 },
>> +       { 200000, 0x04 },
>> +       { 240000, 0x05 },
>> +       { 280000, 0x06 },
>> +       { 320000, 0x07 },
>> +       { 360000, 0x08 },
>> +       { 400000, 0x09 },
>> +       { 600000, 0x0a },
>> +       { 800000, 0x0b },
>> +       { 1000000, 0x0c },
>> +       { 1200000, 0x0d },
>> +       { 1400000, 0x0e },
>> +       { 1600000, 0x0f },
> 
> Huh?!

Please give comments that actually mean something other wise I will opt to ignore them.

> 
> strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;

Not sure what equation you are trying to point out here.  But if you are trying to apply
a timeout step you cannot do this with this part.  As pointed out in the DT doc the timeout
step is not linear.

> 
>> +};
> 
>> +       struct lm3601x_led *led = fled_cdev_to_led(fled_cdev);
>> +       int ret;
>> +       int current_timeout;
>> +       int reg_count;
>> +       int i;
>> +       int timeout_reg_val = 0;
> 
> Better to put lines here in reversed xmas tree order (longest first).

I can do that, again this is a preference.

> 
>> +       reg_count = ARRAY_SIZE(strobe_timeouts);
>> +       for (i = 0; i < reg_count; i++) {
>> +               if (led->strobe_timeout > strobe_timeouts[i].timeout)
>> +                       continue;
> 
> binary search?
> 
> Check lib/bsearch.c (IIRC).
> 
> But! See above the formula.
> 
>> +               brightness_val = (brightness/2);
> 
> Spaces.

Not sure what this means checkpatch was clean

> 
>> +static int lm3601x_register_leds(struct lm3601x_led *led)
>> +{
> 
> 
>> +       int err = -ENODEV;
> 
> Useless assignment.

This is an artifact from prior versions I can remove it

> 
>> +       err = led_classdev_flash_register(&led->client->dev,
>> +                       fled_cdev);
>> +
>> +       return err;
> 
> This is return led_...();

That is a preference.  It does not have to be that way.

> 
>> +}
> 
>> +               ret = of_property_read_string(led->led_node, "label", &name);
> 
> device_property_...();

It can be if the maintainer is requesting this.

Is the trend to move to these functions?
Most drivers use the "of" calls.

> 
>> +               if (!ret)
> 
> if (ret) sounds more natural. And better just to split
> 
>> +                       snprintf(led->led_name, sizeof(led->led_name),
>> +                               "%s:%s", led->led_node->name, name);
>> +               else
>> +                       snprintf(led->led_name, sizeof(led->led_name),
>> +                               "%s:torch", led->led_node->name);
> 
> const char *tmp;
> 
> ret = device_property_read_...(&tmp);
> if (ret)
>  tmp = ...
> sprintf(...);
> 
>> +       led = devm_kzalloc(&client->dev,
>> +                           sizeof(struct lm3601x_led), GFP_KERNEL);
> 
> sizeof(*led) and one line in the result
> 
>> +static const struct i2c_device_id lm3601x_id[] = {
>> +       { "LM36010", CHIP_LM36010 },
>> +       { "LM36011", CHIP_LM36011 },
>> +       { },
> 
> Terminators better w/o comma.

Looking at other drivers adding comma's on the sentinel is accepted.  See the as3645a driver

> 
>> +};
>> +MODULE_DEVICE_TABLE(i2c, lm3601x_id);
>> +
>> +static const struct of_device_id of_lm3601x_leds_match[] = {
>> +       { .compatible = "ti,lm36010", },
>> +       { .compatible = "ti,lm36011", },
>> +       {},
> 
> Ditto.

See above

> 
>> +};
>> +MODULE_DEVICE_TABLE(of, of_lm3601x_leds_match);
> 
> 
> 
> 


-- 
------------------
Dan Murphy
