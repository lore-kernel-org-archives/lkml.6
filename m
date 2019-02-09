Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772F5C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A0A20643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738632;
	bh=eKE2CzvghHkIspAUrkaXB6hPphI4rQhEYKHodqBP14Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2vT+sDlqsuDel1BM4bfJNxZT8rmDjaZZFge3AWdCp24wWNM7JH2pbHD/tH7vEHjHY
	 MNF1Dw4saDQDsMKT3GVwvewzEn/+B+jLdZZawROgt6OP5vxVMh3NzYYQ15qzPYUkJu
	 UO/yGAl5CA1DRnsiji1eSJNcqrycBTfTPKiBl8eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfBIS5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:57:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfBISru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8CD2192C;
        Sat,  9 Feb 2019 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738070;
        bh=eKE2CzvghHkIspAUrkaXB6hPphI4rQhEYKHodqBP14Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wt+Xnb44Z2zFdR/as0+ASqh2dLTNNcguH3ltP5bOUhqY9hUu+eVDfsh2cgHtQQJuP
         tmtAvU9gJktDWichKXTr+qer3r2oPwLoIaRIyeGZsG/2RCa8IzJPPeIndeTAroI8bj
         OY3mshq7YJTgj0KmFZrNNffJrTZ8+I32bEoT6Ru0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 14/42] drm/amd/powerplay: avoid possible buffer overflow
Date:   Sat,  9 Feb 2019 13:47:06 -0500
Message-Id: <20190209184734.125935-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit fff0d3f7686942bd544b53a48d1b76bd62c46946 ]

Make sure the clock level enforced is within the allowed
ranges.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 3b7fce5d7258..b9e19b0eb905 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -2244,6 +2244,13 @@ static int vega20_force_clock_level(struct pp_hwmgr *hwmgr,
 		soft_min_level = mask ? (ffs(mask) - 1) : 0;
 		soft_max_level = mask ? (fls(mask) - 1) : 0;
 
+		if (soft_max_level >= data->dpm_table.gfx_table.count) {
+			pr_err("Clock level specified %d is over max allowed %d\n",
+					soft_max_level,
+					data->dpm_table.gfx_table.count - 1);
+			return -EINVAL;
+		}
+
 		data->dpm_table.gfx_table.dpm_state.soft_min_level =
 			data->dpm_table.gfx_table.dpm_levels[soft_min_level].value;
 		data->dpm_table.gfx_table.dpm_state.soft_max_level =
@@ -2264,6 +2271,13 @@ static int vega20_force_clock_level(struct pp_hwmgr *hwmgr,
 		soft_min_level = mask ? (ffs(mask) - 1) : 0;
 		soft_max_level = mask ? (fls(mask) - 1) : 0;
 
+		if (soft_max_level >= data->dpm_table.mem_table.count) {
+			pr_err("Clock level specified %d is over max allowed %d\n",
+					soft_max_level,
+					data->dpm_table.mem_table.count - 1);
+			return -EINVAL;
+		}
+
 		data->dpm_table.mem_table.dpm_state.soft_min_level =
 			data->dpm_table.mem_table.dpm_levels[soft_min_level].value;
 		data->dpm_table.mem_table.dpm_state.soft_max_level =
-- 
2.19.1

