Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeCFOZV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:25:21 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37740 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:25:19 -0500
X-Google-Smtp-Source: AG47ELuotW8qGVEJtcQh/k2a8fVJc3st5K1/t/6lQmZVCLG4yGtG5H3DyEuUROr4bsXX39kGuqagIg==
Subject: Re: lost interrupts when running sabrelite images (v4.15+) in qemu
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Fugang Duan <fugang.duan@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180303163236.GA29514@roeck-us.net>
 <88917ab4-ade0-dcfc-e81a-eeaa8a4d15b8@boundarydevices.com>
 <2801dae5-1334-a127-d36c-244d35e71222@roeck-us.net>
 <bd6121f1-0466-c6d8-57a9-1c8b03d3ab99@roeck-us.net>
 <5c5ffdea-7702-c989-0fdb-60803c8e59ab@boundarydevices.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9ee66efa-397c-898a-5cad-64eabc7752b9@roeck-us.net>
Date: Tue, 6 Mar 2018 06:25:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5c5ffdea-7702-c989-0fdb-60803c8e59ab@boundarydevices.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 09:30 AM, Troy Kisky wrote:
> On 3/3/2018 1:12 PM, Guenter Roeck wrote:
>> On 03/03/2018 12:48 PM, Guenter Roeck wrote:
>>> On 03/03/2018 11:07 AM, Troy Kisky wrote:
>>>> On 3/3/2018 8:32 AM, Guenter Roeck wrote:
>>>>> Hi,
>>>>>
>>>>> since v4.15, I get the following runtime warning when running sabrelite images
>>>>> in qemu.
>>>>>
>>>>> irq 65: nobody cared (try booting with the "irqpoll" option)
>>>>> ...
>>>>> handlers:
>>>>> [<26292474>] fec_pps_interrupt
>>>>> Disabling IRQ #65
>>>>> fec 2188000.ethernet (unnamed net_device) (uninitialized): MDIO read timeout
>>>>>
>>>>> Bisect points to commit 4ad1ceec05e491 ("net: fec: Let fec_ptp have its
>>>>> own interrupt routine"). Analysis shows that platform_irq_count()
>>>>> returns 2, which is reduced to 1 by fec_enet_get_irq_cnt().
>>>>> If I let fec_enet_get_irq_cnt() return 2, the problem is gone.
>>>>> Reverting commit 4ad1ceec05e491 also fixes the problem.
>>>>>
>>>>> Bisect log is attached.
>>>>>
>>>>
>>>> Sounds like you found a bug with qemu. I just booted sabrelite over nfs fine.
>>>> My interrupts look like this.
>>>>
>>>>
>>>>    64:      98767          0          0          0     GIC-0 150 Level     2188000.ethernet
>>>>    65:          0          0          0          0     GIC-0 151 Level     2188000.ethernet
>>>> ___________
>>>> Irq 65 is only for ptp interrrupts now. If qemu is signaling an tx/rx frame interrupt on 65,
>>>> then qemu is wrong. Of course, I've never used qemu so feel free to ignore me if I make no sense.
>>>>
>>>
>>> Thanks for checking with real hardware.
>>>
>>> This is what I see (with your patch reverted):
>>>
>>>    64:          0     GIC-0 150 Level     2188000.ethernet
>>>    65:         64     GIC-0 151 Level     2188000.ethernet
>>>
>>> Looking into the qemu source, I see:
>>>
>>> #define FSL_IMX6_ENET_MAC_1588_IRQ 118
>>> #define FSL_IMX6_ENET_MAC_IRQ 119
>>>
>>> FSL_IMX6_ENET_MAC_IRQ is then connected to fec interrupt index 0, and FSL_IMX6_ENET_MAC_1588_IRQ
>>> is connected to fec interrupt index 1.
>>>
>>> This may suggest that the defines are reversed. I'll see what happens if I swap them.
>>>
>>
>> Confirmed. If I swap the above defines, everything works fine. At the same time,
>> the modified qemu works with older kernels.
>>
>> Thanks a lot for the hint, and sorry for the noise.
>>
>> Guenter
>>
> It definitely was not noise. I bet it helps people searching the mailing list in the future.
> Thanks for posting the resolution.
> 

Turns out "works" as I stated above is not entirely accurate.

- v4.13 and later work
- In v4.12 and earlier, the Ethernet interface fails to instantiate with
	fec 2188000.ethernet (unnamed net_device) (uninitialized): MDIO read timeout
	fec: probe of 2188000.ethernet failed with error -5
   I have not found the reason yet. Unmodified qemu works fine.
- v4.1 and earlier crash. The crash is fixed by commit 32cba57ba74be ("net: fec:
   introduce fec_ptp_stop and use in probe fail path")

There is also a matching bug at lauchpad:

https://bugs.launchpad.net/qemu/+bug/1753309

Guenter
