Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC70C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA8D20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901436;
	bh=8bdwF+H/m3crtHWEaSx6fgOJ9F/m5B2m9UukNZW6VXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WHaVs2f0J3Ou1Kyw2H0DoXfOQ6iMM0Kpd9pW8yaj+v9pTt47C1AKBSW87aaPRFqLX
	 1pnswvDp2NxN8Zl9tE0dJz3KI3xsHlOfbyhrRc7A8V2xJlnPk8KF/hMUetubRsPm4A
	 Y1O7btIl8TV1vddqZi06HNURdJqysHaHx38onBDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfBKOYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbfBKOY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5AA20821;
        Mon, 11 Feb 2019 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895067;
        bh=8bdwF+H/m3crtHWEaSx6fgOJ9F/m5B2m9UukNZW6VXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FhvUiZburV3DB2si/1vQ5xoY0RJJCJFmbB+syhOlY0Hrn+4jdOA40zaHEDWrO4pJp
         PdfyWvZgwSOXRpZBzlWMOXEEs70RpR7eecKQcooY8hgo9iZNYuiv4hf6942F4C71dt
         AzvclTEMc4Ieg4kRMs1GMEvAjbCN0kMvJlDENGck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 050/352] drm/amd/display: calculate stream->phy_pix_clk before clock mapping
Date:   Mon, 11 Feb 2019 15:14:37 +0100
Message-Id: <20190211141849.425789844@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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



