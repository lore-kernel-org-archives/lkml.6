Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F70C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D762145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D762145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeK3VbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:31:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48810 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeK3VbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:31:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 02E6F20D29; Fri, 30 Nov 2018 11:22:10 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id B9628207B0;
        Fri, 30 Nov 2018 11:21:59 +0100 (CET)
Message-ID: <9e5295e9f1cc05685635a98ba5b23fcca854b1f4.camel@bootlin.com>
Subject: Re: [PATCH] drm/vc4: Add a debugfs entry to disable/enable the load
 tracker
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 30 Nov 2018 11:21:59 +0100
In-Reply-To: <20181130110441.6d765c3e@bbrezillon>
References: <20181130095658.31062-1-paul.kocialkowski@bootlin.com>
         <20181130110441.6d765c3e@bbrezillon>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PazxXsQDp8TlJXNjCxtL"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PazxXsQDp8TlJXNjCxtL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-11-30 at 11:04 +0100, Boris Brezillon wrote:
> Hi Paul,
>=20
> On Fri, 30 Nov 2018 10:56:58 +0100
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> wrote:
>=20
> > diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_dr=
v.c
> > index 7195a0bcceb3..0ee75c71d8d8 100644
> > --- a/drivers/gpu/drm/vc4/vc4_drv.c
> > +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> > @@ -46,6 +46,56 @@
> >  #define DRIVER_MINOR 0
> >  #define DRIVER_PATCHLEVEL 0
> > =20
> > +static int vc4_debugfs_load_tracker_get(struct seq_file *m, void *data=
)
> > +{
> > +	struct drm_device *dev =3D m->private;
> > +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> > +
> > +	if (vc4->load_tracker_enabled)
> > +		seq_printf(m, "enabled\n");
> > +	else
> > +		seq_printf(m, "disabled\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t vc4_debugfs_load_tracker_set(struct file *file,
> > +					    const char __user *ubuf,
> > +					    size_t len, loff_t *offp)
> > +{
> > +	struct seq_file *m =3D file->private_data;
> > +	struct drm_device *dev =3D m->private;
> > +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> > +	char buf[32] =3D {};
> > +
> > +	if (len >=3D sizeof(buf))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_user(buf, ubuf, len))
> > +		return -EFAULT;
> > +
> > +	if (!strncasecmp(buf, "enable", 6))
> > +		vc4->load_tracker_enabled =3D true;
> > +	else if (!strncasecmp(buf, "disable", 7))
> > +		vc4->load_tracker_enabled =3D false;
> > +	else
> > +		return -EINVAL;
> > +
> > +	return len;
> > +}
> > +
> > +static int vc4_debugfs_load_tracker_open(struct inode *inode, struct f=
ile *file)
> > +{
> > +	return single_open(file, vc4_debugfs_load_tracker_get, inode->i_priva=
te);
> > +}
> > +
> > +const struct file_operations vc4_debugfs_load_tracker_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.open =3D vc4_debugfs_load_tracker_open,
> > +	.read =3D seq_read,
> > +	.write =3D vc4_debugfs_load_tracker_set,
> > +};
> > +
>=20
> I'd put this code directly in vc4_debugfs.c so you can make
> vc4_debugfs_load_tracker_fops static and you don't need the extern ...
> definition in vc4_drv.h. But maybe you have a good reason to do that.

You're right, it would be better that way. There is indeed no particular
constraint for having this in vc4_drv.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-PazxXsQDp8TlJXNjCxtL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlwBD0cACgkQ3cLmz3+f
v9GzyAf/f2h9/EXwGUdxxH7k+UgWNUU5EAU6+rguOZ1F3a5M2YxNcWVumYz3Li3s
KXnhcr3kt80pncCTeio80GS/flM2jtYWVTpm+yDPVzR3Zrby5tKdgeR/u+X/axN/
f4H7n2Xzbmz5FP09e7osQtp93NXfQN2EqFvBw9GympRE/Ed2WWYxKd+EEmn0Iz6l
4xvRsJ1qxJMAsD7J1fARq7eNmjaycLrQZnpVJUBtvo3388dPvn/WHwfYwTBF5/vP
rmdSPckJTEZf6LlZdAD+RiTd7zN3ZV917sQE4i0i96Q5Cxq+ocABL/G3ySDi1/aL
SYtQg76JTJ2i8leCZmZCvYtzwEi3LQ==
=tIVF
-----END PGP SIGNATURE-----

--=-PazxXsQDp8TlJXNjCxtL--

