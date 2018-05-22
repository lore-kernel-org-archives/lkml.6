Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeEVMRc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:17:32 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:57203 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeEVMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:17:17 -0400
Subject: Re: [PATCH v7 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20180521180927.18472-1-dmurphy@ti.com>
 <20180521180927.18472-2-dmurphy@ti.com>
 <69a920da-f759-de50-865c-0ebc43044b66@gmail.com>
 <3b20c9cf-5f7e-3ed9-454d-c8e8ca6c0627@ti.com>
 <CAHp75Vf_KaRDJU83d8o1Sy1v+oztucJSYBEK9=cqNw6FQspFvg@mail.gmail.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <c5bbffef-5263-f2ff-6394-a14cbc8971b2@ti.com>
Date: Tue, 22 May 2018 07:17:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf_KaRDJU83d8o1Sy1v+oztucJSYBEK9=cqNw6FQspFvg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy

On 05/21/2018 06:05 PM, Andy Shevchenko wrote:
> On Tue, May 22, 2018 at 12:44 AM, Dan Murphy <dmurphy@ti.com> wrote:
> 
> 
>>>> +    child = device_get_next_child_node(&led->client->dev, child);
>>>> +    if (!child) {
>>>> +        dev_err(&led->client->dev, "No LED Child node\n");
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    ret = fwnode_property_read_u32(child, "reg", &led->led_mode);
>>>> +    if (ret) {
>>>> +        dev_err(&led->client->dev, "reg DT property missing\n");
>>>> +        goto out_err;
>>>> +    }
>>>> +
>>>> +    if (led->led_mode > LM3601X_LED_TORCH ||
>>>> +        led->led_mode < LM3601X_LED_IR) {
>>>> +        dev_warn(&led->client->dev, "Invalid led mode requested\n");
>>>> +        ret = -EINVAL;
>>>> +        goto out_err;
>>>> +    }
>>>> +
>>>> +    ret = fwnode_property_read_string(child, "label", &name);
>>>> +    if (ret) {
>>>> +        if (led->led_mode == LM3601X_LED_TORCH)
>>>> +            name = "torch";
>>>> +        else
>>>> +            name = "infrared";
>>>> +    }
>>>> +
>>>> +    snprintf(led->led_name, sizeof(led->led_name),
>>>> +        "%s:%s", node->name, name);
>>>
>>> Reading once again my recent explanation regarding this I realized
>>> that I didn't provide clear conclusion, which is: we no longer
>>> use child node name for LED class device name if label is absent.
>>> (apart from that - you're using parent DT node now, i.e.
>>> led-controller).
>>>
>>> Please follow what was done for drivers/leds/leds-cr0014114.c.
>>
>> Hmmm.  If this is calling dev->of_node->name to store the name will this
>> work in non-DT configurations?
> 
> I didn't found this kind of use in linux-next, perhaps I missed something?
> 

Linux next has a different version then what I found doing a search for the driver.

I will change the code to match what is in linux-next.

Dan

> In the driver Jacek referred to I found, though, use of of_node, which
> at some point should be changed to fwnode.
> 
> For now you can fill that if you want to using something like this
> (IIRC it should work):
> 
> if (is_of_node(fwnode))
>  ...->of_node = to_of_node(...);
> 
>> I have not dug to deeply into the fwnode code to find out how the nodes
>> get populated.  So my question may not even be valid.
> 


-- 
------------------
Dan Murphy
