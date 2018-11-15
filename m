Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1C9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D82208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D82208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbeKOXs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:48:26 -0500
Received: from 8bytes.org ([81.169.241.247]:40174 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbeKOXs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:48:26 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 26C48402; Thu, 15 Nov 2018 14:40:31 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, David1.Zhou@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] drm/amd/powerplay:  Ratelimit all "was not implemented" messages
Date:   Thu, 15 Nov 2018 14:40:29 +0100
Message-Id: <20181115134029.25675-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Running kfdtest on an AMD Carizzo flooded the kernel log
with thousands of these "was not implemented" messages,
making it impossible to see other messages there.

Ratelimit the messages to prevent user-space from flooding
the kernel log.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 52 +++++++++++++--------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index d6aa1d414320..b68c2e0fef01 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -300,7 +300,7 @@ static int pp_set_clockgating_by_smu(void *handle, uint32_t msg_id)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->update_clock_gatings == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 
@@ -387,7 +387,7 @@ static uint32_t pp_dpm_get_sclk(void *handle, bool low)
 		return 0;
 
 	if (hwmgr->hwmgr_func->get_sclk == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -405,7 +405,7 @@ static uint32_t pp_dpm_get_mclk(void *handle, bool low)
 		return 0;
 
 	if (hwmgr->hwmgr_func->get_mclk == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -422,7 +422,7 @@ static void pp_dpm_powergate_vce(void *handle, bool gate)
 		return;
 
 	if (hwmgr->hwmgr_func->powergate_vce == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -438,7 +438,7 @@ static void pp_dpm_powergate_uvd(void *handle, bool gate)
 		return;
 
 	if (hwmgr->hwmgr_func->powergate_uvd == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -505,7 +505,7 @@ static void pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
 		return;
 
 	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -522,7 +522,7 @@ static uint32_t pp_dpm_get_fan_control_mode(void *handle)
 		return 0;
 
 	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -540,7 +540,7 @@ static int pp_dpm_set_fan_speed_percent(void *handle, uint32_t percent)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_fan_speed_percent == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -558,7 +558,7 @@ static int pp_dpm_get_fan_speed_percent(void *handle, uint32_t *speed)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->get_fan_speed_percent == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 
@@ -594,7 +594,7 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -720,7 +720,7 @@ static int pp_dpm_force_clock_level(void *handle,
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->force_clock_level == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 
@@ -745,7 +745,7 @@ static int pp_dpm_print_clock_levels(void *handle,
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->print_clock_levels == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -763,7 +763,7 @@ static int pp_dpm_get_sclk_od(void *handle)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->get_sclk_od == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -781,7 +781,7 @@ static int pp_dpm_set_sclk_od(void *handle, uint32_t value)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_sclk_od == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 
@@ -800,7 +800,7 @@ static int pp_dpm_get_mclk_od(void *handle)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->get_mclk_od == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -818,7 +818,7 @@ static int pp_dpm_set_mclk_od(void *handle, uint32_t value)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_mclk_od == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
@@ -878,7 +878,7 @@ static int pp_get_power_profile_mode(void *handle, char *buf)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->get_power_profile_mode == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return snprintf(buf, PAGE_SIZE, "\n");
 	}
 
@@ -894,7 +894,7 @@ static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
 		return ret;
 
 	if (hwmgr->hwmgr_func->set_power_profile_mode == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return ret;
 	}
 
@@ -917,7 +917,7 @@ static int pp_odn_edit_dpm_table(void *handle, uint32_t type, long *input, uint3
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->odn_edit_dpm_table == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
 	}
 
@@ -935,7 +935,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_power_profile_mode == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
 	}
 
@@ -972,7 +972,7 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_power_limit == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1212,7 +1212,7 @@ static int pp_dpm_powergate_mmhub(void *handle)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->powergate_mmhub == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 
@@ -1227,7 +1227,7 @@ static int pp_dpm_powergate_gfx(void *handle, bool gate)
 		return 0;
 
 	if (hwmgr->hwmgr_func->powergate_gfx == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 
@@ -1242,7 +1242,7 @@ static void pp_dpm_powergate_acp(void *handle, bool gate)
 		return;
 
 	if (hwmgr->hwmgr_func->powergate_acp == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
 	}
 
@@ -1257,7 +1257,7 @@ static void pp_dpm_powergate_sdma(void *handle, bool gate)
 		return;
 
 	if (hwmgr->hwmgr_func->powergate_sdma == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
 	}
 
@@ -1303,7 +1303,7 @@ static int pp_notify_smu_enable_pwe(void *handle)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->smus_notify_pwe == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return -EINVAL;;
 	}
 
-- 
2.13.7

