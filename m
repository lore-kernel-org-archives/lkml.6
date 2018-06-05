Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeFEDL1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 23:11:27 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34351 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeFEDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 23:11:26 -0400
X-Originating-IP: 96.22.60.141
Date: Mon, 4 Jun 2018 23:11:20 -0400
From: Hugo Lefeuvre <hle@owl.eu.com>
To: Marcus Wolf <linux@wolf-entwicklungen.de>
Cc: Valentin Vidic <Valentin.Vidic@CARNet.hr>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hle@owl.eu.com
Subject: rf69_set_deviation in rf69.c (pi433 driver)
Message-ID: <20180605031120.GB1981@hle-laptop.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcus,

I have been taking a look at the pi433 driver these last days, and started
working on the remaining TODOs. I just stumbled across the following
one (drivers/staging/pi433/rf69.c):

245         // TODO: Dependency to bitrate
246         if (deviation < 600 || deviation > 500000) {
247                 dev_dbg(&spi->dev, "set_deviation: illegal input param"=
);
248                 return -EINVAL;
249         }

According to the datasheet[0], the deviation should always be smaller
than 300kHz, and the following equation should be respected:

  (1) FDA + BRF/2 =3D< 500 kHz

Why did you choose 500kHz as max for FDA, instead of 300kHz ? It looks like
a bug to me.

Concerning the TODO, I can see two solutions currently:

1. Introduce a new rf69_get_bit_rate function which reads REG_BITRATE_MSB
   and REG_BITRATE_LSB and returns reconstructed BRF.
   We could use this function in rf69_set_deviation to retrieve the BRF.

+ clean
+ intuitive
- heavy / slow

2. Store BRF somewhere in rf69.c, initialize it with the default value
   (4.8 kb/s) and update it when rf69_set_bit_rate is called.

+ easy
- dirty, doesn't fit well with the design of rf69.c (do not store
  anything, simply expose API)

I'd really prefer going for the first one, but I wanted to have your opinion
on this.

Thanks for your work !

Best regards,
 Hugo

[0] http://www.hoperf.com/upload/rf/RFM69CW-V1.1.pdf

[CC-ing Valentin Vidic, he was quite active on the pi433 driver these
last months]

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlsV/08ACgkQLVy48vb3
khlVPAgAjghfCSeRglbwClJ4KivU/dh3hwTwITQ1GDDw7wAwfdEd0ReR1T4V8JiZ
7TYCuqfL4D/e2GZgm6kTwLLPPbPZ4s601xcoHduW57E176kdiKjkZs2yGiIPwYsD
dStXvnAMuzyz8wDDRRWhcnAr27Tk2lP/5cdZrVrdqDgX0dzdJd/vMGoU7JH04Vtd
aBnN0M2qq6wP3kK6ba1QL3KH21WPm9hGyvPo4QjdfFvGBxzFcihK/Neam44KLIu3
faR+nO0k1xkSaaizEwjelZobJ6Fg7THAj/M5UWvTHGqa6Ju/v+9Kha2pGC/wZVmV
tOur3ksci4fdRCkOmgxVXzETW5gXug==
=hAVE
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
