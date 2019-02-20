Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C63FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B932147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBTJtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:49:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:48516 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfBTJtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:49:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 01:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,390,1544515200"; 
   d="asc'?scan'208";a="134906913"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.116])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Feb 2019 01:49:32 -0800
Date:   Wed, 20 Feb 2019 17:39:59 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     intel-gvt-dev@lists.freedesktop.org, alex.williamson@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Yulei Zhang <yulei.zhang@intel.com>,
        Xiao Zheng <xiao.zheng@intel.com>
Subject: Re: [PATCH 7/8] drm/i915/gvt: vGPU device config data save/restore
 interface
Message-ID: <20190220093959.GG12380@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20190219074242.14015-1-yan.y.zhao@intel.com>
 <20190219074632.14350-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="92pbEV8XGBb4M+SC"
Content-Disposition: inline
In-Reply-To: <20190219074632.14350-1-yan.y.zhao@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--92pbEV8XGBb4M+SC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019.02.19 02:46:32 -0500, Yan Zhao wrote:
> The patch implments the gvt interface intel_gvt_save_restore to
> save/restore vGPU's device config data for live migration.
>=20
> vGPU device config data includes vreg, vggtt, vcfg space, workloads, ppgt=
t,
> execlist.
> It does not include dirty pages in system memory produced by vGPU.
>=20
> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> Signed-off-by: Xiao Zheng <xiao.zheng@intel.com>
> Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

=2E..

> +
> +#ifndef __GVT_MIGRATE_H__
> +#define __GVT_MIGRATE_H__
> +
> +#define MIGRATION_DIRTY_BITMAP_SIZE (16*1024UL)
> +
> +/* Assume 9MB is enough to descript VM kernel state */
> +#define MIGRATION_IMG_MAX_SIZE (9*1024UL*1024UL)
> +#define GVT_MMIO_SIZE (2*1024UL*1024UL)
> +#define GVT_MIGRATION_VERSION	0
> +
> +enum gvt_migration_type_t {
> +	GVT_MIGRATION_NONE,
> +	GVT_MIGRATION_HEAD,
> +	GVT_MIGRATION_CFG_SPACE,
> +	GVT_MIGRATION_VREG,
> +	GVT_MIGRATION_SREG,
> +	GVT_MIGRATION_GTT,
> +	GVT_MIGRATION_PPGTT,
> +	GVT_MIGRATION_WORKLOAD,
> +	GVT_MIGRATION_EXECLIST,
> +};
> +
> +struct gvt_ppgtt_entry_t {
> +	int page_table_level;
> +	u64 pdp[4];
> +};
> +
> +struct gvt_pending_workload_t {
> +	int ring_id;
> +	bool emulate_schedule_in;
> +	struct execlist_ctx_descriptor_format ctx_desc;
> +	struct intel_vgpu_elsp_dwords elsp_dwords;
> +};
> +
> +struct gvt_region_t {
> +	enum gvt_migration_type_t type;
> +	u32 size;		/* obj size of bytes to read/write */
> +};
> +
> +struct gvt_migration_obj_t {
> +	void *img;
> +	void *vgpu;
> +	u32 offset;
> +	struct gvt_region_t region;
> +	/* operation func defines how data save-restore */
> +	struct gvt_migration_operation_t *ops;
> +	char *name;
> +};
> +
> +struct gvt_migration_operation_t {
> +	/* called during pre-copy stage, VM is still alive */
> +	int (*pre_copy)(const struct gvt_migration_obj_t *obj);
> +	/* called before when VM was paused,
> +	 * return bytes transferred
> +	 */
> +	int (*pre_save)(const struct gvt_migration_obj_t *obj);
> +	/* called before load the state of device */
> +	int (*pre_load)(const struct gvt_migration_obj_t *obj, u32 size);
> +	/* called after load the state of device, VM already alive */
> +	int (*post_load)(const struct gvt_migration_obj_t *obj, u32 size);
> +};
> +
> +struct gvt_image_header_t {
> +	int version;
> +	int data_size;
> +	u64 crc_check;
> +	u64 global_data[64];
> +};

I think this misses device info that should ship with the image,
currently what I can think is that each platform should have seperate
type, e.g BDW, SKL, KBL, etc. We won't allow to restore onto different
platform than the source.

> +
> +#endif
> diff --git a/drivers/gpu/drm/i915/gvt/mmio.c b/drivers/gpu/drm/i915/gvt/m=
mio.c
> index 43f65848ecd6..6221d2f274fc 100644
> --- a/drivers/gpu/drm/i915/gvt/mmio.c
> +++ b/drivers/gpu/drm/i915/gvt/mmio.c
> @@ -50,6 +50,19 @@ int intel_vgpu_gpa_to_mmio_offset(struct intel_vgpu *v=
gpu, u64 gpa)
>  	return gpa - gttmmio_gpa;
>  }
> =20
> +/**
> + * intel_vgpu_mmio_offset_to_GPA - translate a MMIO offset to GPA
> + * @vgpu: a vGPU
> + *
> + * Returns:
> + * Zero on success, negative error code if failed
> + */
> +int intel_vgpu_mmio_offset_to_gpa(struct intel_vgpu *vgpu, u64 offset)
> +{
> +	return offset + ((*(u64 *)(vgpu_cfg_space(vgpu) + PCI_BASE_ADDRESS_0)) &
> +		~GENMASK(3, 0));
> +}
> +
>  #define reg_is_mmio(gvt, reg)  \
>  	(reg >=3D 0 && reg < gvt->device_info.mmio_size)
> =20
> diff --git a/drivers/gpu/drm/i915/gvt/mmio.h b/drivers/gpu/drm/i915/gvt/m=
mio.h
> index 1ffc69eba30e..a2bddb0257cf 100644
> --- a/drivers/gpu/drm/i915/gvt/mmio.h
> +++ b/drivers/gpu/drm/i915/gvt/mmio.h
> @@ -82,6 +82,7 @@ void intel_vgpu_reset_mmio(struct intel_vgpu *vgpu, boo=
l dmlr);
>  void intel_vgpu_clean_mmio(struct intel_vgpu *vgpu);
> =20
>  int intel_vgpu_gpa_to_mmio_offset(struct intel_vgpu *vgpu, u64 gpa);
> +int intel_vgpu_mmio_offset_to_gpa(struct intel_vgpu *vgpu, u64 offset);
> =20
>  int intel_vgpu_emulate_mmio_read(struct intel_vgpu *vgpu, u64 pa,
>  				void *p_data, unsigned int bytes);
> diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/v=
gpu.c
> index fcccda35a456..7676dcfdca09 100644
> --- a/drivers/gpu/drm/i915/gvt/vgpu.c
> +++ b/drivers/gpu/drm/i915/gvt/vgpu.c
> @@ -213,6 +213,7 @@ void intel_gvt_activate_vgpu(struct intel_vgpu *vgpu)
>  {
>  	mutex_lock(&vgpu->gvt->lock);
>  	vgpu->active =3D true;
> +	intel_vgpu_start_schedule(vgpu);
>  	mutex_unlock(&vgpu->gvt->lock);
>  }
> =20
> --=20
> 2.17.1
>=20
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--92pbEV8XGBb4M+SC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXG0gbwAKCRCxBBozTXgY
J1mBAJ48/aOP6VQwKJGcNl0lUE8segOPCACffjXWcsjHMrU2mzluvP7uyute9aQ=
=4s+0
-----END PGP SIGNATURE-----

--92pbEV8XGBb4M+SC--
