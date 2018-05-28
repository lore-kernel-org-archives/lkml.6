Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422990AbeE1MPq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164969AbeE1LDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:03:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Monk Liu <Monk.Liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 456/496] drm/amdgpu: disable GFX ring and disable PQ wptr in hw_fini
Date: Mon, 28 May 2018 12:04:01 +0200
Message-Id: <20180528100339.126537472@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Monk Liu <Monk.Liu@amd.com>

[ Upstream commit 9f0178fb67699992d38601cb923b434f9986dd68 ]

otherwise there will be DMAR reading error comes out from CP since
GFX is still alive and CPC's WPTR_POLL is still enabled, which would
lead to DMAR read error.

fix:
we can hault CPG after hw_fini, but cannot halt CPC becaues KIQ
stil need to be alive to let RLCV invoke, but its WPTR_POLL could
be disabled.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2889,7 +2889,13 @@ static int gfx_v9_0_hw_fini(void *handle
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	if (amdgpu_sriov_vf(adev)) {
-		pr_debug("For SRIOV client, shouldn't do anything.\n");
+		gfx_v9_0_cp_gfx_enable(adev, false);
+		/* must disable polling for SRIOV when hw finished, otherwise
+		 * CPC engine may still keep fetching WB address which is already
+		 * invalid after sw finished and trigger DMAR reading error in
+		 * hypervisor side.
+		 */
+		WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 		return 0;
 	}
 	gfx_v9_0_cp_enable(adev, false);
