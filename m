Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBC62083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBC62083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbeIXSqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:46:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388693AbeIXSqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:46:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64D781099;
        Mon, 24 Sep 2018 12:44:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>, rex.zhu@amd.com,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for smu7/8
Date:   Mon, 24 Sep 2018 13:53:28 +0200
Message-Id: <20180924113125.488862921@linuxfoundation.org>
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

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit c3cb424a086921f6bb0449b10d998352a756d6d5 ]

The previous change wasn't covering smu 7 and 8 and therefore DC was
seeing wrong clock values.

This fixes an issue where the pipes seem to hang with a 4k DP and 1080p
HDMI display.

Fixes: c3df50abc84b ("drm/amd/pp: Convert clock unit to KHz as defined")
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Cc:rex.zhu@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |    8 ++++----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4555,12 +4555,12 @@ static int smu7_get_sclks(struct pp_hwmg
 			return -EINVAL;
 		dep_sclk_table = table_info->vdd_dep_on_sclk;
 		for (i = 0; i < dep_sclk_table->count; i++)
-			clocks->clock[i] = dep_sclk_table->entries[i].clk;
+			clocks->clock[i] = dep_sclk_table->entries[i].clk * 10;
 		clocks->count = dep_sclk_table->count;
 	} else if (hwmgr->pp_table_version == PP_TABLE_V0) {
 		sclk_table = hwmgr->dyn_state.vddc_dependency_on_sclk;
 		for (i = 0; i < sclk_table->count; i++)
-			clocks->clock[i] = sclk_table->entries[i].clk;
+			clocks->clock[i] = sclk_table->entries[i].clk * 10;
 		clocks->count = sclk_table->count;
 	}
 
@@ -4592,7 +4592,7 @@ static int smu7_get_mclks(struct pp_hwmg
 			return -EINVAL;
 		dep_mclk_table = table_info->vdd_dep_on_mclk;
 		for (i = 0; i < dep_mclk_table->count; i++) {
-			clocks->clock[i] = dep_mclk_table->entries[i].clk;
+			clocks->clock[i] = dep_mclk_table->entries[i].clk * 10;
 			clocks->latency[i] = smu7_get_mem_latency(hwmgr,
 						dep_mclk_table->entries[i].clk);
 		}
@@ -4600,7 +4600,7 @@ static int smu7_get_mclks(struct pp_hwmg
 	} else if (hwmgr->pp_table_version == PP_TABLE_V0) {
 		mclk_table = hwmgr->dyn_state.vddc_dependency_on_mclk;
 		for (i = 0; i < mclk_table->count; i++)
-			clocks->clock[i] = mclk_table->entries[i].clk;
+			clocks->clock[i] = mclk_table->entries[i].clk * 10;
 		clocks->count = mclk_table->count;
 	}
 	return 0;
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
@@ -1605,17 +1605,17 @@ static int smu8_get_clock_by_type(struct
 	switch (type) {
 	case amd_pp_disp_clock:
 		for (i = 0; i < clocks->count; i++)
-			clocks->clock[i] = data->sys_info.display_clock[i];
+			clocks->clock[i] = data->sys_info.display_clock[i] * 10;
 		break;
 	case amd_pp_sys_clock:
 		table = hwmgr->dyn_state.vddc_dependency_on_sclk;
 		for (i = 0; i < clocks->count; i++)
-			clocks->clock[i] = table->entries[i].clk;
+			clocks->clock[i] = table->entries[i].clk * 10;
 		break;
 	case amd_pp_mem_clock:
 		clocks->count = SMU8_NUM_NBPMEMORYCLOCK;
 		for (i = 0; i < clocks->count; i++)
-			clocks->clock[i] = data->sys_info.nbp_memory_clock[clocks->count - 1 - i];
+			clocks->clock[i] = data->sys_info.nbp_memory_clock[clocks->count - 1 - i] * 10;
 		break;
 	default:
 		return -1;


