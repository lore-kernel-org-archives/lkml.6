Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932140AbeBVLsT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:48:19 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:46783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753716AbeBVLsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:48:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>, Monk Liu <monk.liu@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: fix drm_get_max_iomem type mismatch
Date: Thu, 22 Feb 2018 12:47:51 +0100
Message-Id: <20180222114804.1394300-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:dQbMdoy6l01x5BYi/1a3Eg9r5f5pXaHyIKXwxQLBzmGEO1OgDDg
 jgafhRtHgknWg9gUKahTxay6u5a+wi737Z08YdO9Zo2CpDSzBJZwW+GE8bOw7zJMQQKsigH
 DKg/1YO2aH9FGCAU3FF4+5b8KK+NEc4G8jKbpfAIdai0QKCrOe8jx1fBmf+W55cSZuHds95
 ZBxJX6tcN7IwHuFqbxefQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kthamrG6Y4s=:6Tq3+lk+2HikqJJmthMYf6
 KLxc5PAoa2Bq6SKAq5wzUp1DHuy4EogIUAtU28ouUpnZkMFM7lOQZeP+Jj+bdiAy1G4gOALCD
 BCiI/fXbffgwmZfnWmJb/L6udfYJHfH5PdphZ+a86/mTNWA3G3+chzkKGbG5Ue+hzx/PjGQuE
 /Zn3WIFjD++yOzubw9nj/95D6lZg/kxAWDqDKkmuubb+Vd98Ezk8+WdH8uBo4T4/Mmeo+O/FH
 Tldm6LaOysMAC7qLEWHzZYUaNm2XHqV1C8ygnht/exgRmrNYRAWNvBvvsoRg6pUgHKlU35apL
 YtEV7nHZHcRf8QKWn3ubKbOljgd/TvYw3kVjsF4++Xb+UqzC5U2Nz5SjgH+wJJtAhnQ0N48Zc
 tAmBDqaXmBKq4dobj5E9GVPDINgEbLkh6+SHSQcjlxzONvkV3cnV1mFUghvRMnPsOJwmJEhLM
 6P01Bm4HoSBkZZWe67tckM9S0xzsPv7V7lNW7UwswKk8vuCu6IrNqkeiNsdTeSuHqz7DSKd9m
 QOfoTJZrrXfCrfIp2IqXEDVjxD0BiDTe2paJ/SGc3c0AqFIu5vMW4VDaVcMZucYGluN3lnvfb
 nu8z1t5s5c6UqhXlfiu+4PoF9YzpCNAMAJYWqdEjTQXcNppTLo4Xfe5eAjrEFb4tOJpYWbM18
 DM2arKb/RDcHDi+9bwhrnWJZ4WNR8rf1v44GMTEI1TZTmw/3rPNCIbSDbTj2owt6IhOD7JqWG
 OcMsIxnKQW4fEwgzM85xmMecPmrAc2RfZilVwA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When comparing two variables with min()/max(), they should be the same type:

drivers/gpu/drm/drm_memory.c: In function 'drm_get_max_iomem':
include/linux/kernel.h:821:16: error: comparison of distinct pointer types lacks a cast [-Werror]
  (void) (&max1 == &max2);

This makes the local variable in drm_get_max_iomem make the type
from resource->end.

Fixes: 82626363a217 ("drm: add func to get max iomem address v2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/drm_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
index 7ca500b8c399..3c54044214db 100644
--- a/drivers/gpu/drm/drm_memory.c
+++ b/drivers/gpu/drm/drm_memory.c
@@ -153,7 +153,7 @@ EXPORT_SYMBOL(drm_legacy_ioremapfree);
 u64 drm_get_max_iomem(void)
 {
 	struct resource *tmp;
-	u64 max_iomem = 0;
+	resource_size_t max_iomem = 0;
 
 	for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling) {
 		max_iomem = max(max_iomem,  tmp->end);
-- 
2.9.0
