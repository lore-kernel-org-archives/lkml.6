Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0502ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6334321486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6334321486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbeIXSjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:39:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58642 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbeIXSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:39:54 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2AE21092;
        Mon, 24 Sep 2018 12:37:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 088/235] drm/amd/pp: Set Max clock level to display by default
Date:   Mon, 24 Sep 2018 13:51:14 +0200
Message-Id: <20180924113113.898793096@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rex Zhu <rex.zhu@amd.com>

[ Upstream commit 97e8f102f5a9123d30258e196c6c1ea29cf52e83 ]

avoid the error in dmesg:
[drm:dm_pp_get_static_clocks]
*ERROR* DM_PPLIB: invalid powerlevel state: 0!

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1020,7 +1020,7 @@ static int pp_get_display_power_level(vo
 static int pp_get_current_clocks(void *handle,
 		struct amd_pp_clock_info *clocks)
 {
-	struct amd_pp_simple_clock_info simple_clocks;
+	struct amd_pp_simple_clock_info simple_clocks = { 0 };
 	struct pp_clock_info hw_clocks;
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
@@ -1056,7 +1056,10 @@ static int pp_get_current_clocks(void *h
 	clocks->max_engine_clock_in_sr = hw_clocks.max_eng_clk;
 	clocks->min_engine_clock_in_sr = hw_clocks.min_eng_clk;
 
-	clocks->max_clocks_state = simple_clocks.level;
+	if (simple_clocks.level == 0)
+		clocks->max_clocks_state = PP_DAL_POWERLEVEL_7;
+	else
+		clocks->max_clocks_state = simple_clocks.level;
 
 	if (0 == phm_get_current_shallow_sleep_clocks(hwmgr, &hwmgr->current_ps->hardware, &hw_clocks)) {
 		clocks->max_engine_clock_in_sr = hw_clocks.max_eng_clk;
@@ -1159,6 +1162,8 @@ static int pp_get_display_mode_validatio
 	if (!hwmgr || !hwmgr->pm_en ||!clocks)
 		return -EINVAL;
 
+	clocks->level = PP_DAL_POWERLEVEL_7;
+
 	mutex_lock(&hwmgr->smu_lock);
 
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_DynamicPatchPowerState))


