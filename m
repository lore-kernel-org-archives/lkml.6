Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeBIXMn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:12:43 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43613 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeBIXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:12:41 -0500
X-Google-Smtp-Source: AH8x227tQx2gU1KQbzCPAHBXN5M2I7jvgUVIdMkF8EkL1O0TOeBVRfKPvijjnfzSrT9tGnCkEcE6Hg==
From: Matthias Kaehlcke <mka@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] amdgpu/dc: Remove unnecessary initialization in dc_link_handle_hpd_rx_irq()
Date: Fri,  9 Feb 2018 15:12:33 -0800
Message-Id: <20180209231233.107711-1-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization of 'result' is unnecessary, the variable is assigned
unconditionally a few lines below. Removing the initialization also fixes
the following warning when building with clang:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1931:26:
  error: implicit conversion from enumeration type 'enum ddc_result'
  to different enumeration type 'enum dc_status' [-Werror,-Wenum-conversion]
    enum dc_status result = DDC_RESULT_UNKNOWN;

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4ee4c03a6724..8e3a8c1395a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1926,7 +1926,7 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 {
 	union hpd_irq_data hpd_irq_dpcd_data = {{{{0}}}};
 	union device_service_irq device_service_clear = { { 0 } };
-	enum dc_status result = DDC_RESULT_UNKNOWN;
+	enum dc_status result;
 	bool status = false;
 	/* For use cases related to down stream connection status change,
 	 * PSR and device auto test, refer to function handle_sst_hpd_irq
-- 
2.16.0.rc1.238.g530d649a79-goog
