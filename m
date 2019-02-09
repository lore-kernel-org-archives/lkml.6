Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC069C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FEA21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738149;
	bh=wS98NmEcYw2q86l3Y4FeuLXZ7nvb3MvknRgcweI+eyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLtziDNnOhz9NjpF5avN6jnQ80n4ibBnnnB7jLljUib4RHun3xw/u8Lj3XRPhm1TG
	 EEOV4WANNvw6VMsV6Ar8vQrIKMAk9WzLUBLq0SwAdYdF/UiqPEjbOLFh14UsF5nO81
	 kwJANy2SZ8marU3bb0UWA+RMAnv3Jadupr401LOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfBIStI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfBIStC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A2821919;
        Sat,  9 Feb 2019 18:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738141;
        bh=wS98NmEcYw2q86l3Y4FeuLXZ7nvb3MvknRgcweI+eyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgZObsJ3EGk3+C3pE9qgGab15zN9QFSXbThJz9ZGkSr4fTIq+37jKRg6eRTSYBvT9
         v18bQo0iRQxPMM3zC1t5WaJ0oIPg8vYKTfkEFn3eSH6ZXc/A8/jbavq1VxeQ+dQcm/
         DYvi7qkZtU+SNvEycBzkHOujH1sh7+isbsKF5Gjo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 10/28] drm/bridge: tc358767: fix single lane configuration
Date:   Sat,  9 Feb 2019 13:48:18 -0500
Message-Id: <20190209184840.126418-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 4d9d54a730434cc068dd3515ba6116697196f77b ]

PHY_2LANE bit is always set in DP_PHY_CTRL, breaking 1 lane use.

Set PHY_2LANE only when 2 lanes are used.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190103115954.12785-4-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 5f0a666db2fd..fee53422c31f 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -543,6 +543,7 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	unsigned long rate;
 	u32 value;
 	int ret;
+	u32 dp_phy_ctrl;
 
 	rate = clk_get_rate(tc->refclk);
 	switch (rate) {
@@ -567,7 +568,10 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
 	tc_write(SYS_PLLPARAM, value);
 
-	tc_write(DP_PHY_CTRL, BGREN | PWR_SW_EN | PHY_2LANE | PHY_A0_EN);
+	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN;
+	if (tc->link.base.num_lanes == 2)
+		dp_phy_ctrl |= PHY_2LANE;
+	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
 
 	/*
 	 * Initially PLLs are in bypass. Force PLL parameter update,
@@ -860,7 +864,9 @@ static int tc_main_link_setup(struct tc_data *tc)
 	tc_write(SYS_PLLPARAM, value);
 
 	/* Setup Main Link */
-	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_2LANE | PHY_A0_EN |  PHY_M0_EN;
+	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN | PHY_M0_EN;
+	if (tc->link.base.num_lanes == 2)
+		dp_phy_ctrl |= PHY_2LANE;
 	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
 	msleep(100);
 
-- 
2.19.1

