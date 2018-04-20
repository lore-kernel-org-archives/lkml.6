Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754528AbeDTJuk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:50:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33914 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbeDTJui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:50:38 -0400
Date: Fri, 20 Apr 2018 11:50:36 +0200
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: dedekind1@gmail.com, dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] ubi: introduce ubi.nocheck parameter to skip CRC
 check when attaching ubi vol
Message-ID: <20180420095035.i6euhg66kmmvqx4w@qschulz>
References: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
 <6551534f88b3aa77cc377c4270c4ddf7fe92cdf4.1524214122.git-series.quentin.schulz@bootlin.com>
 <2085970.qGmQXvoWho@blindfold>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zkmuvlktsng3kjuk"
Content-Disposition: inline
In-Reply-To: <2085970.qGmQXvoWho@blindfold>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zkmuvlktsng3kjuk
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

Turns out I forgot some important information and poorly worded my
commit log :)

Yes sorry, I have a squashfs (read-only by design) as the image of one
static UBI volume.

And yes, I meant when opening a static UBI volume.

Quentin

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
> But again, I don't think we need it per volume.
>=20
> Also don't forget to add the nocheck parameter to the ioctl() interface, =
such that
> you can specify it also with ubiattach...
>=20
> Thanks,
> //richard

--zkmuvlktsng3kjuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJa2bfnAAoJEIS4mnU+4PGjpGcQAKcCo9f56QeLsBGWNVbQ4H/J
85c0CF2qAvsUzDHpEunevNlECTPZesJKtn5tMtkVSvmP40rSD0JRNodBjmZd1Q74
LVQeG/iBqpOiNCB6RPmVIUVO+QhuJDwGvEkc/nLpptaFTECTuD9pCXyF6TffAD9H
p6IEik6XyZGasvzAaJzgKX6cWGlaM9GqVA6suK2uhh8a7brTTt7aZhf2ARoX7OaG
o48Geq2xhzpUnGm45IxhYW7o6rMPEm4pt4azm3Ge3V4DKUnKOtZNGfTnND9Mhh7w
ibrtJjej8Qj9za7ZzREgGNQ6Oemw/FWO2HQC8HpgDzNsXDX7yjUoVYWpQLlTJ7NR
4P40YojiuIoIfhy4a3VV5z2okY3Ja4pVchVOs605byl+48x6zS4QIeIsZBs0+iGZ
Twfr/8T9MW0WChTtZTJ92/QgWl0h6xOiLm3KAQ3da4wx3388w3ylevcn/tjA+AH5
1ed0iiSY6/yuhLlIodLpckjW5vJL8+lNQyhk+tLHpt8Tw1Q5Q4PJvlJfY/hK/V3/
WO1hcEzhhJGjg/BV0nb+a3Hr9MkpN0QUQoSMi0BwL5mwJsRDbooumPaQxFdIe4WW
wR1sIrzIX6YbXFKPO1e7okR4BvmcsThmCNPqNLwhiuk92x7+oeBuBJVySXju8aK8
LsjYI5GDsit78Jbfos/T
=VXPb
-----END PGP SIGNATURE-----

--zkmuvlktsng3kjuk--
