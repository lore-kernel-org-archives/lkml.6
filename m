Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCVCWS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:22:18 -0400
Received: from ozlabs.org ([103.22.144.67]:54871 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeCVCWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:22:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 22 Mar 2018 13:21:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Min He <min.he@intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: linux-next: manual merge of the drm-intel tree with Linus' tree
Message-ID: <20180322132129.6b953166@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9rALYzwp.zLPmq8p/6K6l1a"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9rALYzwp.zLPmq8p/6K6l1a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/gvt/scheduler.c

between commit:

  fa3dd623e559 ("drm/i915/gvt: keep oa config in shadow ctx")

from Linus' tree and commit:

  b20c0d5ce104 ("drm/i915/gvt: Update PDPs after a vGPU mm object is pinned=
.")

from the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/gvt/scheduler.c
index 068126404151,a55b4975c154..000000000000
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@@ -52,54 -52,29 +52,77 @@@ static void set_context_pdp_root_pointe
  		pdp_pair[i].val =3D pdp[7 - i];
  }
 =20
 +/*
 + * when populating shadow ctx from guest, we should not overrride oa rela=
ted
 + * registers, so that they will not be overlapped by guest oa configs. Th=
us
 + * made it possible to capture oa data from host for both host and guests.
 + */
 +static void sr_oa_regs(struct intel_vgpu_workload *workload,
 +		u32 *reg_state, bool save)
 +{
 +	struct drm_i915_private *dev_priv =3D workload->vgpu->gvt->dev_priv;
 +	u32 ctx_oactxctrl =3D dev_priv->perf.oa.ctx_oactxctrl_offset;
 +	u32 ctx_flexeu0 =3D dev_priv->perf.oa.ctx_flexeu0_offset;
 +	int i =3D 0;
 +	u32 flex_mmio[] =3D {
 +		i915_mmio_reg_offset(EU_PERF_CNTL0),
 +		i915_mmio_reg_offset(EU_PERF_CNTL1),
 +		i915_mmio_reg_offset(EU_PERF_CNTL2),
 +		i915_mmio_reg_offset(EU_PERF_CNTL3),
 +		i915_mmio_reg_offset(EU_PERF_CNTL4),
 +		i915_mmio_reg_offset(EU_PERF_CNTL5),
 +		i915_mmio_reg_offset(EU_PERF_CNTL6),
 +	};
 +
 +	if (!workload || !reg_state || workload->ring_id !=3D RCS)
 +		return;
 +
 +	if (save) {
 +		workload->oactxctrl =3D reg_state[ctx_oactxctrl + 1];
 +
 +		for (i =3D 0; i < ARRAY_SIZE(workload->flex_mmio); i++) {
 +			u32 state_offset =3D ctx_flexeu0 + i * 2;
 +
 +			workload->flex_mmio[i] =3D reg_state[state_offset + 1];
 +		}
 +	} else {
 +		reg_state[ctx_oactxctrl] =3D
 +			i915_mmio_reg_offset(GEN8_OACTXCONTROL);
 +		reg_state[ctx_oactxctrl + 1] =3D workload->oactxctrl;
 +
 +		for (i =3D 0; i < ARRAY_SIZE(workload->flex_mmio); i++) {
 +			u32 state_offset =3D ctx_flexeu0 + i * 2;
 +			u32 mmio =3D flex_mmio[i];
 +
 +			reg_state[state_offset] =3D mmio;
 +			reg_state[state_offset + 1] =3D workload->flex_mmio[i];
 +		}
 +	}
 +}
 +
+ static void update_shadow_pdps(struct intel_vgpu_workload *workload)
+ {
+ 	struct intel_vgpu *vgpu =3D workload->vgpu;
+ 	int ring_id =3D workload->ring_id;
+ 	struct i915_gem_context *shadow_ctx =3D vgpu->submission.shadow_ctx;
+ 	struct drm_i915_gem_object *ctx_obj =3D
+ 		shadow_ctx->engine[ring_id].state->obj;
+ 	struct execlist_ring_context *shadow_ring_context;
+ 	struct page *page;
+=20
+ 	if (WARN_ON(!workload->shadow_mm))
+ 		return;
+=20
+ 	if (WARN_ON(!atomic_read(&workload->shadow_mm->pincount)))
+ 		return;
+=20
+ 	page =3D i915_gem_object_get_page(ctx_obj, LRC_STATE_PN);
+ 	shadow_ring_context =3D kmap(page);
+ 	set_context_pdp_root_pointer(shadow_ring_context,
+ 			(void *)workload->shadow_mm->ppgtt_mm.shadow_pdps);
+ 	kunmap(page);
+ }
+=20
  static int populate_shadow_context(struct intel_vgpu_workload *workload)
  {
  	struct intel_vgpu *vgpu =3D workload->vgpu;

--Sig_/9rALYzwp.zLPmq8p/6K6l1a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqzEykACgkQAVBC80lX
0GxuKQf9G9nLIMP0dgOYy2/sl6nQUehyuQo3gZBILO3+nVKtM/0VWMb0GTnSqTJl
B1blQwE6Zc/xBVHsv1v4i8LTZLyn1XVgSSuo+1qjzslpcAWM+0LtQ0FS4M07v6Ap
RWsv7mtFWd5S0giqNR6ZARa07tyQN8t9sUNDRuRN+0AEeYrfvl3OFVvI3wTMNMP2
BWZUpV9IlDN9gzJz6VLQuo9RpzFLOV70FNvnyORc0SQvtootPgBi/rS0pHdRYNTx
2aBNxkYXtnbQ4CnNK0KJhw8Ul1k25dI0msRTkuFpjtBXUd7nne1U3IzL7J4ecFkd
eNdoJcCKHKbOrWf4AdcPwos7CMQ8rQ==
=teZW
-----END PGP SIGNATURE-----

--Sig_/9rALYzwp.zLPmq8p/6K6l1a--
