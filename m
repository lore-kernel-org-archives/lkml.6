Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C987FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABC52146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeL1IW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:22:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45285 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeL1IW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:22:58 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 47EB480705; Fri, 28 Dec 2018 09:22:51 +0100 (CET)
Date:   Fri, 28 Dec 2018 09:22:55 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Anderson Luiz Alves <alacn1@gmail.com>
Cc:     andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] mv88e6060: disable hardware level MAC learning
Message-ID: <20181228082255.GB6341@amd>
References: <20181130235836.11741-1-alacn1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20181130235836.11741-1-alacn1@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-30 21:58:36, Anderson Luiz Alves wrote:
> Disable hardware level MAC learning because it breaks station roaming.
> When enabled it drops all frames that arrive from a MAC address
> that is on a different port at learning table.
>=20
> Signed-off-by: Anderson Luiz Alves <alacn1@gmail.com>

Will not this effectively disable the hardware switching leading to
serious performance implications?

AFAICT the e6060 driver does not support ATU access from the kernel,
so we'll fall back to "all software" bridging....

								Pavel
> ---
>=20
> Notes:
>     v2: Updated code comments.
>     v3: Sent with correct whitespaces.
>=20
>  drivers/net/dsa/mv88e6060.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
> index 65f10fec2..0b3e51f24 100644
> --- a/drivers/net/dsa/mv88e6060.c
> +++ b/drivers/net/dsa/mv88e6060.c
> @@ -116,8 +116,7 @@ static int mv88e6060_switch_reset(struct dsa_switch *=
ds)
>  	/* Reset the switch. */
>  	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
>  		  GLOBAL_ATU_CONTROL_SWRESET |
> -		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
> -		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
> +		  GLOBAL_ATU_CONTROL_LEARNDIS);
> =20
>  	/* Wait up to one second for reset to complete. */
>  	timeout =3D jiffies + 1 * HZ;
> @@ -142,13 +141,10 @@ static int mv88e6060_setup_global(struct dsa_switch=
 *ds)
>  	 */
>  	REG_WRITE(REG_GLOBAL, GLOBAL_CONTROL, GLOBAL_CONTROL_MAX_FRAME_1536);
> =20
> -	/* Enable automatic address learning, set the address
> -	 * database size to 1024 entries, and set the default aging
> -	 * time to 5 minutes.
> +	/* Disable automatic address learning.
>  	 */
>  	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
> -		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
> -		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
> +		  GLOBAL_ATU_CONTROL_LEARNDIS);
> =20
>  	return 0;
>  }

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwl3V8ACgkQMOfwapXb+vJqcgCfZvBmGcCi30mDfzPHuHBcz8CW
6B8An3TWDkrkvTjureoi+qn23hdS9CFv
=hHu6
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
