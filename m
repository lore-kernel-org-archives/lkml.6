Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeBIV3S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:29:18 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46430 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbeBIV3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:29:17 -0500
X-Google-Smtp-Source: AH8x2270fxSHVAo5VKfGa+NjWiSPG+7bYf16JHD12LH3Di/AdOfXMQZO9eE6m66Ka62/HUbw7PmGSg==
From: Matthias Kaehlcke <mka@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] amdgpu/dc: Add missing cast in dce_clock_set_min_clocks_state()
Date: Fri,  9 Feb 2018 13:28:34 -0800
Message-Id: <20180209212834.72129-1-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dce_clock_set_min_clocks_state() assigns (intentionally) a value of type
'enum dm_pp_clocks_state' to a variable of type 'enum dm_pp_power_level'
without an explicit cast. This causes clang to raise the following
warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clocks.c:308:4: error:
  implicit conversion from enumeration type 'enum dm_pp_clocks_state'
  to different enumeration type 'enum dm_pp_power_level' [-Werror,-Wenum-conversion]
    clocks_state };

Make the cast explicit.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
index 9e98a5f39a6d..db3ceb283255 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
@@ -304,7 +304,8 @@ static bool dce_clock_set_min_clocks_state(
 	enum dm_pp_clocks_state clocks_state)
 {
 	struct dm_pp_power_level_change_request level_change_req = {
-			clocks_state };
+		.power_level = (enum dm_pp_power_level)clocks_state
+	};
 
 	if (clocks_state > clk->max_clks_state) {
 		/*Requested state exceeds max supported state.*/
-- 
2.16.0.rc1.238.g530d649a79-goog
