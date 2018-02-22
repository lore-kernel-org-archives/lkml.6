Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933396AbeBVQYg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:24:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:49003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933144AbeBVQYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:24:34 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Eric Anholt <eric@anholt.net>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Stephen Boyd <sboyd@codeaurora.org>, Tom Cooksey <tom.cooksey@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/p[111: add CONFIG_OF dependency
Date: Thu, 22 Feb 2018 17:24:12 +0100
Message-Id: <20180222162420.2825703-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:C0Ve3z5kMbT8xht35nFnAXfN1DuUMBOkIx5+QP0APTPNTzMFNxl
 Bao3pA89Bj5Rp2vS+j6I9ug4YJX+eu+u9S6btAgS6NCK8C5vn0KUS6E21JtZriMjrlyJW2p
 qL6dAYipKkFMznlmrErYaJn9IMzs1kobnST4HnCGfHfExz5J3kLCrfJP+7dMyCY9Mj4pN3U
 QsuvZUBMRf6RdLgq/7mNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2x5eDpCYRMU=:Qqq1kK5wSCaqmARjiC5Ms7
 LbBM/ZSmADLwdBQ0gn2qNvnnBdTNepgK+WFkwGvSniAZz4C9vHsNo2//gsFCJnLM2/QzDmsXR
 S3Cc6bvz+iHYPF+l0U7vP69x2HuOeoWzAAiLB+2+k2kGFfKfbP/EPfyoltJ8q3kE4sigJ+rLd
 6+TfoXAo3zjEKllL355zW2zMRr458uJyJiYOOGOBgRrErcjqxvAdsK9LbkQLe+HV2gxog52lh
 0Kjumx2rJupB5ABnT23xW7lR3z0dkboanxVSP72PeC59zuWuQ24jl1UHLmkEYqhL9ENmLbYOt
 Ic1bA4rswbCmZQgbAMkalcK9iOTkRvbYgS/do4kM5h34GZ2jkTGw9MnwHC9N6TLbodLSzIByF
 v3BSCKWmY3tMpKgGIUtIcRupH6nRb9aCdmHRq4cFbSvhs0IqZcN8WUg/qMLqvPxweG3w0ROuw
 EuI44w3RfuBo9EXlF4HXKCe5gQlvkS+Q6Fc3xPap1DqaDNhBzVFLLrb9o57+3AAHPOiuo9rlF
 Meyziacs1gTSF1lfBr6Px3zLqbD1oHYfPzLLpYnM8iyk4NTMxlDCsWG82BnGihaPbQsSrEKj6
 EHSPGvW5Ne5ooM8bdGNWSYNG3d63BT3HYeCiFLkpNE1MlKk5h/RpiazGX1wKDX8a8Qh3LgH4z
 ZsOK/tcGlo+Fp3WwcklGx6mduOL7HOBFzSE5AMz2Llr/tw+ACs46SgKTYRUI+OJ7somB8Kh/r
 wpXE7ZjUcrLsUAAyEqSJeKNypYH7Dy/Ap2IRcw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot select a symbol without meeting its other dependencies:

warning: (DRM_PL111) selects DRM_DUMB_VGA_DAC which has unmet direct dependencies (HAS_IOMEM && DRM && DRM_BRIDGE && OF)
drivers/gpu/drm/bridge/dumb-vga-dac.c: In function 'dumb_vga_probe':
drivers/gpu/drm/bridge/dumb-vga-dac.c:207:13: error: 'struct drm_bridge' has no member named 'of_node'
  vga->bridge.of_node = pdev->dev.of_node;
             ^

Here it seems reasonable to depend on CONFIG_OF, as all platforms
using this driver already require that anyway.

Fixes: 49f81d80ab84 ("drm/pl111: Support handling bridge timings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/pl111/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
index 82cb3e60ddc8..776448e8d4ee 100644
--- a/drivers/gpu/drm/pl111/Kconfig
+++ b/drivers/gpu/drm/pl111/Kconfig
@@ -3,6 +3,7 @@ config DRM_PL111
 	depends on DRM
 	depends on ARM || ARM64 || COMPILE_TEST
 	depends on COMMON_CLK
+	depends on OF
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
-- 
2.9.0
