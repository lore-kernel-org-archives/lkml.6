Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA153C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA6120817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X0bR59k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA6120817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeKSREV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:04:21 -0500
Received: from ozlabs.org ([203.11.71.1]:48309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeKSREV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:04:21 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 42yzl56fytz9sBQ; Mon, 19 Nov 2018 17:41:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1542609697;
        bh=HtMtsGYqlqi6aIXFoBgtOpeGfTbmd65176UllwGh7f0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0bR59k494bcKnlmInsDvHWVwUNRIOqlDoMWyNm4M827sPQMJUhpeBxwo7Fs8CWd4
         GDUiUVGIRbeoDMR4GPbked1K6SQBwlkEnhHeeXu2qX8nyTuWpqeVj4v568QdvAgekv
         Z3ONU9bVno5dXe6H2Msyllu7s2w8up/G86ynmeK4=
Date:   Mon, 19 Nov 2018 17:41:31 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Wenwen Wang <wang6495@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        kvm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        aik@ozlabs.ru
Subject: Re: [PATCH v4] drivers/vfio: Fix a redundant copy bug
Message-ID: <20181119064131.GK23503@umbus>
References: <1539803924-3190-1-git-send-email-wang6495@umn.edu>
 <CAAa=b7dE=6obq4nABsyo84iA1CTOcLVCAuUxHDYfSCimzc12eA@mail.gmail.com>
 <20181029153234.36e67a6f@t450s.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rnP2AJ7yb1j09OW/"
Content-Disposition: inline
In-Reply-To: <20181029153234.36e67a6f@t450s.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rnP2AJ7yb1j09OW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 03:32:34PM -0600, Alex Williamson wrote:
> On Mon, 29 Oct 2018 13:56:54 -0500
> Wenwen Wang <wang6495@umn.edu> wrote:
>=20
> > Hello,
> >=20
> > Could you please apply this patch? Thanks!
>=20
> I'd like to see testing and/or review from David or Alexey since I also
> don't have an environment for spapr/eeh.  We're already late into the
> v4.20 merge window so this is probably v4.21 material.  Thanks,

I didn't spot this for ages, since I wasn't CCed, I'm guessing the
same is true for Alexey.

TBH, I don't think it's worth bothering with this.  It's a tiny amount
of extra work on a rare debug path.  A couple of code lines simplicity
is worth more than a few bytes worth of redundant copy here.

Testing is.. difficult, since the EEH is already so broken it's hard
to know what to compare against.  Sam Bobroff is already looking
medium-long term at a bunch of EEH rework, so it's quite possible this
will be rewritten then anyway.

>=20
> Alex
>=20
> > On Wed, Oct 17, 2018 at 2:18 PM Wenwen Wang <wang6495@umn.edu> wrote:
> > >
> > > In vfio_spapr_iommu_eeh_ioctl(), if the ioctl command is VFIO_EEH_PE_=
OP,
> > > the user-space buffer 'arg' is copied to the kernel object 'op' and t=
he
> > > 'argsz' and 'flags' fields of 'op' are checked. If the check fails, an
> > > error code EINVAL is returned. Otherwise, 'op.op' is further checked
> > > through a switch statement to invoke related handlers. If 'op.op' is
> > > VFIO_EEH_PE_INJECT_ERR, the whole user-space buffer 'arg' is copied a=
gain
> > > to 'op' to obtain the err information. However, in the following exec=
ution
> > > of this case, the fields of 'op', except the field 'err', are actuall=
y not
> > > used. That is, the second copy has a redundant part. Therefore, for
> > > performance consideration, the redundant part of the second copy shou=
ld be
> > > removed.
> > >
> > > This patch removes such a part in the second copy. It only copies from
> > > 'err.type' to 'err.mask', which is exactly required by the
> > > VFIO_EEH_PE_INJECT_ERR op.
> > >
> > > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > > ---
> > >  drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_=
eeh.c
> > > index 38edeb4..66634c6 100644
> > > --- a/drivers/vfio/vfio_spapr_eeh.c
> > > +++ b/drivers/vfio/vfio_spapr_eeh.c
> > > @@ -37,6 +37,7 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group =
*group,
> > >         struct eeh_pe *pe;
> > >         struct vfio_eeh_pe_op op;
> > >         unsigned long minsz;
> > > +       unsigned long start, end;
> > >         long ret =3D -EINVAL;
> > >
> > >         switch (cmd) {
> > > @@ -86,10 +87,12 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_grou=
p *group,
> > >                         ret =3D eeh_pe_configure(pe);
> > >                         break;
> > >                 case VFIO_EEH_PE_INJECT_ERR:
> > > -                       minsz =3D offsetofend(struct vfio_eeh_pe_op, =
err.mask);
> > > -                       if (op.argsz < minsz)
> > > +                       start =3D offsetof(struct vfio_eeh_pe_op, err=
=2Etype);
> > > +                       end =3D offsetofend(struct vfio_eeh_pe_op, er=
r.mask);
> > > +                       if (op.argsz < end)
> > >                                 return -EINVAL;
> > > -                       if (copy_from_user(&op, (void __user *)arg, m=
insz))
> > > +                       if (copy_from_user(&op.err, (char __user *)ar=
g +
> > > +                                               start, end - start))
> > >                                 return -EFAULT;
> > >
> > >                         ret =3D eeh_pe_inject_err(pe, op.err.type, op=
=2Eerr.func,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rnP2AJ7yb1j09OW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyWxkACgkQbDjKyiDZ
s5JWxQ//SVEE+8+PaxFpc/YZcNHDN6i7I+IZlc9pWPWXB/7OH+Jg6UP+xDxXKtdC
t4ktsuom46ek0UP1eR7Kt5fbGIyG38sGu+X4b5fefgBMA8NrepULft6A/e8jWaov
EBCuutpReATymzBSA2RjOalbGW102GbOpUXM8LnnWVLwQHhv2Asb8xDtCBeCwow0
xRETRRGNiKfEfnTjCoY+1zGRLRNg2KtmJrJS/6Kp8dnMQpCR50kHuBMc8fyfZfKF
x1Gvsv/yMihnThdfGHPduU39MKuBwGJC+04jL3DXD/koxbmk5omix3jqFOylThYT
oonvEpfI+boRjwBrgtSiyJyUppCw25Do/4WmWUNentYfYbiHlAn6ouLzmNkM85X3
Acnt8YNLD9HmCuu32XnArpQCG2KPNQ3Rdc2HwPCDmD3TP7T7s5Q9pkChBrKydzRc
LKGEeiiT8fRpVFWPqcreG6cmreDeLG5QHNiBE3G/QKWm2s+pufbJUoGKv3dSRYBZ
SKYfTa3c8Fn5PWNBfwG4dLmB5mxHBLoDYQ371mW+vMaVdTxs8o2lJ/YCXiUpDfdS
3X+HDV+2YC98rqEjQGg7+lk/jPJtA4eKCkXQj92z8VmbG2JO5NXakawlHpDGJwjF
p9LPUqQFgIfI+579l3k8Dzpppd7DnhmCBP4HhI9pZVWrHyZRYdI=
=TFwv
-----END PGP SIGNATURE-----

--rnP2AJ7yb1j09OW/--
