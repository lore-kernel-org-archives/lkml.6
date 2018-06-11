Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ulM6FPxMHlueLAAAmS7hNA
	; Mon, 11 Jun 2018 10:20:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3D220607A4; Mon, 11 Jun 2018 10:20:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7146D60541;
	Mon, 11 Jun 2018 10:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7146D60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbeFKKUl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:20:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48280 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932517AbeFKKUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:20:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1999F207A5; Mon, 11 Jun 2018 12:20:38 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id C92432069C;
        Mon, 11 Jun 2018 12:20:37 +0200 (CEST)
Date: Mon, 11 Jun 2018 12:20:37 +0200
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: dedekind1@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] ubi: introduce ubi.nocheck parameter to skip CRC
 check when attaching ubi vol
Message-ID: <20180611102037.n5kkdq4mcoixmvti@qschulz>
References: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
 <6551534f88b3aa77cc377c4270c4ddf7fe92cdf4.1524214122.git-series.quentin.schulz@bootlin.com>
 <2085970.qGmQXvoWho@blindfold>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3iaoyoq2ztw7sqea"
Content-Disposition: inline
In-Reply-To: <2085970.qGmQXvoWho@blindfold>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3iaoyoq2ztw7sqea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Fri, Apr 20, 2018 at 11:37:07AM +0200, Richard Weinberger wrote:
> Quentin,
>=20
> Am Freitag, 20. April 2018, 10:52:41 CEST schrieb Quentin Schulz:
> > There's already ECC on NAND pages so there may be no need for one to
> > check the CRC of a UBI volume.
> >=20
> > Let's introduce a ubi.nocheck parameter that let one skip the CRC check
> > when attaching a UBI volume.
> >=20
> > This also drastically speeds kernel boot by removing a potentially
> > useless check, e.g. I gained 3.2s on boot time of a SPEAr600-based board
> > for a ~20MB UBI volume used as rootfs.
>=20
> You mean at *open* time of a *static* UBI volume?
> So I guess the use case is having a read-only filesystem on top of ubiblo=
ck?
>=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
> >  drivers/mtd/ubi/kapi.c | 70 ++++++++++++++++++++++++++++++++++++++++++=
+-
> >  drivers/mtd/ubi/ubi.h  |  6 ++++-
> >  drivers/mtd/ubi/vtbl.c | 24 ++++++++++++++-
> >  3 files changed, 99 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
> > index d4b2e87..d604cd5 100644
> > --- a/drivers/mtd/ubi/kapi.c
> > +++ b/drivers/mtd/ubi/kapi.c
> > @@ -28,6 +28,9 @@
> >  #include <asm/div64.h>
> >  #include "ubi.h"
> > =20
> > +struct ubivol_param ubinocheck_param[UBIVOL_MAX_DEVICES];
> > +int ubinocheck_devs;
> > +
> >  /**
> >   * ubi_do_get_device_info - get information about UBI device.
> >   * @ubi: UBI device description object
> > @@ -865,3 +868,70 @@ int ubi_unregister_volume_notifier(struct notifier=
_block *nb)
> >  	return blocking_notifier_chain_unregister(&ubi_notifiers, nb);
> >  }
> >  EXPORT_SYMBOL_GPL(ubi_unregister_volume_notifier);
> > +
> > +static int __init ubinocheckvol_set_param(const char *val,
> > +					  const struct kernel_param *kp)
> > +{
> > +	int i, ret;
> > +	size_t len;
> > +	struct ubivol_param *param;
> > +	char buf[UBIVOL_PARAM_LEN];
> > +	char *pbuf =3D &buf[0];
> > +	char *tokens[UBIVOL_PARAM_COUNT];
> > +
> > +	if (!val)
> > +		return -EINVAL;
> > +
> > +	len =3D strnlen(val, UBIVOL_PARAM_LEN);
> > +	if (len =3D=3D 0) {
> > +		pr_warn("UBI: nocheck: empty 'nocheck=3D' parameter - ignored\n");
> > +		return 0;
> > +	}
> > +
> > +	if (len =3D=3D UBIVOL_PARAM_LEN) {
> > +		pr_err("UBI: nocheck: parameter \"%s\" is too long, max. is %d\n",
> > +		       val, UBIVOL_PARAM_LEN);
> > +		return -EINVAL;
> > +	}
> > +
> > +	strcpy(buf, val);
> > +
> > +	/* Get rid of the final newline */
> > +	if (buf[len - 1] =3D=3D '\n')
> > +		buf[len - 1] =3D '\0';
> > +
> > +	for (i =3D 0; i < UBIVOL_PARAM_COUNT; i++)
> > +		tokens[i] =3D strsep(&pbuf, ",");
> > +
> > +	param =3D &ubinocheck_param[ubinocheck_devs];
> > +	if (tokens[1]) {
> > +		/* Two parameters: can be 'ubi, vol_id' or 'ubi, vol_name' */
> > +		ret =3D kstrtoint(tokens[0], 10, &param->ubi_num);
> > +		if (ret < 0)
> > +			return -EINVAL;
> > +
> > +		/* Second param can be a number or a name */
> > +		ret =3D kstrtoint(tokens[1], 10, &param->vol_id);
> > +		if (ret < 0) {
> > +			param->vol_id =3D -1;
> > +			strcpy(param->name, tokens[1]);
> > +		}
> > +	}
> >
>=20
> Do we really need this per volume? If your flash is trustworthy, it shoul=
d not matter.
> Having it per UBI instance instead of volume would make the code less com=
plicated.
>=20

In my opinion, yes.

Here is my use case: I have one "big" UBI image with different
volumes and filesystems. One of those is a squashfs that is
mounted/checked by dm-verity. The hash check done by dm-verity is heavy
and makes the CRC check done by UBI useless.

I would like to still be able to check the CRC of the other UBI volumes
but also have one or more volumes for which I bypass the CRC check done
by UBI since it's useless and time consuming. By putting a flag per UBI
image would require me to complexify the layout of my storage medium to
have one UBI image for the volumes that don't need CRC check and one for
the volumes that do. It's cumbersome and can be avoided IMHO.

> > +	ubinocheck_devs++;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct kernel_param_ops ubinocheckvol_param_ops =3D {
> > +	.set	=3D ubinocheckvol_set_param,
> > +};
> > +module_param_cb(nocheck, &ubinocheckvol_param_ops, NULL, 0);
> > +MODULE_PARM_DESC(nocheck,
> > +		 "Disable CRC check for UBI volumes. Parameter format: nocheck=3Ddev=
,[num|name]>.\n"
> > +		 "Multiple \"nocheck\" parameters may be specified.\n"
> > +		 "Examples\n"
> > +		 "Using the UBI device, and the volume name:\n"
> > +		 "ubi.nocheck=3D0,rootfs\n"
> > +		 "Using both UBI device number and UBI volume number:\n"
> > +		 "ubi.nocheck=3D0,0\n");
> > diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> > index 4cc6ec9..2bd89b4 100644
> > --- a/drivers/mtd/ubi/ubi.h
> > +++ b/drivers/mtd/ubi/ubi.h
> > @@ -825,6 +825,12 @@ struct ubivol_param {
> >  	char name[UBIVOL_PARAM_LEN + 1];
> >  };
> > =20
> > +/* Numbers of elements set in the @ubinocheck_param array */
> > +extern int ubinocheck_devs;
> > +
> > +/* MTD devices specification parameters */
> > +extern struct ubivol_param ubinocheck_param[UBIVOL_MAX_DEVICES];
> > +
> >  #include "debug.h"
> > =20
> >  extern struct kmem_cache *ubi_wl_entry_slab;
> > diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
> > index 263743e..06b6cfd 100644
> > --- a/drivers/mtd/ubi/vtbl.c
> > +++ b/drivers/mtd/ubi/vtbl.c
> > @@ -534,9 +534,10 @@ static int init_volumes(struct ubi_device *ubi,
> >  			const struct ubi_attach_info *ai,
> >  			const struct ubi_vtbl_record *vtbl)
> >  {
> > -	int i, reserved_pebs =3D 0;
> > +	int i, j, reserved_pebs =3D 0;
> >  	struct ubi_ainf_volume *av;
> >  	struct ubi_volume *vol;
> > +	struct ubivol_param *param;
> > =20
> >  	for (i =3D 0; i < ubi->vtbl_slots; i++) {
> >  		cond_resched();
> > @@ -620,6 +621,27 @@ static int init_volumes(struct ubi_device *ubi,
> >  			(long long)(vol->used_ebs - 1) * vol->usable_leb_size;
> >  		vol->used_bytes +=3D av->last_data_size;
> >  		vol->last_eb_bytes =3D av->last_data_size;
> > +
> > +		for (j =3D 0; j < ubinocheck_devs; j++) {
> > +			param =3D &ubinocheck_param[j];
> > +
> > +			if (vol->ubi->ubi_num !=3D param->ubi_num)
> > +				continue;
> > +			if (vol->vol_id =3D=3D param->vol_id) {
> > +				ubi_msg(vol->ubi,
> > +					"skipping CRC check for volume %d",
> > +					vol->vol_id);
> > +				vol->checked =3D true;
>=20
> Please don't abuse the checked flag.
> A new one a la "skip_check" does not hurt.

I'll do that.

> But again, I don't think we need it per volume.
>=20
> Also don't forget to add the nocheck parameter to the ioctl() interface, =
such that
> you can specify it also with ubiattach...
>=20

If we go for a per-image flag, adding nocheck to the ioctl makes sense,
otherwise we have to find a way to select only one or more volumes for
which the nocheck flag should be set. That being said, I'm not sure a
per-image flag is the way we want to go.

What are your thoughts on this?

Thanks,
Quentin

--3iaoyoq2ztw7sqea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJbHkzyAAoJEIS4mnU+4PGjqQ0P/iWOwoyJfUEdYvMqe0Lh39Gc
d0YmZV7bK/DSGreu6eJV8iSBg+23dcO9UopvuGOb9rmMgKMmUKuMlHLDvEZ7CUKJ
Mtr/+RHgAoE08iV63WgzOOvp1ppTaudOMzDRmMBKHEt+KLnmsl83WxKzcUO2/BfE
5jC/FdpCtFdZyC7dKtD2Bhhx3zZ5RER5EwxIQwqKTuAVCd55m8Z/cwBucezLvXlh
NaD7z3sztxuEoAOrkw8doO/CVlb2txTmWn1J6cFuwKiXPJdSHXtfZTHa/WDUnkKm
mcSPQXlAMHO9zyosEDIFXKW2D4fv8OYoMaMTujee1+7mrQUwQFH6fylr9ZY7EUQN
AtGLKBSMaPm3FtihPPjCVgrE0aYkqQ28D7eYyhG5/1PuIpuXJJcdN169jvSqZAD4
PJricKmWwtTH/ZYIY5IhIpCh8JPRegI02+RCSXaBGH3xbpeXzbqWh5RERAVhagGZ
jLBcMOuvyVnNRKvskEKa3+mEf+obvNSdzK9zJX2x4VxjKMUUAAccOuTiWClNNfeO
rdHA8KP1AUjRZZT5IZDQkZKAtS3PXlmwH+m/0YBB2y7QCk5e5eZw+/im97GDJwS2
HAGyWQJOfcper39pDqUX/dSGLcMCmonAHtmfSCRDwWo8o9vlFHv7En8NNSKgVlfb
GRNzsJyp3yWblxFH+6iR
=xq7C
-----END PGP SIGNATURE-----

--3iaoyoq2ztw7sqea--
