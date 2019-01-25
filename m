Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B2FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C20218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfAYRwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:52:42 -0500
Received: from anholt.net ([50.246.234.109]:42014 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbfAYRwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:52:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C187110A2AAF;
        Fri, 25 Jan 2019 09:52:39 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ie58D6iJBasz; Fri, 25 Jan 2019 09:52:38 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 65C5910A0E8E;
        Fri, 25 Jan 2019 09:52:38 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 01F232FE3A6F; Fri, 25 Jan 2019 09:52:37 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 2/4] drm/vc4: Report underrun errors
In-Reply-To: <70a1887da5ca55adeeceb0d1758ec7cfe2d747bb.camel@bootlin.com>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com> <20190108145056.2276-3-paul.kocialkowski@bootlin.com> <87a7jrus68.fsf@anholt.net> <70a1887da5ca55adeeceb0d1758ec7cfe2d747bb.camel@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 25 Jan 2019 09:52:37 -0800
Message-ID: <87munovd3u.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Hi Eric,
>
> On Wed, 2019-01-23 at 10:47 -0800, Eric Anholt wrote:
>> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
>> > +void vc4_hvs_mask_underrun(struct drm_device *dev)
>> > +{
>> > +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>> > +	u32 dispctrl =3D HVS_READ(SCALER_DISPCTRL);
>> > +
>> > +	dispctrl &=3D ~(SCALER_DISPCTRL_DSPEISLUR(0) |
>> > +		      SCALER_DISPCTRL_DSPEISLUR(1) |
>> > +		      SCALER_DISPCTRL_DSPEISLUR(2));
>> > +
>> > +	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
>> > +}
>> > +
>> > +void vc4_hvs_unmask_underrun(struct drm_device *dev)
>> > +{
>> > +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>> > +	u32 dispctrl =3D HVS_READ(SCALER_DISPCTRL);
>> > +
>> > +	dispctrl |=3D SCALER_DISPCTRL_DSPEISLUR(0) |
>> > +		    SCALER_DISPCTRL_DSPEISLUR(1) |
>> > +		    SCALER_DISPCTRL_DSPEISLUR(2);
>> > +
>> > +	HVS_WRITE(SCALER_DISPSTAT,
>> > +		  SCALER_DISPSTAT_EUFLOW(0) |
>> > +		  SCALER_DISPSTAT_EUFLOW(1) |
>> > +		  SCALER_DISPSTAT_EUFLOW(2));
>> > +	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
>> > +}
>> > +
>> > +static void vc4_hvs_report_underrun(struct drm_device *dev)
>> > +{
>> > +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>> > +
>> > +	atomic_inc(&vc4->underrun);
>> > +	DRM_DEV_ERROR(dev->dev, "HVS underrun\n");
>> > +}
>> > +
>> > +static irqreturn_t vc4_hvs_irq_handler(int irq, void *data)
>> > +{
>> > +	struct drm_device *dev =3D data;
>> > +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>> > +	u32 status;
>> > +
>> > +	status =3D HVS_READ(SCALER_DISPSTAT);
>> > +
>> > +	if (status &
>> > +	    (SCALER_DISPSTAT_EUFLOW(0) | SCALER_DISPSTAT_EUFLOW(1) |
>> > +	     SCALER_DISPSTAT_EUFLOW(2))) {
>> > +		vc4_hvs_mask_underrun(dev);
>> > +		vc4_hvs_report_underrun(dev);
>> > +	}
>> > +
>> > +	HVS_WRITE(SCALER_DISPSTAT, status);
>> > +
>> > +	return status ? IRQ_HANDLED : IRQ_NONE;
>> > +}
>>=20
>> So, if UFLOW is set then we incremented the counter and disabled the
>> interrupt, otherwise we acked this specific interrupt and return?  Given
>> that a short-line error (the other potential cause of EISLUR) would be
>> likely to persist, we should probably either vc4_hvs_mask_underrun() in
>> that case too, or only return IRQ_HANDLED for the case we actually
>> handled.
>
> I see, there is definitely an inconsistency here. I don't think we
> should be disabling the interrupt if we get a short line indication,
> just in case the interrupt gets triggered later for a legitimate
> underrun (before the next commit).
>
> So I think we should just totally ignore the short line status bit for
> the IRQ return (although it certainly doesn't hurt to clear it as
> well). What do you think?

You just have to make sure that you return UNHANDLED for short line, so
an IRQ storm doesn't take down the machine.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxLTOUACgkQtdYpNtH8
nuitZw/9F2VpeN7k2GBZI/uv73mvAPvmoVipB8ygbeZT0PsVt/ykTLlbmfc/rQNO
WucUauFgAXboeEryl+WzNYw69vOdCOBoKOeOT0Urn/gfJwtKDHyseVoE9Sxt41OE
MHo+/iRn0avKbzgLWxJPcbO67CH5ZPKLfelhDD/fPFYd5OMM5JxJeGlSPX1eGbaS
NPlVaPI6Wz227HaQzBuaKxMpk5wAcdCju9u9kPdPT+yYbyLvYYGReouio+zlvbsg
lcqdDlVycRHB7pHqNAQqB704z0lCKadOoX/NsOWA59YVvIh/MjZWSa543xLJo1mb
ucbVOuKJ/hW3CFvBnDQprcCjFTXRVDo9h2NKbr9NpKaNLzantlqmOp1DR4Txyvan
+5CEM7Gdf4S4CulXaSeadtvWPlBI7pD48O/Hye9r5htMzDJ8x7OfS4Ump1UbCmgs
KfrHQCBdFuqnPwzkc9Dg9M/1qkBMUeMR6m+9iGm9EdpyHsugNBPjA1Vr2GOg0UNQ
paeyYz41K5bSwA9f9HvYQHLBIynLscmXj+Mqd0IrAqwta29s4v17PXRo8gcwtYBs
wurDSqvvHsbw07dz8CW1Mxr2NFaRVj5TECxILKVYPwtc2x0WmyBABKVqN+aZw6pU
J4MwmCHxFVmENAlGw7W+8JlftmD5GY+YVnmhpQD5rTMX+UANqK4=
=vRly
-----END PGP SIGNATURE-----
--=-=-=--
