Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD9BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A8206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbeL0SPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:15:52 -0500
Received: from anholt.net ([50.246.234.109]:40882 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbeL0SPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:15:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1B60010A2766;
        Thu, 27 Dec 2018 10:15:48 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CxsLCbfrmaEA; Thu, 27 Dec 2018 10:15:47 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0A99210A07BC;
        Thu, 27 Dec 2018 10:15:47 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 5D6132FE36F3; Thu, 27 Dec 2018 10:15:46 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a transaction
In-Reply-To: <1232214204.268730.1545919526431@email.ionos.de>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com> <1941132339.131316.1545481176339@email.ionos.de> <baa17fb765bf8b40fe6e91b4884b83af6fcf7641.camel@bootlin.com> <1232214204.268730.1545919526431@email.ionos.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 27 Dec 2018 10:15:44 -0800
Message-ID: <87y38abzu7.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Paul,
>
>> Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 24. Dezember 20=
18 um 10:10 geschrieben:
>>=20
>>=20
>> Hi,
>>=20
>> On Sat, 2018-12-22 at 13:19 +0100, Stefan Wahren wrote:
>> > Hi Paul,
>> >=20
>> > > Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 21. Dezembe=
r 2018 um 13:11 geschrieben:
>> > >=20
>> > >=20
>> > > The driver's interrupt handler checks whether a message is currently
>> > > being handled with the curr_msg pointer. When it is NULL, the interr=
upt
>> > > is considered to be unexpected. Similarly, the i2c_start_transfer
>> > > routine checks for the remaining number of messages to handle in
>> > > num_msgs.
>> > >=20
>> > > However, these values are never cleared and always keep the message =
and
>> > > number relevant to the latest transfer (which might be done already =
and
>> > > the underlying message memory might have been freed).
>> > >=20
>> > > When an unexpected interrupt hits with the DONE bit set, the isr will
>> > > then try to access the flags field of the curr_msg structure, leading
>> > > to a fatal page fault.
>> > >=20
>> > > Fix the issue by systematically clearing curr_msg and num_msgs in the
>> > > driver-wide device structure when a transfer is considered complete.
>> > >=20
>> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> > > ---
>> > >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
>> > >  1 file changed, 3 insertions(+)
>> > >=20
>> > > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i=
2c-bcm2835.c
>> > > index 44deae78913e..5486252f5f2f 100644
>> > > --- a/drivers/i2c/busses/i2c-bcm2835.c
>> > > +++ b/drivers/i2c/busses/i2c-bcm2835.c
>> > > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *=
adap, struct i2c_msg msgs[],
>> > >  		return -ETIMEDOUT;
>> > >  	}
>> > >=20=20
>> > > +	i2c_dev->curr_msg =3D NULL;
>> > > +	i2c_dev->num_msgs =3D 0;
>> >=20
>> > AFAIU this would reduce the chance of a use-after-free dramatically bu=
t not completely.
>>=20
>> Do you have a specific case of use-after-free related to these
>> variables in mind that this cleanup would not fix (except for the
>> timeout case)?
>
> okay i was wrong about the use-after-free. But i'm not sure about this sc=
enario on the I2C bus shared with the VC4:
>
> 1. ARM core starts I2C transfer (bcm2835_i2c_start_transfer)
> 2. VC4 triggers a BCM2835_I2C_S_DONE interrupt
> 3. ARM core catches this interrupt before the VC4

We don't share I2C buses with VC4, though, right?  That would just be
totally broken.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwlFtAACgkQtdYpNtH8
nugzSBAAh+TmXC01oxfSSVCliBfeyMCRU0gv80tB0rEz9aLB/YmE5hybGpC8NlrG
AxsvacMW/2GdBm9GDr0kLc4aTHCILpcPua13JJWjAs0AQVrw2tDBa4M8j6ldR/OD
IONgtWUZU1T1XauXVsuBmmZCx4mDyqTcljjxMa8ckDKgmWkQ8v+jONXu0QLYsoeN
mX8kM/dB1oDCUtnvf4i2515mhQSA55nZeW+i9AB64i8OXL/D6O0FbKHCa4o7dj/e
VvXfGoG4GPV+Yd+h3oZ/uqvIzkYuSt3Npd8DvQddIsKjdK75TENDoCgDjpI46Fpc
06HlUeNp3QXVwvTNiD1SFIjfoa6GOwquWY3nc8o5bRZl3Pblad4UkPoIUz62A8hG
cu1FOahSzmws3bhC//Ecs6RGKEnV6RS3VKwtzDUkpyE+qseKbsyMBNf+P9ZmXDqu
OnyRSm2n5XWXKTfPJSkEhpX+PbpjuJ3dKGjTmdMP2JKBKrrWwI54Qyl5L1zdwbj0
gtQtTZwvKfmU1eagk1Ojry0bVzdNbaGVRIy65sZE6z7g3s1eo2/BlDaClF3BB93E
2qdn0vzDLtUrD1ZkIySUL9cKhtfEEf01T47yG9mdzqe6y7A/IIy1d8Nia2acjoKY
bMjQ6/J/jevZ9wkJbwjWPaadQcsoPt1dWIjIo+bT6bZUoA0InnM=
=3fJl
-----END PGP SIGNATURE-----
--=-=-=--
