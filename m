Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754791AbeBGRUb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:20:31 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35676 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbeBGRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:20:29 -0500
X-Google-Smtp-Source: AH8x225mXSzUTddhxiEoYx0iO1cWunWcLrXrpGOWJOX7HA1U7hJMGdnbhFo+OM/oBuFnzVf2E12Zjg==
Date: Wed, 7 Feb 2018 18:20:25 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Chen Guanqiao <chen.chenchacha@foxmail.com>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v9 2/3] fs: fat: Add volume label entry method function
Message-ID: <20180207172025.e5f3pxzjdot26l2u@pali>
References: <20180207161407.30507-1-chen.chenchacha@foxmail.com>
 <20180207161407.30507-3-chen.chenchacha@foxmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="c3pd4opbkkxzxn4z"
Content-Disposition: inline
In-Reply-To: <20180207161407.30507-3-chen.chenchacha@foxmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3pd4opbkkxzxn4z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 08 February 2018 00:14:06 Chen Guanqiao wrote:
> Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>

Missing commit message and information what are the new proposed
functions suppose to do.

> ---
>  fs/fat/dir.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 8e100c3bf72c..d5286402c829 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -881,6 +881,53 @@ static int fat_get_short_entry(struct inode *dir, lo=
ff_t *pos,
> 	return -ENOENT;
>  }
>=20
> +int fat_get_volume_label_entry(struct inode *dir, struct buffer_head **b=
h,
> +			       struct msdos_dir_entry **de)
> +{
> +	loff_t pos =3D 0;
> +
> +	*bh =3D NULL;
> +	*de =3D NULL;
> +	while (fat_get_entry(dir, &pos, bh, de) >=3D 0) {
> +		if (((*de)->attr & ATTR_VOLUME) && ((*de)->attr !=3D ATTR_EXT) &&
> +		    !IS_FREE((*de)->name))
> +			return 0;
> +	}
> +	return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(fat_get_volume_label_entry);

Why both functions are exported? In this patch series are used only in
file.c which is in the same object file.

> +
> +int fat_add_volume_label_entry(struct inode *dir, const unsigned char *n=
ame,
> +			       struct timespec *ts)
> +{
> +	struct msdos_sb_info *sbi =3D MSDOS_SB(dir->i_sb);
> +	struct msdos_dir_entry de;
> +	struct fat_slot_info sinfo;
> +	__le16 time, date;
> +	int err;
> +
> +	memcpy(de.name, name, MSDOS_NAME);
> +	de.attr =3D ATTR_VOLUME;
> +	de.lcase =3D 0;
> +	fat_time_unix2fat(sbi, ts, &time, &date, NULL);
> +	de.cdate =3D de.adate =3D 0;
> +	de.ctime =3D 0;
> +	de.ctime_cs =3D 0;
> +	de.time =3D time;
> +	de.date =3D date;
> +	fat_set_start(&de, 0);
> +	de.size =3D 0;
> +
> +	err =3D fat_add_entries(dir, &de, 1, &sinfo);
> +	if (err)
> +		return err;
> +
> +	brelse(sinfo.bh);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fat_add_volume_label_entry);

This function looks like copy+paste of function msdos_add_entry().
Please de-duplicate code as this would lead to problems in future.

Also who is supposed to format dos name? Caller or callee? There is no
information neither in commit message nor in comments.

> +
>  /*
>   * The ".." entry can not provide the "struct fat_slot_info" information
>   * for inode, nor a usable i_pos. So, this function provides some inform=
ation
> --
> 2.14.3

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--c3pd4opbkkxzxn4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWns1VwAKCRCL8Mk9A+RD
UmM1AJ9GiZN3yipEL+9WuOJQIrE4/K5YLgCfdMLZXh9oAqJ2umf/+o9it9Ct45o=
=mRGt
-----END PGP SIGNATURE-----

--c3pd4opbkkxzxn4z--
