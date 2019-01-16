Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F69C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27F620840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391671AbfAPJfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:35:14 -0500
Received: from shell.v3.sk ([90.176.6.54]:55902 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388935AbfAPJfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:35:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4FFDB527B1;
        Wed, 16 Jan 2019 10:35:10 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iVZGMiR5SVVE; Wed, 16 Jan 2019 10:35:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D14BA5283F;
        Wed, 16 Jan 2019 10:35:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id frTvlp2_1CTS; Wed, 16 Jan 2019 10:35:07 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3303B527B1;
        Wed, 16 Jan 2019 10:35:07 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
Subject: [PATCH] clk: mmp2: avoid disabling the SP clock when unused
Date:   Wed, 16 Jan 2019 10:35:05 +0100
Message-Id: <20190116093505.1920945-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be vital functionality running on the SP PJ1 core it can not =
be
restarted just by turning the clock back on.

On the OLPC laptop, the keyboard controller code runs there. It
wouldn't be possible to load the driver for it as a module if the clock
is disabled on boot.

Cc: stable@vger.kernel.org # v4.18+
Fixes: commit fc27c2394d96 ("clk: mmp2: add SP clock")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index f2a1c9bbaa63..3e33f1295f59 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -246,7 +246,7 @@ static struct mmp_param_gate_clk apmu_gate_clks[] =3D=
 {
 	{MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APM=
U_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RATE_PAR=
ENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET_RATE_=
PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
-	{MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT, APMU_SP, 0x1b, 0x1b,=
 0x0, 0, &sp_lock},
+	{MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, =
APMU_SP, 0x1b, 0x1b, 0x0, 0, &sp_lock},
 };
=20
 static void mmp2_axi_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
--=20
2.20.1

