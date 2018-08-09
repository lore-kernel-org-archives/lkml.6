Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B4CC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9102C21EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9102C21EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbeHITSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:18:14 -0400
Received: from mailoutvs53.siol.net ([185.57.226.244]:43595 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730634AbeHITSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:18:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 23A0E520431;
        Thu,  9 Aug 2018 18:52:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qQ4-hMFAoZjy; Thu,  9 Aug 2018 18:52:28 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A0A225203A0;
        Thu,  9 Aug 2018 18:52:28 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 5E606520431;
        Thu,  9 Aug 2018 18:52:26 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 0/5] Set max rate for video PLLs
Date:   Thu,  9 Aug 2018 18:52:12 +0200
Message-Id: <20180809165217.30680-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implement maximum rate constraint for video PLLs,
because it is possible to set higher PLL rate that is actually
supported in HW.

Issue became apparent when user reported non-working monitor connected
to board with H5 SoC. Native monitor resolution in this case was
2560x1080, with 185580 kHz pixel clock. Clock subsystem found out that
best matching pixel clock can be generated if video PLL is set to 2040
MHz, which is way out of specs for PLL. With this patch series applied,
everything worked just fine, with slightly higher rate error, but within
working limits for PLL and HDMI.

I'm not sure if "Fixes" tag should be added. It solves real world
problem, but there was nothing wrongly implemented, just upper limit
is missing.

While user reported that these patches solve the issue on H5, I added
similar fixes for other SoCs too. Since I don't have such monitor,
I only tested if board boots up and if HDMI works (H3, R40 and A83T).

Jernej Skrabec (5):
  clk: sunxi-ng: Add maximum rate constraint to NM PLLs
  clk: sunxi-ng: h3/h5: Add max. rate constraint to pll-video
  clk: sunxi-ng: r40: Add max. rate constraint to video PLLs
  clk: sunxi-ng: nkmp: Add constraint for maximum rate
  clk: sunxi-ng: a83t: Add max. rate constraint to video PLLs

 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c |  2 ++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c   | 25 ++++++-------
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c  | 52 +++++++++++++--------------
 drivers/clk/sunxi-ng/ccu_nkmp.c       |  7 ++++
 drivers/clk/sunxi-ng/ccu_nkmp.h       |  1 +
 drivers/clk/sunxi-ng/ccu_nm.c         |  7 ++++
 drivers/clk/sunxi-ng/ccu_nm.h         | 30 ++++++++++++++++
 7 files changed, 86 insertions(+), 38 deletions(-)

-- 
2.18.0

