Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EEBC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1144D20868
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHzs7hbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1144D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbeKDXHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbeKDXHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A24B20862;
        Sun,  4 Nov 2018 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339537;
        bh=LEGj17Jhyj6/B6t1PxLgpH0ZbEsQXEOMPsrRd7NOQRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHzs7hbMgGjVX9LnQ8z1cajBcV/sYuBeTCC9D9bMLUtG8Iihmp5K+J3q/p8PSGJnX
         iklh/xfEO8Cbn4kW853+NxJge1KycEOucg+R4Mq+1KUGaxDpzGGP3lF4Dpr+URR2rI
         TEFg6wtcEa2BQ/9/bxzCpjeMrFbJSecQ5eovHHh8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 32/57] drm/amd/display: Raise dispclk value for dce120 by 15%
Date:   Sun,  4 Nov 2018 08:51:19 -0500
Message-Id: <20181104135144.88324-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 481f576c6c21bf0446eaa23623ef0262e9a5387c ]

[Why]

The DISPCLK value was previously requested to be 15% higher for all
ASICs that went through the dce110 bandwidth code path. As part of a
refactoring of dce_clocks and the dce110 set bandwidth codepath this
was removed for power saving considerations.

That change caused display corruption under certain hardware
configurations with Vega10.

[How]

The 15% DISPCLK increase is brought back but only on dce110 for now.
This is should be a temporary workaround until the root cause is sorted
out for why this occurs on Vega (or other ASICs, if reported).

Tested-by: Nick Sarnie <sarnex@gentoo.org>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
index fb1f373d08a1..e798241fae37 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
@@ -466,6 +466,9 @@ static void dce12_update_clocks(struct dccg *dccg,
 {
 	struct dm_pp_clock_for_voltage_req clock_voltage_req = {0};
 
+	/* TODO: Investigate why this is needed to fix display corruption. */
+	new_clocks->dispclk_khz = new_clocks->dispclk_khz * 115 / 100;
+
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, dccg->clks.dispclk_khz)) {
 		clock_voltage_req.clk_type = DM_PP_CLOCK_TYPE_DISPLAY_CLK;
 		clock_voltage_req.clocks_in_khz = new_clocks->dispclk_khz;
-- 
2.17.1

