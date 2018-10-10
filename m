Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72281C4161B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396E420870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396E420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeJJVsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:48:01 -0400
Received: from shell.v3.sk ([90.176.6.54]:53510 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeJJVsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:48:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2C1E5BCF5F;
        Wed, 10 Oct 2018 16:25:34 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xW8cVI8Nx_zI; Wed, 10 Oct 2018 16:25:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DA378BCF72;
        Wed, 10 Oct 2018 16:25:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ewCO3gzgGqB6; Wed, 10 Oct 2018 16:25:10 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 13CC6BCF66;
        Wed, 10 Oct 2018 16:25:10 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 4/8] clk: mmp2: add SP clock
Date:   Wed, 10 Oct 2018 16:25:00 +0200
Message-Id: <20181010142504.233467-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010142504.233467-1-lkundrak@v3.sk>
References: <20181010142504.233467-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "security processor", sometimes referred to as "wireless trusted
module" or "generic encrypt unit" is a low-power core present on MMP2,
that has nothing to do with security, wireless, trust or encryption.

On an OLPC machine it runs CForth and serves as a keyboard controller:
http://dev.laptop.org/git/users/wmb/cforth/tree/src/app/arm-xo-1.75/ps2.f=
th

The register address was obtained from the OLPC kernel, since the
datasheet seems to be the Marvell's most important business secret.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index 0fc75c395957..1da50f827a15 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -53,6 +53,7 @@
 #define APMU_DISP1	0x110
 #define APMU_CCIC0	0x50
 #define APMU_CCIC1	0xf4
+#define APMU_SP		0x68
 #define MPMU_UART_PLL	0x14
=20
 struct mmp2_clk_unit {
@@ -209,6 +210,8 @@ static struct mmp_clk_mix_config ccic1_mix_config =3D=
 {
 	.reg_info =3D DEFINE_MIX_REG_INFO(4, 16, 2, 6, 32),
 };
=20
+static DEFINE_SPINLOCK(sp_lock);
+
 static struct mmp_param_mux_clk apmu_mux_clks[] =3D {
 	{MMP2_CLK_DISP0_MUX, "disp0_mux", disp_parent_names, ARRAY_SIZE(disp_pa=
rent_names), CLK_SET_RATE_PARENT, APMU_DISP0, 6, 2, 0, &disp0_lock},
 	{MMP2_CLK_DISP1_MUX, "disp1_mux", disp_parent_names, ARRAY_SIZE(disp_pa=
rent_names), CLK_SET_RATE_PARENT, APMU_DISP1, 6, 2, 0, &disp1_lock},
@@ -239,6 +242,7 @@ static struct mmp_param_gate_clk apmu_gate_clks[] =3D=
 {
 	{MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APM=
U_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RATE_PAR=
ENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET_RATE_=
PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
+	{MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT, APMU_SP, 0x1b, 0x1b,=
 0x0, 0, &sp_lock},
 };
=20
 static void mmp2_axi_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
--=20
2.19.0

