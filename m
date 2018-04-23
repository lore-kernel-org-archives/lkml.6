Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755612AbeDWOL2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:11:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2775 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755494AbeDWOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:11:17 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 2/4] drm/panel: otm8009a: fix glitches by moving backlight enable to otm8009a_enable()
Date: Mon, 23 Apr 2018 16:10:51 +0200
Message-ID: <20180423141054.13128-3-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180423141054.13128-1-philippe.cornu@st.com>
References: <20180423141054.13128-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The backlight 1st update was in the otm8009a_prepare() function
for a bad reason: backlight was not working in video mode and the
otm8009a_prepare() is in command mode for the init sequence. As the
backlight is now fixed (no lpm), it is good to put it back in the
otm8009a_enable() function, avoiding also image glitches visible
on some "slow" devices.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 0fd2e0144d2b..de4a16d5275c 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -330,13 +330,6 @@ static int otm8009a_prepare(struct drm_panel *panel)
 
 	ctx->prepared = true;
 
-	/*
-	 * Power on the backlight. Note: end-user still controls brightness
-	 * Note: ctx->prepared must be true before updating the backlight.
-	 */
-	ctx->bl_dev->props.power = FB_BLANK_UNBLANK;
-	backlight_update_status(ctx->bl_dev);
-
 	return 0;
 }
 
@@ -344,6 +337,16 @@ static int otm8009a_enable(struct drm_panel *panel)
 {
 	struct otm8009a *ctx = panel_to_otm8009a(panel);
 
+	if (ctx->enabled)
+		return 0;
+
+	/*
+	 * Power on the backlight. Note: end-user still controls brightness
+	 * Note: ctx->prepared must be true before updating the backlight.
+	 */
+	ctx->bl_dev->props.power = FB_BLANK_UNBLANK;
+	backlight_update_status(ctx->bl_dev);
+
 	ctx->enabled = true;
 
 	return 0;
-- 
2.15.1
