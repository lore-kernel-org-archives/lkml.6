Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeEVONV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:13:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34687 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEVONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:13:20 -0400
X-Google-Smtp-Source: AB8JxZpzpp7Z2RV5AuE/2Rt46Sz4VeCpPI3gQ+B1j0Om171QF9/A/ZvOBKc7uJJw/4Am73dZgFCLUQ==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org
Cc: andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH] drm: Fix possible race conditions while unplugging DRM device
Date: Tue, 22 May 2018 17:13:04 +0300
Message-Id: <20180522141304.18646-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

When unplugging a hotpluggable DRM device we first unregister it
with drm_dev_unregister and then set drm_device.unplugged flag which
is used to mark device critical sections with drm_dev_enter()/
drm_dev_exit() preventing access to device resources that are not
available after the device is gone.
But drm_dev_unregister may lead to hotplug uevent(s) fired to
user-space on card and/or connector removal, thus making it possible
for user-space to try accessing a disconnected device.

Fix this by first making sure device is properly marked as
disconnected and only then unregister it.

Fixes: bee330f3d672 ("drm: Use srcu to protect drm_device.unplugged")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reported-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
---
 drivers/gpu/drm/drm_drv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index b553a6f2ff0e..7af748ed1c58 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -369,13 +369,6 @@ EXPORT_SYMBOL(drm_dev_exit);
  */
 void drm_dev_unplug(struct drm_device *dev)
 {
-	drm_dev_unregister(dev);
-
-	mutex_lock(&drm_global_mutex);
-	if (dev->open_count == 0)
-		drm_dev_put(dev);
-	mutex_unlock(&drm_global_mutex);
-
 	/*
 	 * After synchronizing any critical read section is guaranteed to see
 	 * the new value of ->unplugged, and any critical section which might
@@ -384,6 +377,13 @@ void drm_dev_unplug(struct drm_device *dev)
 	 */
 	dev->unplugged = true;
 	synchronize_srcu(&drm_unplug_srcu);
+
+	drm_dev_unregister(dev);
+
+	mutex_lock(&drm_global_mutex);
+	if (dev->open_count == 0)
+		drm_dev_put(dev);
+	mutex_unlock(&drm_global_mutex);
 }
 EXPORT_SYMBOL(drm_dev_unplug);
 
-- 
2.17.0
