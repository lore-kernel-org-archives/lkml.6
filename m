Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeDIXqM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 19:46:12 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:51102 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeDIXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 19:46:06 -0400
X-Google-Smtp-Source: AIpwx49ohjeniJBQcEOimp/RHU3u21pyT4EGjaxhTOoMgAEzF9sjwwLRHeEDjLgMHaSKie/wHJKZQg==
Subject: Re: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to
 3-byte addressing.
To: NeilBrown <neil@brown.name>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <874lkmw54j.fsf@notabene.neil.brown.name>
 <61e255fa-ece4-5566-d63a-730aaa25f18c@gmail.com>
 <87sh85uzu3.fsf@notabene.neil.brown.name>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a3bb28f9-1185-3dbb-1a1f-1bfe03a8798c@gmail.com>
Date: Mon, 9 Apr 2018 23:58:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87sh85uzu3.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2018 11:56 PM, NeilBrown wrote:
> On Sun, Apr 08 2018, Marek Vasut wrote:
> 
>> On 04/08/2018 09:04 AM, NeilBrown wrote:
>>>
>>> According to section
>>>    8.2.7 Write Extended Address Register (C5h)
>>>
>>> of the Winbond W25Q256FV data sheet (256M-BIT SPI flash)
>>>
>>>    The Extended Address Register is only effective when the device is
>>>    in the 3-Byte Address Mode.  When the device operates in the 4-Byte
>>>    Address Mode (ADS=1), any command with address input of A31-A24
>>>    will replace the Extended Address Register values. It is
>>>    recommended to check and update the Extended Address Register if
>>>    necessary when the device is switched from 4-Byte to 3-Byte Address
>>>    Mode.
>>>
>>> This patch adds code to implement that recommendation.  Without this,
>>> my GNUBEE-PC1 will not successfully reboot, as the Extended Address
>>> Register is left with a value of '1'. When the SOC attempts to read
>>> (in 3-byte address mode) the boot loader, it reads from the wrong
>>> location.
>>
>> Your board is broken by design and does not implement proper reset logic
>> for the SPI NOR chip, right ? That is, when the CPU resets, the SPI NOR
>> is left in some random undefined state instead of being reset too, yes?
> 
> Thanks for the reply.

Sorry for the delay.

> "Broken" is an emotive word :-)  Certain the board *doesn't* reset the NOR
> chip on reset.

It's not emotive, it is descriptive of what it really is. Such boards
which do not correctly reset the SPI NOR can, during ie. reset, get into
a state where the system is unbootable or corrupts the content of the
SPI NOR. This stuff came up over and over on the ML, it seems HW
designers never learn.

> However the NOR chip doesn't have a dedicated RESET pin. It has a pin
> that defaults to "HOLD" and can be programmed to act as "RESET".  This
> pin is tied to 3V3 on my board. If it were tied to a reset line, it
> would still need code changes to work (or switch from the default).

I'm afraid this needs HW changes. The solution for SPI NORs without a
dedicated reset line is to just hard cut the power to them for a while
in case the CPU core reset out is asserted.

> A few month ago:
> Commit: 8dee1d971af9 ("mtd: spi-nor: add an API to restore the status of SPI flash chip")
> Commit: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when exiting")

This works when reloading the driver, but not when restarting the system.

> were added to Linux.  They appear to be designed to address a very
> similar situation to mine.  Unfortunately they aren't complete as the
> code to disable 4-byte addressing doesn't follow documented requirements
> (at least for winbond) and doesn't work as intended (at least in one
> case - mine). This code should either be fixed (e.g. with my patch), or removed.
> 
>>
>> Doesn't this chip support 4-byte addressing opcodes ? If so, we should
>> use those and keep the chip in 3-byte addressing mode. Would that work?
> 
> Yes and no.
> If I
> -	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512,
> +			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			  SPI_NOR_4B_OPCODES) },
> 
> then I can still read all the flash and it never gets switched to
> 4-byte mode.

Yes, dedicated opcodes are the way to go ... although, it doesn't solve
the reset problem completely. Imagine your CPU ie. restarts during a
page program operation and then the BootROM sends data over the SPI.
Those data might get written into the SPI NOR, thus corrupting the content.

> However, if the last address read from the flash is beyond 16M, the
> extended address register gets implicitly set to 1, and reboot doesn't
> work.
> i.e. the problem isn't 4-byte mode exactly.  The problem is the Extended
> Address Register being set implicitly, and not being zero at reboot.

Uh oh, I seems to remember something like this with the winbond flash.
I think this was also the reason why zynqmp couldn't boot from those,
because it was somehow weirdly configured by default.

> It looks like we need to clear the extended address register before
> reboot, either by:
>  - software-reset the flash at shutdown

Doesn't work if CPU resets without executing this hook.

>  - write '0' in the shutdown handler

See above

>  - write '0' after every transfer (or every transfer beyond 16M).

What happens if CPU resets during the transfer ? System fails to boot.

> Which would you prefer, or is there another option?
Neither, and I am really sorry I don't have a suggestion for you here.
But I think there might be something eluding me regarding this winbond
extended something register. How is the behavior of the chip different
exactly from a convention > 16 MiB SPI NOR (ie. Spansion one) ?

-- 
Best regards,
Marek Vasut
