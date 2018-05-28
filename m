Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163320AbeE1Ktj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163537AbeE1Ktb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom St Denis <tom.stdenis@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 187/496] drm/amd/amdgpu: Correct VRAM width for APUs with GMC9
Date: Mon, 28 May 2018 11:59:32 +0200
Message-Id: <20180528100327.840413630@linuxfoundation.org>
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

From: Tom St Denis <tom.stdenis@amd.com>

[ Upstream commit 585b7f161c85bd5ca675b97580faf21c506541e3 ]

DDR4 has a 64-bit width not 128-bits.  It was reporting
twice the width.  Tested with my Ryzen 2400G.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -456,7 +456,10 @@ static int gmc_v9_0_mc_init(struct amdgp
 	adev->mc.vram_width = amdgpu_atomfirmware_get_vram_width(adev);
 	if (!adev->mc.vram_width) {
 		/* hbm memory channel size */
-		chansize = 128;
+		if (adev->flags & AMD_IS_APU)
+			chansize = 64;
+		else
+			chansize = 128;
 
 		tmp = RREG32_SOC15(DF, 0, mmDF_CS_AON0_DramBaseAddress0);
 		tmp &= DF_CS_AON0_DramBaseAddress0__IntLvNumChan_MASK;
