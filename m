Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeBGRoO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:44:14 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51188 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754633AbeBGRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:44:12 -0500
X-Google-Smtp-Source: AH8x225XIh/vt/KIK+0MzYNenPLC4ItUzeHVwAwKUSw+IufwJcJ1L8j8m8+3SAFbitS037hSgvD2nQ==
Date: Wed, 7 Feb 2018 18:44:08 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Chen Guanqiao <chen.chenchacha@foxmail.com>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v9 3/3] fs: fat: add ioctl method in fat filesystem driver
Message-ID: <20180207174408.xppbbwaobt6vxkvx@pali>
References: <20180207161407.30507-1-chen.chenchacha@foxmail.com>
 <20180207161407.30507-4-chen.chenchacha@foxmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tgb4tneqgqbsncik"
Content-Disposition: inline
In-Reply-To: <20180207161407.30507-4-chen.chenchacha@foxmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tgb4tneqgqbsncik
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 08 February 2018 00:14:07 Chen Guanqiao wrote:
> Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
> ---
>  fs/fat/file.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 145 insertions(+)
>=20
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 4724cc9ad650..e87c5ae9208e 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -15,11 +15,46 @@
>  #include <linux/fsnotify.h>
>  #include <linux/security.h>
>  #include <linux/falloc.h>
> +#include <linux/ctype.h>
>  #include "fat.h"
>=20
>  static long fat_fallocate(struct file *file, int mode,
> 			  loff_t offset, loff_t len);
>=20
> +static int fat_generate_volume_name(char *label, unsigned long len)
> +{
> +	unsigned int i;
> +
> +	/* For reasons, refer to namei_msdos.c:msdos_format_name() */
> +	if (label[0] =3D=3D 0xE5)
> +		label[0] =3D 0x05;
> +
> +	for (i =3D 0; i < len; ++i) {
> +		char c =3D label[i];
> +		/* valid character contains d-characters and all extended ASCII
> +		 * characters.
> +		 * remaining empty spaces are padded by 0x20.
> +		 */
> +		if (c <=3D 0x7f)

This check if tautology and do nothing. Maximal value in c for x86 is
127 and minimal value -128. (0x7f =3D=3D 127)

> +			switch (label[i]) {
> +			case 'a' ... 'z':
> +				label[i] =3D __toupper(label[i]);

Why this is enforced? And ignored mount option nocase?

> +			case 'A' ... 'Z':
> +			case '0' ... '9':
> +			case '_':
> +			case 0x20:
> +				continue;
> +			case 0:
> +				label[i] =3D 0x20;
> +				continue;
> +			default:
> +				return -EINVAL;

Why are other characters disallowed (e.g. '!')? And completely ignored
mount option check?

> +			}
> +	}
> +
> +	return 0;
> +}

What is purpose of this function at all? There is already e.g.
msdos_format_name() which do lot of needed checks and formats.

> +
>  static int fat_ioctl_get_attributes(struct inode *inode, u32 __user *use=
r_attr)
>  {
> 	u32 attr;
> @@ -121,10 +156,116 @@ static int fat_ioctl_get_volume_id(struct inode *i=
node, u32 __user *user_attr)
> 	return put_user(sbi->vol_id, user_attr);
>  }
>=20
> +
> +static int fat_ioctl_get_volume_label(struct inode *inode, u8 __user *la=
bel)
> +{
> +	struct super_block *sb =3D inode->i_sb;
> +	struct buffer_head *bh;
> +	struct msdos_dir_entry *de;
> +	int err;
> +
> +	inode =3D d_inode(sb->s_root);
> +	inode_lock_shared(inode);
> +
> +	err =3D fat_get_volume_label_entry(inode, &bh, &de);
> +	if (err)
> +		goto out;

Missing handling of leading 0xE5, leading spaces, etc...

> +	if (copy_to_user(label, de->name, MSDOS_NAME))
> +		err =3D -EFAULT;
> +
> +	brelse(bh);
> +out:
> +	inode_unlock_shared(inode);
> +
> +	return err;
> +}
> +
> +static int fat_ioctl_set_volume_label(struct file *file, u8 __user *labe=
l)
> +{
> +	struct inode *inode =3D file_inode(file);
> +	struct super_block *sb =3D inode->i_sb;
> +	struct timespec ts;
> +	struct buffer_head *boot_bh;
> +	struct buffer_head *vol_bh;
> +	struct msdos_dir_entry *de;
> +	struct fat_boot_sector *b;
> +	u8 buf[MSDOS_NAME];
> +	int err;
> +
> +	inode =3D d_inode(sb->s_root);
> +
> +	if (copy_from_user(buf, label, sizeof(buf))) {
> +		err =3D -EFAULT;
> +		goto out;
> +	}
> +
> +	err =3D fat_generate_volume_name(buf, sizeof(buf));
> +	if (err)
> +		goto out;

This looks like a wrong API for userspace. Whole FAT driver for
userspace is working according to codepage=3D and iocharset=3D/utf8 mount
options, just this call fully ignores it. Seems very unintuitive.

What is the reason for such API?

Also there is missing handling of special cases, like empty file label,
etc...

> +	down_write(&sb->s_umount);
> +	err =3D mnt_want_write_file(file);
> +	if (err)
> +		goto out;
> +
> +	inode_lock(inode);
> +
> +	/* Updates root directory's label */
> +	err =3D fat_get_volume_label_entry(inode, &vol_bh, &de);
> +	ts =3D current_time(inode);
> +	if (err) {
> +		/* Create volume label entry */
> +		err =3D fat_add_volume_label_entry(inode, buf, &ts);
> +		if (err)
> +			goto out_vol_brelse;
> +	} else {
> +		/* Write to root directory */
> +		memcpy(de->name, buf, sizeof(de->name));
> +		inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D ts;
> +
> +		mark_buffer_dirty(vol_bh);
> +	}
> +
> +	/* Update sector's label */
> +	boot_bh =3D sb_bread(sb, 0);
> +	if (boot_bh =3D=3D NULL) {
> +		fat_msg(sb, KERN_ERR,
> +			"unable to read boot sector to write volume label");
> +		err =3D -EIO;
> +		goto out_boot_brelse;
> +	}
> +
> +	b =3D (struct fat_boot_sector *)boot_bh->b_data;
> +	if (MSDOS_SB(sb)->fat_bits =3D=3D 32)
> +		memcpy(b->fat32.vol_label, buf, sizeof(buf));
> +	else
> +		memcpy(b->fat16.vol_label, buf, sizeof(buf));

IIRC in boot sector is no 0xE5 <--> 0x05 conversion.

> +	mark_buffer_dirty(boot_bh);
> +
> +	/* Synchronize the data together */
> +	err =3D sync_dirty_buffer(boot_bh);
> +	if (err)
> +		goto out_boot_brelse;
> +
> +out_boot_brelse:
> +	brelse(boot_bh);
> +out_vol_brelse:
> +	brelse(vol_bh);
> +
> +	inode_unlock(inode);
> +	mnt_drop_write_file(file);
> +	up_write(&sb->s_umount);
> +out:
> +	return err;
> +}
> +
>  long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned lon=
g arg)
>  {
> 	struct inode *inode =3D file_inode(filp);
> 	u32 __user *user_attr =3D (u32 __user *)arg;
> +	u8 __user *user_vol_label =3D (u8 __user *)arg;
>=20
> 	switch (cmd) {
> 	case FAT_IOCTL_GET_ATTRIBUTES:
> @@ -133,6 +274,10 @@ long fat_generic_ioctl(struct file *filp, unsigned i=
nt cmd, unsigned long arg)
> 		return fat_ioctl_set_attributes(filp, user_attr);
> 	case FAT_IOCTL_GET_VOLUME_ID:
> 		return fat_ioctl_get_volume_id(inode, user_attr);
> +	case FAT_IOCTL_GET_VOLUME_LABEL:
> +		return fat_ioctl_get_volume_label(inode, user_vol_label);
> +	case FAT_IOCTL_SET_VOLUME_LABEL:
> +		return fat_ioctl_set_volume_label(filp, user_vol_label);
> 	default:
> 		return -ENOTTY;	/* Inappropriate ioctl for device */
> 	}
> --
> 2.14.3

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--tgb4tneqgqbsncik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWns65gAKCRCL8Mk9A+RD
UubqAJwNyamidRDsTa4CgCIuZCtEElJYUgCgzPLHts4Qol59FnhJLiRCPYLmkh8=
=U9+O
-----END PGP SIGNATURE-----

--tgb4tneqgqbsncik--
