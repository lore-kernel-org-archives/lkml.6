Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeBCIhE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 03:37:04 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45940 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBCIgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 03:36:55 -0500
X-Google-Smtp-Source: AH8x225YnsKVDPqoSMJaF2FV/qvhkHMJGSM+dgrPi9FWH4WYbTrljV7mAHz5pDCLdUGG/DzyyvlZgw==
Date: Sat, 3 Feb 2018 09:36:51 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com
Subject: Re: [PATCH 1/2] HID: core: i2c-hid: fix size check and type usage
Message-ID: <20180203083651.GB707@gmail.com>
References: <20180102173006.506-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20180102173006.506-1-aaron.ma@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Wed, Jan 03, 2018 at 01:30:05AM +0800, Aaron Ma wrote:
> When convert char array with signed int, if the inbuf[x] is negative then
> upper bits will be set to 1. Fix this by using u8 instead of char.
>=20
> ret_size has to be at least 3, hid_input_report use it after minus 2 byte=
s.

At least 2?
hid_input_report() checks (!size)

>=20
> size should be more than 0 to keep memset safe.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/hid/hid-core.c        |  4 ++--
>  drivers/hid/i2c-hid/i2c-hid.c | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 0c3f608131cf..992547771d96 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1506,7 +1506,7 @@ int hid_report_raw_event(struct hid_device *hid, in=
t type, u8 *data, int size,
>  	if (rsize > HID_MAX_BUFFER_SIZE)
>  		rsize =3D HID_MAX_BUFFER_SIZE;
> =20
> -	if (csize < rsize) {
> +	if ((csize < rsize) && (csize > 0)) {
>  		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
>  				csize, rsize);
>  		memset(cdata + csize, 0, rsize - csize);
> @@ -1566,7 +1566,7 @@ int hid_input_report(struct hid_device *hid, int ty=
pe, u8 *data, int size, int i
>  	report_enum =3D hid->report_enum + type;
>  	hdrv =3D hid->driver;
> =20
> -	if (!size) {
> +	if (size <=3D 0) {

All code that is using hid_input_report() seems to check that no
negative size is provided.

If we want this check, maybe we should consider making size unsigned
instead?

>  		dbg_hid("empty report\n");
>  		ret =3D -1;
>  		goto unlock;
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index e054ee43c1e2..09404ffdb08b 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -144,10 +144,10 @@ struct i2c_hid {
>  						   * register of the HID
>  						   * descriptor. */
>  	unsigned int		bufsize;	/* i2c buffer size */
> -	char			*inbuf;		/* Input buffer */
> -	char			*rawbuf;	/* Raw Input buffer */
> -	char			*cmdbuf;	/* Command buffer */
> -	char			*argsbuf;	/* Command arguments buffer */
> +	u8			*inbuf;		/* Input buffer */
> +	u8			*rawbuf;	/* Raw Input buffer */
> +	u8			*cmdbuf;	/* Command buffer */
> +	u8			*argsbuf;	/* Command arguments buffer */

Looks good

> =20
>  	unsigned long		flags;		/* device flags */
>  	unsigned long		quirks;		/* Various quirks */
> @@ -473,7 +473,7 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
> =20
>  	ret_size =3D ihid->inbuf[0] | ihid->inbuf[1] << 8;
> =20
> -	if (!ret_size) {
> +	if (ret_size <=3D 2) {

if (ret_size < 2) ?


>  		/* host or device initiated RESET completed */
>  		if (test_and_clear_bit(I2C_HID_RESET_PENDING, &ihid->flags))
>  			wake_up(&ihid->wait);
> --=20
> 2.14.3


Best regards
Marcus Folkesson

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlp1dJ4ACgkQiIBOb1ld
UjJwoQ/8CjhTg3RxsLsSW9f2be0hZ8HzlHBn2YkE6J97mt6kYV2twMaaN29slSNi
t+c1w5EK4qFpMZbQ3yl4023fnEgZPrh52TpdiyJJXCb5sSqfaOuHVu1eBIgIEIRg
bHbN+CpXpMhBHRy5mbCzWh6tRJfGT45wO9Sh9w+k3QMNVhh8XkHsBUbSUjEl6ozV
8fnONxnArhXoVfYVfg+42QRg6FYImZT93LzNM1kQLg8F8azZgd0jug5mi2ickdH5
VXG6iZ0hD7d8yZu6+o2TAS6rK4AVDHX3+ZqZ9maIb4hR6h7D4SibQ5qP4TbbASTt
VNXrJVCI8vBg5Cm+lvVKwNXA5TO4VmJfv3CkQ7+4w9z3J5tzieAVUY7qy/MxhCu6
rWEjxTm19m7zp6HkJff22DiljRBCIGP6NqvMpJf8X4uFBNtj2cUeRY5vwX9X1Ub1
TO+0mvQh61SKdjEn6VXlqqz/vzpHCt7Nx/ENLpEL/EYOyj4GChvpsSVoLYjwsrxp
WQl6ScEUS8c1Rx6WN859QqxUNCRsWwzNdN1jIncuMosBcM6i0AT/TxyHpp8yeLmM
+29t1UyiuVHPqvmsylat1M7EO49BVfIKN/AEWEujngBsxhJrQZ6lNKNqoRvUunxM
wABz7m0IU/W309MMd81f2zBFH5DtNKFU0YDxS36JRdcFvRHY6p4=
=IoLX
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
