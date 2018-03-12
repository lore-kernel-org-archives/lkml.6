Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeCLXNk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:13:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43257 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeCLXNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:13:38 -0400
X-Google-Smtp-Source: AG47ELtpnjtnGHckSgSdFcmsxrnUiQ3kei0GOyQubMUSTb3zF7MheKBrLNemCY+mbsbCHvzLjp0Q7A==
Date: Tue, 13 Mar 2018 00:13:35 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Masaki Ota <masaki.ota@jp.alps.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization for v3
 and v6 protocols
Message-ID: <20180312231335.fnfxgenu22utr3z6@pali>
References: <20180312230915.26050-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wapmdgzw56g4lcxp"
Content-Disposition: inline
In-Reply-To: <20180312230915.26050-1-pali.rohar@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wapmdgzw56g4lcxp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Masaki, if you have access to the internal ALPS v3 / Rushmore
documentation, I would like to have a review of this patch or
confirmation of those information :-)

On Tuesday 13 March 2018 00:09:15 Pali Roh=C3=A1r wrote:
> Remove cite "Not sure what this does, but it is absolutely essential".
>=20
> Extract initialization of trackstick part when touchpad is in passthrought
> mode for v3 and v6 protocols into own function. Initialization for v3 is:
> setscale11, setscale11, setscale11, nibble 0x9, nibble 0x4. Initialization
> for v6 is: setscale11, setscale11, setscale11, setrate 0xC8, setrate 0x14.
> Nibbles 0x9 and 0x4 for v3 protocol correspondent to setrate 0xC8 and 0x1=
4,
> therefore these sequences are same.
>=20
> When touchpad is in passthrought mode, then OS communicates with tracksti=
ck
> and this sequence is some magic vendor PS/2 command to put trackstick into
> "extended" mode. After that sequence trackstick starts reporting packets =
in
> some vendor 4 bytes format (first byte is always 0xE8).
>=20
> Next step after configuring trackstick to be in "extended" mode, is to
> configure touchpad for v3 protocol to expect that trackstick reports data
> in "extended" mode. For v3 protocol this is done by setting bit 1 in
> register 0xC2C8 (offset 0x08 from base address 0xC2C0).
>=20
> When both touchpad and trackstick are not configured for "extended" mode
> then touchpad reports trackstick packets in different format, which is not
> supported by psmouse/alps driver (yet).
>=20
> In Cirque documentation GP-AN- 130823 INTERFACING TO GEN4 OVER I2C (PDF)
> available at http://www.cirque.com/gen4-dev-resources is Logical Address
> 0xC2C8 named as PS2AuxControl and Bit Number 1 as ProcessAuxExtendedData
> with description: Auxiliary device data is assumed to be extended data wh=
en
> set.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  drivers/input/mouse/alps.c | 80 ++++++++++++++++++++++++++++------------=
------
>  1 file changed, 49 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index dbe57da8c1a1..010c1bcdb06d 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2063,14 +2063,11 @@ static int alps_hw_init_v1_v2(struct psmouse *psm=
ouse)
>  	return 0;
>  }
> =20
> -static int alps_hw_init_v6(struct psmouse *psmouse)
> +/* Must be in passthrough mode when calling this function */
> +static int alps_trackstick_enter_extended_mode_v3_v6(struct psmouse *psm=
ouse)
>  {
>  	unsigned char param[2] =3D {0xC8, 0x14};
> =20
> -	/* Enter passthrough mode to let trackpoint enter 6byte raw mode */
> -	if (alps_passthrough_mode_v2(psmouse, true))
> -		return -1;
> -
>  	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
>  	    ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
>  	    ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
> @@ -2078,9 +2075,25 @@ static int alps_hw_init_v6(struct psmouse *psmouse)
>  	    ps2_command(&psmouse->ps2dev, &param[1], PSMOUSE_CMD_SETRATE))
>  		return -1;
> =20
> +	return 0;
> +}
> +
> +static int alps_hw_init_v6(struct psmouse *psmouse)
> +{
> +	int ret;
> +
> +	/* Enter passthrough mode to let trackpoint enter 6byte raw mode */
> +	if (alps_passthrough_mode_v2(psmouse, true))
> +		return -1;
> +
> +	ret =3D alps_trackstick_enter_extended_mode_v3_v6(psmouse);
> +
>  	if (alps_passthrough_mode_v2(psmouse, false))
>  		return -1;
> =20
> +	if (ret)
> +		return ret;
> +
>  	if (alps_absolute_mode_v6(psmouse)) {
>  		psmouse_err(psmouse, "Failed to enable absolute mode\n");
>  		return -1;
> @@ -2154,10 +2167,18 @@ static int alps_probe_trackstick_v3_v7(struct psm=
ouse *psmouse, int reg_base)
> =20
>  static int alps_setup_trackstick_v3(struct psmouse *psmouse, int reg_bas=
e)
>  {
> -	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
>  	int ret =3D 0;
> +	int reg_val;
>  	unsigned char param[4];
> =20
> +	/*
> +	 * We need to configure trackstick to report data for touchpad in
> +	 * extended format. And also we need to tell touchpad to expect data
> +	 * from trackstick in extended format. Without this configuration
> +	 * trackstick packets sent from touchpad are in basic format which is
> +	 * different from what we expect.
> +	 */
> +
>  	if (alps_passthrough_mode_v3(psmouse, reg_base, true))
>  		return -EIO;
> =20
> @@ -2175,39 +2196,36 @@ static int alps_setup_trackstick_v3(struct psmous=
e *psmouse, int reg_base)
>  		ret =3D -ENODEV;
>  	} else {
>  		psmouse_dbg(psmouse, "trackstick E7 report: %3ph\n", param);
> -
> -		/*
> -		 * Not sure what this does, but it is absolutely
> -		 * essential. Without it, the touchpad does not
> -		 * work at all and the trackstick just emits normal
> -		 * PS/2 packets.
> -		 */
> -		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
> -		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
> -		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
> -		    alps_command_mode_send_nibble(psmouse, 0x9) ||
> -		    alps_command_mode_send_nibble(psmouse, 0x4)) {
> -			psmouse_err(psmouse,
> -				    "Error sending magic E6 sequence\n");
> +		if (alps_trackstick_enter_extended_mode_v3_v6(psmouse)) {
> +			psmouse_err(psmouse, "Failed to enter into trackstick extended mode\n=
");
>  			ret =3D -EIO;
> -			goto error;
>  		}
> +	}
> +
> +	if (alps_passthrough_mode_v3(psmouse, reg_base, false))
> +		return -EIO;
> +
> +	if (ret)
> +		return ret;
> =20
> +	if (alps_enter_command_mode(psmouse))
> +		return -EIO;
> +
> +	reg_val =3D alps_command_mode_read_reg(psmouse, reg_base + 0x08);
> +	if (reg_val =3D=3D -1) {
> +		ret =3D -EIO;
> +	} else {
>  		/*
> -		 * This ensures the trackstick packets are in the format
> -		 * supported by this driver. If bit 1 isn't set the packet
> -		 * format is different.
> +		 * Tell touchpad that trackstick is now in extended mode.
> +		 * If bit 1 isn't set the packet format is different.
>  		 */
> -		if (alps_enter_command_mode(psmouse) ||
> -		    alps_command_mode_write_reg(psmouse,
> -						reg_base + 0x08, 0x82) ||
> -		    alps_exit_command_mode(psmouse))
> +		reg_val |=3D BIT(1);
> +		if (__alps_command_mode_write_reg(psmouse, reg_val))
>  			ret =3D -EIO;
>  	}
> =20
> -error:
> -	if (alps_passthrough_mode_v3(psmouse, reg_base, false))
> -		ret =3D -EIO;
> +	if (alps_exit_command_mode(psmouse))
> +		return -EIO;
> =20
>  	return ret;
>  }

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--wapmdgzw56g4lcxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqcJmwAKCRCL8Mk9A+RD
UvtrAJ0bHthOAthzxKY1ko/WTUK2RNBzPwCcCl/+bSes4qWJ5jyrfMHC6CxwgVk=
=agNz
-----END PGP SIGNATURE-----

--wapmdgzw56g4lcxp--
