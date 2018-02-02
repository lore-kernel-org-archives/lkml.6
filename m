Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeBBNFK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:05:10 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.31]:40904 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750773AbeBBNFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:05:04 -0500
Date: Fri, 2 Feb 2018 06:42:33 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Lloyd Atkinson <latkinso@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/msm/dsi: Fix potential NULL pointer dereference in
 msm_dsi_modeset_init
Message-ID: <20180202124233.GA5056@embeddedor.com>
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
X-Source-IP: 189.152.201.65
X-Source-L: No
X-Exim-ID: 1ehafq-0023dk-Ja
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.201.65]:44582
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_dev_ is being dereferenced before it is null checked, hence there
is a potential null pointer dereference.

Fix this by moving the pointer dereference after _dev_ has been
null checked.

Fixes: d4e7f38d70ef ("drm/msm/dsi: check msm_dsi and dsi pointers before use")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/msm/dsi/dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index ee7e090..b744bcc 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -192,13 +192,14 @@ void __exit msm_dsi_unregister(void)
 int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
 			 struct drm_encoder *encoder)
 {
-	struct msm_drm_private *priv = dev->dev_private;
+	struct msm_drm_private *priv;
 	struct drm_bridge *ext_bridge;
 	int ret;
 
 	if (WARN_ON(!encoder) || WARN_ON(!msm_dsi) || WARN_ON(!dev))
 		return -EINVAL;
 
+	priv = dev->dev_private;
 	msm_dsi->dev = dev;
 
 	ret = msm_dsi_host_modeset_init(msm_dsi->host, dev);
-- 
2.7.4
