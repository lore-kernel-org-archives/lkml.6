Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14816C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C7720449
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497860;
	bh=FX83/G13E90Jfl+2ngpLUNE0LT7sVAbfj83kpOLpl7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=icJKHacoZ4c6BTb+iXYs8qE84KYEIU+YbObQmq8/sVsfpXgiUeWAbim5p1p+Q1rHc
	 MCdcjfdr4gGORxbvYf/3fHrRsQchVOb05ndUSvbX1T5jbr7IZLf6nuRb+diUvkxn+3
	 i9Gwf3/WeABSJAHZxioby9qx4W/j2hsWyiR8udfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfBRNu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:50:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732298AbfBRNuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D9F20449;
        Mon, 18 Feb 2019 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497853;
        bh=FX83/G13E90Jfl+2ngpLUNE0LT7sVAbfj83kpOLpl7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAnt92SXLZrCe4qaCktIxLyGC1DXEFFhhICYHnmWrKep02pbD/ErKXoH1n/Y/wRH0
         rROHOQm1V1iZcqzgzHyW8k1ealxfVIN+pL+q6rVUXVPcG/fcBCyD7gMC/7gNuva4xb
         rrwCOaM5+CxHcjx0Fca0VbxO9zx/ZSi+ViwFKkiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 31/85] drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value
Date:   Mon, 18 Feb 2019 14:42:57 +0100
Message-Id: <20190218133503.200026610@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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



