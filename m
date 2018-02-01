Return-Path: <lyude@redhat.com>
X-Google-Smtp-Source: AH8x227kLbx7HjQWNKSDXj1KawF8dvH4Q2BAHM76bfaveI+bxJGex8o4pF3CAtabkIcMrhiBMq5T
ARC-Seal: i=1; a=rsa-sha256; t=1517508949; cv=none;
        d=google.com; s=arc-20160816;
        b=MzJjP+qmVbYNVTaOjJ2Vz6CU3y5/FqMZqpCgaUgUVgZaWcL8HDmjCxCfQgoEWD8bhq
         C1w699G5Bvt/0a309jbK8hc+aIl9vovOKHC0/aimI0TMQ1HIH0PX3OEOz9D4oXpIXHAl
         SNvV8/F5HmTefYb7OndXY4D5GV90MErfdWXT97xoxIQ02yKUY7c/BHPK8UK/qH25iFw4
         nE+rNxZ0wJxULZtOhKrQP5oY69zRADC8mlnUa1AxDzDBqofN7Z+sFfFrCiSZaNUwdqzQ
         ApdVHwgviqrHu4G/sHgaiiwF/u9jfZUuXG6mJM3hinDqGEktLU4xmfD0CoXN36adLOMe
         il9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=RY8iAUl7jptsvuZNySqy8HvChdXNWXODlLJeNMfgYH4=;
        b=BXDdXdMLGx35K1wtJUR1Tx5+38GcXbEYgDcnPx3HHpjcc8hVTyp5btY16W9CKcOjbA
         pPrRLNevQ2ZTKn7gOGmtJnLgJO+jCKfzBmb/YEUh9IDkK3YOJpdBfVJIG0KQpRlFKUjn
         Uayu8rPXfrd3XL4mKKhe0EY3CLSuLX0/6SafDN89n/XMN0VbbAFWMgQoaq6MDKaRsGvu
         A+Xlhu45P7QQ5FR3+aZzTTv1YwwiNlB3kOe3E/LhqPcruoSH6UhpsQq7V5qU2nACxzti
         BR3Tzj+6Gq4KBmtXYkJ7dVGFEod+ElQ8YVI2priRFm4DU2EvEFGSvkk78mK6bObnHscF
         ++xA==
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
	Rhys Kidd <rhyskidd@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Karol Herbst <karolherbst@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Ilia Mirkin <imirkin@alum.mit.edu>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC v6 1/5] drm/nouveau: Add support for basic clockgating on Kepler1
Date: Thu,  1 Feb 2018 13:13:55 -0500
Message-Id: <20180201181458.25776-2-lyude@redhat.com>
In-Reply-To: <20180201181458.25776-1-lyude@redhat.com>
References: <20180201181458.25776-1-lyude@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223464094098215?=
X-GMAIL-MSGID: =?utf-8?q?1591223464094098215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds support for enabling automatic clockgating on nvidia GPUs for
Kepler1. While this is not technically a clockgating level, it does
enable clockgating using the clockgating values initially set by the
vbios (which should be safe to use).

This introduces two therm helpers for controlling basic clockgating:
	nvkm_therm_clkgate_enable() - enables clockgating through
	CG_CTRL, done after initializing the GPU fully
	nvkm_therm_clkgate_fini() - prepares clockgating for suspend or
	driver unload

A lot of this code was originally going to be based off of fermi;
however it turns out that while Fermi's the first line of GPUs that
introduced this kind of power saving, Fermi requires more fine tuned
control of the CG_CTRL registers from the driver while reclocking that
we don't entirely understand yet.

For the simple parts we will be sharing with Fermi for certain however,
we at least add those into a new subdev/therm/gf100.h header.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Martin Peres <martin.peres@free.fr>
---
 .../gpu/drm/nouveau/include/nvkm/subdev/therm.h    |   5 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  17 +--
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild   |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |  58 +++++++--
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.h  |  35 ++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c  |   8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c  | 135 +++++++++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h  |  48 ++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h   |  15 ++-
 9 files changed, 301 insertions(+), 21 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
index b1ac47eb786e..240b19bb4667 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
@@ -85,17 +85,22 @@ struct nvkm_therm {
 
 	int (*attr_get)(struct nvkm_therm *, enum nvkm_therm_attr_type);
 	int (*attr_set)(struct nvkm_therm *, enum nvkm_therm_attr_type, int);
+
+	bool clkgating_enabled;
 };
 
 int nvkm_therm_temp_get(struct nvkm_therm *);
 int nvkm_therm_fan_sense(struct nvkm_therm *);
 int nvkm_therm_cstate(struct nvkm_therm *, int, int);
+void nvkm_therm_clkgate_enable(struct nvkm_therm *);
+void nvkm_therm_clkgate_fini(struct nvkm_therm *, bool);
 
 int nv40_therm_new(struct nvkm_device *, int, struct nvkm_therm **);
 int nv50_therm_new(struct nvkm_device *, int, struct nvkm_therm **);
 int g84_therm_new(struct nvkm_device *, int, struct nvkm_therm **);
 int gt215_therm_new(struct nvkm_device *, int, struct nvkm_therm **);
 int gf119_therm_new(struct nvkm_device *, int, struct nvkm_therm **);
+int gk104_therm_new(struct nvkm_device *, int, struct nvkm_therm **);
 int gm107_therm_new(struct nvkm_device *, int, struct nvkm_therm **);
 int gm200_therm_new(struct nvkm_device *, int, struct nvkm_therm **);
 int gp100_therm_new(struct nvkm_device *, int, struct nvkm_therm **);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index 08e77cd55e6e..74bd09b1c893 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -28,6 +28,7 @@
 #include <core/option.h>
 
 #include <subdev/bios.h>
+#include <subdev/therm.h>
 
 static DEFINE_MUTEX(nv_devices_mutex);
 static LIST_HEAD(nv_devices);
@@ -1682,7 +1683,7 @@ nve4_chipset = {
 	.mxm = nv50_mxm_new,
 	.pci = gk104_pci_new,
 	.pmu = gk104_pmu_new,
-	.therm = gf119_therm_new,
+	.therm = gk104_therm_new,
 	.timer = nv41_timer_new,
 	.top = gk104_top_new,
 	.volt = gk104_volt_new,
@@ -1721,7 +1722,7 @@ nve6_chipset = {
 	.mxm = nv50_mxm_new,
 	.pci = gk104_pci_new,
 	.pmu = gk104_pmu_new,
-	.therm = gf119_therm_new,
+	.therm = gk104_therm_new,
 	.timer = nv41_timer_new,
 	.top = gk104_top_new,
 	.volt = gk104_volt_new,
@@ -1760,7 +1761,7 @@ nve7_chipset = {
 	.mxm = nv50_mxm_new,
 	.pci = gk104_pci_new,
 	.pmu = gk104_pmu_new,
-	.therm = gf119_therm_new,
+	.therm = gk104_therm_new,
 	.timer = nv41_timer_new,
 	.top = gk104_top_new,
 	.volt = gk104_volt_new,
@@ -1824,7 +1825,7 @@ nvf0_chipset = {
 	.mxm = nv50_mxm_new,
 	.pci = gk104_pci_new,
 	.pmu = gk110_pmu_new,
-	.therm = gf119_therm_new,
+	.therm = gk104_therm_new,
 	.timer = nv41_timer_new,
 	.top = gk104_top_new,
 	.volt = gk104_volt_new,
@@ -1862,7 +1863,7 @@ nvf1_chipset = {
 	.mxm = nv50_mxm_new,
 	.pci = gk104_pci_new,
 	.pmu = gk110_pmu_new,
-	.therm = gf119_therm_new,
+	.therm = gk104_therm_new,
 	.timer = nv41_timer_new,
 	.top = gk104_top_new,
 	.volt = gk104_volt_new,
@@ -1900,7 +1901,7 @@ nv106_chipset = {
 	.mxm = nv50_mxm_new,
 	.pci = gk104_pci_new,
 	.pmu = gk208_pmu_new,
-	.therm = gf119_therm_new,
+	.therm = gk104_therm_new,
 	.timer = nv41_timer_new,
 	.top = gk104_top_new,
 	.volt = gk104_volt_new,
@@ -1938,7 +1939,7 @@ nv108_chipset = {
 	.mxm = nv50_mxm_new,
 	.pci = gk104_pci_new,
 	.pmu = gk208_pmu_new,
-	.therm = gf119_therm_new,
+	.therm = gk104_therm_new,
 	.timer = nv41_timer_new,
 	.top = gk104_top_new,
 	.volt = gk104_volt_new,
@@ -2508,6 +2509,7 @@ nvkm_device_fini(struct nvkm_device *device, bool suspend)
 		}
 	}
 
+	nvkm_therm_clkgate_fini(device->therm, suspend);
 
 	if (device->func->fini)
 		device->func->fini(device, suspend);
@@ -2597,6 +2599,7 @@ nvkm_device_init(struct nvkm_device *device)
 	}
 
 	nvkm_acpi_init(device);
+	nvkm_therm_clkgate_enable(device->therm);
 
 	time = ktime_to_us(ktime_get()) - time;
 	nvdev_trace(device, "init completed in %lldus\n", time);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild
index 7ba56b12badd..4bac4772d8ed 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild
@@ -10,6 +10,7 @@ nvkm-y += nvkm/subdev/therm/nv50.o
 nvkm-y += nvkm/subdev/therm/g84.o
 nvkm-y += nvkm/subdev/therm/gt215.o
 nvkm-y += nvkm/subdev/therm/gf119.o
+nvkm-y += nvkm/subdev/therm/gk104.o
 nvkm-y += nvkm/subdev/therm/gm107.o
 nvkm-y += nvkm/subdev/therm/gm200.o
 nvkm-y += nvkm/subdev/therm/gp100.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
index f27fc6d0d4c6..cf1d5af30f5f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
@@ -21,6 +21,7 @@
  *
  * Authors: Martin Peres
  */
+#include <nvkm/core/option.h>
 #include "priv.h"
 
 int
@@ -297,6 +298,38 @@ nvkm_therm_attr_set(struct nvkm_therm *therm,
 	return -EINVAL;
 }
 
+void
+nvkm_therm_clkgate_enable(struct nvkm_therm *therm)
+{
+	if (!therm->func->clkgate_enable || !therm->clkgating_enabled)
+		return;
+
+	nvkm_debug(&therm->subdev,
+		   "Enabling clockgating\n");
+	therm->func->clkgate_enable(therm);
+}
+
+void
+nvkm_therm_clkgate_fini(struct nvkm_therm *therm, bool suspend)
+{
+	if (!therm->func->clkgate_fini || !therm->clkgating_enabled)
+		return;
+
+	nvkm_debug(&therm->subdev,
+		   "Preparing clockgating for %s\n",
+		   suspend ? "suspend" : "fini");
+	therm->func->clkgate_fini(therm, suspend);
+}
+
+static void
+nvkm_therm_clkgate_oneinit(struct nvkm_therm *therm)
+{
+	if (!therm->func->clkgate_enable || !therm->clkgating_enabled)
+		return;
+
+	nvkm_info(&therm->subdev, "Clockgating enabled\n");
+}
+
 static void
 nvkm_therm_intr(struct nvkm_subdev *subdev)
 {
@@ -333,6 +366,7 @@ nvkm_therm_oneinit(struct nvkm_subdev *subdev)
 	nvkm_therm_fan_ctor(therm);
 	nvkm_therm_fan_mode(therm, NVKM_THERM_CTRL_AUTO);
 	nvkm_therm_sensor_preinit(therm);
+	nvkm_therm_clkgate_oneinit(therm);
 	return 0;
 }
 
@@ -374,15 +408,10 @@ nvkm_therm = {
 	.intr = nvkm_therm_intr,
 };
 
-int
-nvkm_therm_new_(const struct nvkm_therm_func *func, struct nvkm_device *device,
-		int index, struct nvkm_therm **ptherm)
+void
+nvkm_therm_ctor(struct nvkm_therm *therm, struct nvkm_device *device,
+		int index, const struct nvkm_therm_func *func)
 {
-	struct nvkm_therm *therm;
-
-	if (!(therm = *ptherm = kzalloc(sizeof(*therm), GFP_KERNEL)))
-		return -ENOMEM;
-
 	nvkm_subdev_ctor(&nvkm_therm, device, index, &therm->subdev);
 	therm->func = func;
 
@@ -395,5 +424,18 @@ nvkm_therm_new_(const struct nvkm_therm_func *func, struct nvkm_device *device,
 	therm->attr_get = nvkm_therm_attr_get;
 	therm->attr_set = nvkm_therm_attr_set;
 	therm->mode = therm->suspend = -1; /* undefined */
+	therm->clkgating_enabled = false;
+}
+
+int
+nvkm_therm_new_(const struct nvkm_therm_func *func, struct nvkm_device *device,
+		int index, struct nvkm_therm **ptherm)
+{
+	struct nvkm_therm *therm;
+
+	if (!(therm = *ptherm = kzalloc(sizeof(*therm), GFP_KERNEL)))
+		return -ENOMEM;
+
+	nvkm_therm_ctor(therm, device, index, func);
 	return 0;
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.h b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.h
new file mode 100644
index 000000000000..cfb25af77c60
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.h
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
+#ifndef __GF100_THERM_H__
+#define __GF100_THERM_H__
+
+#include <core/device.h>
+
+struct gf100_idle_filter {
+	u32 fecs;
+	u32 hubmmu;
+};
+
+#endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
index 06dcfd6ee966..0981b02790e2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
@@ -49,7 +49,7 @@ pwm_info(struct nvkm_therm *therm, int line)
 	return -ENODEV;
 }
 
-static int
+int
 gf119_fan_pwm_ctrl(struct nvkm_therm *therm, int line, bool enable)
 {
 	struct nvkm_device *device = therm->subdev.device;
@@ -63,7 +63,7 @@ gf119_fan_pwm_ctrl(struct nvkm_therm *therm, int line, bool enable)
 	return 0;
 }
 
-static int
+int
 gf119_fan_pwm_get(struct nvkm_therm *therm, int line, u32 *divs, u32 *duty)
 {
 	struct nvkm_device *device = therm->subdev.device;
@@ -85,7 +85,7 @@ gf119_fan_pwm_get(struct nvkm_therm *therm, int line, u32 *divs, u32 *duty)
 	return -EINVAL;
 }
 
-static int
+int
 gf119_fan_pwm_set(struct nvkm_therm *therm, int line, u32 divs, u32 duty)
 {
 	struct nvkm_device *device = therm->subdev.device;
@@ -102,7 +102,7 @@ gf119_fan_pwm_set(struct nvkm_therm *therm, int line, u32 divs, u32 duty)
 	return 0;
 }
 
-static int
+int
 gf119_fan_pwm_clock(struct nvkm_therm *therm, int line)
 {
 	struct nvkm_device *device = therm->subdev.device;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c
new file mode 100644
index 000000000000..79806a757893
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c
@@ -0,0 +1,135 @@
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
+#include "gk104.h"
+
+void
+gk104_clkgate_enable(struct nvkm_therm *base)
+{
+	struct gk104_therm *therm = gk104_therm(base);
+	struct nvkm_device *dev = therm->base.subdev.device;
+	const struct gk104_clkgate_engine_info *order = therm->clkgate_order;
+	int i;
+
+	/* Program ENG_MANT, ENG_FILTER */
+	for (i = 0; order[i].engine != NVKM_SUBDEV_NR; i++) {
+		if (!nvkm_device_subdev(dev, order[i].engine))
+			continue;
+
+		nvkm_mask(dev, 0x20200 + order[i].offset, 0xff00, 0x4500);
+	}
+
+	/* magic */
+	nvkm_wr32(dev, 0x020288, therm->idle_filter->fecs);
+	nvkm_wr32(dev, 0x02028c, therm->idle_filter->hubmmu);
+
+	/* Enable clockgating (ENG_CLK = RUN->AUTO) */
+	for (i = 0; order[i].engine != NVKM_SUBDEV_NR; i++) {
+		if (!nvkm_device_subdev(dev, order[i].engine))
+			continue;
+
+		nvkm_mask(dev, 0x20200 + order[i].offset, 0x00ff, 0x0045);
+	}
+}
+
+void
+gk104_clkgate_fini(struct nvkm_therm *base, bool suspend)
+{
+	struct gk104_therm *therm = gk104_therm(base);
+	struct nvkm_device *dev = therm->base.subdev.device;
+	const struct gk104_clkgate_engine_info *order = therm->clkgate_order;
+	int i;
+
+	/* ENG_CLK = AUTO->RUN, ENG_PWR = RUN->AUTO */
+	for (i = 0; order[i].engine != NVKM_SUBDEV_NR; i++) {
+		if (!nvkm_device_subdev(dev, order[i].engine))
+			continue;
+
+		nvkm_mask(dev, 0x20200 + order[i].offset, 0xff, 0x54);
+	}
+}
+
+const struct gk104_clkgate_engine_info gk104_clkgate_engine_info[] = {
+	{ NVKM_ENGINE_GR,     0x00 },
+	{ NVKM_ENGINE_MSPDEC, 0x04 },
+	{ NVKM_ENGINE_MSPPP,  0x08 },
+	{ NVKM_ENGINE_MSVLD,  0x0c },
+	{ NVKM_ENGINE_CE0,    0x10 },
+	{ NVKM_ENGINE_CE1,    0x14 },
+	{ NVKM_ENGINE_MSENC,  0x18 },
+	{ NVKM_ENGINE_CE2,    0x1c },
+	{ NVKM_SUBDEV_NR, 0 },
+};
+
+const struct gf100_idle_filter gk104_idle_filter = {
+	.fecs = 0x00001000,
+	.hubmmu = 0x00001000,
+};
+
+static const struct nvkm_therm_func
+gk104_therm_func = {
+	.init = gf119_therm_init,
+	.fini = g84_therm_fini,
+	.pwm_ctrl = gf119_fan_pwm_ctrl,
+	.pwm_get = gf119_fan_pwm_get,
+	.pwm_set = gf119_fan_pwm_set,
+	.pwm_clock = gf119_fan_pwm_clock,
+	.temp_get = g84_temp_get,
+	.fan_sense = gt215_therm_fan_sense,
+	.program_alarms = nvkm_therm_program_alarms_polling,
+	.clkgate_enable = gk104_clkgate_enable,
+	.clkgate_fini = gk104_clkgate_fini,
+};
+
+static int
+gk104_therm_new_(const struct nvkm_therm_func *func,
+		 struct nvkm_device *device,
+		 int index,
+		 const struct gk104_clkgate_engine_info *clkgate_order,
+		 const struct gf100_idle_filter *idle_filter,
+		 struct nvkm_therm **ptherm)
+{
+	struct gk104_therm *therm = kzalloc(sizeof(*therm), GFP_KERNEL);
+
+	if (!therm)
+		return -ENOMEM;
+
+	nvkm_therm_ctor(&therm->base, device, index, func);
+	*ptherm = &therm->base;
+	therm->clkgate_order = clkgate_order;
+	therm->idle_filter = idle_filter;
+
+	return 0;
+}
+
+int
+gk104_therm_new(struct nvkm_device *device,
+		int index, struct nvkm_therm **ptherm)
+{
+	return gk104_therm_new_(&gk104_therm_func, device, index,
+				gk104_clkgate_engine_info, &gk104_idle_filter,
+				ptherm);
+}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h
new file mode 100644
index 000000000000..293e7743b19b
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h
@@ -0,0 +1,48 @@
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
+#ifndef __GK104_THERM_H__
+#define __GK104_THERM_H__
+#define gk104_therm(p) (container_of((p), struct gk104_therm, base))
+
+#include <subdev/therm.h>
+#include "priv.h"
+#include "gf100.h"
+
+struct gk104_clkgate_engine_info {
+	enum nvkm_devidx engine;
+	u8 offset;
+};
+
+struct gk104_therm {
+	struct nvkm_therm base;
+
+	const struct gk104_clkgate_engine_info *clkgate_order;
+	const struct gf100_idle_filter *idle_filter;
+};
+
+extern const struct gk104_clkgate_engine_info gk104_clkgate_engine_info[];
+extern const struct gf100_idle_filter gk104_idle_filter;
+
+#endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
index 1f46e371d7c4..f30202dd88e7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
@@ -32,6 +32,8 @@
 
 int nvkm_therm_new_(const struct nvkm_therm_func *, struct nvkm_device *,
 		    int index, struct nvkm_therm **);
+void nvkm_therm_ctor(struct nvkm_therm *therm, struct nvkm_device *device,
+		     int index, const struct nvkm_therm_func *func);
 
 struct nvkm_fan {
 	struct nvkm_therm *parent;
@@ -66,8 +68,6 @@ int nvkm_therm_fan_set(struct nvkm_therm *, bool now, int percent);
 int nvkm_therm_fan_user_get(struct nvkm_therm *);
 int nvkm_therm_fan_user_set(struct nvkm_therm *, int percent);
 
-int nvkm_therm_preinit(struct nvkm_therm *);
-
 int  nvkm_therm_sensor_init(struct nvkm_therm *);
 int  nvkm_therm_sensor_fini(struct nvkm_therm *, bool suspend);
 void nvkm_therm_sensor_preinit(struct nvkm_therm *);
@@ -96,6 +96,9 @@ struct nvkm_therm_func {
 	int (*fan_sense)(struct nvkm_therm *);
 
 	void (*program_alarms)(struct nvkm_therm *);
+
+	void (*clkgate_enable)(struct nvkm_therm *);
+	void (*clkgate_fini)(struct nvkm_therm *, bool);
 };
 
 void nv40_therm_intr(struct nvkm_therm *);
@@ -112,8 +115,16 @@ void g84_therm_fini(struct nvkm_therm *);
 int gt215_therm_fan_sense(struct nvkm_therm *);
 
 void g84_therm_init(struct nvkm_therm *);
+
+int gf119_fan_pwm_ctrl(struct nvkm_therm *, int, bool);
+int gf119_fan_pwm_get(struct nvkm_therm *, int, u32 *, u32 *);
+int gf119_fan_pwm_set(struct nvkm_therm *, int, u32, u32);
+int gf119_fan_pwm_clock(struct nvkm_therm *, int);
 void gf119_therm_init(struct nvkm_therm *);
 
+void gk104_clkgate_enable(struct nvkm_therm *);
+void gk104_clkgate_fini(struct nvkm_therm *, bool);
+
 int nvkm_fanpwm_create(struct nvkm_therm *, struct dcb_gpio_func *);
 int nvkm_fantog_create(struct nvkm_therm *, struct dcb_gpio_func *);
 int nvkm_fannil_create(struct nvkm_therm *);
-- 
2.14.3
