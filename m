Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B840217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498187;
	bh=uP5lI/LxRyYRFWe7ziKPog8U0FWiVYX9gsGDufZEwPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FJr1VXlRZs/tC0mxWNgPOBWNQJn1XVb/17wz3z+hR7/uZAMv3WJzxnFEVN7J+wDWD
	 go7ZOfZOKfGpIvBl8W+qG4zIOYCNIwGWI304kOmJFzaScypY21QokJ5YbHh5JHzJEh
	 bTk4WgWABg11eWP8lIiilNacuFrRyL/bjoVVPFUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbfBRN4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731605AbfBRN4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF7C2077B;
        Mon, 18 Feb 2019 13:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498183;
        bh=uP5lI/LxRyYRFWe7ziKPog8U0FWiVYX9gsGDufZEwPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoEFZWpIzJQF4Un0CJzZtE3Fl/WWdwb1XxeRs+3bjhaETn9Ne+E/MKoVcmQRseYIg
         xg+ODji9NeC09ngqU53DIsKEWx0t8Nbj354mTGg0ZbLHydyZ/w0Hi8rfGpfvTcmaMq
         N1+0SXGW85bDqIz6Szuu1Ss58V/rwBQWvFerNgLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 29/62] drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value
Date:   Mon, 18 Feb 2019 14:43:35 +0100
Message-Id: <20190218133508.457746998@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index acac2c1769ad..24bb6bfa36f3 100644
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



