Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeCWAvC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:51:02 -0400
Received: from ozlabs.org ([103.22.144.67]:48275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbeCWAvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:51:01 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 23 Mar 2018 11:50:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: DRI <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Min He <min.he@intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: linux-next: manual merge of the drm-intel tree with Linus' tree
Message-ID: <20180323115018.1ae3ca1d@canb.auug.org.au>
In-Reply-To: <20180322132129.6b953166@canb.auug.org.au>
References: <20180322132129.6b953166@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6GYT71yLkaIpBNvnDM8_2Y1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6GYT71yLkaIpBNvnDM8_2Y1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 22 Mar 2018 13:21:29 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the drm-intel tree got a conflict in:
>=20
>   drivers/gpu/drm/i915/gvt/scheduler.c
>=20
> between commit:
>=20
>   fa3dd623e559 ("drm/i915/gvt: keep oa config in shadow ctx")
>=20
> from Linus' tree and commit:
>=20
>   b20c0d5ce104 ("drm/i915/gvt: Update PDPs after a vGPU mm object is pinn=
ed.")
>=20
> from the drm-intel tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/gpu/drm/i915/gvt/scheduler.c
> index 068126404151,a55b4975c154..000000000000
> --- a/drivers/gpu/drm/i915/gvt/scheduler.c
> +++ b/drivers/gpu/drm/i915/gvt/scheduler.c
> @@@ -52,54 -52,29 +52,77 @@@ static void set_context_pdp_root_pointe
>   		pdp_pair[i].val =3D pdp[7 - i];
>   }
>  =20
>  +/*
>  + * when populating shadow ctx from guest, we should not overrride oa re=
lated
>  + * registers, so that they will not be overlapped by guest oa configs. =
Thus
>  + * made it possible to capture oa data from host for both host and gues=
ts.
>  + */
>  +static void sr_oa_regs(struct intel_vgpu_workload *workload,
>  +		u32 *reg_state, bool save)
>  +{
>  +	struct drm_i915_private *dev_priv =3D workload->vgpu->gvt->dev_priv;
>  +	u32 ctx_oactxctrl =3D dev_priv->perf.oa.ctx_oactxctrl_offset;
>  +	u32 ctx_flexeu0 =3D dev_priv->perf.oa.ctx_flexeu0_offset;
>  +	int i =3D 0;
>  +	u32 flex_mmio[] =3D {
>  +		i915_mmio_reg_offset(EU_PERF_CNTL0),
>  +		i915_mmio_reg_offset(EU_PERF_CNTL1),
>  +		i915_mmio_reg_offset(EU_PERF_CNTL2),
>  +		i915_mmio_reg_offset(EU_PERF_CNTL3),
>  +		i915_mmio_reg_offset(EU_PERF_CNTL4),
>  +		i915_mmio_reg_offset(EU_PERF_CNTL5),
>  +		i915_mmio_reg_offset(EU_PERF_CNTL6),
>  +	};
>  +
>  +	if (!workload || !reg_state || workload->ring_id !=3D RCS)
>  +		return;
>  +
>  +	if (save) {
>  +		workload->oactxctrl =3D reg_state[ctx_oactxctrl + 1];
>  +
>  +		for (i =3D 0; i < ARRAY_SIZE(workload->flex_mmio); i++) {
>  +			u32 state_offset =3D ctx_flexeu0 + i * 2;
>  +
>  +			workload->flex_mmio[i] =3D reg_state[state_offset + 1];
>  +		}
>  +	} else {
>  +		reg_state[ctx_oactxctrl] =3D
>  +			i915_mmio_reg_offset(GEN8_OACTXCONTROL);
>  +		reg_state[ctx_oactxctrl + 1] =3D workload->oactxctrl;
>  +
>  +		for (i =3D 0; i < ARRAY_SIZE(workload->flex_mmio); i++) {
>  +			u32 state_offset =3D ctx_flexeu0 + i * 2;
>  +			u32 mmio =3D flex_mmio[i];
>  +
>  +			reg_state[state_offset] =3D mmio;
>  +			reg_state[state_offset + 1] =3D workload->flex_mmio[i];
>  +		}
>  +	}
>  +}
>  +
> + static void update_shadow_pdps(struct intel_vgpu_workload *workload)
> + {
> + 	struct intel_vgpu *vgpu =3D workload->vgpu;
> + 	int ring_id =3D workload->ring_id;
> + 	struct i915_gem_context *shadow_ctx =3D vgpu->submission.shadow_ctx;
> + 	struct drm_i915_gem_object *ctx_obj =3D
> + 		shadow_ctx->engine[ring_id].state->obj;
> + 	struct execlist_ring_context *shadow_ring_context;
> + 	struct page *page;
> +=20
> + 	if (WARN_ON(!workload->shadow_mm))
> + 		return;
> +=20
> + 	if (WARN_ON(!atomic_read(&workload->shadow_mm->pincount)))
> + 		return;
> +=20
> + 	page =3D i915_gem_object_get_page(ctx_obj, LRC_STATE_PN);
> + 	shadow_ring_context =3D kmap(page);
> + 	set_context_pdp_root_pointer(shadow_ring_context,
> + 			(void *)workload->shadow_mm->ppgtt_mm.shadow_pdps);
> + 	kunmap(page);
> + }
> +=20
>   static int populate_shadow_context(struct intel_vgpu_workload *workload)
>   {
>   	struct intel_vgpu *vgpu =3D workload->vgpu;

This is now a conflict between the drm tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/6GYT71yLkaIpBNvnDM8_2Y1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq0T0oACgkQAVBC80lX
0GxkeAf/VlX26jRufxf3NEO+fNBaJd0x1rIOloax6hd7boo6wk4xXeirpZu8NtAy
JSgmWBrHuO5wKzZfLqfnpzEuLVCuYOUtduejZn+C+XeFW6UDMOS4dFSB9DSL1hAv
dl4Nx4SUbiss9WEer5lvkQt8Ax2wMF2nftewJPdU3JwrH6+t3vT5evLgr7xqH1pm
/js84TdXvwVOq66DTkek9hPVKvSo8pWWQ2QlXz7/UhUR5FY7UH4Rp7GFYIQXFaQt
X0LHEkfXR+VRmr/92QoR/xWYR+5+ez3Agsh4FljOlYT29HVdqbILGzIztj9VHSY8
N0Lm+exzf6oosPPPqTfmUUsKLP9wRg==
=hLXn
-----END PGP SIGNATURE-----

--Sig_/6GYT71yLkaIpBNvnDM8_2Y1--
