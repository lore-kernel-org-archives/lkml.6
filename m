Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2882621848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfBSHvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:51:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:10038 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfBSHvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:51:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="147958349"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2019 23:51:17 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yulei Zhang <yulei.zhang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 4/8] drm/i915/gvt: Retrieve the guest gm base address from PVINFO
Date:   Tue, 19 Feb 2019 02:46:02 -0500
Message-Id: <20190219074602.14215-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219074242.14015-1-yan.y.zhao@intel.com>
References: <20190219074242.14015-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yulei Zhang <yulei.zhang@intel.com>

As after migration the host gm base address will be changed due
to resource re-allocation, in order to make sure the guest gm
address doesn't change with that to retrieve the guest gm base
address from PVINFO.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 drivers/gpu/drm/i915/gvt/cfg_space.c |  3 ++-
 drivers/gpu/drm/i915/gvt/gtt.c       |  8 ++++----
 drivers/gpu/drm/i915/gvt/gvt.h       | 22 ++++++++++++++++++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/cfg_space.c b/drivers/gpu/drm/i915/gvt/cfg_space.c
index 19cf1bbe059d..272f8dba7b21 100644
--- a/drivers/gpu/drm/i915/gvt/cfg_space.c
+++ b/drivers/gpu/drm/i915/gvt/cfg_space.c
@@ -33,6 +33,7 @@
 
 #include "i915_drv.h"
 #include "gvt.h"
+#include "i915_pvinfo.h"
 
 enum {
 	INTEL_GVT_PCI_BAR_GTTMMIO = 0,
@@ -133,7 +134,7 @@ static int map_aperture(struct intel_vgpu *vgpu, bool map)
 	else
 		val = *(u32 *)(vgpu_cfg_space(vgpu) + PCI_BASE_ADDRESS_2);
 
-	first_gfn = (val + vgpu_aperture_offset(vgpu)) >> PAGE_SHIFT;
+	first_gfn = (val + vgpu_guest_aperture_offset(vgpu)) >> PAGE_SHIFT;
 
 	ret = intel_gvt_hypervisor_map_gfn_to_mfn(vgpu, first_gfn,
 						  aperture_pa >> PAGE_SHIFT,
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 8a5d26d1d402..753ad975c958 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -70,10 +70,10 @@ int intel_gvt_ggtt_gmadr_g2h(struct intel_vgpu *vgpu, u64 g_addr, u64 *h_addr)
 
 	if (vgpu_gmadr_is_aperture(vgpu, g_addr))
 		*h_addr = vgpu_aperture_gmadr_base(vgpu)
-			  + (g_addr - vgpu_aperture_offset(vgpu));
+			  + (g_addr - vgpu_guest_aperture_gmadr_base(vgpu));
 	else
 		*h_addr = vgpu_hidden_gmadr_base(vgpu)
-			  + (g_addr - vgpu_hidden_offset(vgpu));
+			  + (g_addr - vgpu_guest_hidden_gmadr_base(vgpu));
 	return 0;
 }
 
@@ -85,10 +85,10 @@ int intel_gvt_ggtt_gmadr_h2g(struct intel_vgpu *vgpu, u64 h_addr, u64 *g_addr)
 		return -EACCES;
 
 	if (gvt_gmadr_is_aperture(vgpu->gvt, h_addr))
-		*g_addr = vgpu_aperture_gmadr_base(vgpu)
+		*g_addr = vgpu_guest_aperture_gmadr_base(vgpu)
 			+ (h_addr - gvt_aperture_gmadr_base(vgpu->gvt));
 	else
-		*g_addr = vgpu_hidden_gmadr_base(vgpu)
+		*g_addr = vgpu_guest_hidden_gmadr_base(vgpu)
 			+ (h_addr - gvt_hidden_gmadr_base(vgpu->gvt));
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 8621d0f5fd26..1f5ef59a36ac 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -424,6 +424,20 @@ int intel_gvt_load_firmware(struct intel_gvt *gvt);
 #define vgpu_fence_base(vgpu) (vgpu->fence.base)
 #define vgpu_fence_sz(vgpu) (vgpu->fence.size)
 
+/* Aperture/GM space definitions for vGPU Guest view point */
+#define vgpu_guest_aperture_offset(vgpu) \
+	vgpu_vreg_t(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base))
+#define vgpu_guest_hidden_offset(vgpu)	\
+	vgpu_vreg_t(vgpu, vgtif_reg(avail_rs.nonmappable_gmadr.base))
+
+#define vgpu_guest_aperture_gmadr_base(vgpu) (vgpu_guest_aperture_offset(vgpu))
+#define vgpu_guest_aperture_gmadr_end(vgpu) \
+	(vgpu_guest_aperture_gmadr_base(vgpu) + vgpu_aperture_sz(vgpu) - 1)
+
+#define vgpu_guest_hidden_gmadr_base(vgpu) (vgpu_guest_hidden_offset(vgpu))
+#define vgpu_guest_hidden_gmadr_end(vgpu) \
+	(vgpu_guest_hidden_gmadr_base(vgpu) + vgpu_hidden_sz(vgpu) - 1)
+
 struct intel_vgpu_creation_params {
 	__u64 handle;
 	__u64 low_gm_sz;  /* in MB */
@@ -499,12 +513,12 @@ void intel_gvt_deactivate_vgpu(struct intel_vgpu *vgpu);
 
 /* validating GM functions */
 #define vgpu_gmadr_is_aperture(vgpu, gmadr) \
-	((gmadr >= vgpu_aperture_gmadr_base(vgpu)) && \
-	 (gmadr <= vgpu_aperture_gmadr_end(vgpu)))
+	((gmadr >= vgpu_guest_aperture_gmadr_base(vgpu)) && \
+	 (gmadr <= vgpu_guest_aperture_gmadr_end(vgpu)))
 
 #define vgpu_gmadr_is_hidden(vgpu, gmadr) \
-	((gmadr >= vgpu_hidden_gmadr_base(vgpu)) && \
-	 (gmadr <= vgpu_hidden_gmadr_end(vgpu)))
+	((gmadr >= vgpu_guest_hidden_gmadr_base(vgpu)) && \
+	 (gmadr <= vgpu_guest_hidden_gmadr_end(vgpu)))
 
 #define vgpu_gmadr_is_valid(vgpu, gmadr) \
 	 ((vgpu_gmadr_is_aperture(vgpu, gmadr) || \
-- 
2.17.1

