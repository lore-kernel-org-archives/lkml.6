Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053D2C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BDA20643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738613;
	bh=YTe8f1mJ+AdROhW/xPStVDHFqPiuDCzwVBUcoTELU/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USN+d0VJEZZcMfGy/GsLYsLWp/Vy6rMtl02mueRUscJiJOTTTG9NIiTEl7AIWCbGq
	 UNcw6uJRV8JLew/s/SM2ETNN4dLUPruVsz/Vq3zyihRxbC1Pt8AVZX2yMc2/1C3+l9
	 QWXmyMjw7LezEr9dSTDsV0OJv6tLNywhKgkjkFYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfBIS4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfBISrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5FF2192B;
        Sat,  9 Feb 2019 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738074;
        bh=YTe8f1mJ+AdROhW/xPStVDHFqPiuDCzwVBUcoTELU/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTOARvp57XskLsr1xDL6TKH32puFfrjv8rvlR4/PBuPf5tpVGnOpQbqsUgfrh9CjE
         lWMBNaSJP1ue7mzje8PieDVB/vV5wBb68OJRmalCv5hzXFTQGeanFaCSlnF9+mB9/e
         ZWEUU01RWGolOLglNEP09udVfVCHWY/MpCSe5dgA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 18/42] drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value
Date:   Sat,  9 Feb 2019 13:47:10 -0500
Message-Id: <20190209184734.125935-18-sashal@kernel.org>
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

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 9a63bd6fe1b5590ffa42ae2ed22ee21363293e31 ]

Initially DP0_SRCCTRL is set to a static value which includes
DP0_SRCCTRL_LANES_2 and DP0_SRCCTRL_BW27, even when only 1 lane of
1.62Gbps speed is used. DP1_SRCCTRL is configured to a magic number.

This patch changes the configuration as follows:

Configure DP0_SRCCTRL by using tc_srcctrl() which provides the correct
value.

DP1_SRCCTRL needs two bits to be set to the same value as DP0_SRCCTRL:
SSCG and BW27. All other bits can be zero.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190103115954.12785-5-tomi.valkeinen@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index fee53422c31f..ab299f4debfa 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -836,12 +836,11 @@ static int tc_main_link_setup(struct tc_data *tc)
 	if (!tc->mode)
 		return -EINVAL;
 
-	/* from excel file - DP0_SrcCtrl */
-	tc_write(DP0_SRCCTRL, DP0_SRCCTRL_SCRMBLDIS | DP0_SRCCTRL_EN810B |
-		 DP0_SRCCTRL_LANESKEW | DP0_SRCCTRL_LANES_2 |
-		 DP0_SRCCTRL_BW27 | DP0_SRCCTRL_AUTOCORRECT);
-	/* from excel file - DP1_SrcCtrl */
-	tc_write(DP1_SRCCTRL, 0x00003083);
+	tc_write(DP0_SRCCTRL, tc_srcctrl(tc));
+	/* SSCG and BW27 on DP1 must be set to the same as on DP0 */
+	tc_write(DP1_SRCCTRL,
+		 (tc->link.spread ? DP0_SRCCTRL_SSCG : 0) |
+		 ((tc->link.base.rate != 162000) ? DP0_SRCCTRL_BW27 : 0));
 
 	rate = clk_get_rate(tc->refclk);
 	switch (rate) {
-- 
2.19.1

