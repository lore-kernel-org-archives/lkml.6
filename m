Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeA3SWj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:22:39 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38206 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeA3SWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:22:36 -0500
X-Google-Smtp-Source: AH8x22529xczBxa/ax/bFBLFPQlTwtsMGYuNAesn6vEdKByhewakABpj76kB+2kReyqc2qYqbDqpE1wEFGtz+5ZeYh0=
MIME-Version: 1.0
In-Reply-To: <56310e2c-eedc-a71a-3247-d418ec10052d@opengear.com>
References: <cover.1517195327.git.andrew.cooks@opengear.com>
 <f6b7e8e5dc31d294c08d1c218b59e1afce820b37.1517195327.git.andrew.cooks@opengear.com>
 <CAHp75VeZ6fXJsRAj=4ozhLe=X=yL8y3pBVk1c4H7_niQ88Gfhw@mail.gmail.com> <56310e2c-eedc-a71a-3247-d418ec10052d@opengear.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 20:22:34 +0200
Message-ID: <CAHp75VeFym8ei2M9_de0Wqg7g1dDV1TAq6DxTigfHfeT4TFopg@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c: add ACPI support for i2c-piix4
To: Andrew Cooks <andrew.cooks@opengear.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C/SMBUS CONTROLLER DRIVERS FOR PC"
        <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 3:43 AM, Andrew Cooks <andrew.cooks@opengear.com> wrote:
> On 29/01/18 23:30, Andy Shevchenko wrote:
>> On Mon, Jan 29, 2018 at 5:54 AM, Andrew Cooks <andrew.cooks@opengear.com> wrote:
>>> This enables the i2c-piix4 SMBus controller driver to enumerate I2C
>>> slave devices using ACPI. It builds on the related I2C mux device work
>>> in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")
>>>
>>> In the i2c-piix4 driver the adapters are enumerated as:
>>>  Main SMBus adapter Port 0, Port 2, ..., aux port (i.e., ASF adapter)
>>>
>>> However, in the AMD BKDG documentation[1], the implied order of ports is:
>>>  Main SMBus adapter Port 0, ASF adapter, Port 2, Port 3, ...
>>>
>>> This ordering difference is unfortunate, and we assume that ACPI
>>> developers will use the Linux ordering.
>>>
>>> [1] 52740 BIOS and Kernel Developer's Guide (BKDG) for AMD Family 16h
>>> Models 30h-3Fh Processors
>>
>>> +       if (has_acpi_companion(&dev->dev)) {
>>> +               acpi_preset_companion(&adap->dev,
>>> +                                     ACPI_COMPANION(&dev->dev),
>>> +                                     piix4_adapter_count++);
>>> +       }
>>
>> Wouldn't be enough just following:
>>
>>      ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&dev->dev));
>
> In the ACPI DSDT, I've modeled the topology as follows:
>
> Device(SBUS) {
>         Name(_ADR, 0x00140000)
>         Name(_HID, "SMB0001") // SMBus CMI spec uses (invalid hid) "SMBUS01"
>
>         Device(CH00) {
>                 Name(_ADR, 0) // main SMBus adapter, Port 0
>                 Name (_STR, Unicode ("Main SMBus adapter, Port 0"))
>         }
>
>         Device(CH01) {
>                 Name(_ADR, 1) // main SMBus Port 2 (Port 1 label is undefined)
>                 Name (_STR, Unicode ("Main SMBus adapter, Port 2"))
>         }
>
>         Device (CH02) {
>                 Name(_ADR, 2) // ASF adapter (what Linux calls 'aux port')
>                 Name (_STR, Unicode ("AUX / ASF SMBus adapter"))
>         }
> }
>
> That is why each piix4 adapter matches a CH0? device that is descendant from the SBUS device in ACPI.
>
> It is similar to the topology shown in commit 8eb5c87a ("i2c: add ACPI support for I2C mux ports")

Ah, I see now. Your initial approach seems fine.

Perhaps even new helper can be made for users (currently i2c mux,
sdio, libata) in the future.

-- 
With Best Regards,
Andy Shevchenko
