Return-Path: <lyude@redhat.com>
X-Google-Smtp-Source: AH8x224cqSn7/yPwePJDNw82JBdlaj/lZAR26813Atnl5CBuGHSILvwo0guAtNMdOWdonC+DUOi1
ARC-Seal: i=1; a=rsa-sha256; t=1517509030; cv=none;
        d=google.com; s=arc-20160816;
        b=iad791wNnEkGhvLTxvsdiVF2nt5BCrsTmS0MyPvYVXEsy4cqFtRyr4blWO9mFWGqw8
         75QI8gBSM5OWbQt25KTREHd7xs0XNn20la6mhy5GsYMsHpIGQvOfLhc5U2oWvy5RcfvK
         C1KQ/nvIPFDj5QmVYke5fk9G7P2MNXx41+YnKuZVAMiqlJFTpYuz1Bg6lIQ723YVwRk0
         frKN3oBY6nWxD2jLSOesmHaqd9UXy0ADv9QBxyhGEYxd7b/4CyIf+rAo8I5bnKabgjC7
         gmZyWckI4D4nOgylx3QvbvNAqv1amQxhpUvu40Ul07utfaJU/Xd1Hfuaj48JvDR6v/tr
         NvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GMkiDCqFZ4SmEy8AATvXBlYPr1pU3FDXnsUBkZ6HHb0=;
        b=ds9pnrhnjLHDsgYlA9oYDdXsnZFHIKqU540AOpy2J8kfQSuV1UBhYUFY536hdyEaoU
         SRnPGHhVL+lRaWIcmPyMomZElh6VMHgCVvCbX5DHORq60ffj9LNj+OImXuYgK05sRNM3
         Cj2sdxOYXYVWc16QRamoiY+aICQdKBP/QpbtnHcLc8DeaRU8eW5/kLckTSuU3DqHbe2N
         d6LwBmKEwz456aoZDLw7JOi+UU9886hc0R9gpKWGERYwXGxBiuZLGuiz8YHcmCviE3yZ
         gHaRgtZZNryCeqHmfL5IwnFcG9kjqtIId31CvW458rx4ArSYNX4Cxq/NJEwv9xvN7SsB
         BazA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lyude@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=lyude@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lyude@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=lyude@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org
Cc: Ben Skeggs <bskeggs@redhat.com>,
	David Airlie <airlied@linux.ie>,
	Martin Peres <martin.peres@free.fr>,
	Karol Herbst <karolherbst@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rhys Kidd <rhyskidd@gmail.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC v6 2/5] drm/nouveau: Add support for BLCG on Kepler1
Date: Thu,  1 Feb 2018 13:13:56 -0500
Message-Id: <20180201181458.25776-3-lyude@redhat.com>
In-Reply-To: <20180201181458.25776-1-lyude@redhat.com>
References: <20180201181458.25776-1-lyude@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223549234124399?=
X-GMAIL-MSGID: =?utf-8?q?1591223549234124399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This enables BLCG optimization for kepler1. When using clockgating,
nvidia's firmware has a set of registers which are initially programmed
by the vbios with various engine delays and other mysterious settings
that are safe enough to bring up the GPU. However, the values used by
the vbios are more power hungry then they need to be, so the nvidia driver
writes it's own more optimized set of BLCG settings before enabling
CG_CTRL. This adds support for programming the optimized BLCG values
during engine/subdev init, which enables rather significant power
savings.

This introduces the nvkm_therm_clkgate_init() helper, which we use to
program the optimized BLCG settings before enabling clockgating with
nvkm_therm_clkgate_enable.

As well, this commit shares a lot more code with Fermi since BLCG is
mostly the same there as far as we can tell. In the future, it's likely
we'll reformat the clkgate_packs for kepler1 so that they share a list
of mmio packs with Fermi.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Martin Peres <martin.peres@free.fr>
---
 .../gpu/drm/nouveau/include/nvkm/subdev/therm.h    |  12 ++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h     |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c     | 207 +++++++++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.h     |  55 ++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.c     |   6 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c     |  47 +++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.h     |  35 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |   2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild   |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |  10 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.c  |  58 ++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c  |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h   |   6 +
 14 files changed, 442 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
index 240b19bb4667..9398d9f09339 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
@@ -46,6 +46,16 @@ enum nvkm_therm_attr_type {
 	NVKM_THERM_ATTR_THRS_SHUTDOWN_HYST = 17,
 };
 
+struct nvkm_therm_clkgate_init {
+	u32 addr;
+	u8  count;
+	u32 data;
+};
+
+struct nvkm_therm_clkgate_pack {
+	const struct nvkm_therm_clkgate_init *init;
+};
+
 struct nvkm_therm {
 	const struct nvkm_therm_func *func;
 	struct nvkm_subdev subdev;
@@ -92,6 +102,8 @@ struct nvkm_therm {
 int nvkm_therm_temp_get(struct nvkm_therm *);
 int nvkm_therm_fan_sense(struct nvkm_therm *);
 int nvkm_therm_cstate(struct nvkm_therm *, int, int);
+void nvkm_therm_clkgate_init(struct nvkm_therm *,
+			     const struct nvkm_therm_clkgate_pack *);
 void nvkm_therm_clkgate_enable(struct nvkm_therm *);
 void nvkm_therm_clkgate_fini(struct nvkm_therm *, bool);
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h
index d7c2adb9b543..c8ec3fd97155 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h
@@ -137,6 +137,7 @@ struct gf100_gr_func {
 	int (*rops)(struct gf100_gr *);
 	int ppc_nr;
 	const struct gf100_grctx_func *grctx;
+	const struct nvkm_therm_clkgate_pack *clkgate_pack;
 	struct nvkm_sclass sclass[];
 };
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c
index 5e82f94c2245..1b52fcb2c49a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c
@@ -22,6 +22,7 @@
  * Authors: Ben Skeggs <bskeggs@redhat.com>
  */
 #include "gf100.h"
+#include "gk104.h"
 #include "ctxgf100.h"
 
 #include <nvif/class.h>
@@ -173,6 +174,208 @@ gk104_gr_pack_mmio[] = {
 	{}
 };
 
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_main_0[] = {
+	{ 0x4041f0, 1, 0x00004046 },
+	{ 0x409890, 1, 0x00000045 },
+	{ 0x4098b0, 1, 0x0000007f },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_rstr2d_0[] = {
+	{ 0x4078c0, 1, 0x00000042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_unk_0[] = {
+	{ 0x406000, 1, 0x00004044 },
+	{ 0x405860, 1, 0x00004042 },
+	{ 0x40590c, 1, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gcc_0[] = {
+	{ 0x408040, 1, 0x00004044 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_sked_0[] = {
+	{ 0x407000, 1, 0x00004044 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_unk_1[] = {
+	{ 0x405bf0, 1, 0x00004044 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_ctxctl_0[] = {
+	{ 0x41a890, 1, 0x00000042 },
+	{ 0x41a8b0, 1, 0x0000007f },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_unk_0[] = {
+	{ 0x418500, 1, 0x00004042 },
+	{ 0x418608, 1, 0x00004042 },
+	{ 0x418688, 1, 0x00004042 },
+	{ 0x418718, 1, 0x00000042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_esetup_0[] = {
+	{ 0x418828, 1, 0x00000044 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_tpbus_0[] = {
+	{ 0x418bbc, 1, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_zcull_0[] = {
+	{ 0x418970, 1, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_tpconf_0[] = {
+	{ 0x418c70, 1, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_unk_1[] = {
+	{ 0x418cf0, 1, 0x00004042 },
+	{ 0x418d70, 1, 0x00004042 },
+	{ 0x418f0c, 1, 0x00004042 },
+	{ 0x418e0c, 1, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_gcc_0[] = {
+	{ 0x419020, 1, 0x00004042 },
+	{ 0x419038, 1, 0x00000042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_ffb_0[] = {
+	{ 0x418898, 1, 0x00000042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_tex_0[] = {
+	{ 0x419a40, 9, 0x00004042 },
+	{ 0x419acc, 1, 0x00004047 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_poly_0[] = {
+	{ 0x419868, 1, 0x00000042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_l1c_0[] = {
+	{ 0x419ccc, 3, 0x00000042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_unk_2[] = {
+	{ 0x419c70, 1, 0x00004045 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_mp_0[] = {
+	{ 0x419fd0, 1, 0x00004043 },
+	{ 0x419fd8, 1, 0x00004049 },
+	{ 0x419fe0, 2, 0x00004042 },
+	{ 0x419ff0, 1, 0x00004046 },
+	{ 0x419ff8, 1, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_gpc_ppc_0[] = {
+	{ 0x41be28, 1, 0x00000042 },
+	{ 0x41bfe8, 1, 0x00004042 },
+	{ 0x41bed0, 1, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_rop_zrop_0[] = {
+	{ 0x408810, 2, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_rop_0[] = {
+	{ 0x408a80, 6, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_rop_crop_0[] = {
+	{ 0x4089a8, 1, 0x00004042 },
+	{ 0x4089b0, 1, 0x00000042 },
+	{ 0x4089b8, 1, 0x00004042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_clkgate_blcg_init_pxbar_0[] = {
+	{ 0x13c820, 1, 0x0001007f },
+	{ 0x13cbe0, 1, 0x00000042 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_pack
+gk104_clkgate_pack[] = {
+	{ gk104_clkgate_blcg_init_main_0 },
+	{ gk104_clkgate_blcg_init_rstr2d_0 },
+	{ gk104_clkgate_blcg_init_unk_0 },
+	{ gk104_clkgate_blcg_init_gcc_0 },
+	{ gk104_clkgate_blcg_init_sked_0 },
+	{ gk104_clkgate_blcg_init_unk_1 },
+	{ gk104_clkgate_blcg_init_gpc_ctxctl_0 },
+	{ gk104_clkgate_blcg_init_gpc_unk_0 },
+	{ gk104_clkgate_blcg_init_gpc_esetup_0 },
+	{ gk104_clkgate_blcg_init_gpc_tpbus_0 },
+	{ gk104_clkgate_blcg_init_gpc_zcull_0 },
+	{ gk104_clkgate_blcg_init_gpc_tpconf_0 },
+	{ gk104_clkgate_blcg_init_gpc_unk_1 },
+	{ gk104_clkgate_blcg_init_gpc_gcc_0 },
+	{ gk104_clkgate_blcg_init_gpc_ffb_0 },
+	{ gk104_clkgate_blcg_init_gpc_tex_0 },
+	{ gk104_clkgate_blcg_init_gpc_poly_0 },
+	{ gk104_clkgate_blcg_init_gpc_l1c_0 },
+	{ gk104_clkgate_blcg_init_gpc_unk_2 },
+	{ gk104_clkgate_blcg_init_gpc_mp_0 },
+	{ gk104_clkgate_blcg_init_gpc_ppc_0 },
+	{ gk104_clkgate_blcg_init_rop_zrop_0 },
+	{ gk104_clkgate_blcg_init_rop_0 },
+	{ gk104_clkgate_blcg_init_rop_crop_0 },
+	{ gk104_clkgate_blcg_init_pxbar_0 },
+	{}
+};
+
 /*******************************************************************************
  * PGRAPH engine/subdev functions
  ******************************************************************************/
@@ -214,6 +417,9 @@ gk104_gr_init(struct gf100_gr *gr)
 	gr->func->init_gpc_mmu(gr);
 
 	gf100_gr_mmio(gr, gr->func->mmio);
+	if (gr->func->clkgate_pack)
+		nvkm_therm_clkgate_init(gr->base.engine.subdev.device->therm,
+					gr->func->clkgate_pack);
 
 	nvkm_wr32(device, GPC_UNIT(0, 0x3018), 0x00000001);
 
@@ -338,6 +544,7 @@ gk104_gr = {
 	.rops = gf100_gr_rops,
 	.ppc_nr = 1,
 	.grctx = &gk104_grctx,
+	.clkgate_pack = gk104_clkgate_pack,
 	.sclass = {
 		{ -1, -1, FERMI_TWOD_A },
 		{ -1, -1, KEPLER_INLINE_TO_MEMORY_A },
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.h b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.h
new file mode 100644
index 000000000000..a24c177365d1
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright 2018 Red Hat Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Lyude Paul <lyude@redhat.com>
+ */
+#ifndef __GK104_GR_H__
+#define __GK104_GR_H__
+
+#include <subdev/therm.h>
+
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_main_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_rstr2d_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_unk_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gcc_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_sked_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_unk_1[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_ctxctl_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_unk_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_esetup_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_tpbus_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_zcull_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_tpconf_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_unk_1[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_gcc_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_ffb_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_tex_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_poly_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_l1c_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_unk_2[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_mp_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_gpc_ppc_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_rop_zrop_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_rop_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_rop_crop_0[];
+extern const struct nvkm_therm_clkgate_init gk104_clkgate_blcg_init_pxbar_0[];
+
+#endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.c
index 47d28c279707..cdc4e0a2cc6b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.c
@@ -26,6 +26,7 @@
 
 #include <core/memory.h>
 #include <core/option.h>
+#include <subdev/therm.h>
 
 void
 gf100_fb_intr(struct nvkm_fb *base)
@@ -92,6 +93,11 @@ gf100_fb_init(struct nvkm_fb *base)
 
 	if (fb->r100c10_page)
 		nvkm_wr32(device, 0x100c10, fb->r100c10 >> 8);
+
+	if (base->func->clkgate_pack) {
+		nvkm_therm_clkgate_init(device->therm,
+					base->func->clkgate_pack);
+	}
 }
 
 void *
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
index 0a6e8eaad42c..48fd98e08baa 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
@@ -20,10 +20,56 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  * Authors: Ben Skeggs
+ *          Lyude Paul
  */
+#include "gk104.h"
 #include "gf100.h"
 #include "ram.h"
 
+/*
+ *******************************************************************************
+ * PGRAPH registers for clockgating
+ *******************************************************************************
+ */
+const struct nvkm_therm_clkgate_init
+gk104_fb_clkgate_blcg_init_unk_0[] = {
+	{ 0x100d10, 1, 0x0000c244 },
+	{ 0x100d30, 1, 0x0000c242 },
+	{ 0x100d3c, 1, 0x00000242 },
+	{ 0x100d48, 1, 0x00000242 },
+	{ 0x100d1c, 1, 0x00000042 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_fb_clkgate_blcg_init_vm_0[] = {
+	{ 0x100c98, 1, 0x00000242 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_fb_clkgate_blcg_init_main_0[] = {
+	{ 0x10f000, 1, 0x00000042 },
+	{ 0x17e030, 1, 0x00000044 },
+	{ 0x17e040, 1, 0x00000044 },
+	{}
+};
+
+const struct nvkm_therm_clkgate_init
+gk104_fb_clkgate_blcg_init_bcast_0[] = {
+	{ 0x17ea60, 4, 0x00000044 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_pack
+gk104_fb_clkgate_pack[] = {
+	{ gk104_fb_clkgate_blcg_init_unk_0 },
+	{ gk104_fb_clkgate_blcg_init_vm_0 },
+	{ gk104_fb_clkgate_blcg_init_main_0 },
+	{ gk104_fb_clkgate_blcg_init_bcast_0 },
+	{}
+};
+
 static const struct nvkm_fb_func
 gk104_fb = {
 	.dtor = gf100_fb_dtor,
@@ -33,6 +79,7 @@ gk104_fb = {
 	.intr = gf100_fb_intr,
 	.ram_new = gk104_ram_new,
 	.default_bigpage = 17,
+	.clkgate_pack = gk104_fb_clkgate_pack,
 };
 
 int
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.h b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.h
new file mode 100644
index 000000000000..b3c78e4ff706
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright 2018 Red Hat Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Lyude Paul
+ */
+
+#ifndef __GK104_FB_H__
+#define __GK104_FB_H__
+
+#include <subdev/therm.h>
+
+extern const struct nvkm_therm_clkgate_init gk104_fb_clkgate_blcg_init_unk_0[];
+extern const struct nvkm_therm_clkgate_init gk104_fb_clkgate_blcg_init_vm_0[];
+extern const struct nvkm_therm_clkgate_init gk104_fb_clkgate_blcg_init_main_0[];
+extern const struct nvkm_therm_clkgate_init gk104_fb_clkgate_blcg_init_bcast_0[];
+
+#endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h
index 9351188d5d76..414a423e0e55 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h
@@ -3,6 +3,7 @@
 #define __NVKM_FB_PRIV_H__
 #define nvkm_fb(p) container_of((p), struct nvkm_fb, subdev)
 #include <subdev/fb.h>
+#include <subdev/therm.h>
 struct nvkm_bios;
 
 struct nvkm_fb_func {
@@ -27,6 +28,7 @@ struct nvkm_fb_func {
 	int (*ram_new)(struct nvkm_fb *, struct nvkm_ram **);
 
 	u8 default_bigpage;
+	const struct nvkm_therm_clkgate_pack *clkgate_pack;
 };
 
 void nvkm_fb_ctor(const struct nvkm_fb_func *, struct nvkm_device *device,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild
index 4bac4772d8ed..550702eab0b1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild
@@ -9,6 +9,7 @@ nvkm-y += nvkm/subdev/therm/nv40.o
 nvkm-y += nvkm/subdev/therm/nv50.o
 nvkm-y += nvkm/subdev/therm/g84.o
 nvkm-y += nvkm/subdev/therm/gt215.o
+nvkm-y += nvkm/subdev/therm/gf100.o
 nvkm-y += nvkm/subdev/therm/gf119.o
 nvkm-y += nvkm/subdev/therm/gk104.o
 nvkm-y += nvkm/subdev/therm/gm107.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
index cf1d5af30f5f..de07bc07abdb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
@@ -391,6 +391,16 @@ nvkm_therm_init(struct nvkm_subdev *subdev)
 	return 0;
 }
 
+void
+nvkm_therm_clkgate_init(struct nvkm_therm *therm,
+			const struct nvkm_therm_clkgate_pack *p)
+{
+	if (!therm->func->clkgate_init || !therm->clkgating_enabled)
+		return;
+
+	therm->func->clkgate_init(therm, p);
+}
+
 static void *
 nvkm_therm_dtor(struct nvkm_subdev *subdev)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.c
new file mode 100644
index 000000000000..5ae6913320e8
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright 2018 Red Hat Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Lyude Paul
+ */
+#include <core/device.h>
+
+#include "priv.h"
+
+#define pack_for_each_init(init, pack, head)                          \
+	for (pack = head; pack && pack->init; pack++)                 \
+		  for (init = pack->init; init && init->count; init++)
+void
+gf100_clkgate_init(struct nvkm_therm *therm,
+		   const struct nvkm_therm_clkgate_pack *p)
+{
+	struct nvkm_device *device = therm->subdev.device;
+	const struct nvkm_therm_clkgate_pack *pack;
+	const struct nvkm_therm_clkgate_init *init;
+	u32 next, addr;
+
+	pack_for_each_init(init, pack, p) {
+		next = init->addr + init->count * 8;
+		addr = init->addr;
+
+		nvkm_trace(&therm->subdev, "{ 0x%06x, %d, 0x%08x }\n",
+			   init->addr, init->count, init->data);
+		while (addr < next) {
+			nvkm_trace(&therm->subdev, "\t0x%06x = 0x%08x\n",
+				   addr, init->data);
+			nvkm_wr32(device, addr, init->data);
+			addr += 8;
+		}
+	}
+}
+
+/*
+ * TODO: Fermi clockgating isn't understood fully yet, so we don't specify any
+ * clockgate functions to use
+ */
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c
index 79806a757893..4e03971d2e3d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c
@@ -100,6 +100,7 @@ gk104_therm_func = {
 	.temp_get = g84_temp_get,
 	.fan_sense = gt215_therm_fan_sense,
 	.program_alarms = nvkm_therm_program_alarms_polling,
+	.clkgate_init = gf100_clkgate_init,
 	.clkgate_enable = gk104_clkgate_enable,
 	.clkgate_fini = gk104_clkgate_fini,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c
index c08097f2aff5..4caf401d001a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c
@@ -36,7 +36,7 @@ gt215_therm_fan_sense(struct nvkm_therm *therm)
 	return -ENODEV;
 }
 
-static void
+void
 gt215_therm_init(struct nvkm_therm *therm)
 {
 	struct nvkm_device *device = therm->subdev.device;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
index f30202dd88e7..21659daf1864 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
@@ -97,6 +97,8 @@ struct nvkm_therm_func {
 
 	void (*program_alarms)(struct nvkm_therm *);
 
+	void (*clkgate_init)(struct nvkm_therm *,
+			     const struct nvkm_therm_clkgate_pack *);
 	void (*clkgate_enable)(struct nvkm_therm *);
 	void (*clkgate_fini)(struct nvkm_therm *, bool);
 };
@@ -114,6 +116,9 @@ void g84_therm_fini(struct nvkm_therm *);
 
 int gt215_therm_fan_sense(struct nvkm_therm *);
 
+void gf100_clkgate_init(struct nvkm_therm *,
+			const struct nvkm_therm_clkgate_pack *);
+
 void g84_therm_init(struct nvkm_therm *);
 
 int gf119_fan_pwm_ctrl(struct nvkm_therm *, int, bool);
@@ -122,6 +127,7 @@ int gf119_fan_pwm_set(struct nvkm_therm *, int, u32, u32);
 int gf119_fan_pwm_clock(struct nvkm_therm *, int);
 void gf119_therm_init(struct nvkm_therm *);
 
+void gk104_therm_init(struct nvkm_therm *);
 void gk104_clkgate_enable(struct nvkm_therm *);
 void gk104_clkgate_fini(struct nvkm_therm *, bool);
 
-- 
2.14.3
