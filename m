Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeDTV2b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:28:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53425 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751375AbeDTV2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:28:30 -0400
From: NeilBrown <neil@brown.name>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Date: Sat, 21 Apr 2018 07:28:19 +1000
Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Brian Norris" <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: clear Winbond Extended Address Reg on switch to 3-byte addressing.
In-Reply-To: <20180420215440.7b078f6c@bbrezillon>
References: <874lkmw54j.fsf@notabene.neil.brown.name> <87sh7wrq8p.fsf@notabene.neil.brown.name> <20180420215440.7b078f6c@bbrezillon>
Message-ID: <87efj9pnyk.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20 2018, Boris Brezillon wrote:

> Hi Neil,
>
> On Mon, 16 Apr 2018 09:42:30 +1000
> NeilBrown <neil@brown.name> wrote:
>
>> Winbond spi-nor flash 32MB and larger have an 'Extended Address
>> Register' as one option for addressing beyond 16MB (Macronix
>> has the same concept, Spansion has EXTADD bits in the Bank Address
>> Register).
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
>> So the documentation suggests clearing the EAR after switching to
>> 3-byte mode.  Experimentation shows that the EAR is *always* one after
>> the switch to 3-byte mode, so clearing the EAR is mandatory at
>> shutdown for a subsequent 3-byte-addressed reboot to work.
>>=20
>> Note that some SOCs (e.g. MT7621) do not assert a reset line at normal
>> reboot, so we cannot rely on hardware reset.  The MT7621 does assert a
>> reset line at watchdog-reset.
>>=20
>> Signed-off-by: NeilBrown <neil@brown.name>
>
> We should probably backport the fix. Can you add a Fixes and Cc-stable
> tag?

It's a bit weird having Fixes when this isn't a regression, but I guess
it doesn't hurt.
I chose
  Fixes: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when e=
xiting")
as this patch it useless without that one.

I also fixed the comment and have resent.

Thanks,
NeilBrown

>
>> ---
>>=20
>> following a helpful discussion with Marek, I've revised the description
>> a little, and make the code change specific to winbond.
>> I've change the OP names to RDEAR and WREAR instead of RDXA and WRXA to
>> match names used in the Macronix documentation.  Winbond documentation
>> doesn't provide abbreviated OP names.
>>=20
>> Thanks,
>> NeilBrown
>>=20
>>=20
>>  drivers/mtd/spi-nor/spi-nor.c | 13 +++++++++++++
>>  include/linux/mtd/spi-nor.h   |  2 ++
>>  2 files changed, 15 insertions(+)
>>=20
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor=
.c
>> index d445a4d3b770..0d0af0acf8b9 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -284,6 +284,19 @@ static inline int set_4byte(struct spi_nor *nor, co=
nst struct flash_info *info,
>>  		if (need_wren)
>>  			write_disable(nor);
>>=20=20
>> +		if (!status && !enable &&
>> +		    JEDEC_MFR(info) =3D=3D SNOR_MFR_WINBOND) {
>> +			/* On Winbond W25Q256FV, leaving 4byte mode causes
>
> We use regular kernel-comment style in MTD:
>
> 			/*
> 			 * blablabla
> 			 */
>
> Thanks,
>
> Boris
>
>> +			 * the Extended Address Register to be set to 1, so all
>> +			 * 3-byte-address reads come from the second 16M.
>> +			 * We must clear the register to enable normal behavior.
>> +			 */
>> +			write_enable(nor);
>> +			nor->cmd_buf[0] =3D 0;
>> +			nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf, 1);
>> +			write_disable(nor);
>> +		}
>> +
>>  		return status;
>>  	default:
>>  		/* Spansion style */
>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>> index de36969eb359..e60da0d34cc1 100644
>> --- a/include/linux/mtd/spi-nor.h
>> +++ b/include/linux/mtd/spi-nor.h
>> @@ -62,6 +62,8 @@
>>  #define SPINOR_OP_RDCR		0x35	/* Read configuration register */
>>  #define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
>>  #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
>> +#define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
>> +#define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
>>=20=20
>>  /* 4-byte address opcodes - used on Spansion and some Macronix flashes.=
 */
>>  #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlraW3MACgkQOeye3VZi
gbkrvQ//fXP5JfgGVVb2AqXFyXJhbrSEufa0dlaD97IFkIvWh9t3WWWqs1N7nAI4
txILjvT31ui8aQUei98aAyjEnxmxMJNwm/sk7JF1dBPowxtx+VUXk4QEt/RzIVRD
WtIZfcjKRBsov8qQSRlGQb4w2h0z951125E2IX9cmIBLbqgNe3yEOUdPXfotoAdE
aCYMEkhrqLv1Vs4aRp34J1WHN+l4TUMAp6ZnVU9L2kA923m9NjJFwYUxGb4ph02V
Kmk/sl0wUeGtBPvZQfGlK0xKMZhKJ/ZpkytsL5hTKX50SjsfVqv5qHBa3lgkqfYD
ERrFco9nrVj8Gb9lu6Fz99PypXXajlPPoLd4q6skovnLmmpSlKlVMlrrsBC8zOlw
JyjW9N8e8EOvvnojQ33VWnWnzjpDyzUqh3Zv8RM1tSA5SXpml6PXJS50xG1eqjaO
aBwET0Yt3Lfd7iQA1CT5IzFDiVL5tfxLe0IGogiH4KrIXbIWDHm9QIWSSo0GcJOY
H8/iweGwviSPyfl5aNLLEIrpQCrfMGCvzfbjplgjX+eSNAuj9Z4MkXTN9R3pUZJk
ndlDlhz629TlJLL0F3y8BMsHqaY1Zf4uDD4BEJjWphg6RWUwlxSwbE6hJbLnQr52
jGjCNrGijYkWtO43h22IUfEEZEP478q5WieTz9JHqvnDB0sQes8=
=+oqp
-----END PGP SIGNATURE-----
--=-=-=--
