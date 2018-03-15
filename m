Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeCOLHv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:07:51 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43968 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeCOLHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:07:48 -0400
X-Google-Smtp-Source: AG47ELshL+OgAbJZ3sRPSYpmvzzNYb5Rko55Ox2HVlGt/YPSehpdlH1SPPgrnwVEXaMt4zxlZDSRXg==
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180314155514.3374-1-thierry.escande@linaro.org>
 <20180314155514.3374-3-thierry.escande@linaro.org>
 <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
 <20180314183043.GX18510@minitux>
 <D999852D-E9A7-41D2-9878-A93CB4D43D0C@holtmann.org>
 <20180314190522.GY18510@minitux>
 <494C4C44-1949-405E-91DA-1B40100ED2E6@holtmann.org>
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <d14007a1-a4dd-bd28-3452-a4d3ad70e5a0@linaro.org>
Date: Thu, 15 Mar 2018 12:07:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <494C4C44-1949-405E-91DA-1B40100ED2E6@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 14/03/2018 20:51, Marcel Holtmann wrote:
> Hi Bjorn,
> 
>>>>>> +		bt-disable-n-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>>>>>
>>>>> can we use a common name here. I think that Nokia and Broadcom drivers
>>>>> define one. And if this is the enable/shutdown GPIO, we should name it
>>>>> consistently across all manufacturers. It essentially does the same on
>>>>> Bluetooth UART chips no matter what chip is behind them.
>>>>>
>>>>
>>>> Broadcomm has a device-wakup-gpios and Nokia has bluetooth-wakup-gpios.
>>>> It might be that these behave in the same way, but from the description
>>>> they only trigger the wakeup.
>>>
>>> that is something that we might need to start fixing. I really prefer
>>> if we name the GPIOs a bit more consistent.
>>>
>>>> The reason for the proposed naming here is that the pin is named
>>>> "BT_DISABLE_N" in the datasheet.
>>>
>>> That is not a reason I buy. So the next board comes around that labels
>>> it in the data sheet BT_DISABLE_YEAH_SUPER_GREAT and you send me a
>>> patch to the driver to look for that name. If the GPIO does the same
>>> thing, I couldn’t care less what the data sheet says. That might be
>>> a comment in the DT file, but it should not pollute the driver code.
>>>
>>
>> BT_DISABLE_N is the name of this pin in the datasheet of the QCA chip,
>> not on the board, so this name is the same regardless of what you name
>> the line or gpio your board connect it to.
> 
> and QCA chip v1 and QCA chip v2 will use the same driver and same firmware loading mechanism. So why do we have to add a new GPIO naming if they decide to change the name in the data sheet. With Bluetooth it is pretty much all the same. Every UART chip has a shutdown/reset GPIO to enable/disable the chip behind the UART.
> 
>>> A new board should not require driver changes, you just ship a new DT
>>> for that board and an existing driver hopefully just does the job. No
>>> matter how someone named a GPIO in a piece of paper.
>>>
>>
>> I totally agree with the fact that the board should not affect the
>> naming of the gpio in the driver. But I do enjoy when we refer to pins
>> by their real name - instead of having to guess which pin in the _chip_
>> specification the driver actually refer to.
>>
>>
>> That said, what name would you prefer for this?
>>
>> Afaict this is not "wakeup" and there are a few extra steps between the
>> disabled state and "bluetooth is enabled", so "enable" feels slightly
>> wrong. And it probably should be "bluetooth" and not just "device" as
>> this refers to a pin on a WiFi/BT combo chip.
> 
> The Broadcom side called it shutdown GPIO, it is essentially the shutdown/reset GPIO or power on/off GPIO. Personally I do not care what it is named, but it will be all the same for all Bluetooth chips. Take a poll from Broadcom, Intel, Realtek and Qualcomm and you can pick a reasonable common name.

The Nokia driver has "bluetooth-wakeup" gpio. The Broadcom one has 
"device-wakeup" and "shutdown". The "shutdown" gpio is set to its active 
state to power on the chip which sounds reversed logic. Same for the 
"bt-disable-n" gpio in the Qualcomm driver, configured as ACTIVE_HIGH, 
and which is set to 1 to enable it...

So for consistency, naming it as "shutdown" to stick to the bcm driver 
but it should be configured as ACTIVE_LOW in the dts so we actually do a 
gpiod_set_value(0) to un-shutdown it. Does that sound ok?

Regards,
Thierry

> For the wakeup GPIOs, these are different and depend on if there is some low-power mode provided. You would need to check the data sheet to see if they provide more advanced low-power state handling.
> 
> Regards
> 
> Marcel
> 
