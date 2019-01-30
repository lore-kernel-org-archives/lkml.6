Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8C3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9093320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfA3PZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:25:52 -0500
Received: from shell.v3.sk ([90.176.6.54]:33868 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfA3PZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:25:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8C7A4CD00F;
        Wed, 30 Jan 2019 16:25:45 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dn7PRA5aUiRy; Wed, 30 Jan 2019 16:25:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BCCD1CD013;
        Wed, 30 Jan 2019 16:25:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zAw-v775xxio; Wed, 30 Jan 2019 16:25:39 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 84BFCCD00F;
        Wed, 30 Jan 2019 16:25:39 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2] drm/armada: add mmp2 support
Date:   Wed, 30 Jan 2019 16:25:36 +0100
Message-Id: <20190130152536.1890325-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heavily based on the Armada 510 (Dove) support.

Tested to work well with Display 1 and Display 2 clocks driving the inter=
nal
panel on the OLPC XO 1.75 laptop. Some tweaking might be required if anyo=
ne
wants to use it with a MIPI or HDMI encoder.

The data sheet is not available, but James Cameron of OLPC kindly
provided some details about the LCD_SCLK_DIV register.

Link: https://lists.freedesktop.org/archives/dri-devel/2018-December/2010=
21.html
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Applies on top of "drm-armada-devel" branch of
git://git.armlinux.org.uk/~rmk/linux-arm.git

Changes since v1:
- Aligned with more recent Armada 510 support: using the same clock
  names and allowing for more flexible pixel clock source selection.

 drivers/gpu/drm/armada/Makefile      |   1 +
 drivers/gpu/drm/armada/armada_610.c  | 143 +++++++++++++++++++++++++++
 drivers/gpu/drm/armada/armada_crtc.c |   4 +
 drivers/gpu/drm/armada/armada_drm.h  |   1 +
 drivers/gpu/drm/armada/armada_hw.h   |  10 ++
 5 files changed, 159 insertions(+)
 create mode 100644 drivers/gpu/drm/armada/armada_610.c

diff --git a/drivers/gpu/drm/armada/Makefile b/drivers/gpu/drm/armada/Mak=
efile
index 9bc3c3213724..5bbf86324cda 100644
--- a/drivers/gpu/drm/armada/Makefile
+++ b/drivers/gpu/drm/armada/Makefile
@@ -2,6 +2,7 @@
 armada-y	:=3D armada_crtc.o armada_drv.o armada_fb.o armada_fbdev.o \
 		   armada_gem.o armada_overlay.o armada_plane.o armada_trace.o
 armada-y	+=3D armada_510.o
+armada-y	+=3D armada_610.o
 armada-$(CONFIG_DEBUG_FS) +=3D armada_debugfs.o
=20
 obj-$(CONFIG_DRM_ARMADA) :=3D armada.o
diff --git a/drivers/gpu/drm/armada/armada_610.c b/drivers/gpu/drm/armada=
/armada_610.c
new file mode 100644
index 000000000000..586965fca907
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_610.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 Russell King
+ * Copyright (C) 2018,2019 Lubomir Rintel
+ *  Largely based on Armada 510 support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Armada MMP2 variant support
+ */
+#include <linux/clk.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_crtc.h>
+#include "armada_crtc.h"
+#include "armada_drm.h"
+#include "armada_hw.h"
+
+struct armada610_variant_data {
+	struct clk *clks[4];
+	struct clk *sel_clk;
+};
+
+static int armada610_crtc_init(struct armada_crtc *dcrtc, struct device =
*dev)
+{
+	struct armada610_variant_data *v;
+	struct property *prop;
+	struct clk *clk;
+	const char *s;
+	int idx;
+
+	v =3D devm_kzalloc(dev, sizeof(*v), GFP_KERNEL);
+	if (!v)
+		return -ENOMEM;
+
+	dcrtc->variant_data =3D v;
+
+	of_property_for_each_string(dev->of_node, "clock-names", prop, s) {
+		if (!strcmp(s, "ext_ref_clk0"))
+			idx =3D 0;
+		else if (!strcmp(s, "ext_ref_clk1"))
+			idx =3D 1;
+		else if (!strcmp(s, "plldivider"))
+			idx =3D 2;
+		else if (!strcmp(s, "axibus"))
+			idx =3D 3;
+		else
+			continue;
+
+		clk =3D devm_clk_get(dev, s);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk) =3D=3D -ENOENT ? -EPROBE_DEFER :
+				PTR_ERR(clk);
+		v->clks[idx] =3D clk;
+	}
+
+	return 0;
+}
+
+static const u32 armada610_clk_sels[] =3D {
+	SCLK_610_DISP0,
+	SCLK_610_DISP1,
+	SCLK_610_PLL,
+	SCLK_610_AXI,
+};
+
+static const struct armada_clocking_params armada610_clocking =3D {
+	/* HDMI requires -0.6%..+0.5% */
+	.permillage_min =3D 0,
+	.permillage_max =3D 2000,
+	.settable =3D BIT(0) | BIT(1),
+	.div_max =3D SCLK_610_INT_DIV_MASK,
+};
+
+/*
+ * This gets called with sclk =3D NULL to test whether the mode is
+ * supportable, and again with sclk !=3D NULL to set the clocks up for
+ * that.  The former can return an error, but the latter is expected
+ * not to.
+ */
+static int armada610_crtc_compute_clock(struct armada_crtc *dcrtc,
+	const struct drm_display_mode *mode, uint32_t *sclk)
+{
+	struct armada610_variant_data *v =3D dcrtc->variant_data;
+	unsigned long desired_khz =3D mode->crtc_clock;
+	struct armada_clk_result res;
+	int ret, idx;
+
+	idx =3D armada_crtc_select_clock(dcrtc, &res, &armada610_clocking,
+				       v->clks, ARRAY_SIZE(v->clks),
+				       desired_khz);
+	if (idx < 0)
+		return idx;
+
+	ret =3D clk_prepare_enable(res.clk);
+	if (ret)
+		return ret;
+
+	if (sclk) {
+		clk_set_rate(res.clk, res.desired_clk_hz);
+
+		*sclk =3D 0x00001000;	/* No idea */
+		*sclk |=3D 1 << 8;	/* MIPI clock bypass */
+		*sclk |=3D armada610_clk_sels[idx];
+		*sclk |=3D res.div;
+
+		/* We are now using this clock */
+		v->sel_clk =3D res.clk;
+		swap(dcrtc->clk, res.clk);
+	}
+
+	clk_disable_unprepare(res.clk);
+
+	return 0;
+}
+
+static void armada610_crtc_disable(struct armada_crtc *dcrtc)
+{
+	if (dcrtc->clk) {
+		clk_disable_unprepare(dcrtc->clk);
+		dcrtc->clk =3D NULL;
+	}
+}
+
+static void armada610_crtc_enable(struct armada_crtc *dcrtc,
+	const struct drm_display_mode *mode)
+{
+	struct armada610_variant_data *v =3D dcrtc->variant_data;
+
+	if (!dcrtc->clk && v->sel_clk) {
+		if (!WARN_ON(clk_prepare_enable(v->sel_clk)))
+			dcrtc->clk =3D v->sel_clk;
+	}
+}
+
+
+const struct armada_variant armada610_ops =3D {
+	.init =3D armada610_crtc_init,
+	.compute_clock =3D armada610_crtc_compute_clock,
+	.disable =3D armada610_crtc_disable,
+	.enable =3D armada610_crtc_enable,
+};
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armad=
a/armada_crtc.c
index 047136fda14b..d5cf35f6dab1 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1104,6 +1104,10 @@ static const struct of_device_id armada_lcd_of_mat=
ch[] =3D {
 		.compatible	=3D "marvell,dove-lcd",
 		.data		=3D &armada510_ops,
 	},
+	{
+		.compatible	=3D "marvell,mmp2-lcd",
+		.data		=3D &armada610_ops,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, armada_lcd_of_match);
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada=
/armada_drm.h
index b6307235f320..03aeb9c030e4 100644
--- a/drivers/gpu/drm/armada/armada_drm.h
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -52,6 +52,7 @@ struct armada_variant {
=20
 /* Variant ops */
 extern const struct armada_variant armada510_ops;
+extern const struct armada_variant armada610_ops;
=20
 struct armada_private {
 	struct drm_device	drm;
diff --git a/drivers/gpu/drm/armada/armada_hw.h b/drivers/gpu/drm/armada/=
armada_hw.h
index 5b1af0cc9f50..19544dfd6afb 100644
--- a/drivers/gpu/drm/armada/armada_hw.h
+++ b/drivers/gpu/drm/armada/armada_hw.h
@@ -219,6 +219,16 @@ enum {
 	SCLK_510_FRAC_DIV_MASK	=3D 0xfff << 16,
 	SCLK_510_INT_DIV_MASK	=3D 0xffff << 0,
=20
+	/* Armada 610 */
+	SCLK_610_AXI		=3D 0x0 << 30,
+	SCLK_610_DISP0		=3D 0x1 << 30,	/* LCD Display 1 */
+	SCLK_610_DISP1		=3D 0x2 << 30,	/* LCD Display 2 */
+	SCLK_610_PLL		=3D 0x3 << 30,	/* HDMI PLL clock */
+	SCLK_610_PANEL_CLK_DIS	=3D 0x1 << 28,	/* 1 =3D panel clock disabled */
+	SCLK_610_FRAC_DIV_MASK	=3D 0xfff << 16,
+	SCLK_610_MIPI_DIV_MASK	=3D 0xf << 8,	/* 0 =3D off, 1 =3D bypass, ... */
+	SCLK_610_INT_DIV_MASK	=3D 0xff << 0,
+
 	/* Armada 16x */
 	SCLK_16X_AHB		=3D 0x0 << 28,
 	SCLK_16X_PCLK		=3D 0x1 << 28,
--=20
2.20.1

