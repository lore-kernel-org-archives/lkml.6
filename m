Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D4AB2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9115A208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9115A208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755863AbeFOH56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:57:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41813 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755853AbeFOH54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:57:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A2250207A8; Fri, 15 Jun 2018 09:57:54 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7073A2073C;
        Fri, 15 Jun 2018 09:57:54 +0200 (CEST)
Date:   Fri, 15 Jun 2018 09:57:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] crypto: sun4i-ss: prevent deadlock on emulated hardware
Message-ID: <20180615075754.b3ivyagjsomiafwk@flea>
References: <20180614193659.29261-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d3bc5bjiueqxbttr"
Content-Disposition: inline
In-Reply-To: <20180614193659.29261-1-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d3bc5bjiueqxbttr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 09:36:59PM +0200, Corentin Labbe wrote:
> Running a qemu emulated cubieboard with sun4i-ss driver enabled led to a =
never
> ending boot.
> This is due to sun4i-ss deadlocked and taking all cpu in an infinite loop.
> Since the crypto hardware is not implemented, all registers are read as 0.
> So sun4i-ss will never progress in any operations. (TX_CNT being always 0)
>=20
> The first idea is to add a "TX_CNT always zero timeout" but this made cip=
her/hash loops
> more complex and prevent a case that never happen on real hardware.
>=20
> The best way to fix is to check at probe time if we run on a virtual
> machine with hardware emulated but non-implemented and prevent
> sun4i-ss to be loaded in that case.
> Letting sun4i-ss to load is useless anyway since all crypto algorithm wil=
l be
> disabled since they will fail crypto selftests.
>=20
> Tested-on: qemu-cubieboard
> Tested-on: cubieboard2
>=20
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sun=
xi-ss/sun4i-ss-core.c
> index a81d89b3b7d8..a178e80adcf3 100644
> --- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> +++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> @@ -341,9 +341,18 @@ static int sun4i_ss_probe(struct platform_device *pd=
ev)
>  	 * I expect to be a sort of Security System Revision number.
>  	 * Since the A80 seems to have an other version of SS
>  	 * this info could be useful
> +	 * Detect virtual machine with non-implemented hardware
> +	 * (qemu-cubieboard) by checking the register value after a write to it.
> +	 * On non-implemented hardware, all registers are read as 0.
> +	 * On real hardware we should have a value > 0.
>  	 */
>  	writel(SS_ENABLED, ss->base + SS_CTL);
>  	v =3D readl(ss->base + SS_CTL);
> +	if (!v) {
> +		dev_err(&pdev->dev, "Qemu with non-implemented SS detected.\n");
> +		err =3D -ENODEV;
> +		goto error_rst;
> +	}

This is wrong way to tackle the issue. There's multiple reason why
this could happen (for example the device not being clocked, or
maintained in reset). There's nothing specific about qemu here, and
the fundamental issue isn't that the device isn't functional in qemu,
it's that qemu lies about which hardware it can emulate in the DT it
passes to the kernel.

There's no way this can scale, alone from the fact that qemu should
patch the DT according to what it can do. Not trying to chase after
each and every device that is broken in qemu.

NAK.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--d3bc5bjiueqxbttr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsjcYEACgkQ0rTAlCFN
r3RnVg//coWWia0EGvQBuHfMfNhL+KHWmUzN8b9bHkJe66git/dx7GTDcekwFjb9
wIQZs3Kd/uNg36AVSz3XJr0dqfpJTLeAs3LKcjUL9v1Tec3ETbpuw8azqRQ9FzFO
+YOjs+6OUp+WLQ6wanHZHwwePe6ZRqTu35o/FFBpdv59RFdyzc2dXUrrZjbYB5Li
gSZxkqmLMaT6B/0zupF+v7ud3AFOqAI08sfwMrOmtbI0jwgWzXZ+uyXVwDOe+YVk
I1AooDj9RAiL00Xdo2fp/pd2JJXUwv0Jo1+R4WsP+0dZWu/ULsXIbFjD3yBQlppB
ErnrIbUrPacWW5kwZLNG5zy94fyc1qcdbxjHx0Mm78BiLWycbS0wpmrwiA4Ouucp
Jj+eiqFYGsQmeqvtRAtA5OBs8ArIkTfZ5zSBYccBNYCbvBiR9KbPSey7kMGiBy4Q
kyskqB6nqc/ZXxb5bRhmCS1TDPVv0NnRzDewrlLYKyLhDbksejcGZuKBBFOd2nky
lyPhhw11w6LPvdHvsACV/JEiXJRTVYkQavgOvgX8OwrMU17YJit50vqYFtIuNv3V
dG7BsYztkKXm2beHGjM+Slk+pqs15zuN3VLSTxXaldtDx/Jt7/YpE7Dh6/lIkXRy
izZCI7Vorh2Q2Tj9L48n/wOZgqHcUKBvt2777mWJo0yIMEbnJ5Q=
=82VN
-----END PGP SIGNATURE-----

--d3bc5bjiueqxbttr--
