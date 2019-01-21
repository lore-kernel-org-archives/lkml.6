Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6362C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8107D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfAUHij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:38:39 -0500
Received: from shell.v3.sk ([90.176.6.54]:49581 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbfAUHie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:38:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 62D21CB08D;
        Mon, 21 Jan 2019 07:23:27 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3G7SUyllmrc3; Mon, 21 Jan 2019 07:23:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 202EACAE3B;
        Mon, 21 Jan 2019 07:23:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PC_3sMcY6Ici; Mon, 21 Jan 2019 07:23:17 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7072BCAE4E;
        Mon, 21 Jan 2019 07:23:17 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/3] Revert "clk: mmp2: add SP clock"
Date:   Mon, 21 Jan 2019 07:22:55 +0100
Message-Id: <20190121062255.551587-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121062255.551587-1-lkundrak@v3.sk>
References: <20190121062255.551587-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the kernel has no business managing this clock: once the SP
clock is disabled, it's not sufficient to just enable in order to bring t=
he
SP core back up. Just let the firmware keep it enabled and don't expose i=
t
to drivers.

This reverts commit fc27c2394d96fd19854b7e2d3f0e60df0d86fc90.

Link: https://lore.kernel.org/lkml/154783267051.169631.319783654464662574=
7@swboyd.mtv.corp.google.com/
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index 61fefc046ec5..d083b860f083 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -53,7 +53,6 @@
 #define APMU_DISP1	0x110
 #define APMU_CCIC0	0x50
 #define APMU_CCIC1	0xf4
-#define APMU_SP		0x68
 #define MPMU_UART_PLL	0x14
=20
 struct mmp2_clk_unit {
@@ -210,8 +209,6 @@ static struct mmp_clk_mix_config ccic1_mix_config =3D=
 {
 	.reg_info =3D DEFINE_MIX_REG_INFO(4, 16, 2, 6, 32),
 };
=20
-static DEFINE_SPINLOCK(sp_lock);
-
 static struct mmp_param_mux_clk apmu_mux_clks[] =3D {
 	{MMP2_CLK_DISP0_MUX, "disp0_mux", disp_parent_names, ARRAY_SIZE(disp_pa=
rent_names), CLK_SET_RATE_PARENT, APMU_DISP0, 6, 2, 0, &disp0_lock},
 	{MMP2_CLK_DISP1_MUX, "disp1_mux", disp_parent_names, ARRAY_SIZE(disp_pa=
rent_names), CLK_SET_RATE_PARENT, APMU_DISP1, 6, 2, 0, &disp1_lock},
@@ -242,7 +239,6 @@ static struct mmp_param_gate_clk apmu_gate_clks[] =3D=
 {
 	{MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APM=
U_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RATE_PAR=
ENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET_RATE_=
PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
-	{MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT, APMU_SP, 0x1b, 0x1b,=
 0x0, 0, &sp_lock},
 };
=20
 static void mmp2_axi_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
--=20
2.20.1

