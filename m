Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeDJBGE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:06:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbeDJBGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:06:03 -0400
From: NeilBrown <neil@brown.name>
To: Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Date: Tue, 10 Apr 2018 11:05:50 +1000
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to 3-byte addressing.
In-Reply-To: <a3bb28f9-1185-3dbb-1a1f-1bfe03a8798c@gmail.com>
References: <874lkmw54j.fsf@notabene.neil.brown.name> <61e255fa-ece4-5566-d63a-730aaa25f18c@gmail.com> <87sh85uzu3.fsf@notabene.neil.brown.name> <a3bb28f9-1185-3dbb-1a1f-1bfe03a8798c@gmail.com>
Message-ID: <87efjnvpjl.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09 2018, Marek Vasut wrote:

> On 04/08/2018 11:56 PM, NeilBrown wrote:
>> On Sun, Apr 08 2018, Marek Vasut wrote:
>>=20
>>> On 04/08/2018 09:04 AM, NeilBrown wrote:
>>>>
>>>> According to section
>>>>    8.2.7 Write Extended Address Register (C5h)
>>>>
>>>> of the Winbond W25Q256FV data sheet (256M-BIT SPI flash)
>>>>
>>>>    The Extended Address Register is only effective when the device is
>>>>    in the 3-Byte Address Mode.  When the device operates in the 4-Byte
>>>>    Address Mode (ADS=3D1), any command with address input of A31-A24
>>>>    will replace the Extended Address Register values. It is
>>>>    recommended to check and update the Extended Address Register if
>>>>    necessary when the device is switched from 4-Byte to 3-Byte Address
>>>>    Mode.
>>>>
>>>> This patch adds code to implement that recommendation.  Without this,
>>>> my GNUBEE-PC1 will not successfully reboot, as the Extended Address
>>>> Register is left with a value of '1'. When the SOC attempts to read
>>>> (in 3-byte address mode) the boot loader, it reads from the wrong
>>>> location.
>>>
>>> Your board is broken by design and does not implement proper reset logic
>>> for the SPI NOR chip, right ? That is, when the CPU resets, the SPI NOR
>>> is left in some random undefined state instead of being reset too, yes?
>>=20
>> Thanks for the reply.
>
> Sorry for the delay.
>
>> "Broken" is an emotive word :-)  Certain the board *doesn't* reset the N=
OR
>> chip on reset.
>
> It's not emotive, it is descriptive of what it really is. Such boards
> which do not correctly reset the SPI NOR can, during ie. reset, get into
> a state where the system is unbootable or corrupts the content of the
> SPI NOR. This stuff came up over and over on the ML, it seems HW
> designers never learn.

Ok, the board is broken.
Still, Linux has a history of even supporting broken hardware -  Spectre
and Meltdown for example.
I wouldn't propose a fix that harms the kernel in any way (hurts
maintainability or negatively affect other hardware), but I don't
think my proposed patch does.

>
>> However the NOR chip doesn't have a dedicated RESET pin. It has a pin
>> that defaults to "HOLD" and can be programmed to act as "RESET".  This
>> pin is tied to 3V3 on my board. If it were tied to a reset line, it
>> would still need code changes to work (or switch from the default).
>
> I'm afraid this needs HW changes. The solution for SPI NORs without a
> dedicated reset line is to just hard cut the power to them for a while
> in case the CPU core reset out is asserted.
>
>> A few month ago:
>> Commit: 8dee1d971af9 ("mtd: spi-nor: add an API to restore the status of=
 SPI flash chip")
>> Commit: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when=
 exiting")
>
> This works when reloading the driver, but not when restarting the system.

I don't understand what you are saying.
The second patch provides a ->shutdown function for the spi_driver.
This is called by spi_drv_shutdown which is called by the driver
=2D>shutdown function, which is called by device_shutdown(), which
is only called by
  kernel_shutdown_prepare() and
  kernel_restart_prepare().

So it works exactly when restarting the system, and not when reloading
the driver.

>
>> were added to Linux.  They appear to be designed to address a very
>> similar situation to mine.  Unfortunately they aren't complete as the
>> code to disable 4-byte addressing doesn't follow documented requirements
>> (at least for winbond) and doesn't work as intended (at least in one
>> case - mine). This code should either be fixed (e.g. with my patch), or =
removed.
>>=20
>>>
>>> Doesn't this chip support 4-byte addressing opcodes ? If so, we should
>>> use those and keep the chip in 3-byte addressing mode. Would that work?
>>=20
>> Yes and no.
>> If I
>> -	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_=
READ | SPI_NOR_QUAD_READ) },
>> +	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512,
>> +			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>> +			  SPI_NOR_4B_OPCODES) },
>>=20
>> then I can still read all the flash and it never gets switched to
>> 4-byte mode.
>
> Yes, dedicated opcodes are the way to go ... although, it doesn't solve
> the reset problem completely. Imagine your CPU ie. restarts during a
> page program operation and then the BootROM sends data over the SPI.
> Those data might get written into the SPI NOR, thus corrupting the
> content.

What, apart from power loss, would restart the CPU??
I guess the watchdog could do that - so I would not enable the watchdog
timer on this board unless I could disable it during a NOR write cycle.

Even if I we cannot, in software, fix all the down-sides of not having a
reset line, I think there is still a case for fixing anything that can
easily be fixed.

>
>> However, if the last address read from the flash is beyond 16M, the
>> extended address register gets implicitly set to 1, and reboot doesn't
>> work.
>> i.e. the problem isn't 4-byte mode exactly.  The problem is the Extended
>> Address Register being set implicitly, and not being zero at reboot.
>
> Uh oh, I seems to remember something like this with the winbond flash.
> I think this was also the reason why zynqmp couldn't boot from those,
> because it was somehow weirdly configured by default.

I've since discovered another aspect of the weirdness.
Switching from 4-byte mode to 3-byte mode sets the extended address
register to 1.  I'm happy to call that "broken hardware".
So for this chip, the correct sequence for switching to 3-byte mode is:
  - send the "switch to 3-byte mote" command
  - write 0 to the extended address register.
=20

>
>> It looks like we need to clear the extended address register before
>> reboot, either by:
>>  - software-reset the flash at shutdown
>
> Doesn't work if CPU resets without executing this hook.
>
>>  - write '0' in the shutdown handler
>
> See above
>
>>  - write '0' after every transfer (or every transfer beyond 16M).
>
> What happens if CPU resets during the transfer ? System fails to boot.
>
>> Which would you prefer, or is there another option?
> Neither, and I am really sorry I don't have a suggestion for you here.
> But I think there might be something eluding me regarding this winbond
> extended something register. How is the behavior of the chip different
> exactly from a convention > 16 MiB SPI NOR (ie. Spansion one) ?

I'm sorry but I cannot answer that.  I don't have a Spansion chip and
I've never worked with nor flash before.
What I know is that in the Winbond W25Q256FV

=2D There is an "Extended address register" (EAR) which is used for the
  top byte when 3-byte addressing is used.
=2D The EAR is set to 1 when switching from 4-byte to 3-byte mode, and
  set to zero at power-on.
=2D When using a 4-byte-address opcode, the high byte is copied into
  the EAR on each access.

(I examined http://www.cypress.com/file/177966/download which seems to be
 a data sheet for the spansion S25FL256S and it describes a single bit
 in the BAR (Bank Address Register) which corresponds to the Winbond
 Extended address register.  Presumably is does not get updated
 implicitly in the same way that the Winbond EAR does)

Also on my board
=2D the SOC boots from the NOR flash in 3-byte mode
=2D the hold/reset line for the NOR flash is wired to 3v3.

I cannot defend any of this, nor can I change it.  I just want to make
it work as best I can.  The patch I provided does fix the one
problematic symptom that I can easily reproduce.  Do you have any
objection to the actual code?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrMDe4ACgkQOeye3VZi
gbkmpA/+JBZIJWan16DabdNLUV9XqkQGnazdE7ULtZK511phELzWvsCLA732TPGR
Kodcf6qUno1y4CLAZl/DVhfwGXnYY+0w0nb/6JarOR+w0xJzfBBQYfyNu8qfij0t
OJQSdpU1aAVpSCxUNcW+q6GmkoZX557ykA1xLibb70fhC+UZsOcotxWQ8iw8+n5Q
4uqVixgJ8aEMKnAy4wG6MolS5OXqslh64bBPQi/DpbmYW8YqSlgTKBNaNYWeThci
toSkna7Ird4sjuOgc2z97R/+UbWtlx4vAhRefqT97urwqbHL7iAqIBBcxW7Dfftt
fSedlwKDDk/2g32tnRwwWg7w8dwYXT4PTmkqPhCCQIOG4ZYRmDabY5SMpmV7wQBi
4hwWk8iBDnNiTIsrF6eFrAOYSMhXBOfQSth71y0YebQWWh1E6+DREjG3APt0HkAV
8B2gTU70PtMvZtDkw6bXUgbJDnRyKZMcjYI9OdyeUaZaaVD5u3Ovc5VsWCdzOje9
oy7Lb9K35tBCkiAEVhs14hEIpz3vLBEmyGkCQHiUNb+ykIrJMcGsoiNmeGfCBZ/U
pE61xIuUiXZD5n7KXr5zxbL9my9+HjoOSuGwjxNPQYJKzWQB5nV0oAH2yhcYDJ0X
e1pK+cxr44UpAvIpxGVpGh2vkXdQhZj2TajCDtDt6OWZKjNFveg=
=A2B8
-----END PGP SIGNATURE-----
--=-=-=--
