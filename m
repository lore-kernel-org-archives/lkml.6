Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4774C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD3C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfBSHvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:51:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:16836 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfBSHvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:51:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:51:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="147958373"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2019 23:51:29 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yulei Zhang <yulei.zhang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 5/8] drm/i915/gvt: Align the guest gm aperture start offset for live migration
Date:   Tue, 19 Feb 2019 02:46:10 -0500
Message-Id: <20190219074610.14260-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219074242.14015-1-yan.y.zhao@intel.com>
References: <20190219074242.14015-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yulei Zhang <yulei.zhang@intel.com>

As guest gm aperture region start offset is initialized when vGPU created,
in order to make sure that start offset is remain the same after migration,
align the aperture start offset to 0 for guest.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c |  3 +--
 drivers/gpu/drm/i915/gvt/vgpu.c  | 10 ++++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index c1072143da1d..223c67e87680 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1198,8 +1198,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 			sparse->header.version = 1;
 			sparse->nr_areas = nr_areas;
 			cap_type_id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
-			sparse->areas[0].offset =
-					PAGE_ALIGN(vgpu_aperture_offset(vgpu));
+			sparse->areas[0].offset = 0;
 			sparse->areas[0].size = vgpu_aperture_sz(vgpu);
 			break;
 
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index c628be05fbfe..fcccda35a456 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -48,8 +48,7 @@ void populate_pvinfo_page(struct intel_vgpu *vgpu)
 	vgpu_vreg_t(vgpu, vgtif_reg(vgt_caps)) |= VGT_CAPS_HWSP_EMULATION;
 	vgpu_vreg_t(vgpu, vgtif_reg(vgt_caps)) |= VGT_CAPS_HUGE_GTT;
 
-	vgpu_vreg_t(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base)) =
-		vgpu_aperture_gmadr_base(vgpu);
+	vgpu_vreg_t(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base)) = 0;
 	vgpu_vreg_t(vgpu, vgtif_reg(avail_rs.mappable_gmadr.size)) =
 		vgpu_aperture_sz(vgpu);
 	vgpu_vreg_t(vgpu, vgtif_reg(avail_rs.nonmappable_gmadr.base)) =
@@ -524,6 +523,9 @@ void intel_gvt_reset_vgpu_locked(struct intel_vgpu *vgpu, bool dmlr,
 {
 	struct intel_gvt *gvt = vgpu->gvt;
 	struct intel_gvt_workload_scheduler *scheduler = &gvt->scheduler;
+	u64 maddr = vgpu_vreg_t(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base));
+	u64 unmaddr = vgpu_vreg_t(vgpu,
+				vgtif_reg(avail_rs.nonmappable_gmadr.base));
 	unsigned int resetting_eng = dmlr ? ALL_ENGINES : engine_mask;
 
 	gvt_dbg_core("------------------------------------------\n");
@@ -556,6 +558,10 @@ void intel_gvt_reset_vgpu_locked(struct intel_vgpu *vgpu, bool dmlr,
 
 		intel_vgpu_reset_mmio(vgpu, dmlr);
 		populate_pvinfo_page(vgpu);
+		vgpu_vreg_t(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base)) =
+			maddr;
+		vgpu_vreg_t(vgpu, vgtif_reg(avail_rs.nonmappable_gmadr.base)) =
+			unmaddr;
 		intel_vgpu_reset_display(vgpu);
 
 		if (dmlr) {
-- 
2.17.1

