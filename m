Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeCUS1A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:27:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53893 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeCUS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:26:57 -0400
From: Colin King <colin.king@canonical.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pp: use mlck_table.count for array loop index limit
Date: Wed, 21 Mar 2018 18:26:53 +0000
Message-Id: <20180321182653.3150-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The for-loops process data in the mclk_table but use slck_table.count
as the loop index limit.  I believe these are cut-n-paste errors from
the previous almost identical loops as indicated by static analysis.
Fix these.

Detected by CoverityScan, CID#1466001 ("Copy-paste error")

Fixes: 5d97cf39ff24 ("drm/amd/pp: Add and initialize OD_dpm_table for CI/VI.")
Fixes: 5e4d4fbea557 ("drm/amd/pp: Implement edit_dpm_table on smu7")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index df2a312ca6c9..d1983273ec7c 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -855,7 +855,7 @@ static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 
 	odn_table->odn_memory_clock_dpm_levels.num_of_pl =
 						data->golden_dpm_table.mclk_table.count;
-	for (i=0; i<data->golden_dpm_table.sclk_table.count; i++) {
+	for (i=0; i<data->golden_dpm_table.mclk_table.count; i++) {
 		odn_table->odn_memory_clock_dpm_levels.entries[i].clock =
 					data->golden_dpm_table.mclk_table.dpm_levels[i].value;
 		odn_table->odn_memory_clock_dpm_levels.entries[i].enabled = true;
@@ -4735,7 +4735,7 @@ static void smu7_check_dpm_table_updated(struct pp_hwmgr *hwmgr)
 		}
 	}
 
-	for (i=0; i<data->dpm_table.sclk_table.count; i++) {
+	for (i=0; i<data->dpm_table.mclk_table.count; i++) {
 		if (odn_table->odn_memory_clock_dpm_levels.entries[i].clock !=
 					data->dpm_table.mclk_table.dpm_levels[i].value) {
 			data->need_update_smu7_dpm_table |= DPMTABLE_OD_UPDATE_MCLK;
-- 
2.15.1
