Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5315EC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2C820821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738295;
	bh=8/o753cGMQ1UiRqrZE9HIcZGKH2qMgdA5DKO9XJJiRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Paj5liut68i3fG2bDNYJVnVyUN45Wdybl4GZjxH0vxo5G5lVvR8a+qaGTPWa35djE
	 ztzKWEPLUNwE3AaVE9salmJFKXGKnm7aJh4L+lXb4hadyweVMmCGK5qIw9JROFiPv6
	 +uzr57Fjc/oSG0ZAduwaynYX6n7xgg5vLqyQfAIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfBISvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:51:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbfBISt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E8721916;
        Sat,  9 Feb 2019 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738198;
        bh=8/o753cGMQ1UiRqrZE9HIcZGKH2qMgdA5DKO9XJJiRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1dK80u/3YFuw+y9SCyxIngWkRMMy7Wkd/fyLMAldKtcov9ipM6y+ecpPileWPGCUP
         tQkwXhEBrgFa8+MOViH4vVEO35VERy7uSbZsaqb6u6ZCE/NItb7DnDmFgIV8GHQ8/a
         lSD0Bb9dcrwbzCP9znQN93zs9APO+HFHK4xn3EXs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 05/12] drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value
Date:   Sat,  9 Feb 2019 13:49:45 -0500
Message-Id: <20190209184952.127009-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184952.127009-1-sashal@kernel.org>
References: <20190209184952.127009-1-sashal@kernel.org>
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
index 8098297c5fe5..dbe403ea130d 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -834,12 +834,11 @@ static int tc_main_link_setup(struct tc_data *tc)
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

