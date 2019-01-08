Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CAAC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D76A2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975878;
	bh=d1u8BwQe20uw1Ej7C6lpZIkVa1IQ/7VMYBsHokp50U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ep4GZfkOBCOIwuHnE7v2IqurOTmIidO9x8+Vmk6mYjKvnVrB88yxTioM+/TzQAhAw
	 kYvhjHNnL2mkbfze7GdrI66bDhYagvrh2opy0067adtkmUOXaAOCBUURMDhNeIcqBL
	 w2eKNDK5rWwdoB5CUDXlevDOl/bYA4IyIP8YRWm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfAHTbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:31:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731012AbfAHTbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BC220645;
        Tue,  8 Jan 2019 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975871;
        bh=d1u8BwQe20uw1Ej7C6lpZIkVa1IQ/7VMYBsHokp50U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbIuKQK9dgv9TSyXAysMKjHdJ2yIyfjwEnqPyqoMJR3XoAdJfmtkWZs9RVG39Zb0/
         6IrC08hwOdJaaCGeUvukFDK5K+n256vwCNXKjgqYrVWxlG7Jj0k2dTr1y2MFHfE/La
         kOIpSCscKz6EpHNT/ez/9XXzyTGcyk7LAxHKAfEg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 50/97] clk: imx6q: reset exclusive gates on init
Date:   Tue,  8 Jan 2019 14:28:59 -0500
Message-Id: <20190108192949.122407-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit f7542d817733f461258fd3a47d77da35b2d9fc81 ]

The exclusive gates may be set up in the wrong way by software running
before the clock driver comes up. In that case the exclusive setup is
locked in its initial state, as the complementary function can't be
activated without disabling the initial setup first.

To avoid this lock situation, reset the exclusive gates to the off
state and allow the kernel to provide the proper setup.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Dong Aisheng <Aisheng.dong@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx6q.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8c7c2fcb8d94..c509324f6338 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -508,8 +508,12 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	 * lvds1_gate and lvds2_gate are pseudo-gates.  Both can be
 	 * independently configured as clock inputs or outputs.  We treat
 	 * the "output_enable" bit as a gate, even though it's really just
-	 * enabling clock output.
+	 * enabling clock output. Initially the gate bits are cleared, as
+	 * otherwise the exclusive configuration gets locked in the setup done
+	 * by software running before the clock driver, with no way to change
+	 * it.
 	 */
+	writel(readl(base + 0x160) & ~0x3c00, base + 0x160);
 	clk[IMX6QDL_CLK_LVDS1_GATE] = imx_clk_gate_exclusive("lvds1_gate", "lvds1_sel", base + 0x160, 10, BIT(12));
 	clk[IMX6QDL_CLK_LVDS2_GATE] = imx_clk_gate_exclusive("lvds2_gate", "lvds2_sel", base + 0x160, 11, BIT(13));
 
-- 
2.19.1

