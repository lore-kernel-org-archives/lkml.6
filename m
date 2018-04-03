Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeDCNUf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:20:35 -0400
Received: from sauhun.de ([88.99.104.3]:42248 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932151AbeDCNUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:20:34 -0400
Date: Tue, 3 Apr 2018 15:20:32 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>
Cc: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/6] drivers/i2c: Update i2c_trace_msg static key to
 modern api
Message-ID: <20180403132032.bseezddmd6rrka6g@ninjato>
References: <20180326210929.5244-1-dave@stgolabs.net>
 <20180326210929.5244-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xxl2fqw3fz72krmp"
Content-Disposition: inline
In-Reply-To: <20180326210929.5244-2-dave@stgolabs.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xxl2fqw3fz72krmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 02:09:24PM -0700, Davidlohr Bueso wrote:
> No changes in refcount semantics -- key init is false; replace
>=20
> static_key_slow_inc|dec   with   static_branch_inc|dec
> static_key_false          with   static_branch_unlikely
>=20
> Added a '_key' suffix to i2c_trace_msg, for better self
> documentation.
>=20

CCing David who wrote the original code

> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  drivers/i2c/i2c-core-base.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 16a3b73375a6..bfcff2a6f0a3 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -69,18 +69,18 @@ static DEFINE_IDR(i2c_adapter_idr);
> =20
>  static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *dr=
iver);
> =20
> -static struct static_key i2c_trace_msg =3D STATIC_KEY_INIT_FALSE;
> +static DEFINE_STATIC_KEY_FALSE(i2c_trace_msg_key);
>  static bool is_registered;
> =20
>  int i2c_transfer_trace_reg(void)
>  {
> -	static_key_slow_inc(&i2c_trace_msg);
> +	static_branch_inc(&i2c_trace_msg_key);
>  	return 0;
>  }
> =20
>  void i2c_transfer_trace_unreg(void)
>  {
> -	static_key_slow_dec(&i2c_trace_msg);
> +	static_branch_dec(&i2c_trace_msg_key);
>  }
> =20
>  const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
> @@ -1848,11 +1848,12 @@ int __i2c_transfer(struct i2c_adapter *adap, stru=
ct i2c_msg *msgs, int num)
>  	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
>  		return -EOPNOTSUPP;
> =20
> -	/* i2c_trace_msg gets enabled when tracepoint i2c_transfer gets
> +	/*
> +	 * i2c_trace_msg_key gets enabled when tracepoint i2c_transfer gets
>  	 * enabled.  This is an efficient way of keeping the for-loop from
>  	 * being executed when not needed.
>  	 */
> -	if (static_key_false(&i2c_trace_msg)) {
> +	if (static_branch_unlikely(&i2c_trace_msg_key)) {
>  		int i;
>  		for (i =3D 0; i < num; i++)
>  			if (msgs[i].flags & I2C_M_RD)
> @@ -1871,7 +1872,7 @@ int __i2c_transfer(struct i2c_adapter *adap, struct=
 i2c_msg *msgs, int num)
>  			break;
>  	}
> =20
> -	if (static_key_false(&i2c_trace_msg)) {
> +	if (static_branch_unlikely(&i2c_trace_msg_key)) {
>  		int i;
>  		for (i =3D 0; i < ret; i++)
>  			if (msgs[i].flags & I2C_M_RD)
> --=20
> 2.13.6
>=20

--xxl2fqw3fz72krmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrDf6AACgkQFA3kzBSg
KbazIw/9H4eSlFdejqiccIT8tWvw2+Uz4pKkFtrtGrq3SK08rxVjpqYyBykk5m3O
5GTxFLENW2copdyMPDuXV1j1fgnR3aWEi5jzNOwpmJJNi8uqjIscYuCbpkfAo+q0
fWMGcCMympf1Qln/Ss4WVci2OYROOpfbPMyQsjecV2XdKfsWUz/kWoP75K+LCcI/
bqNKAQK8WwrccOYTU0bfGhdI2PCcSupsAFio+pdKtiUXasV9WuklXUa+Madp7r9Q
fO2W91QZ7AFt/nWBfvD8ngy38fGAPxigazM/n1y7XQw4RkEHSxM0DinlfYJGTz/H
6zK+TYgU0HgFFzzL1leyXa3N5i7fOJ4rgENV/Df9jozcvYRtSJKuOuWGIUcM16ts
/KIabp+VfU7kgj/cjve2c3qYPsoqD+MKXGmupAC3GP4bbr1am+P+uP97PGcYnf/5
GKHgcR8XOs5T6m2nAzYcylN117KesQ/JfLtByu7BksBOnHGKgMkxAB3A1STxobOk
uT36xkfAL1o96fNGKU0Az5nWVqxnNp3b0dUYo+gz8RQulDVzz4omrMQln5x8BQcm
mx4IwDgSzeZl2EcbLoDSolNfkh9rttmouTiEqW9FaEJ1Bo4NC+CPmP+Iau8gqcU1
T2Kbc/YqWevbSEnRNS+9dkWrCsH1cJAu9laegvssTyxknyXu3oU=
=GKb6
-----END PGP SIGNATURE-----

--xxl2fqw3fz72krmp--
