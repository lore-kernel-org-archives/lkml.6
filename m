Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5CEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5B32084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694049;
	bh=7NzD0BLo68vKDP7D5v0/7AZER6eA00AwLtRi1gQIwoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bVgvGjbKif3+JQ6W67/xGR9zdGIN2XKfMwZbeGE21IqNAJNQmIlFx+wGC/binAIjY
	 UzLGYpl9m1j0Ps41RkEy8R1lQQ9I0cm9N0U2RxHHsJzvbgQcqmefnQLlYdMlXD0BCD
	 HVVPC8HLNfTs3hcpzxt2rtfMEIM8GSVGPCCTv77Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbfA1Qr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388738AbfA1QWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:22:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C1820663;
        Mon, 28 Jan 2019 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692528;
        bh=7NzD0BLo68vKDP7D5v0/7AZER6eA00AwLtRi1gQIwoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFsCRfQxY0iyf5UiYuLtBFEFmJh2xAmn1eM4IN2dVhfIlOZoIPXPXgLZRURsi9+Vo
         HbyFJYVC4KcL05ywF9selUvVJ4v8Eoh2CZNe+NqkcSAnchme1nNZfkvU9yZHD0JNja
         mDoOBZGEbhZ6nFVwM6M6h0Uhf2HdFwA4PZ26PkNY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 051/107] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Date:   Mon, 28 Jan 2019 11:18:51 -0500
Message-Id: <20190128161947.57405-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

[ Upstream commit 0efcc2c0fd2001a83240a8c3d71f67770484917e ]

Same as other i.MX6 SoCs, ensure unused MMDC channel's
handshake is bypassed, this is to make sure no request
signal will be generated when periphe_clk_sel is changed
or SRC warm reset is triggered.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx6sl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 5fd4ddac1bf1..f3d9dc2d2405 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -17,6 +17,8 @@
 
 #include "clk.h"
 
+#define CCDR				0x4
+#define BM_CCM_CCDR_MMDC_CH0_MASK	(1 << 17)
 #define CCSR			0xc
 #define BM_CCSR_PLL1_SW_CLK_SEL	(1 << 2)
 #define CACRR			0x10
@@ -414,6 +416,10 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_USDHC3]       = imx_clk_gate2("usdhc3",       "usdhc3_podf",       base + 0x80, 6);
 	clks[IMX6SL_CLK_USDHC4]       = imx_clk_gate2("usdhc4",       "usdhc4_podf",       base + 0x80, 8);
 
+	/* Ensure the MMDC CH0 handshake is bypassed */
+	writel_relaxed(readl_relaxed(base + CCDR) |
+		BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
+
 	imx_check_clocks(clks, ARRAY_SIZE(clks));
 
 	clk_data.clks = clks;
-- 
2.19.1

