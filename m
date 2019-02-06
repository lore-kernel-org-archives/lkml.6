Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D79218AF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfBFXvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:51:38 -0500
Received: from anholt.net ([50.246.234.109]:52442 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfBFXvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:51:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 421A610A2BF3;
        Wed,  6 Feb 2019 15:51:37 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id F9HxO1BTfgSK; Wed,  6 Feb 2019 15:51:35 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 34ADE10A282F;
        Wed,  6 Feb 2019 15:51:35 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CFC5C2FE464C; Wed,  6 Feb 2019 15:51:34 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v4 1/4] drm/vc4: Report HVS underrun errors
In-Reply-To: <20190206144906.24304-2-paul.kocialkowski@bootlin.com>
References: <20190206144906.24304-1-paul.kocialkowski@bootlin.com> <20190206144906.24304-2-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 06 Feb 2019 15:51:34 -0800
Message-ID: <874l9glbll.fsf@anholt.net>
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

> From: Boris Brezillon <boris.brezillon@bootlin.com>
>
> Add a debugfs entry and helper for reporting HVS underrun errors as
> well as helpers for masking and unmasking the underrun interrupts.
> Add an IRQ handler and initial IRQ configuration.
> Rework related register definitions to take the channel number.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/vc4/vc4_debugfs.c |  1 +
>  drivers/gpu/drm/vc4/vc4_drv.h     | 10 ++++
>  drivers/gpu/drm/vc4/vc4_hvs.c     | 92 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_kms.c     |  4 ++
>  drivers/gpu/drm/vc4/vc4_regs.h    | 49 +++++-----------
>  5 files changed, 121 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_=
debugfs.c
> index 7a0003de71ab..64021bcba041 100644
> --- a/drivers/gpu/drm/vc4/vc4_debugfs.c
> +++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
> @@ -23,6 +23,7 @@ static const struct drm_info_list vc4_debugfs_list[] =
=3D {
>  	{"vec_regs", vc4_vec_debugfs_regs, 0},
>  	{"txp_regs", vc4_txp_debugfs_regs, 0},
>  	{"hvs_regs", vc4_hvs_debugfs_regs, 0},
> +	{"hvs_underrun",  vc4_hvs_debugfs_underrun, 0},
>  	{"crtc0_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)0},
>  	{"crtc1_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)1},
>  	{"crtc2_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)2},
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 2c635f001c71..b34da7b6ee6b 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -185,6 +185,13 @@ struct vc4_dev {
>  	/* Bitmask of the current bin_alloc used for overflow memory. */
>  	uint32_t bin_alloc_overflow;
>=20=20
> +	/* Incremented when an underrun error happened after an atomic commit.
> +	 * This is particularly useful to detect when a specific modeset is too
> +	 * demanding in term of memory or HVS bandwidth which is hard to guess
> +	 * at atomic check time.
> +	 */
> +	atomic_t underrun;
> +
>  	struct work_struct overflow_mem_work;
>=20=20
>  	int power_refcount;
> @@ -773,6 +780,9 @@ void vc4_irq_reset(struct drm_device *dev);
>  extern struct platform_driver vc4_hvs_driver;
>  void vc4_hvs_dump_state(struct drm_device *dev);
>  int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
> +int vc4_hvs_debugfs_underrun(struct seq_file *m, void *unused);
> +void vc4_hvs_unmask_underrun(struct drm_device *dev);
> +void vc4_hvs_mask_underrun(struct drm_device *dev);
>=20=20
>  /* vc4_kms.c */
>  int vc4_kms_load(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 5d8c749c9749..d5bc3bcd3e51 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -22,6 +22,7 @@
>   * each CRTC.
>   */
>=20=20
> +#include <drm/drm_atomic_helper.h>
>  #include <linux/component.h>
>  #include "vc4_drv.h"
>  #include "vc4_regs.h"
> @@ -102,6 +103,18 @@ int vc4_hvs_debugfs_regs(struct seq_file *m, void *u=
nused)
>=20=20
>  	return 0;
>  }
> +
> +int vc4_hvs_debugfs_underrun(struct seq_file *m, void *data)
> +{
> +	struct drm_info_node *node =3D m->private;
> +	struct drm_device *dev =3D node->minor->dev;
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +	struct drm_printer p =3D drm_seq_file_printer(m);
> +
> +	drm_printf(&p, "%d\n", atomic_read(&vc4->underrun));
> +
> +	return 0;
> +}
>  #endif
>=20=20
>  /* The filter kernel is composed of dwords each containing 3 9-bit
> @@ -166,6 +179,67 @@ static int vc4_hvs_upload_linear_kernel(struct vc4_h=
vs *hvs,
>  	return 0;
>  }
>=20=20
> +void vc4_hvs_mask_underrun(struct drm_device *dev)
> +{
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +	u32 dispctrl =3D HVS_READ(SCALER_DISPCTRL);
> +
> +	dispctrl &=3D ~(SCALER_DISPCTRL_DSPEISLUR(0) |
> +		      SCALER_DISPCTRL_DSPEISLUR(1) |
> +		      SCALER_DISPCTRL_DSPEISLUR(2));
> +
> +	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
> +}
> +
> +void vc4_hvs_unmask_underrun(struct drm_device *dev)
> +{
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +	u32 dispctrl =3D HVS_READ(SCALER_DISPCTRL);
> +
> +	dispctrl |=3D SCALER_DISPCTRL_DSPEISLUR(0) |
> +		    SCALER_DISPCTRL_DSPEISLUR(1) |
> +		    SCALER_DISPCTRL_DSPEISLUR(2);
> +
> +	HVS_WRITE(SCALER_DISPSTAT,
> +		  SCALER_DISPSTAT_EUFLOW(0) |
> +		  SCALER_DISPSTAT_EUFLOW(1) |
> +		  SCALER_DISPSTAT_EUFLOW(2));
> +	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
> +}
> +
> +static void vc4_hvs_report_underrun(struct drm_device *dev)
> +{
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +
> +	atomic_inc(&vc4->underrun);
> +	DRM_DEV_ERROR(dev->dev, "HVS underrun\n");
> +}
> +
> +static irqreturn_t vc4_hvs_irq_handler(int irq, void *data)
> +{
> +	struct drm_device *dev =3D data;
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +	irqreturn_t irqret =3D IRQ_NONE;
> +	u32 status;
> +
> +	status =3D HVS_READ(SCALER_DISPSTAT);
> +
> +	if (status & (SCALER_DISPSTAT_EUFLOW(0) |
> +		      SCALER_DISPSTAT_EUFLOW(1) |
> +		      SCALER_DISPSTAT_EUFLOW(2))) {
> +		vc4_hvs_mask_underrun(dev);
> +		vc4_hvs_report_underrun(dev);
> +
> +		irqret =3D IRQ_HANDLED;
> +	}
> +
> +	HVS_WRITE(SCALER_DISPSTAT, SCALER_DISPSTAT_IRQMASK(0) |
> +				   SCALER_DISPSTAT_IRQMASK(1) |
> +				   SCALER_DISPSTAT_IRQMASK(2));
> +
> +	return irqret;
> +}
> +
>  static int vc4_hvs_bind(struct device *dev, struct device *master, void =
*data)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
> @@ -219,15 +293,33 @@ static int vc4_hvs_bind(struct device *dev, struct =
device *master, void *data)
>  	dispctrl =3D HVS_READ(SCALER_DISPCTRL);
>=20=20
>  	dispctrl |=3D SCALER_DISPCTRL_ENABLE;
> +	dispctrl |=3D SCALER_DISPCTRL_DSPEISLUR(0) | SCALER_DISPCTRL_DISPEIRQ(0=
) |
> +		    SCALER_DISPCTRL_DSPEISLUR(1) | SCALER_DISPCTRL_DISPEIRQ(1) |
> +		    SCALER_DISPCTRL_DSPEISLUR(2) | SCALER_DISPCTRL_DISPEIRQ(2);
>=20=20
>  	/* Set DSP3 (PV1) to use HVS channel 2, which would otherwise
>  	 * be unused.
>  	 */
>  	dispctrl &=3D ~SCALER_DISPCTRL_DSP3_MUX_MASK;
> +	dispctrl &=3D ~(SCALER_DISPCTRL_DMAEIRQ |
> +		      SCALER_DISPCTRL_SLVWREIRQ |
> +		      SCALER_DISPCTRL_SLVRDEIRQ |
> +		      SCALER_DISPCTRL_DSPEIEOF(0) |
> +		      SCALER_DISPCTRL_DSPEIEOF(1) |
> +		      SCALER_DISPCTRL_DSPEIEOF(2) |
> +		      SCALER_DISPCTRL_DSPEIEOLN(0) |
> +		      SCALER_DISPCTRL_DSPEIEOLN(1) |
> +		      SCALER_DISPCTRL_DSPEIEOLN(2) |
> +		      SCALER_DISPCTRL_SCLEIRQ);
>  	dispctrl |=3D VC4_SET_FIELD(2, SCALER_DISPCTRL_DSP3_MUX);
>=20=20
>  	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
>=20=20
> +	ret =3D devm_request_irq(dev, platform_get_irq(pdev, 0),
> +			       vc4_hvs_irq_handler, 0, "vc4 hvs", drm);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>=20=20
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 91b8c72ff361..3c87fbcd0b17 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -139,6 +139,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *s=
tate)
>  	struct drm_device *dev =3D state->dev;
>  	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>=20=20
> +	vc4_hvs_mask_underrun(dev);
> +
>  	drm_atomic_helper_wait_for_fences(dev, state, false);
>=20=20
>  	drm_atomic_helper_wait_for_dependencies(state);
> @@ -155,6 +157,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *s=
tate)
>=20=20
>  	drm_atomic_helper_commit_hw_done(state);
>=20=20
> +	vc4_hvs_unmask_underrun(dev);
> +
>  	drm_atomic_helper_wait_for_flip_done(dev, state);
>=20=20
>  	drm_atomic_helper_cleanup_planes(dev, state);

I think the mask/unmask in here could race against another atomic_commit
happening on another CRTC in parallel.  I guess maybe we should mask off
interrupts on the specific channel being modified.

However, given that we're just talking about a debugfs entry and
user-space testing tool, I'm fine with this as-is.

Other than my concern for patch #4, patch 1-3 are:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxbcwYACgkQtdYpNtH8
nuiMUw//f6S3eIFEoHdaRbFUfERSxEVcNJKQtKOaqyLc3Gr7X//Wp/VRfLQ48y+u
1gA/bB8aYfE1OHJ8QCT4Md3gGFukVknVcI3Z55rtq1STFW9jnD1Be4uUEUMDnXNt
adlu/dT5jpLR62N8lh+zOk2IBf6FwvMbWqaVTcIGYUFU9V2pUXL58ta92GqZ8NEL
xNMhh10t0HrN41WZsG+8Cspg4CJe8CZ3fJin9URf6mSSoqFKJFZUzbJcYYRHi0sw
XtAxkTxnCKX/AgDylfdsdC/lCNeP55T2lXzD2pQ3+jLR9lv1Z6ccB0EBngIOkqU0
NOhbpWYlEihCe+vQrKXDvGlaqSTCfSXyxJ+AfZDUbnQcqOqjZfULnOCXVE5BOt1T
Nh4X7bFfliQAVFSq+GsAHwwnxqCQO5oM/Cs/5phCrpMLUge7NUrZQvYBwIumGevB
crjpoQonuQrYfc0fmAcD+hjGqcuOM45njUtVuyMVzcDrssam6ZV6P1KSYpqw6aoo
Tme6VQ4rDMFJedmmaFX+7CLL4gXpJXVsUcSUZE69Nc+JU00RxZc842YTB6YNPeYS
PvX+llLnLYLN/ne07gAxxgxZG0gqyVfVdc9OOpKCW+rIRF2S8TiFWqqqQ6LlW6/B
5iC9lXYRfxpt3cuXbdCYJSFTIT8PDAGo+jl1atsNldyWZYMCrYk=
=lRjt
-----END PGP SIGNATURE-----
--=-=-=--
