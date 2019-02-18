Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0528E218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497581;
	bh=0H7uUrrRubL9hx1Kfc78n6GVhjDFR1pTSbDT+jNmRD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OJFtczqxuTBOdu2s4TW6nAZT1JurO3f9u7ctfMa2T71ZaR3WGtPHC4/WLoQkCtIgY
	 YuG0XSak5qZLmknwEpb6lJHau/prOHplM+dbDfT09N9RvSwh5vye3BGqbpo5vzthgj
	 nD0CW4inAKs4DoXK4gDKnygKh4NyjZy4b83rgiV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfBRNqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:46:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731559AbfBRNqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2627D217F5;
        Mon, 18 Feb 2019 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497573;
        bh=0H7uUrrRubL9hx1Kfc78n6GVhjDFR1pTSbDT+jNmRD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G35GjN+3U14qwPXuXNKAyng87dwEVDc8tp1re4HfVNq7/l3CSm72S+Ohr8UYC7Ax5
         2GiwyWN65hfBRwxwU8X9Oy3AnbOWBV8uvnm8WAoGcfplg2C1KFOJhGKwpced1rjwiL
         W1HHISitHZ86Fjsa782fBQgHEcJ/G1ZHeiRHvXo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 17/92] drm/amd/powerplay: avoid possible buffer overflow
Date:   Mon, 18 Feb 2019 14:42:20 +0100
Message-Id: <20190218133456.295495891@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



