Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeEUMJd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:09:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753000AbeEUMJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:25 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH 24/33] drm: use match_string() helper
Date: Mon, 21 May 2018 19:58:01 +0800
Message-ID: <1526903890-35761-25-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 902cc1a..3367c36 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -136,7 +136,6 @@ int drm_get_panel_orientation_quirk(int width, int height)
 	const struct dmi_system_id *match;
 	const struct drm_dmi_panel_orientation_data *data;
 	const char *bios_date;
-	int i;
 
 	for (match = dmi_first_match(orientation_data);
 	     match;
@@ -154,10 +153,8 @@ int drm_get_panel_orientation_quirk(int width, int height)
 		if (!bios_date)
 			continue;
 
-		for (i = 0; data->bios_dates[i]; i++) {
-			if (!strcmp(data->bios_dates[i], bios_date))
-				return data->orientation;
-		}
+		if (match_string(data->bios_dates, -1, bios_date) >= 0)
+			return data->orientation;
 	}
 
 	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
-- 
1.7.12.4
