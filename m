Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82845C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4956F2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690344;
	bh=W8tcpiDPkLw1Y6TcS9TQUa3cX/RYD3g2gB7DXexROUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qEHBixrUloXeEGIrUDS6Rd8XvNEtBly84RWwwBY5JSzucg7pQa5mTiwH2vvhyn5RO
	 /kjUYno+YLYCHLZEAlT7tpaA1lXC2Hp9D+7HQ/JAQ/PSOfRhnj3WY3ZjE9QQ47o41f
	 J+MwjiAg/6QI+T+MdgT1D4MRiDBeKA4wem0VGmcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfA1Ppm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfA1Ppj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E05420880;
        Mon, 28 Jan 2019 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690338;
        bh=W8tcpiDPkLw1Y6TcS9TQUa3cX/RYD3g2gB7DXexROUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xMHV5RzqNIue0CrylLVSjOUYJ0vYX457Wec9i2xmdpzioPAdJYChdwCyu7wq0L9ll
         9YJZS/qsaxrtqSJ3tyTBvI7ALbGUFrZtY7FRanG44DBit4qmnX4n1SciUHnhMfQVZY
         IPnmaTfyVV2NgyNeCc2koblbWUJCwosedTUw/xfQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 056/304] drm/amd/display: calculate stream->phy_pix_clk before clock mapping
Date:   Mon, 28 Jan 2019 10:39:33 -0500
Message-Id: <20190128154341.47195-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>

[ Upstream commit 08e1c28dd521c7b08d1b0af0bae9fb22ccc012a4 ]

[why]
phy_pix_clk is one of the variable used to check if one PLL can be shared
with displays having common mode set configuration. As of now
phy_pix_clock varialbe is calculated in function dc_validate_stream().
dc_validate_stream() function is called after clocks are assigned for the
new display. Due to this during hotplug, when PLL sharing conditions are
checked for new display phy_pix_clk variable will be 0 and for displays
that are already enabled phy_pix_clk will have some value. Hence PLL will
not be shared and if the display hardware doesn't have any more PLL to
assign, mode set will fail due to resource unavailability.

[how]
Instead of only calculating the phy_pix_clk variable after the PLL is
assigned for new display, this patch calculates phy_pix_clk also during
the before assigning the PLL for new display.

Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b6fe29b9fb65..8bd8f34b979c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2002,6 +2002,8 @@ enum dc_status resource_map_pool_resources(
 		}
 	*/
 
+	calculate_phy_pix_clks(stream);
+
 	/* acquire new resources */
 	pipe_idx = acquire_first_free_pipe(&context->res_ctx, pool, stream);
 
-- 
2.19.1

