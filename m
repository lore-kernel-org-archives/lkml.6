Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC21C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472ED21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBSHu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:50:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:23058 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBSHu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:50:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="147958255"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2019 23:50:56 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yulei Zhang <yulei.zhang@intel.com>
Subject: [PATCH 2/8] drm/i915/gvt: Apply g2h adjustment during fence mmio access
Date:   Tue, 19 Feb 2019 02:45:41 -0500
Message-Id: <20190219074541.14125-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219074242.14015-1-yan.y.zhao@intel.com>
References: <20190219074242.14015-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yulei Zhang <yulei.zhang@intel.com>

Apply the guest to host gma conversion while guest config the
fence mmio registers due to the host gma change after the migration.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/aperture_gm.c |  6 ++++--
 drivers/gpu/drm/i915/gvt/gvt.h         | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/aperture_gm.c b/drivers/gpu/drm/i915/gvt/aperture_gm.c
index 359d37d5c958..123c475f2f6e 100644
--- a/drivers/gpu/drm/i915/gvt/aperture_gm.c
+++ b/drivers/gpu/drm/i915/gvt/aperture_gm.c
@@ -146,8 +146,10 @@ void intel_vgpu_write_fence(struct intel_vgpu *vgpu,
 	I915_WRITE(fence_reg_lo, 0);
 	POSTING_READ(fence_reg_lo);
 
-	I915_WRITE(fence_reg_hi, upper_32_bits(value));
-	I915_WRITE(fence_reg_lo, lower_32_bits(value));
+	I915_WRITE(fence_reg_hi,
+		intel_gvt_reg_g2h(vgpu, upper_32_bits(value), 0xFFFFF000));
+	I915_WRITE(fence_reg_lo,
+		intel_gvt_reg_g2h(vgpu, lower_32_bits(value), 0xFFFFF000));
 	POSTING_READ(fence_reg_lo);
 }
 
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index b4ab1dad0143..8621d0f5fd26 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -530,6 +530,20 @@ int intel_gvt_ggtt_index_g2h(struct intel_vgpu *vgpu, unsigned long g_index,
 int intel_gvt_ggtt_h2g_index(struct intel_vgpu *vgpu, unsigned long h_index,
 			     unsigned long *g_index);
 
+/* apply guest to host gma conversion in GM registers setting */
+static inline u64 intel_gvt_reg_g2h(struct intel_vgpu *vgpu,
+		u32 addr, u32 mask)
+{
+	u64 gma;
+
+	if (addr) {
+		intel_gvt_ggtt_gmadr_g2h(vgpu,
+				addr & mask, &gma);
+		addr = gma | (addr & (~mask));
+	}
+	return addr;
+}
+
 void intel_vgpu_init_cfg_space(struct intel_vgpu *vgpu,
 		bool primary);
 void intel_vgpu_reset_cfg_space(struct intel_vgpu *vgpu);
-- 
2.17.1

