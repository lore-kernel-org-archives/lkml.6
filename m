Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61BBC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEC92086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEC92086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeIJQU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:20:57 -0400
Received: from shell.v3.sk ([90.176.6.54]:35747 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbeIJQUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:20:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0CACBB82D6;
        Mon, 10 Sep 2018 13:27:16 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rFykAoM81yUO; Mon, 10 Sep 2018 13:27:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8C8FEB82D1;
        Mon, 10 Sep 2018 13:27:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xa-7Re8p9TxL; Mon, 10 Sep 2018 13:27:01 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 75A51B82CE;
        Mon, 10 Sep 2018 13:27:00 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4/8] clk: mmp2: add SP clock
Date:   Mon, 10 Sep 2018 13:26:50 +0200
Message-Id: <20180910112654.42061-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910112654.42061-1-lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "security processor", sometimes referred to as "wireless trusted
module" or "generic encrypt unit" is a low-power core present on MMP2,
that has nothing to do with security, wireless, trust or encryption.

On an OLPC machine it runs CForth and serves as a keyboard controller:
http://dev.laptop.org/git/users/wmb/cforth/tree/src/app/arm-xo-1.75/ps2.fth

The register address was obtained from the OLPC kernel, since the
datasheet seems to be the Marvell's most important business secret.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 0fc75c395957..1da50f827a15 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -53,6 +53,7 @@
 #define APMU_DISP1	0x110
 #define APMU_CCIC0	0x50
 #define APMU_CCIC1	0xf4
+#define APMU_SP		0x68
 #define MPMU_UART_PLL	0x14
 
 struct mmp2_clk_unit {
@@ -209,6 +210,8 @@ static struct mmp_clk_mix_config ccic1_mix_config = {
 	.reg_info = DEFINE_MIX_REG_INFO(4, 16, 2, 6, 32),
 };
 
+static DEFINE_SPINLOCK(sp_lock);
+
 static struct mmp_param_mux_clk apmu_mux_clks[] = {
 	{MMP2_CLK_DISP0_MUX, "disp0_mux", disp_parent_names, ARRAY_SIZE(disp_parent_names), CLK_SET_RATE_PARENT, APMU_DISP0, 6, 2, 0, &disp0_lock},
 	{MMP2_CLK_DISP1_MUX, "disp1_mux", disp_parent_names, ARRAY_SIZE(disp_parent_names), CLK_SET_RATE_PARENT, APMU_DISP1, 6, 2, 0, &disp1_lock},
@@ -239,6 +242,7 @@ static struct mmp_param_gate_clk apmu_gate_clks[] = {
 	{MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
+	{MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT, APMU_SP, 0x1b, 0x1b, 0x0, 0, &sp_lock},
 };
 
 static void mmp2_axi_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
-- 
2.17.1

