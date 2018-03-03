Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeCCUs6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 15:48:58 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44157 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbeCCUs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 15:48:57 -0500
X-Google-Smtp-Source: AG47ELuFWx+yQn+tMRi78NNNgpowKerm5KLv9UNP8SuCKL5Ub5BRlnw9Mm23cwQHlbviZYedXKOtDQ==
Subject: Re: lost interrupts when running sabrelite images (v4.15+) in qemu
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Fugang Duan <fugang.duan@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180303163236.GA29514@roeck-us.net>
 <88917ab4-ade0-dcfc-e81a-eeaa8a4d15b8@boundarydevices.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2801dae5-1334-a127-d36c-244d35e71222@roeck-us.net>
Date: Sat, 3 Mar 2018 12:48:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <88917ab4-ade0-dcfc-e81a-eeaa8a4d15b8@boundarydevices.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2018 11:07 AM, Troy Kisky wrote:
> On 3/3/2018 8:32 AM, Guenter Roeck wrote:
>> Hi,
>>
>> since v4.15, I get the following runtime warning when running sabrelite images
>> in qemu.
>>
>> irq 65: nobody cared (try booting with the "irqpoll" option)
>> ...
>> handlers:
>> [<26292474>] fec_pps_interrupt
>> Disabling IRQ #65
>> fec 2188000.ethernet (unnamed net_device) (uninitialized): MDIO read timeout
>>
>> Bisect points to commit 4ad1ceec05e491 ("net: fec: Let fec_ptp have its
>> own interrupt routine"). Analysis shows that platform_irq_count()
>> returns 2, which is reduced to 1 by fec_enet_get_irq_cnt().
>> If I let fec_enet_get_irq_cnt() return 2, the problem is gone.
>> Reverting commit 4ad1ceec05e491 also fixes the problem.
>>
>> Bisect log is attached.
>>
> 
> Sounds like you found a bug with qemu. I just booted sabrelite over nfs fine.
> My interrupts look like this.
> 
> 
>   64:      98767          0          0          0     GIC-0 150 Level     2188000.ethernet
>   65:          0          0          0          0     GIC-0 151 Level     2188000.ethernet
> ___________
> Irq 65 is only for ptp interrrupts now. If qemu is signaling an tx/rx frame interrupt on 65,
> then qemu is wrong. Of course, I've never used qemu so feel free to ignore me if I make no sense.
> 

Thanks for checking with real hardware.

This is what I see (with your patch reverted):

  64:          0     GIC-0 150 Level     2188000.ethernet
  65:         64     GIC-0 151 Level     2188000.ethernet

Looking into the qemu source, I see:

#define FSL_IMX6_ENET_MAC_1588_IRQ 118
#define FSL_IMX6_ENET_MAC_IRQ 119

FSL_IMX6_ENET_MAC_IRQ is then connected to fec interrupt index 0, and FSL_IMX6_ENET_MAC_1588_IRQ
is connected to fec interrupt index 1.

This may suggest that the defines are reversed. I'll see what happens if I swap them.

Thanks,
Guenter
