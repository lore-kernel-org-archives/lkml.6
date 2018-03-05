Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeCERa7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:30:59 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36881 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbeCERa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:30:57 -0500
X-Google-Smtp-Source: AG47ELuClMBsvw+XGiEng7mWgnaSw8wwUSLwuzSYzfboVSC+KbtFAs4isLMCVI3OcNwd31Tvq4bC/w==
Subject: Re: lost interrupts when running sabrelite images (v4.15+) in qemu
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fugang Duan <fugang.duan@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180303163236.GA29514@roeck-us.net>
 <88917ab4-ade0-dcfc-e81a-eeaa8a4d15b8@boundarydevices.com>
 <2801dae5-1334-a127-d36c-244d35e71222@roeck-us.net>
 <bd6121f1-0466-c6d8-57a9-1c8b03d3ab99@roeck-us.net>
From: Troy Kisky <troy.kisky@boundarydevices.com>
Message-ID: <5c5ffdea-7702-c989-0fdb-60803c8e59ab@boundarydevices.com>
Date: Mon, 5 Mar 2018 09:30:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bd6121f1-0466-c6d8-57a9-1c8b03d3ab99@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/2018 1:12 PM, Guenter Roeck wrote:
> On 03/03/2018 12:48 PM, Guenter Roeck wrote:
>> On 03/03/2018 11:07 AM, Troy Kisky wrote:
>>> On 3/3/2018 8:32 AM, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> since v4.15, I get the following runtime warning when running sabrelite images
>>>> in qemu.
>>>>
>>>> irq 65: nobody cared (try booting with the "irqpoll" option)
>>>> ...
>>>> handlers:
>>>> [<26292474>] fec_pps_interrupt
>>>> Disabling IRQ #65
>>>> fec 2188000.ethernet (unnamed net_device) (uninitialized): MDIO read timeout
>>>>
>>>> Bisect points to commit 4ad1ceec05e491 ("net: fec: Let fec_ptp have its
>>>> own interrupt routine"). Analysis shows that platform_irq_count()
>>>> returns 2, which is reduced to 1 by fec_enet_get_irq_cnt().
>>>> If I let fec_enet_get_irq_cnt() return 2, the problem is gone.
>>>> Reverting commit 4ad1ceec05e491 also fixes the problem.
>>>>
>>>> Bisect log is attached.
>>>>
>>>
>>> Sounds like you found a bug with qemu. I just booted sabrelite over nfs fine.
>>> My interrupts look like this.
>>>
>>>
>>>   64:      98767          0          0          0     GIC-0 150 Level     2188000.ethernet
>>>   65:          0          0          0          0     GIC-0 151 Level     2188000.ethernet
>>> ___________
>>> Irq 65 is only for ptp interrrupts now. If qemu is signaling an tx/rx frame interrupt on 65,
>>> then qemu is wrong. Of course, I've never used qemu so feel free to ignore me if I make no sense.
>>>
>>
>> Thanks for checking with real hardware.
>>
>> This is what I see (with your patch reverted):
>>
>>   64:          0     GIC-0 150 Level     2188000.ethernet
>>   65:         64     GIC-0 151 Level     2188000.ethernet
>>
>> Looking into the qemu source, I see:
>>
>> #define FSL_IMX6_ENET_MAC_1588_IRQ 118
>> #define FSL_IMX6_ENET_MAC_IRQ 119
>>
>> FSL_IMX6_ENET_MAC_IRQ is then connected to fec interrupt index 0, and FSL_IMX6_ENET_MAC_1588_IRQ
>> is connected to fec interrupt index 1.
>>
>> This may suggest that the defines are reversed. I'll see what happens if I swap them.
>>
> 
> Confirmed. If I swap the above defines, everything works fine. At the same time,
> the modified qemu works with older kernels.
> 
> Thanks a lot for the hint, and sorry for the noise.
> 
> Guenter
> 
It definitely was not noise. I bet it helps people searching the mailing list in the future.
Thanks for posting the resolution.

BR
Troy
