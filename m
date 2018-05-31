Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755137AbeEaLZU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:25:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754764AbeEaLWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:43 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "David Airlie" <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Arvind Yadav" <arvind.yadav.cs@gmail.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2 12/21] drm: i2c: ch7006: use match_string() helper
Date: Thu, 31 May 2018 19:11:17 +0800
Message-ID: <1527765086-19873-13-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: David Airlie <airlied@linux.ie>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - handle err case before normal case.

 drivers/gpu/drm/i2c/ch7006_drv.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
index 544a8a2..9eefdfe 100644
--- a/drivers/gpu/drm/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/i2c/ch7006_drv.c
@@ -464,16 +464,13 @@ static int ch7006_encoder_init(struct i2c_client *client,
 	priv->chip_version = ch7006_read(client, CH7006_VERSION_ID);
 
 	if (ch7006_tv_norm) {
-		for (i = 0; i < NUM_TV_NORMS; i++) {
-			if (!strcmp(ch7006_tv_norm_names[i], ch7006_tv_norm)) {
-				priv->norm = i;
-				break;
-			}
-		}
-
-		if (i == NUM_TV_NORMS)
+		i = match_string(ch7006_tv_norm_names,
+				 NUM_TV_NORMS, ch7006_tv_norm);
+		if (i < 0)
 			ch7006_err(client, "Invalid TV norm setting \"%s\".\n",
 				   ch7006_tv_norm);
+		else
+			priv->norm = i;
 	}
 
 	if (ch7006_scale >= 0 && ch7006_scale <= 2)
-- 
1.7.12.4
