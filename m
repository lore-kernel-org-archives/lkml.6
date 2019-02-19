Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC43C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E757621848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfBSHtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:49:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:33604 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBSHtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:49:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:49:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="147957784"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2019 23:49:18 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yulei Zhang <yulei.zhang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 1/8] drm/i915/gvt: Apply g2h adjust for GTT mmio access
Date:   Tue, 19 Feb 2019 02:43:57 -0500
Message-Id: <20190219074357.14061-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219074242.14015-1-yan.y.zhao@intel.com>
References: <20190219074242.14015-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yulei Zhang <yulei.zhang@intel.com>

Apply guest to host gma conversion while guest try to access the
GTT mmio registers, as after enable live migration the host gma
will be changed due to the resourece re-allocation, but guest
gma should be remaining unchanged, thus g2h conversion is request
for it.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index c7103dd2d8d5..8a5d26d1d402 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -65,8 +65,7 @@ bool intel_gvt_ggtt_validate_range(struct intel_vgpu *vgpu, u64 addr, u32 size)
 /* translate a guest gmadr to host gmadr */
 int intel_gvt_ggtt_gmadr_g2h(struct intel_vgpu *vgpu, u64 g_addr, u64 *h_addr)
 {
-	if (WARN(!vgpu_gmadr_is_valid(vgpu, g_addr),
-		 "invalid guest gmadr %llx\n", g_addr))
+	if (!vgpu_gmadr_is_valid(vgpu, g_addr))
 		return -EACCES;
 
 	if (vgpu_gmadr_is_aperture(vgpu, g_addr))
@@ -2162,7 +2161,8 @@ static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 	struct intel_vgpu_mm *ggtt_mm = vgpu->gtt.ggtt_mm;
 	struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
 	unsigned long g_gtt_index = off >> info->gtt_entry_size_shift;
-	unsigned long gma, gfn;
+	unsigned long gfn;
+	unsigned long h_gtt_index;
 	struct intel_gvt_gtt_entry e, m;
 	dma_addr_t dma_addr;
 	int ret;
@@ -2172,10 +2172,8 @@ static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 	if (bytes != 4 && bytes != 8)
 		return -EINVAL;
 
-	gma = g_gtt_index << I915_GTT_PAGE_SHIFT;
-
 	/* the VM may configure the whole GM space when ballooning is used */
-	if (!vgpu_gmadr_is_valid(vgpu, gma))
+	if (intel_gvt_ggtt_index_g2h(vgpu, g_gtt_index, &h_gtt_index))
 		return 0;
 
 	e.type = GTT_TYPE_GGTT_PTE;
@@ -2259,11 +2257,12 @@ static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 out:
 	ggtt_set_guest_entry(ggtt_mm, &e, g_gtt_index);
 
-	ggtt_get_host_entry(ggtt_mm, &e, g_gtt_index);
+	ggtt_get_host_entry(ggtt_mm, &e, h_gtt_index);
 	ggtt_invalidate_pte(vgpu, &e);
 
-	ggtt_set_host_entry(ggtt_mm, &m, g_gtt_index);
+	ggtt_set_host_entry(ggtt_mm, &m, h_gtt_index);
 	ggtt_invalidate(gvt->dev_priv);
+
 	return 0;
 }
 
-- 
2.17.1

