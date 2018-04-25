Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756078AbeDYRnH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:43:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38841 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755295AbeDYRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:43:04 -0400
X-Google-Smtp-Source: AIpwx4/WAaGS06b58zpaZCPvJuQlZWciCCFK/G3EeJ7jKlUv84bzAoX+QA8CufyM9eJ0ruqIPBMJxw==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 1/6] backlight: Nuke unused backlight.props.state states
Date: Wed, 25 Apr 2018 19:42:48 +0200
Message-Id: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The backlight power state handling is supremely confusing. We have:
- props.power, using FB_BLANK_* defines
- props.fb_blank, using the same, but deprecated int favour of
  props.state
- props.state, using the BL_CORE_* defines
- and finally a bunch of backlight drivers treat brightness == 0 as
  off. But of course not all of them.

This is way too much confusion to fix in a simple patch, but at least
prevent more hilarity from spreading by removing the unused BL_CORE_*
defines. I have no idea why exactly anyone would need that.

Wrt the ideal state, we really just want a boolean state. The 4 power
saving states that the fbdev subsystem uses are overkill in todays hw
(this was only relevant for VGA and similar analog circuits like
TV-out), the new drm atomic modeset api simplified even the uapi to a
simple bool. And there was never a valid technical reason to have the
intermediate fbdev power states for backlights (those really only can
be either off or on).

Cleanup motivated by Meghana's questions about all this.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Meghana Madhyastha <meghana.madhyastha@gmail.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 include/linux/backlight.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 2baab6f3861d..1db67662bfcb 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -84,9 +84,6 @@ struct backlight_properties {
 
 #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
 #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
-#define BL_CORE_DRIVER4		(1 << 28)	/* reserved for driver specific use */
-#define BL_CORE_DRIVER3		(1 << 29)	/* reserved for driver specific use */
-#define BL_CORE_DRIVER2		(1 << 30)	/* reserved for driver specific use */
 #define BL_CORE_DRIVER1		(1 << 31)	/* reserved for driver specific use */
 
 };
-- 
2.17.0
