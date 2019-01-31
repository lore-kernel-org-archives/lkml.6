Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B427C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C749720870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WLitOF91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfAaD6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:58:12 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:44719 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbfAaD6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:58:12 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x0V3utwP003571;
        Thu, 31 Jan 2019 12:56:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x0V3utwP003571
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548907016;
        bh=nA7OVdphXejFekmto7aFwQbHffCjYfYDnedm8HnxaZM=;
        h=From:To:Cc:Subject:Date:From;
        b=WLitOF91a8fQAbxsncIbPchdsRGX6JddUOgJ+fTMKUXgI6Z1zJY0N/gqwg/d5oUVW
         2mffSjUsUbZBpZZCWL5XEUqfFoC61jZ8C4k3cI9xiBaJY08yPDziSUzfWszqIs5dkV
         ieSeJ/ynfJufOOJZbNVqafo0WWO9tkLPGwPWKx0U32RmEHQx35nyi6jCo9+R2DPjJ4
         UKLJTDiZ0GrD648AjjyZMJFCRdDJLuxEovlmt8KXpIyxGR9AIHzE47e/sPusxEf86Z
         6NIX5IfiP3eLjf3kN3YtCgbmj+5nEK2e9Omh7EHMpnjSdqxliLxg6O4IhLu8cZv1vc
         lchc6657w1yIQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        freedreno@lists.freedesktop.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rob Clark <robdclark@gmail.com>, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gvt-dev@lists.freedesktop.org
Subject: [PATCH] drm: prefix header search paths with $(srctree)/
Date:   Thu, 31 Jan 2019 12:56:39 +0900
Message-Id: <1548906999-22143-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the Kbuild core manipulates header search paths in a crazy
way [1].

To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
the search paths in the srctree. Some Makefiles are already written in
that way, but not all. The goal of this work is to make the notation
consistent, and finally get rid of the gross hacks.

Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
("kbuild: do not drop -I without parameter").

[1]: https://patchwork.kernel.org/patch/9632347/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I put all gpu/drm changes into a single patch because
they are trivial conversion.

Please let me know if I need to split this into per-driver patches.


 drivers/gpu/drm/amd/amdgpu/Makefile | 2 +-
 drivers/gpu/drm/amd/lib/Makefile    | 2 +-
 drivers/gpu/drm/i915/gvt/Makefile   | 2 +-
 drivers/gpu/drm/msm/Makefile        | 6 +++---
 drivers/gpu/drm/nouveau/Kbuild      | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index f76bcb9..b21ebb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-FULL_AMD_PATH=$(src)/..
+FULL_AMD_PATH=$(srctree)/$(src)/..
 DISPLAY_FOLDER_NAME=display
 FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
 
diff --git a/drivers/gpu/drm/amd/lib/Makefile b/drivers/gpu/drm/amd/lib/Makefile
index 6902430..d534992 100644
--- a/drivers/gpu/drm/amd/lib/Makefile
+++ b/drivers/gpu/drm/amd/lib/Makefile
@@ -27,6 +27,6 @@
 # driver components or later moved to kernel/lib for sharing with
 # other drivers.
 
-ccflags-y := -I$(src)/../include
+ccflags-y := -I $(srctree)/$(src)/../include
 
 obj-$(CONFIG_CHASH) += chash.o
diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index b016dc7..a4a5a96 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -5,6 +5,6 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
 	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
 	fb_decoder.o dmabuf.o page_track.o
 
-ccflags-y				+= -I$(src) -I$(src)/$(GVT_DIR)
+ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
 i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
 obj-$(CONFIG_DRM_I915_GVT_KVMGT)	+= $(GVT_DIR)/kvmgt.o
diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 56a70c7..b7b1ebd 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -Idrivers/gpu/drm/msm
-ccflags-y += -Idrivers/gpu/drm/msm/disp/dpu1
-ccflags-$(CONFIG_DRM_MSM_DSI) += -Idrivers/gpu/drm/msm/dsi
+ccflags-y := -I $(srctree)/$(src)
+ccflags-y += -I $(srctree)/$(src)/disp/dpu1
+ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(srctree)/$(src)/dsi
 
 msm-y := \
 	adreno/adreno_device.o \
diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
index b17843d..b4bc88ad 100644
--- a/drivers/gpu/drm/nouveau/Kbuild
+++ b/drivers/gpu/drm/nouveau/Kbuild
@@ -1,7 +1,7 @@
-ccflags-y += -I$(src)/include
-ccflags-y += -I$(src)/include/nvkm
-ccflags-y += -I$(src)/nvkm
-ccflags-y += -I$(src)
+ccflags-y += -I $(srctree)/$(src)/include
+ccflags-y += -I $(srctree)/$(src)/include/nvkm
+ccflags-y += -I $(srctree)/$(src)/nvkm
+ccflags-y += -I $(srctree)/$(src)
 
 # NVKM - HW resource manager
 #- code also used by various userspace tools/tests
-- 
2.7.4

