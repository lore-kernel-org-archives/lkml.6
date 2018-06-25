Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7303C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA1F25B4A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA1F25B4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934377AbeFYOTF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:19:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52284 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934294AbeFYOTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:19:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9E1D020DC1; Mon, 25 Jun 2018 16:19:01 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 409E420719;
        Mon, 25 Jun 2018 16:18:51 +0200 (CEST)
Message-ID: <b222fae80b1b212fdc5171a39b9a761527931eb0.camel@bootlin.com>
Subject: Re: [PATCH 7/9] media: cedrus: Move IRQ maintainance to
 cedrus_dec_ops
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>, hans.verkuil@cisco.com,
        acourbot@chromium.org, sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     tfiga@chromium.org, posciak@chromium.org,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Mon, 25 Jun 2018 16:18:51 +0200
In-Reply-To: <a2e1e0a85e0cd650d27eb02dc58d438d6a750929.camel@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
         <20180613140714.1686-8-maxime.ripard@bootlin.com>
         <a2e1e0a85e0cd650d27eb02dc58d438d6a750929.camel@bootlin.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4BdntKClLHQdbv06E5wp"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4BdntKClLHQdbv06E5wp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2018-06-21 at 17:35 +0200, Paul Kocialkowski wrote:
> Hi,
>=20
> On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > The IRQ handler up until now was hardcoding the use of the MPEG engine =
to
> > read the interrupt status, clear it and disable the interrupts.
> >=20
> > Obviously, that won't work really well with the introduction of new cod=
ecs
> > that use a separate engine with a separate register set.
> >=20
> > In order to make this more future proof, introduce new decodec operatio=
ns
> > to deal with the interrupt management. The only one missing is the one =
to
> > enable the interrupts in the first place, but that's taken care of by t=
he
> > trigger hook for now.
>=20
> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Scratch that for now, I just thought of something here (see below).

> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  .../sunxi/cedrus/sunxi_cedrus_common.h        |  9 +++++
> >  .../platform/sunxi/cedrus/sunxi_cedrus_hw.c   | 21 ++++++------
> >  .../sunxi/cedrus/sunxi_cedrus_mpeg2.c         | 33 +++++++++++++++++++
> >  3 files changed, 53 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h =
b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> > index c2e2c92d103b..a2a507eb9fc9 100644
> > --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> > +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> > @@ -108,7 +108,16 @@ struct sunxi_cedrus_buffer *vb2_to_cedrus_buffer(c=
onst struct vb2_buffer *p)
> >  	return vb2_v4l2_to_cedrus_buffer(to_vb2_v4l2_buffer(p));
> >  }
> > =20
> > +enum sunxi_cedrus_irq_status {
> > +	SUNXI_CEDRUS_IRQ_NONE,
> > +	SUNXI_CEDRUS_IRQ_ERROR,
> > +	SUNXI_CEDRUS_IRQ_OK,
> > +};
> > +
> >  struct sunxi_cedrus_dec_ops {
> > +	void (*irq_clear)(struct sunxi_cedrus_ctx *ctx);
> > +	void (*irq_disable)(struct sunxi_cedrus_ctx *ctx);
> > +	enum sunxi_cedrus_irq_status (*irq_status)(struct sunxi_cedrus_ctx *c=
tx);
> >  	void (*setup)(struct sunxi_cedrus_ctx *ctx,
> >  		      struct sunxi_cedrus_run *run);
> >  	void (*trigger)(struct sunxi_cedrus_ctx *ctx);
> > diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c b/dr=
ivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
> > index bb46a01214e0..6b97cbd2834e 100644
> > --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
> > +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
> > @@ -77,27 +77,28 @@ static irqreturn_t sunxi_cedrus_ve_irq(int irq, voi=
d *dev_id)
> >  	struct sunxi_cedrus_ctx *ctx;
> >  	struct sunxi_cedrus_buffer *src_buffer, *dst_buffer;
> >  	struct vb2_v4l2_buffer *src_vb, *dst_vb;
> > +	enum sunxi_cedrus_irq_status status;
> >  	unsigned long flags;
> > -	unsigned int value, status;
> > =20
> >  	spin_lock_irqsave(&dev->irq_lock, flags);
> > =20
> > -	/* Disable MPEG interrupts and stop the MPEG engine */
> > -	value =3D sunxi_cedrus_read(dev, VE_MPEG_CTRL);
> > -	sunxi_cedrus_write(dev, value & (~0xf), VE_MPEG_CTRL);
> > -
> > -	status =3D sunxi_cedrus_read(dev, VE_MPEG_STATUS);
> > -	sunxi_cedrus_write(dev, 0x0000c00f, VE_MPEG_STATUS);
> > -	sunxi_cedrus_engine_disable(dev);
> > -
> >  	ctx =3D v4l2_m2m_get_curr_priv(dev->m2m_dev);
> >  	if (!ctx) {
> >  		pr_err("Instance released before the end of transaction\n");
> >  		spin_unlock_irqrestore(&dev->irq_lock, flags);
> > =20
> > -		return IRQ_HANDLED;
> > +		return IRQ_NONE;
> >  	}
> > =20
> > +	status =3D dev->dec_ops[ctx->current_codec]->irq_status(ctx);
> > +	if (status =3D=3D SUNXI_CEDRUS_IRQ_NONE) {
> > +		spin_unlock_irqrestore(&dev->irq_lock, flags);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	dev->dec_ops[ctx->current_codec]->irq_disable(ctx);
> > +	dev->dec_ops[ctx->current_codec]->irq_clear(ctx);
> > +
> >  	src_vb =3D v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> >  	dst_vb =3D v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);

Later in that file, there is still some checking that the first bit of
status is set:

	/* First bit of MPEG_STATUS indicates success. */
	if (ctx->job_abort || !(status & 0x01))

So !(status & 0x01) must be replaced with status !=3D CEDRUS_IRQ_OK.

It seems that was working "by accident", with CEDRUS_IRQ_OK probably
being set by the compiler to 0x03.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-4BdntKClLHQdbv06E5wp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlsw+csACgkQ3cLmz3+f
v9FPSAf9FIF1U8jNWvvuo6G87x/S9UU6zGXpyLPZDTAlFzOBvHCCEHnpUe8uuCSr
gsTixqiB5M1YRhkIXOML8AK7v2pUMLZ6kRPN2YT9RK1f0tem4jzrRtgdagpVe7dd
DLAd65qtHYwpRuvXl4q2TU1GEewgipMCOgLFZh+ZNZKOyxIiLTuefP1JzZw5Sh2K
WJF/JH2EHhxc4QgvvKKPnP8PROppkQb78kWYgbPVaVzQHjvcLg+mIKAWu7q3RGtg
wz37lc251ekCgX+hobFXF+af7GmhZMQaNHo9NtVRWYay1V7GeB2VPGFRi+Ho6CRd
3ogGJ5StuKSVpT4Y3tKmSLMA86J13A==
=3BLb
-----END PGP SIGNATURE-----

--=-4BdntKClLHQdbv06E5wp--

