Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424194AbeE1LlP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423822AbeE1LL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:11:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 175/272] drm/meson: Fix an un-handled error path in meson_drv_bind_master()
Date: Mon, 28 May 2018 12:03:28 +0200
Message-Id: <20180528100255.442731300@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e770f6bf18182bc3af6ceec30189b6c323cbc157 ]

'drm_vblank_init()' can fail. So handle this (unlikely) error.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/6cbf3d70ac3904489c7194c895225c4103aebb96.1520885192.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/meson/meson_drv.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -230,7 +230,10 @@ static int meson_drv_bind_master(struct
 
 	priv->vsync_irq = platform_get_irq(pdev, 0);
 
-	drm_vblank_init(drm, 1);
+	ret = drm_vblank_init(drm, 1);
+	if (ret)
+		goto free_drm;
+
 	drm_mode_config_init(drm);
 	drm->mode_config.max_width = 3840;
 	drm->mode_config.max_height = 2160;
