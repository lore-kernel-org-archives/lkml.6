Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeC1Vxa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:53:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752894AbeC1Vx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:53:28 -0400
From: NeilBrown <neilb@suse.com>
To: Andreas Gruenbacher <agruenba@redhat.com>, cluster-devel@redhat.com
Date: Thu, 29 Mar 2018 08:53:19 +1100
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH] gfs2: Stop using rhashtable_walk_peek
In-Reply-To: <20180328160009.29633-1-agruenba@redhat.com>
References: <20180328160009.29633-1-agruenba@redhat.com>
Message-ID: <87woxv3m0g.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28 2018, Andreas Gruenbacher wrote:

> Function rhashtable_walk_peek is problematic because there is no
> guarantee that the glock previously returned still exists; when that key
> is deleted, rhashtable_walk_peek can end up returning a different key,
> which would cause an inconsistent glock dump.  So instead of using
> rhashtable_walk_peek, keep track of the current glock in the seq file
> iterator functions.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/glock.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 82fb5583445c..f1fc353875d3 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -55,6 +55,7 @@ struct gfs2_glock_iter {
>  	struct gfs2_sbd *sdp;		/* incore superblock           */
>  	struct rhashtable_iter hti;	/* rhashtable iterator         */
>  	struct gfs2_glock *gl;		/* current glock struct        */
> +	bool gl_held;
>  	loff_t last_pos;		/* last position               */
>  };
>=20=20
> @@ -1923,9 +1924,11 @@ void gfs2_glock_exit(void)
>=20=20
>  static void gfs2_glock_iter_next(struct gfs2_glock_iter *gi, loff_t n)
>  {
> -	if (n =3D=3D 0)
> -		gi->gl =3D rhashtable_walk_peek(&gi->hti);
> -	else {
> +	if (n !=3D 0 || !gi->gl) {
> +		if (gi->gl_held) {
> +			gfs2_glock_queue_put(gi->gl);
> +			gi->gl_held =3D false;
> +		}
>  		gi->gl =3D rhashtable_walk_next(&gi->hti);
>  		n--;
>  	}

Thank for this patch!
The above looks a bit fragile to me.
gfs2_glock_iter_next() (And hence gfs2_glock_seq_start()) will sometimes
exit with gl_held true, and sometimes with it false.
gfs2_glock_seq_stop() assumes that it is false.
Normally gfs2_glock_seq_next() will normally be called between these
two and will clear gl_held, but I don't think there is a hard guarantee
of that.
Maybe we should always 'put' gi->gl in iter_next if gl_held??

Thanks,
NeilBrown



> @@ -1988,7 +1991,10 @@ static void gfs2_glock_seq_stop(struct seq_file *s=
eq, void *iter_ptr)
>  {
>  	struct gfs2_glock_iter *gi =3D seq->private;
>=20=20
> -	gi->gl =3D NULL;
> +	if (gi->gl) {
> +		lockref_get(&gi->gl->gl_lockref);
> +		gi->gl_held =3D true;
> +	}
>  	rhashtable_walk_stop(&gi->hti);
>  }
>=20=20
> @@ -2061,6 +2067,7 @@ static int __gfs2_glocks_open(struct inode *inode, =
struct file *file,
>  		 */
>  		gi->last_pos =3D -1;
>  		gi->gl =3D NULL;
> +		gi->gl_held =3D false;
>  		rhashtable_walk_enter(&gl_hash_table, &gi->hti);
>  	}
>  	return ret;
> @@ -2076,7 +2083,8 @@ static int gfs2_glocks_release(struct inode *inode,=
 struct file *file)
>  	struct seq_file *seq =3D file->private_data;
>  	struct gfs2_glock_iter *gi =3D seq->private;
>=20=20
> -	gi->gl =3D NULL;
> +	if (gi->gl_held)
> +		gfs2_glock_put(gi->gl);
>  	rhashtable_walk_exit(&gi->hti);
>  	return seq_release_private(inode, file);
>  }
> --=20
> 2.14.3

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq8Ds8ACgkQOeye3VZi
gblzyBAAl+FP/c4DZRamjdrf9EZ260npA9I3KJgHAE1+/mdv6GlBGfsFkc41/dLo
73dG5dMoXEFb6GnHjz00yh/YdlV4sI+LdLudx8CRCqedRjTz3l8JCjF8Oo4p3N/p
8zFcAZVoqB3SI4izAd6x9gFPJpIPeqzR+bEaUZHcyMy3svNrqhDI8+hYMopNIxHD
ER85ae/Vg+m4GQ4xCG/dDS0aRhNtgH3eB5vaMmrGLRkYu82zzZIVRPP/Bh8oecAQ
leRtt3H/Ramm1psFxDzVbvvbjT6H/puiQENXJ5Vj6uA7UZ69smxRi6Ml7iQN5HpC
HuTGeCWvDSqUexfS/zkcJiDDuB1lgTN2Q694GBhEW2gREMDKIo8usp1CFFEB1sQg
GFeqoUsJXcDNxYN4eXBn8IJFgZNDDmQcXfyD3lxYaZm9Wagvg7GzPuyZsqA5VKrb
HQqDw/1AJo+w6kK0HuXejlhNHrWPMwgseMYXer8caTtwXqDAauFUqBHLHEp5cbBx
Ir36yBXujQ4lVKViDesBhuWxsZaK80IJBoPjoK+zzYpoMGJTN/wY1UqfQOzhzCUf
WfGvVajiFQj8qKz4evcE+P4J6a9JxmzJ66VeiSmbv6YGn5N81n8uM0ZbfFofT+BN
HTr48enjvx5xdc3VJxHSnkRyOqUlpXCmZbhMqGixad2WWZ4O0W0=
=LT7r
-----END PGP SIGNATURE-----
--=-=-=--
