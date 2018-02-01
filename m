Return-Path: <lyude@redhat.com>
X-Google-Smtp-Source: AH8x227IrUgBAjveKJwuG07eyl+eP3Zg76J3NjXmesPRy5C2RP0SvVeyULwE4etsv+EzHfruT32P
ARC-Seal: i=1; a=rsa-sha256; t=1517509058; cv=none;
        d=google.com; s=arc-20160816;
        b=K/vG/O0uAQnJDm0zo/B/kAsj6PZ9z5ZqEBRr1c/J7+iA6WzdB8bH2NkYgDYMhv9N7g
         ppxgLwo4BENT2BOzMvWhS86DTitiOS1FBk/s9/BrynixjdUzq/+ANi0VrNLy56emjz2v
         s+BqTSUAGsXKUUaKYXAIey+dea6IKSex41pZQHdwK6U3bIQM73VZh+0ULD+8684WMa3q
         AkYrm4ygQGcNiY+MZOesgHvROjBbZZVEDxQkXNLJAQxOcNz074pf+jthoihlMQPEcjMG
         Bvugz/B6St3SdVKBgHvmkLpVtKjUGNtGu+0fMZIqDtNA7XFu6aS62vtLRvG38OhCLRJn
         D/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=u6+NUrOOao7KZ4YUg/otbbPFQqolFkAjZtVOds4mvgM=;
        b=YNxrLL4f1OxmGpfs7+xk0IjWGRq089HS6wh5y2sS9NSUzc0faf1EQv27IOJCNBYv/H
         0nH7AlTvsQA041kXtpU2uZdbV1OrQhS7N6yPkFwJiebq++/q4I0oe7qkeRcm6kxQNJ4/
         pwKaGGnU/p7ECR6Fd9kUt6rT2b0U7re7PMlt9jNQENTiamGM1ecLq+TUVmR1HFHZKO1B
         MTRHD20Dm0nomesdWrH2Rnq430nA+C6feRNaxcZlkFwZoPZLZWdWfDCFu/gHdugPm6mq
         bqQ2uSUEYtYkIIsx5sZanJrrqZOrbEcFb5bfRVmtyj1rK8jTSkc+4CDhbPSMXaybIZrb
         mUsA==
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
	Thomas Gleixner <tglx@linutronix.de>,
	Martin Peres <martin.peres@free.fr>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Karol Herbst <karolherbst@gmail.com>,
	Ilia Mirkin <imirkin@alum.mit.edu>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC v6 3/5] drm/nouveau: Add support for BLCG on Kepler2
Date: Thu,  1 Feb 2018 13:13:57 -0500
Message-Id: <20180201181458.25776-4-lyude@redhat.com>
In-Reply-To: <20180201181458.25776-1-lyude@redhat.com>
References: <20180201181458.25776-1-lyude@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223578826603408?=
X-GMAIL-MSGID: =?utf-8?q?1591223578826603408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Same as the previous patch, but for Kepler2 now

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Martin Peres <martin.peres@free.fr>
---
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h  |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c |  8 +--
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c    | 62 ++++++++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild     |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c    | 71 +++++++++++++++++++++++
 5 files changed, 139 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h
index adb78f7d083a..92be0e5269c6 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h
@@ -75,6 +75,7 @@ int mcp89_fb_new(struct nvkm_device *, int, struct nvkm_fb **);
 int gf100_fb_new(struct nvkm_device *, int, struct nvkm_fb **);
 int gf108_fb_new(struct nvkm_device *, int, struct nvkm_fb **);
 int gk104_fb_new(struct nvkm_device *, int, struct nvkm_fb **);
+int gk110_fb_new(struct nvkm_device *, int, struct nvkm_fb **);
 int gk20a_fb_new(struct nvkm_device *, int, struct nvkm_fb **);
 int gm107_fb_new(struct nvkm_device *, int, struct nvkm_fb **);
 int gm200_fb_new(struct nvkm_device *, int, struct nvkm_fb **);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index 74bd09b1c893..7590a30b7ff0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -1812,7 +1812,7 @@ nvf0_chipset = {
 	.bus = gf100_bus_new,
 	.clk = gk104_clk_new,
 	.devinit = gf100_devinit_new,
-	.fb = gk104_fb_new,
+	.fb = gk110_fb_new,
 	.fuse = gf100_fuse_new,
 	.gpio = gk104_gpio_new,
 	.i2c = gk104_i2c_new,
@@ -1850,7 +1850,7 @@ nvf1_chipset = {
 	.bus = gf100_bus_new,
 	.clk = gk104_clk_new,
 	.devinit = gf100_devinit_new,
-	.fb = gk104_fb_new,
+	.fb = gk110_fb_new,
 	.fuse = gf100_fuse_new,
 	.gpio = gk104_gpio_new,
 	.i2c = gk104_i2c_new,
@@ -1888,7 +1888,7 @@ nv106_chipset = {
 	.bus = gf100_bus_new,
 	.clk = gk104_clk_new,
 	.devinit = gf100_devinit_new,
-	.fb = gk104_fb_new,
+	.fb = gk110_fb_new,
 	.fuse = gf100_fuse_new,
 	.gpio = gk104_gpio_new,
 	.i2c = gk104_i2c_new,
@@ -1926,7 +1926,7 @@ nv108_chipset = {
 	.bus = gf100_bus_new,
 	.clk = gk104_clk_new,
 	.devinit = gf100_devinit_new,
-	.fb = gk104_fb_new,
+	.fb = gk110_fb_new,
 	.fuse = gf100_fuse_new,
 	.gpio = gk104_gpio_new,
 	.i2c = gk104_i2c_new,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c
index a38e19b61c1d..a528894231d0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c
@@ -22,6 +22,7 @@
  * Authors: Ben Skeggs <bskeggs@redhat.com>
  */
 #include "gf100.h"
+#include "gk104.h"
 #include "ctxgf100.h"
 
 #include <subdev/timer.h>
@@ -156,6 +157,66 @@ gk110_gr_pack_mmio[] = {
 	{}
 };
 
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_blcg_init_sked_0[] = {
+	{ 0x407000, 1, 0x00004041 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_blcg_init_gpc_gcc_0[] = {
+	{ 0x419020, 1, 0x00000042 },
+	{ 0x419038, 1, 0x00000042 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_blcg_init_gpc_l1c_0[] = {
+	{ 0x419cd4, 2, 0x00004042 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_init
+gk110_clkgate_blcg_init_gpc_mp_0[] = {
+	{ 0x419fd0, 1, 0x00004043 },
+	{ 0x419fd8, 1, 0x00004049 },
+	{ 0x419fe0, 2, 0x00004042 },
+	{ 0x419ff0, 1, 0x00000046 },
+	{ 0x419ff8, 1, 0x00004042 },
+	{ 0x419f90, 1, 0x00004042 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_pack
+gk110_clkgate_pack[] = {
+	{ gk104_clkgate_blcg_init_main_0 },
+	{ gk104_clkgate_blcg_init_rstr2d_0 },
+	{ gk104_clkgate_blcg_init_unk_0 },
+	{ gk104_clkgate_blcg_init_gcc_0 },
+	{ gk110_clkgate_blcg_init_sked_0 },
+	{ gk104_clkgate_blcg_init_unk_1 },
+	{ gk104_clkgate_blcg_init_gpc_ctxctl_0 },
+	{ gk104_clkgate_blcg_init_gpc_unk_0 },
+	{ gk104_clkgate_blcg_init_gpc_esetup_0 },
+	{ gk104_clkgate_blcg_init_gpc_tpbus_0 },
+	{ gk104_clkgate_blcg_init_gpc_zcull_0 },
+	{ gk104_clkgate_blcg_init_gpc_tpconf_0 },
+	{ gk104_clkgate_blcg_init_gpc_unk_1 },
+	{ gk110_clkgate_blcg_init_gpc_gcc_0 },
+	{ gk104_clkgate_blcg_init_gpc_ffb_0 },
+	{ gk104_clkgate_blcg_init_gpc_tex_0 },
+	{ gk104_clkgate_blcg_init_gpc_poly_0 },
+	{ gk110_clkgate_blcg_init_gpc_l1c_0 },
+	{ gk104_clkgate_blcg_init_gpc_unk_2 },
+	{ gk110_clkgate_blcg_init_gpc_mp_0 },
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
@@ -192,6 +253,7 @@ gk110_gr = {
 	.rops = gf100_gr_rops,
 	.ppc_nr = 2,
 	.grctx = &gk110_grctx,
+	.clkgate_pack = gk110_clkgate_pack,
 	.sclass = {
 		{ -1, -1, FERMI_TWOD_A },
 		{ -1, -1, KEPLER_INLINE_TO_MEMORY_B },
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild
index 2571530e82f1..b4f22cce5d43 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild
@@ -22,6 +22,7 @@ nvkm-y += nvkm/subdev/fb/mcp89.o
 nvkm-y += nvkm/subdev/fb/gf100.o
 nvkm-y += nvkm/subdev/fb/gf108.o
 nvkm-y += nvkm/subdev/fb/gk104.o
+nvkm-y += nvkm/subdev/fb/gk110.o
 nvkm-y += nvkm/subdev/fb/gk20a.o
 nvkm-y += nvkm/subdev/fb/gm107.o
 nvkm-y += nvkm/subdev/fb/gm200.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
new file mode 100644
index 000000000000..0695e5dd360e
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
@@ -0,0 +1,71 @@
+/*
+ * Copyright 2017 Red Hat Inc.
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
+#include "gf100.h"
+#include "gk104.h"
+#include "ram.h"
+#include <subdev/therm.h>
+#include <subdev/fb.h>
+
+/*
+ *******************************************************************************
+ * PGRAPH registers for clockgating
+ *******************************************************************************
+ */
+
+static const struct nvkm_therm_clkgate_init
+gk110_fb_clkgate_blcg_init_unk_0[] = {
+	{ 0x100d10, 1, 0x0000c242 },
+	{ 0x100d30, 1, 0x0000c242 },
+	{ 0x100d3c, 1, 0x00000242 },
+	{ 0x100d48, 1, 0x0000c242 },
+	{ 0x100d1c, 1, 0x00000042 },
+	{}
+};
+
+static const struct nvkm_therm_clkgate_pack
+gk110_fb_clkgate_pack[] = {
+	{ gk110_fb_clkgate_blcg_init_unk_0 },
+	{ gk104_fb_clkgate_blcg_init_vm_0 },
+	{ gk104_fb_clkgate_blcg_init_main_0 },
+	{ gk104_fb_clkgate_blcg_init_bcast_0 },
+	{}
+};
+
+static const struct nvkm_fb_func
+gk110_fb = {
+	.dtor = gf100_fb_dtor,
+	.oneinit = gf100_fb_oneinit,
+	.init = gf100_fb_init,
+	.init_page = gf100_fb_init_page,
+	.intr = gf100_fb_intr,
+	.ram_new = gk104_ram_new,
+	.default_bigpage = 17,
+	.clkgate_pack = gk110_fb_clkgate_pack,
+};
+
+int
+gk110_fb_new(struct nvkm_device *device, int index, struct nvkm_fb **pfb)
+{
+	return gf100_fb_new_(&gk110_fb, device, index, pfb);
+}
-- 
2.14.3
