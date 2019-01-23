Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A600921872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfAWSec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:34:32 -0500
Received: from anholt.net ([50.246.234.109]:56524 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAWSeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:34:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2BEBE10A2A9B;
        Wed, 23 Jan 2019 10:34:31 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id SCLOHzzh0h_Y; Wed, 23 Jan 2019 10:34:29 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A3B0A10A1DB6;
        Wed, 23 Jan 2019 10:34:29 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 118852FE3A6E; Wed, 23 Jan 2019 10:34:29 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 1/4] drm/vc4: Wait for display list synchronization when completing commit
In-Reply-To: <20190108145056.2276-2-paul.kocialkowski@bootlin.com>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com> <20190108145056.2276-2-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 23 Jan 2019 10:34:28 -0800
Message-ID: <87d0onussr.fsf@anholt.net>
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

> During an atomic commit, the HVS is configured with a display list
> for the channel matching the associated CRTC. The Pixel Valve (CRTC)
> and encoder are also configured for the new setup at that time.
> While the Pixel Valve and encoder are reconfigured synchronously, the
> HVS is only reconfigured after the display list address (DISPLIST) has
> been updated to the current display list address (DISPLACTX), which is
> the responsibility of the hardware.
>
> The time frame during which the HVS is still running on its previous
> configuration but the CRTC and encoder have been reconfigured already
> can lead to a number of synchronization issues. They will eventually
> cause errors reported on the FIFOs, such as underruns.
>
> With underrun detection enabled (from Boris Brezillon's series), this
> leads to unreliable underrun detection with random false positives.
>
> To ensure a coherent state, wait for each enabled channel of the HVS
> to synchronize its current display list address. This fixes the issue
> of random underrun reporting on commits.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/vc4/vc4_drv.h  |  1 +
>  drivers/gpu/drm/vc4/vc4_hvs.c  | 17 +++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_kms.c  |  2 ++
>  drivers/gpu/drm/vc4/vc4_regs.h |  2 ++
>  4 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index c24b078f0593..955f157f5ad0 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -772,6 +772,7 @@ void vc4_irq_reset(struct drm_device *dev);
>  extern struct platform_driver vc4_hvs_driver;
>  void vc4_hvs_dump_state(struct drm_device *dev);
>  int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
> +void vc4_hvs_sync_dlist(struct drm_device *dev);
>=20=20
>  /* vc4_kms.c */
>  int vc4_kms_load(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 5d8c749c9749..1ba60b8e0c2d 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -166,6 +166,23 @@ static int vc4_hvs_upload_linear_kernel(struct vc4_h=
vs *hvs,
>  	return 0;
>  }
>=20=20
> +void vc4_hvs_sync_dlist(struct drm_device *dev)
> +{
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +	unsigned int i;
> +	int ret;
> +
> +	for (i =3D 0; i < SCALER_CHANNELS_COUNT; i++) {
> +		if (!(HVS_READ(SCALER_DISPCTRLX(i)) & SCALER_DISPCTRLX_ENABLE))
> +			continue;
> +
> +		ret =3D wait_for(HVS_READ(SCALER_DISPLACTX(i)) =3D=3D
> +			       HVS_READ(SCALER_DISPLISTX(i)), 1000);
> +		WARN(ret, "Timeout waiting for channel %d display list sync\n",
> +		     i);
> +	}
> +}
> +
>  static int vc4_hvs_bind(struct device *dev, struct device *master, void =
*data)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 0490edb192a1..2d66a2b57a91 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -155,6 +155,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *s=
tate)
>=20=20
>  	drm_atomic_helper_commit_hw_done(state);
>=20=20
> +	vc4_hvs_sync_dlist(dev);
> +
>  	drm_atomic_helper_wait_for_flip_done(dev, state);

wait_for_flip_done should already be waiting for DISPLACTX to match our
crtc's display list, though, right (see vc4_crtc_handle_page_flip())?
This seems like a no-op to me.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxIs7QACgkQtdYpNtH8
nuggiA//bWr2s7jgOPZ3iugGZA383KlyLd52nnKPkRBsRvY8w3UkDc8XAPsB22Yh
uvdbSmGCOKO15y/r2MFWmjpTk66wTowJeaqnPAvU2HlmI90vOCH0kv7b8gFjzL5W
l4hhj9P26HtKKGWSfzvYQhguinw3VbdFmclvfcvzg2hxAY35kz2qc5W4/edRW3KZ
fts1sNipEmcUWQI+gw530sMpo6NWqr12aRIaA6pUdoDGH/+TrzGvJiZ92FFhdxk4
ROjQk4hpcPSZTCVWx/v3igra1YyyZopg3nLECMFeEBnux1FcQsBzVZokIo//WC4L
MOPjIt1DEtWdONcAGtLU/Hxn62PrOSAd8ASaM9I5niJ/H4bfPGy5h2HdDKqYQTTC
WX7fdINp4haTtYcfL7HlIDO9zThdSqLSSEBgUCC7V1P+lesJFC7Mg9mztiIa32bg
SvYCDcgYfYLqabBN9ui/VcmfKyeFEbaaL9psdFOwnc2c+nHoLatI81uQxOJ+2PoC
fdTTKg8aOOl7iGVoVSQ9Z42zA1uLyMPXWgrtvxcIu14S72oAp2BAgZOaX48elJzs
4IaefnIPlOpKtA8d8jhGiLEiYZI8BQfzpuPAC1NrXzBzjb2visUvf8c2U2WcMhVN
V8ybytZt52fzxLWjEafdTqB3V7mSClIgNq/kRyyzDVaw05Tfkj8=
=683S
-----END PGP SIGNATURE-----
--=-=-=--
