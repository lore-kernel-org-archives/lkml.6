Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0953C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F15C20449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298509;
	bh=ebzs3UZIi6TeWygCAtnXRdoCKXR3Wj+mYg26DOaOIYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fLxf99Tcjo8X0RIOrXatUVLv13UUI44sjlm+mWwo2IUbvVAlqVlnHxgfkJKqhx3pi
	 jrpnq9vqyTg62FgY/CB4q1HMPd22e/1G7I83Gqa3A3ptVxgdAWvNV+GK9J1dwBwUu+
	 UCx5cfzDVTCv9nwODGfKJyeKHoadcj6GQKqtpFps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbeLTJfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbeLTJ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0936321852;
        Thu, 20 Dec 2018 09:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298134;
        bh=ebzs3UZIi6TeWygCAtnXRdoCKXR3Wj+mYg26DOaOIYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6L/MFU6q+h1aGKVwVPm/YMcTIWE0l+H9Cx4ygET6vdConXw3nOVnD7WxzopgwZRR
         5CDrQnNMcA+RTboc2DLkCKUWRBaw/2G5ON5Ton+yzWqXt+Uarqvox9qjFiKmQAMVHQ
         BZK2XjqkU1VXx4C8dzZW5EFtFmG2bJM0U0hYIpKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hersen Wu <hersenxs.wu@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Roman Li <Roman.Li@amd.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 12/67] drm/amd/display: Fix 6x4K displays light-up on Vega20 (v2)
Date:   Thu, 20 Dec 2018 10:18:24 +0100
Message-Id: <20181220085904.051223633@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c6888879fd55b1ba903c2a770127edbf6aef6f27 ]

[Why]
More than 4x4K didn't lightup on Vega20 due to low dcfclk value.
Powerplay expects valid min requirement for dcfclk from DC.

[How]
Update min_dcfclock_khz based on min_engine_clock value.

v2: backport to 4.20 (Alex)

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index b2f308766a9e..0941f3c689bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2530,6 +2530,8 @@ static void pplib_apply_display_requirements(
 			dc,
 			context->bw.dce.sclk_khz);
 
+	pp_display_cfg->min_dcfclock_khz = pp_display_cfg->min_engine_clock_khz;
+
 	pp_display_cfg->min_engine_clock_deep_sleep_khz
 			= context->bw.dce.sclk_deep_sleep_khz;
 
-- 
2.19.1



