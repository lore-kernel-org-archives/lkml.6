Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeDHV4w (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 17:56:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55263 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752212AbeDHV4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 17:56:50 -0400
From: NeilBrown <neil@brown.name>
To: Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Date: Mon, 09 Apr 2018 07:56:36 +1000
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to 3-byte addressing.
In-Reply-To: <61e255fa-ece4-5566-d63a-730aaa25f18c@gmail.com>
References: <874lkmw54j.fsf@notabene.neil.brown.name> <61e255fa-ece4-5566-d63a-730aaa25f18c@gmail.com>
Message-ID: <87sh85uzu3.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08 2018, Marek Vasut wrote:

> On 04/08/2018 09:04 AM, NeilBrown wrote:
>>=20
>> According to section
>>    8.2.7 Write Extended Address Register (C5h)
>>=20
>> of the Winbond W25Q256FV data sheet (256M-BIT SPI flash)
>>=20
>>    The Extended Address Register is only effective when the device is
>>    in the 3-Byte Address Mode.  When the device operates in the 4-Byte
>>    Address Mode (ADS=3D1), any command with address input of A31-A24
>>    will replace the Extended Address Register values. It is
>>    recommended to check and update the Extended Address Register if
>>    necessary when the device is switched from 4-Byte to 3-Byte Address
>>    Mode.
>>=20
>> This patch adds code to implement that recommendation.  Without this,
>> my GNUBEE-PC1 will not successfully reboot, as the Extended Address
>> Register is left with a value of '1'. When the SOC attempts to read
>> (in 3-byte address mode) the boot loader, it reads from the wrong
>> location.
>
> Your board is broken by design and does not implement proper reset logic
> for the SPI NOR chip, right ? That is, when the CPU resets, the SPI NOR
> is left in some random undefined state instead of being reset too, yes?

Thanks for the reply.
"Broken" is an emotive word :-)  Certain the board *doesn't* reset the NOR
chip on reset.
However the NOR chip doesn't have a dedicated RESET pin. It has a pin
that defaults to "HOLD" and can be programmed to act as "RESET".  This
pin is tied to 3V3 on my board. If it were tied to a reset line, it
would still need code changes to work (or switch from the default).

A few month ago:
Commit: 8dee1d971af9 ("mtd: spi-nor: add an API to restore the status of SP=
I flash chip")
Commit: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when ex=
iting")

were added to Linux.  They appear to be designed to address a very
similar situation to mine.  Unfortunately they aren't complete as the
code to disable 4-byte addressing doesn't follow documented requirements
(at least for winbond) and doesn't work as intended (at least in one
case - mine). This code should either be fixed (e.g. with my patch), or rem=
oved.

>
> Doesn't this chip support 4-byte addressing opcodes ? If so, we should
> use those and keep the chip in 3-byte addressing mode. Would that work?

Yes and no.
If I
=2D	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_R=
EAD | SPI_NOR_QUAD_READ) },
+	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512,
+			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			  SPI_NOR_4B_OPCODES) },

then I can still read all the flash and it never gets switched to
4-byte mode.
However, if the last address read from the flash is beyond 16M, the
extended address register gets implicitly set to 1, and reboot doesn't
work.
i.e. the problem isn't 4-byte mode exactly.  The problem is the Extended
Address Register being set implicitly, and not being zero at reboot.
It looks like we need to clear the extended address register before
reboot, either by:
 - software-reset the flash at shutdown
 - write '0' in the shutdown handler
 - write '0' after every transfer (or every transfer beyond 16M).

Which would you prefer, or is there another option?

Thanks,
NeilBrown



>
>> Signed-off-by: NeilBrown <neil@brown.name>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 10 ++++++++++
>>  include/linux/mtd/spi-nor.h   |  2 ++
>>  2 files changed, 12 insertions(+)
>>=20
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor=
.c
>> index d445a4d3b770..c303bf0d2982 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -269,6 +269,7 @@ static inline int set_4byte(struct spi_nor *nor, con=
st struct flash_info *info,
>>  	int status;
>>  	bool need_wren =3D false;
>>  	u8 cmd;
>> +	u8 val;
>>=20=20
>>  	switch (JEDEC_MFR(info)) {
>>  	case SNOR_MFR_MICRON:
>> @@ -283,6 +284,15 @@ static inline int set_4byte(struct spi_nor *nor, co=
nst struct flash_info *info,
>>  		status =3D nor->write_reg(nor, cmd, NULL, 0);
>>  		if (need_wren)
>>  			write_disable(nor);
>> +		if (!status && !enable &&
>> +		    nor->read_reg(nor, SPINOR_OP_RDXA, &val, 1) =3D=3D 0 &&
>> +		    val !=3D 0) {
>> +			/* need to reset the Extended Address Register */
>> +			write_enable(nor);
>> +			val =3D 0;
>> +			nor->write_reg(nor, SPINOR_OP_WRXA, &val, 1);
>> +			write_disable(nor);
>> +		}
>>=20=20
>>  		return status;
>>  	default:
>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>> index de36969eb359..42954419cfdf 100644
>> --- a/include/linux/mtd/spi-nor.h
>> +++ b/include/linux/mtd/spi-nor.h
>> @@ -62,6 +62,8 @@
>>  #define SPINOR_OP_RDCR		0x35	/* Read configuration register */
>>  #define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
>>  #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
>> +#define SPINOR_OP_RDXA		0xc8	/* Read Extended Address Register */
>> +#define SPINOR_OP_WRXA		0xc5	/* Write Extended Address Register */
>>=20=20
>>  /* 4-byte address opcodes - used on Spansion and some Macronix flashes.=
 */
>>  #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
>>=20
>
>
> --=20
> Best regards,
> Marek Vasut

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrKkBQACgkQOeye3VZi
gbmP0A//ZMeppMmXBRCa1w6clTOoJAn2ExjKBrkiKhtTM7rx1Bt89+1U5o7WWbdk
0AN7Mk5Ncj5aCFhFXdHwe25i2fKXCaNXDhrXFZUB9GTFzgZCGEuewutJbthcfvNY
YGXuszfKqjUxwDZKz1mea9WP9CgghiR4ewberIHLzsgb/e3ejGg5F+EtHWAKtTnW
/YQNBXT6vjWNq8ZPe677SsIJSPMs6g924DakJ+OnaTBPNAmUX/kny+SGw3EpckEf
cmGDmOHH4R8S8KXX0iV1N5BjcTQqS7v46qj2vxVEPODzYx6/9+uoqARlulhrVvmW
Cq0QwRCqssFL//Ql8YOKzNickpJZ+janG8kyHhpr+Dtl9ECQAffwzcsL2xeiQ0Ti
+r04BRPsvlbo7Sfs9cHZgZwFabgp566TDw44ZJo7AwiwJRrQfCOmt07egJoXvqFN
+LRrCBqE15B3YSNLQCHhQFpJhfo2OAMxyq8eIIG3MESOwc27/QcR9SZnemdA14BJ
C14XYlcOKex1Loxe7s6Q54zR2vw2GI3pmPt3wRI0EPDwagwh2e4AVVLKWB/yOixC
o/2Th7/u+9lsiemeuIaXSFDlQOsefy2S8Ie8tvXZnapS95lXzlQZ1YPGmJA2Nl0r
kiQBApQB3i8P0WpRffQz9IYB44cC9qgHsf+MUUpQaKrdTDiNnlg=
=uaMT
-----END PGP SIGNATURE-----
--=-=-=--
