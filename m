Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754245AbeDWI4h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:56:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38426 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754130AbeDWI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:56:34 -0400
X-Google-Smtp-Source: AIpwx4/Uz0+DjzXtLC7vOuVLFdlL9kwwdEdUtRfIP+4J4Eba3CPleR98a/u1r3UyVDua83+zCDA7xA==
From: Tobias Regnery <tobias.regnery@gmail.com>
To: architt@codeaurora.org, a.hajda@samsung.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: m.purski@samsung.com, Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH] drm/bridge/sii8620: fix link error
Date: Mon, 23 Apr 2018 10:47:00 +0200
Message-Id: <20180423084700.27888-1-tobias.regnery@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_EXTCON=m and CONFIG_DRM_SIL_SII8620=y we see the following link
error:

drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_remove':
sil-sii8620.c:(.text+0xd5): undefined reference to `extcon_unregister_notifier'
drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_probe':
sil-sii8620.c:(.text+0x2a4b): undefined reference to `extcon_find_edev_by_node'
sil-sii8620.c:(.text+0x2af4): undefined reference to `extcon_register_notifier'
drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_extcon_work':
sil-sii8620.c:(.text+0x2b94): undefined reference to `extcon_get_state'

Fix this by selecting EXTCON.

Fixes: 688838442147 ("drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 3aa65bdecb0e..ab99e36ee034 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -74,6 +74,7 @@ config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF && RC_CORE
 	select DRM_KMS_HELPER
+	select EXTCON
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
 
-- 
2.17.0
