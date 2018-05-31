Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755153AbeEaLZX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:25:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754758AbeEaLWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:43 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Ben Skeggs" <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>
Subject: [PATCH v2 11/21] drm/nouveau: use match_string() helper
Date: Thu, 31 May 2018 19:11:16 +0800
Message-ID: <1527765086-19873-12-git-send-email-xieyisheng1@huawei.com>
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

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - handle err case before normal case - per Andy

 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 6d99f11..67ba2ac 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -644,16 +644,13 @@ static int nv17_tv_create_resources(struct drm_encoder *encoder,
 	int i;
 
 	if (nouveau_tv_norm) {
-		for (i = 0; i < num_tv_norms; i++) {
-			if (!strcmp(nv17_tv_norm_names[i], nouveau_tv_norm)) {
-				tv_enc->tv_norm = i;
-				break;
-			}
-		}
-
-		if (i == num_tv_norms)
+		i = match_string(nv17_tv_norm_names,
+				 num_tv_norms, nouveau_tv_norm);
+		if (i < 0)
 			NV_WARN(drm, "Invalid TV norm setting \"%s\"\n",
 				nouveau_tv_norm);
+		else
+			tv_enc->tv_norm = i;
 	}
 
 	drm_mode_create_tv_properties(dev, num_tv_norms, nv17_tv_norm_names);
-- 
1.7.12.4
