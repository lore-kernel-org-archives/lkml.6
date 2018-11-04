Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00CEC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832C020854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832C020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbeKEDnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:43:37 -0500
Received: from mailoutvs22.siol.net ([185.57.226.213]:47155 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387431AbeKEDng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:43:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9AB16521282;
        Sun,  4 Nov 2018 19:27:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G4lkHGgKQoEC; Sun,  4 Nov 2018 19:27:41 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4BA94521270;
        Sun,  4 Nov 2018 19:27:41 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id D047E521282;
        Sun,  4 Nov 2018 19:27:38 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 04/28] clk: sunxi-ng: h6: Set video PLLs limits
Date:   Sun,  4 Nov 2018 19:26:41 +0100
Message-Id: <20181104182705.18047-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video PLL factors can be set in a way that final PLL rate is outside
stable range. H6 user manual specifically says that N factor should not
be below 12. While it doesn't says anything about maximum stable rate, it
is clear that PLL doesn't work at 6.096 GHz (254 * 24 MHz).

Set minimum allowed PLL video rate to 288 MHz (12 * 24 MHz) and maximum
to 2.4 GHz, which is maximum in BSP driver.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/=
ccu-sun50i-h6.c
index 2193e1495086..19ff09f610e4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -120,6 +120,8 @@ static struct ccu_nm pll_video0_clk =3D {
 	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
 	.fixed_post_div	=3D 4,
+	.min_rate	=3D 288000000,
+	.max_rate	=3D 2400000000UL,
 	.common		=3D {
 		.reg		=3D 0x040,
 		.features	=3D CCU_FEATURE_FIXED_POSTDIV,
@@ -136,6 +138,8 @@ static struct ccu_nm pll_video1_clk =3D {
 	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
 	.fixed_post_div	=3D 4,
+	.min_rate	=3D 288000000,
+	.max_rate	=3D 2400000000UL,
 	.common		=3D {
 		.reg		=3D 0x048,
 		.features	=3D CCU_FEATURE_FIXED_POSTDIV,
--=20
2.19.1

