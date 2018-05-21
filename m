Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbeEUMLz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:11:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752990AbeEUMJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:24 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 22/33] drm/i915: use match_string() helper
Date: Mon, 21 May 2018 19:57:59 +0800
Message-ID: <1526903890-35761-23-git-send-email-xieyisheng1@huawei.com>
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

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/gpu/drm/i915/intel_pipe_crc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_pipe_crc.c b/drivers/gpu/drm/i915/intel_pipe_crc.c
index 1f5cd57..f6b1335 100644
--- a/drivers/gpu/drm/i915/intel_pipe_crc.c
+++ b/drivers/gpu/drm/i915/intel_pipe_crc.c
@@ -764,13 +764,12 @@ enum intel_pipe_crc_object {
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(pipe_crc_objects); i++)
-		if (!strcmp(buf, pipe_crc_objects[i])) {
-			*o = i;
-			return 0;
-		}
+	i = match_string(pipe_crc_objects, ARRAY_SIZE(pipe_crc_objects), buf);
+	if (i < 0)
+		return -EINVAL;
 
-	return -EINVAL;
+	*o = i;
+	return 0;
 }
 
 static int display_crc_ctl_parse_pipe(struct drm_i915_private *dev_priv,
@@ -796,13 +795,12 @@ static int display_crc_ctl_parse_pipe(struct drm_i915_private *dev_priv,
 		return 0;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(pipe_crc_sources); i++)
-		if (!strcmp(buf, pipe_crc_sources[i])) {
-			*s = i;
-			return 0;
-		}
+	i = match_string(pipe_crc_sources, ARRAY_SIZE(pipe_crc_sources), buf);
+	if (i < 0)
+		return -EINVAL;
 
-	return -EINVAL;
+	*s = i;
+	return 0;
 }
 
 static int display_crc_ctl_parse(struct drm_i915_private *dev_priv,
-- 
1.7.12.4
