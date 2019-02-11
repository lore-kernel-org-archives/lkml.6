Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833CEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E0B21479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBKKVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:21:05 -0500
Received: from shell.v3.sk ([90.176.6.54]:44915 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfBKKVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:21:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CB182CE8D0;
        Mon, 11 Feb 2019 11:20:59 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ksaCio4dxNcy; Mon, 11 Feb 2019 11:20:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A43FBCE8D2;
        Mon, 11 Feb 2019 11:20:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ci_mVG5vkJWI; Mon, 11 Feb 2019 11:20:55 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C8D5DCE8D0;
        Mon, 11 Feb 2019 11:20:54 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] clk: mmp2: separate LCDC peripheral clk form the display clock
Date:   Mon, 11 Feb 2019 11:20:50 +0100
Message-Id: <20190211102050.24422-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211102050.24422-1-lkundrak@v3.sk>
References: <20190211102050.24422-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are in fact two clocks, they shouldn't be exposed as one. One is
required for accessing LCD controller registers (peripheral clock), while
other (AXI clock) can be optionally used as a pixel clock source for the
panel.

LCDC can alternatively use different clocks than the Display 1 AXI clock
for generating the pixel clock: the second AXI clock (fixed in this
commit too), the HDMI PLL, or the AXI bus clock.

They should really be controlled independently.

Link: https://lists.freedesktop.org/archives/dri-devel/2019-January/20397=
5.html
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index d083b860f083..a60a1be937ad 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -229,9 +229,10 @@ static struct mmp_param_gate_clk apmu_gate_clks[] =3D=
 {
 	{MMP2_CLK_SDH1, "sdh1_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SD=
H1, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
 	{MMP2_CLK_SDH2, "sdh2_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SD=
H2, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
 	{MMP2_CLK_SDH3, "sdh3_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SD=
H3, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
-	{MMP2_CLK_DISP0, "disp0_clk", "disp0_div", CLK_SET_RATE_PARENT, APMU_DI=
SP0, 0x1b, 0x1b, 0x0, 0, &disp0_lock},
+	{MMP2_CLK_DISP0, "disp0_clk", "disp0_div", CLK_SET_RATE_PARENT, APMU_DI=
SP0, 0x09, 0x09, 0x0, 0, &disp0_lock},
+	{MMP2_CLK_DISP0_LCDC, "disp0_lcdc_clk", "disp0_mux", CLK_SET_RATE_PAREN=
T, APMU_DISP0, 0x12, 0x12, 0x0, 0, &disp0_lock},
 	{MMP2_CLK_DISP0_SPHY, "disp0_sphy_clk", "disp0_sphy_div", CLK_SET_RATE_=
PARENT, APMU_DISP0, 0x1024, 0x1024, 0x0, 0, &disp0_lock},
-	{MMP2_CLK_DISP1, "disp1_clk", "disp1_div", CLK_SET_RATE_PARENT, APMU_DI=
SP1, 0x1b, 0x1b, 0x0, 0, &disp1_lock},
+	{MMP2_CLK_DISP1, "disp1_clk", "disp1_div", CLK_SET_RATE_PARENT, APMU_DI=
SP1, 0x09, 0x09, 0x0, 0, &disp1_lock},
 	{MMP2_CLK_CCIC_ARBITER, "ccic_arbiter", "vctcxo", CLK_SET_RATE_PARENT, =
APMU_CCIC0, 0x1800, 0x1800, 0x0, 0, &ccic0_lock},
 	{MMP2_CLK_CCIC0, "ccic0_clk", "ccic0_mix_clk", CLK_SET_RATE_PARENT, APM=
U_CCIC0, 0x1b, 0x1b, 0x0, 0, &ccic0_lock},
 	{MMP2_CLK_CCIC0_PHY, "ccic0_phy_clk", "ccic0_mix_clk", CLK_SET_RATE_PAR=
ENT, APMU_CCIC0, 0x24, 0x24, 0x0, 0, &ccic0_lock},
--=20
2.20.1

