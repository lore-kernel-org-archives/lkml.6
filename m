Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032131AbeCAP0f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:26:35 -0500
Received: from gloria.sntech.de ([95.129.55.99]:48578 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032010AbeCAP03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:26:29 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org
Cc: Thierry Escande <thierry.escande@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sandy Huang <hjc@rock-chips.com>, linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: analogix_dp: reorder psr_unregister call in unbind
Date: Thu, 01 Mar 2018 16:25:58 +0100
Message-ID: <76025075.yWNtk1v57f@phil>
In-Reply-To: <20180110162348.22765-4-thierry.escande@collabora.com>
References: <20180110162348.22765-1-thierry.escande@collabora.com> <20180110162348.22765-4-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In bind the psr handler gets registered first before the core
analogix_dp_bind() gets called. So it should be the other way
around in unbind, first unbind the analogix_dp and then
unregister the psr.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 37250ab63bd7..eb88c52336a7 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -370,8 +377,8 @@ static void rockchip_dp_unbind(struct device *dev, struct device *master,
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
 
-	rockchip_drm_psr_unregister(&dp->encoder);
 	analogix_dp_unbind(dp->adp);
+	rockchip_drm_psr_unregister(&dp->encoder);
 	dp->encoder.funcs->destroy(&dp->encoder);
 }
 
-- 
2.15.1
