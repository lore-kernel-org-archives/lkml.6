Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E0AC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E235A208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX0nZ/4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E235A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbeKTC5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbeKTC5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAEE220870;
        Mon, 19 Nov 2018 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645187;
        bh=pIjE03AXdBEJ6/ozBXc7uVxMdpt+sHAZo+b6Sb7Kpoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qX0nZ/4tkcz5njXMr8T+Qauxq6Eb6eDooBnIfuKAMEGJOjUoYadnEHFtJuUfB0ZBm
         TnEiLbKsiXT1eZnldZ/XhsTwtnFEWEDnxoji1Fqrk6CV1gvA5xrWJf5ieNjBuvFe0j
         7lLMGxaWuAwB2YJr4Q9RAp4xr4+cMWIUCVVdXzys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Sarnie <sarnex@gentoo.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 020/205] drm/amd/display: Raise dispclk value for dce120 by 15%
Date:   Mon, 19 Nov 2018 17:25:27 +0100
Message-Id: <20181119162620.982335916@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
@@ -466,6 +466,9 @@ static void dce12_update_clocks(struct d
 {
 	struct dm_pp_clock_for_voltage_req clock_voltage_req = {0};
 
+	/* TODO: Investigate why this is needed to fix display corruption. */
+	new_clocks->dispclk_khz = new_clocks->dispclk_khz * 115 / 100;
+
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, dccg->clks.dispclk_khz)) {
 		clock_voltage_req.clk_type = DM_PP_CLOCK_TYPE_DISPLAY_CLK;
 		clock_voltage_req.clocks_in_khz = new_clocks->dispclk_khz;


