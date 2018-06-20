Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F59FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6CB20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QPiW8+Cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6CB20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754866AbeFTJQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:16:04 -0400
Received: from mout01.posteo.de ([185.67.36.65]:40530 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754348AbeFTJQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:16:00 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 29F6F2115B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 11:15:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529486158; bh=K4mBmzcvkFX6EAlI+OOwpDWvG2OE27Rhd9cgxrkpuQo=;
        h=Subject:To:Cc:From:Date:From;
        b=QPiW8+CycslJZ/Wsk1mL2mKeGa37xmW0MaZX5r8mmtu3cRFYdT7vVqr1LPXYtbaSn
         jaSYZ6OwSkaGk5vteebtVzk/sAuWF5eSsgMlUm8MdarzGy4UtFvUtzNY8ME4dzcCS0
         lE2ltIdysiiOyaYC2tYcVE9P9mbWMz7iEs11Eyuhe/RxLcRXD7p4PUb7BvgLelJaJG
         8xfHPVBp2vfzNidzQiIjE25Q9NmUtVn8ha/Rx8Yhpg1RR2ib7Ci2xifjEF8m+qODXA
         7GdsWMG9YTX9bNtOsIygISnAp6Pd47h+LlzIFDFmH0drp6mC8MwvJagVcIepXTT9cQ
         GiQMYYAR6d6hQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 419fMH2kFzz9rxK;
        Wed, 20 Jun 2018 11:15:55 +0200 (CEST)
Subject: Re: [PATCH] iio: mma8452: Fix ignoring MMA8452_INT_DRDY
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Harinath Nampally <harinath922@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d3cdb3fef8434663c95b7b2f799c5ee4446a5231.1528397238.git.leonard.crestez@nxp.com>
From:   Martin Kepplinger <martink@posteo.de>
Message-ID: <55337e35-a4f7-e543-6384-e1f523d3f463@posteo.de>
Date:   Wed, 20 Jun 2018 11:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d3cdb3fef8434663c95b7b2f799c5ee4446a5231.1528397238.git.leonard.crestez@nxp.com>
Content-Type: multipart/mixed;
 boundary="------------D2EA9B289B1D020A999BAE92"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D2EA9B289B1D020A999BAE92
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-07 20:52, Leonard Crestez wrote:
> Interrupts are ignored if no event bit is set in the status status
> register and this breaks the buffer interface. No data is shown when
> running "iio_generic_buffer -n mma8451 -a" and interrupt counts go
> crazy.
>=20
> Fix by not returning IRQ_NONE if DRDY is set.
>=20
> Fixes: 605f72de137a ("iio: accel: mma8452: improvements to handle
> multiple events")
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

At least this does no harm to events. So if this solves your problem:

Acked-by: Martin Kepplinger <martink@posteo.de>

thanks,

                            martin

>=20
> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Perhaps this whole early-exit check could be dropped? It is not clear
> how it helps.
>=20
> If for some models we want to ignore unsupported events then maybe this=

> should be checked for each individual bit. Instead of
>=20
> if (src & MMA8452_INT_FF_MT) {
>=20
> Check for:
>=20
> if ((src & MMA8452_INT_FF_MT) && (data->chip_info->enabled_events & MMA=
8452_INT_FF_MT))
>=20
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7a2da7f9d4dc..5485b35fe553 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1032,11 +1032,11 @@ static irqreturn_t mma8452_interrupt(int irq, v=
oid *p)
> =20
>  	src =3D i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>  	if (src < 0)
>  		return IRQ_NONE;
> =20
> -	if (!(src & data->chip_info->enabled_events))
> +	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
>  		return IRQ_NONE;
> =20
>  	if (src & MMA8452_INT_DRDY) {
>  		iio_trigger_poll_chained(indio_dev->trig);
>  		ret =3D IRQ_HANDLED;
>=20


--------------D2EA9B289B1D020A999BAE92
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFrystwBCADHbgV1brDLZDyFVnYzlhd1sI3eDgWQMuCV8CFnKM4+VK8dK3T7
IuA56+xW5cLsNNhpsCHgyl1/hoZFStaEt2aOSeUoNwlxLhBX3zS6KMk6R1cpsq+L
TgnoU+yFez2yh0RlZcOI0cYCEPG9FyolrQ1Xmx12mUDP62G+EEM+7ln+3J9e/QWo
ubdygiiSBsvHp7kQuHt09FdS74ey+dUghtczIJChH1BNgko7WDooXHBcrwj5rG4j
OHetOm6DZfuNtAlYI/XQsjerZtvimT+OLoBLHZ2POITHXhNLnsYQvducqeMbLW6G
H6FVaHjAMmE2vYL+Gsk+0X1so7Hft3AiFcuLABEBAAG0JU1hcnRpbiBLZXBwbGlu
Z2VyIDxtYXJ0aW5rQHBvc3Rlby5kZT6JAVQEEwEIAD4WIQS0F76hydj1GXEYJVOh
2YOPZcMl0AUCWvKy3QIbAwUJAeEzgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAK
CRCh2YOPZcMl0AGVB/sHTB8m5D/YIqVQ1cDsUFu9jqNbsxxvPN5UNA7u3/FrQI2y
fvOxxIdrKWbZUhMzbjhlZWXYyPhzDIShyusbIG9eBUxcabVFXHN2UwfoGyBT5htN
bNoLBi1LV9a22IF3sowJRC7tjVs2AFnUyC2IAX8qX8w4kwB2a2nn7LRrEWq2cBbd
+dlIcKROVkFpqBpxO3Echx8MnspYDZOmLrSzxJ2yjQjUHENrVtUzVOyjfUjmr42Q
Fa9+8pMg2fuoW0rUe8s1PdxsyQJGBIB7uPVeRfhb5VQd9TNNcp1VTTid0F+UbcJz
YISYUhVr6p6KyP3lO6TB2qm03DOks7lvAqmShBV0uQENBFrystwBCAC5FF+kLz9O
329d32O5jKeddYNHOljPjCQtA7irZPYgYT0pfgx8NM9FhVACiV3s1s0PYBe6kP7p
s4SxKN06Xo5SSXmTNuSWIAOY2iGnZueEB9PRXPDiz3+Nqk/z2QbOcDLzSutxoNUe
p2Zxu4bvK8ieAk0/H9ZlYCGfw7fC4v+yiqD4mWVWiYEwiDIbV08eRYo5DyGzT+oY
aVP66NI9DtxXRGDK5Fa9HfjQj3dm29ehr640CowF/aGpsdiIdzQ1BDtjY5odaw8a
FBhSNUg/53GVi0qOeiq3+z8l7WzesTtTRQXsKkLfm+D35gg4PMs8L1pXnKAHuok4
pgeDZ4VFlX1BABEBAAGJATwEGAEIACYWIQS0F76hydj1GXEYJVOh2YOPZcMl0AUC
WvKy3AIbDAUJAeEzgAAKCRCh2YOPZcMl0ML9B/9eZI8Og2+jvIgDwSXApL/7Vscl
rz/QB/JW3uCmNeud2Y4022kaYSgiMnuR0ceg47JMHxl2I6Rye2pjI7nVV2Ia1nbM
ycNnxpSGgFKkN6y6zqlt7ms8MO9Ph09DnLHJRbHDJI7l7MP1k7Ri7NzRZmVkh6ES
y+yd6AQbINujvDw16wIIDoL7cmM+kyCBPKhH2iPiknLTaaC0UTGs22e4xhr7WOku
T0pnuoPe4Dn2lFsbkP7LDOfSgij5AlcH6dyOAjv7yXJFXYmomI2JTh9PbgvAG9j0
KnKObElXGxN2dqd3z11N0u0NXL5izbmTBtZB+F6Fk1PVdu8bnImM6Wwa7io8
=3D55tu
-----END PGP PUBLIC KEY BLOCK-----

--------------D2EA9B289B1D020A999BAE92--
