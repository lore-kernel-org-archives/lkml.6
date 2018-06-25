Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9080C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D21B25AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D21B25AB3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934268AbeFYNnH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:43:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50280 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934034AbeFYNnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:43:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1FFFC206A0; Mon, 25 Jun 2018 15:43:02 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id BB90820703;
        Mon, 25 Jun 2018 15:42:51 +0200 (CEST)
Message-ID: <bb4dea42891f1857a994b3b7f7c4f34f52acc41c.camel@bootlin.com>
Subject: Re: [PATCH 8/9] media: cedrus: Add start and stop decoder operations
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@chromium.org, posciak@chromium.org,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Mon, 25 Jun 2018 15:42:52 +0200
In-Reply-To: <20180625133233.3b7qup3tcgydfo5t@flea>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
         <20180613140714.1686-9-maxime.ripard@bootlin.com>
         <f37f23580c92728bbcd5bfe3fff506b5bb2bdfd0.camel@bootlin.com>
         <20180625133233.3b7qup3tcgydfo5t@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-f791yFd3OE0dTHcCvKWJ"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f791yFd3OE0dTHcCvKWJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2018-06-25 at 15:32 +0200, Maxime Ripard wrote:
> On Thu, Jun 21, 2018 at 05:38:23PM +0200, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > > Some codec needs to perform some additional task when a decoding is s=
tarted
> > > and stopped, and not only at every frame.
> > >=20
> > > For example, the H264 decoding support needs to allocate buffers that=
 will
> > > be used in the decoding process, but do not need to change over time,=
 or at
> > > each frame.
> > >=20
> > > In order to allow that for codecs, introduce a start and stop hook th=
at
> > > will be called if present at start_streaming and stop_streaming time.
> > >=20
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > ---
> > >  .../platform/sunxi/cedrus/sunxi_cedrus_common.h    |  2 ++
> > >  .../platform/sunxi/cedrus/sunxi_cedrus_video.c     | 14 ++++++++++++=
+-
> > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.=
h b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> > > index a2a507eb9fc9..20c78ec1f037 100644
> > > --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> > > +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> > > @@ -120,6 +120,8 @@ struct sunxi_cedrus_dec_ops {
> > >  	enum sunxi_cedrus_irq_status (*irq_status)(struct sunxi_cedrus_ctx =
*ctx);
> > >  	void (*setup)(struct sunxi_cedrus_ctx *ctx,
> > >  		      struct sunxi_cedrus_run *run);
> > > +	int (*start)(struct sunxi_cedrus_ctx *ctx);
> > > +	void (*stop)(struct sunxi_cedrus_ctx *ctx);
> > >  	void (*trigger)(struct sunxi_cedrus_ctx *ctx);
> > >  };
> > > =20
> > > diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_video.c=
 b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_video.c
> > > index fb7b081a5bb7..d93461178857 100644
> > > --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_video.c
> > > +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_video.c
> > > @@ -416,6 +416,8 @@ static int sunxi_cedrus_buf_prepare(struct vb2_bu=
ffer *vb)
> > >  static int sunxi_cedrus_start_streaming(struct vb2_queue *q, unsigne=
d int count)
> > >  {
> > >  	struct sunxi_cedrus_ctx *ctx =3D vb2_get_drv_priv(q);
> > > +	struct sunxi_cedrus_dev *dev =3D ctx->dev;
> > > +	int ret =3D 0;
> > > =20
> > >  	switch (ctx->vpu_src_fmt->fourcc) {
> > >  	case V4L2_PIX_FMT_MPEG2_FRAME:
> > > @@ -425,16 +427,26 @@ static int sunxi_cedrus_start_streaming(struct =
vb2_queue *q, unsigned int count)
> > >  		return -EINVAL;
> > >  	}
> > > =20
> > > -	return 0;
> > > +	if (V4L2_TYPE_IS_OUTPUT(q->type) &&
> >=20
> > I suppose this check was put in place to ensure that ->start is only
> > called once, but what if start_streaming is called multiple times on
> > output? Am I totally unsure about whether the API guarantees that we
> > only get one start_streaming call per buffer queue, regardless of how
> > many userspace issues.
> >=20
> > If we don't have such a guarantee, we probably need an internal
> > mechanism to avoid having ->start called more than once.
>=20
> As far as I understand it, start_streaming can only be called once:
> https://elixir.bootlin.com/linux/latest/source/include/media/videobuf2-co=
re.h#L357

And there's definitely a check in vb2_core_streamon:

	if (q->streaming) {
		dprintk(3, "already streaming\n");
		return 0;
	}

so it looks like we're safe :)

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-f791yFd3OE0dTHcCvKWJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlsw8VwACgkQ3cLmz3+f
v9HytAf/R8CAkDcS7YLu4K+EZ/FfEjTiCiZDaDRAT2Enn2FvuxCELOgAvCdhh+E6
PAbLTkAnEvPJVUd6YM1s+sUB/eVIcR5ye8dfEeAwgH4kYNPUcrP0Ni51iD4xl4bP
CguBcUWMsKlDkxy+aI/TXR+gHetQTJ3eP8ejov8P9Km+vrOvhh9lYwA4jJ4Ua4Jx
IwhAVNm6hfm3w6re1KhyJFzwHNMe5PEkq111ZKO6Ng4xrvk347nWdYkG12Jl7Zsf
+h/ZT1IkfwjR7xhDYC4exUXnQmxwm5QxMGif2OSlLFLz0WkT968Io2N+eYFbgLVr
tEJZ8bhh4LyZaFcNNgsl9rvZlmLqHA==
=FoKz
-----END PGP SIGNATURE-----

--=-f791yFd3OE0dTHcCvKWJ--

