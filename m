Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeCONzE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:55:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37388 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCONzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:55:03 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180315134645.sp3ru2mk6lpqyrda@earth.universe>
Date: Thu, 15 Mar 2018 14:54:59 +0100
Cc: Thierry Escande <thierry.escande@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Content-Transfer-Encoding: 8BIT
Message-Id: <8481B301-0B92-4247-8DC0-A1EDB32325F4@holtmann.org>
References: <20180314155514.3374-1-thierry.escande@linaro.org>
 <20180314155514.3374-3-thierry.escande@linaro.org>
 <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
 <20180314183043.GX18510@minitux>
 <D999852D-E9A7-41D2-9878-A93CB4D43D0C@holtmann.org>
 <20180314190522.GY18510@minitux>
 <494C4C44-1949-405E-91DA-1B40100ED2E6@holtmann.org>
 <d14007a1-a4dd-bd28-3452-a4d3ad70e5a0@linaro.org>
 <20180315134645.sp3ru2mk6lpqyrda@earth.universe>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

>>>> BT_DISABLE_N is the name of this pin in the datasheet of the QCA chip,
>>>> not on the board, so this name is the same regardless of what you name
>>>> the line or gpio your board connect it to.
>>> 
>>> and QCA chip v1 and QCA chip v2 will use the same driver and
>>> same firmware loading mechanism. So why do we have to add a new
>>> GPIO naming if they decide to change the name in the data sheet.
>>> With Bluetooth it is pretty much all the same. Every UART chip
>>> has a shutdown/reset GPIO to enable/disable the chip behind the
>>> UART.
>>> 
>>>>> A new board should not require driver changes, you just ship a new DT
>>>>> for that board and an existing driver hopefully just does the job. No
>>>>> matter how someone named a GPIO in a piece of paper.
>>>>> 
>>>> 
>>>> I totally agree with the fact that the board should not affect the
>>>> naming of the gpio in the driver. But I do enjoy when we refer to pins
>>>> by their real name - instead of having to guess which pin in the _chip_
>>>> specification the driver actually refer to.
>>>> 
>>>> 
>>>> That said, what name would you prefer for this?
>>>> 
>>>> Afaict this is not "wakeup" and there are a few extra steps between the
>>>> disabled state and "bluetooth is enabled", so "enable" feels slightly
>>>> wrong. And it probably should be "bluetooth" and not just "device" as
>>>> this refers to a pin on a WiFi/BT combo chip.
>>> 
>>> The Broadcom side called it shutdown GPIO, it is essentially the
>>> shutdown/reset GPIO or power on/off GPIO. Personally I do not
>>> care what it is named, but it will be all the same for all
>>> Bluetooth chips. Take a poll from Broadcom, Intel, Realtek and
>>> Qualcomm and you can pick a reasonable common name.
>> 
>> The Nokia driver has "bluetooth-wakeup" gpio. The Broadcom one has
>> "device-wakeup" and "shutdown". The "shutdown" gpio is set to its active
>> state to power on the chip which sounds reversed logic. Same for the
>> "bt-disable-n" gpio in the Qualcomm driver, configured as ACTIVE_HIGH, and
>> which is set to 1 to enable it...
>> 
>> So for consistency, naming it as "shutdown" to stick to the bcm driver but
>> it should be configured as ACTIVE_LOW in the dts so we actually do a
>> gpiod_set_value(0) to un-shutdown it. Does that sound ok?
> 
> FWIW you picked the wrong gpio from the nokia bluetooth binding. The
> gpio for shutdown would be "reset". The "bluetooth-wakeup" is
> required for normal operation to exit idle mode. The "reset" name
> used by the nokia binding is quite common for DT:
> 
> Documentation/devicetree/bindings $ git grep reset-gpios | wc -l
> 212
> 
> I guess it only makes sense when the device is actually being
> reset, though (i.e. for Nokia the settings are back to defaults
> and you need to re-upload the FW).

that is actually a good point. I like to differentiate between a shutdown GPIO (and we can argue about the inversion here) and the reset GPIO. If we loose the firmware and the programmed BD_ADDR, then it is a hard-reset, otherwise it is shutdown/power GPIO.

So can we agree on how we name the hard-reset, shutdown, wakeup etc. GPIOs for Bluetooth UART devices?

Regards

Marcel
