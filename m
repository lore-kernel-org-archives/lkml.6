Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB43C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3220854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Qps/s+Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE3220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeILXi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:38:27 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52504 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeILXi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:38:27 -0400
Received: from trochilidae.toradex.int (75-146-58-181-Washington.hfc.comcastbusiness.net [75.146.58.181])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C59015C1D14;
        Wed, 12 Sep 2018 20:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536777160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWmLkqQ3Jh/lp2FK2rtWSudrxyNjX+B0+ERaan1G8G4=;
        b=Qps/s+Q2k4x1rDhIO+Plj/6ulszARuwJmiXnfiS0bt5d2p0dDjj10OjLCOy40NcdJgwb+X
        trg4odYE1P/4yKRPi3agC9VItumBsDwtGz69pd/Qr0YJImCHBM0HfbGnGvR7Zy+/T1WpRb
        eJGRvbLIQ0MYt3qGb5O8PHOTlAIqWa4=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/8] drm/pl111: simplify bridge timing support
Date:   Wed, 12 Sep 2018 11:32:16 -0700
Message-Id: <20180912183222.25414-3-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify bridge timing support by only supporting pixel clock
polarity. This aligns pixel clock polarity handling for bridges
with displays.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/pl111/pl111_display.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 754f6b25f265..31eb62e4476f 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -196,23 +196,13 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		const struct drm_bridge_timings *btimings = bridge->timings;
 
 		/*
-		 * Here is when things get really fun. Sometimes the bridge
-		 * timings are such that the signal out from PL11x is not
-		 * stable before the receiving bridge (such as a dumb VGA DAC
-		 * or similar) samples it. If that happens, we compensate by
-		 * the only method we have: output the data on the opposite
-		 * edge of the clock so it is for sure stable when it gets
-		 * sampled.
-		 *
-		 * The PL111 manual does not contain proper timining diagrams
-		 * or data for these details, but we know from experiments
-		 * that the setup time is more than 3000 picoseconds (3 ns).
-		 * If we have a bridge that requires the signal to be stable
-		 * earlier than 3000 ps before the clock pulse, we have to
-		 * output the data on the opposite edge to avoid flicker.
+		 * Use LCD Timing 2 Register Invert Pixel Clock (IPC) bit
+		 * to make sure to drive data on falling edge if requested
+		 * by bridge.
 		 */
-		if (btimings && btimings->setup_time_ps >= 3000)
-			tim2 ^= TIM2_IPC;
+		if (btimings && btimings->input_bus_flags &
+		    DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+			tim2 |= TIM2_IPC;
 	}
 
 	tim2 |= cpl << 16;
-- 
2.18.0

