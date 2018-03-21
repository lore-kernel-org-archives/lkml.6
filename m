Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeCUTHD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:07:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54549 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbeCUTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:07:00 -0400
From: Colin King <colin.king@canonical.com>
To: Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gvt: don't dereference 'workload' before null checking it
Date: Wed, 21 Mar 2018 19:06:53 +0000
Message-Id: <20180321190653.3829-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer workload is dereferenced before it is null checked, hence
there is a potential for a null pointer dereference on workload. Fix
this by only dereferencing workload after it is null checked.

Detected by CoverityScan, CID#1466017 ("Dereference before null check")

Fixes: fa3dd623e559 ("drm/i915/gvt: keep oa config in shadow ctx")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/gvt/scheduler.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 068126404151..f3010e365a48 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -60,9 +60,9 @@ static void set_context_pdp_root_pointer(
 static void sr_oa_regs(struct intel_vgpu_workload *workload,
 		u32 *reg_state, bool save)
 {
-	struct drm_i915_private *dev_priv = workload->vgpu->gvt->dev_priv;
-	u32 ctx_oactxctrl = dev_priv->perf.oa.ctx_oactxctrl_offset;
-	u32 ctx_flexeu0 = dev_priv->perf.oa.ctx_flexeu0_offset;
+	struct drm_i915_private *dev_priv;
+	u32 ctx_oactxctrl;
+	u32 ctx_flexeu0;
 	int i = 0;
 	u32 flex_mmio[] = {
 		i915_mmio_reg_offset(EU_PERF_CNTL0),
@@ -77,6 +77,10 @@ static void sr_oa_regs(struct intel_vgpu_workload *workload,
 	if (!workload || !reg_state || workload->ring_id != RCS)
 		return;
 
+	dev_priv = workload->vgpu->gvt->dev_priv;
+	ctx_oactxctrl = dev_priv->perf.oa.ctx_oactxctrl_offset;
+	ctx_flexeu0 = dev_priv->perf.oa.ctx_flexeu0_offset;
+
 	if (save) {
 		workload->oactxctrl = reg_state[ctx_oactxctrl + 1];
 
-- 
2.15.1
