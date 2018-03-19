Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968423AbeCSTbD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:31:03 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.251]:23871 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S968009AbeCSTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:30:57 -0400
Date: Mon, 19 Mar 2018 14:30:53 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915/gvt/scheduler: fix potential NULL pointer
 dereference
Message-ID: <20180319193053.GA7016@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.36.34
X-Source-L: No
X-Exim-ID: 1ey0Uh-0041gY-6N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.145.36.34]:37902
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_workload_ is being dereferenced before it is null checked, hence
there is a potential null pointer dereference.

Fix this by moving the pointer dereference after _workload_ has
been null checked.

Addresses-Coverity-ID: 1430136 ("Dereference before null check")
Fixes: fa3dd623e559 ("drm/i915/gvt: keep oa config in shadow ctx")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/gvt/scheduler.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 0681264..be1a297 100644
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
2.7.4
