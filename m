Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4E42173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498514;
	bh=1a9yR9nru/4IjSxwrdKqcIs/aUMcezZp+C/3WdXtYqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IDN1/AQ1ayk3FDgH3Tn0h09pI+bkiJvLWIEDabbkAzRaxqOu1fZngmkYVv6wu1/TL
	 Jwi4gaOuVxd4N8DrbEaeAtkjFZu1gZoj8v/TN/I5sNN53taV0OwGxIvHijfkE19kDM
	 8hhfDsKaQBWSieHKDHJttJtVlLtsYOc2VHwd0HVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389199AbfBROBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389184AbfBROBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:01:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1422720842;
        Mon, 18 Feb 2019 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498509;
        bh=1a9yR9nru/4IjSxwrdKqcIs/aUMcezZp+C/3WdXtYqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcTWaVr6V2GFtJ80gkq4ZRJR+z0xojTAu7WYkuwBt6BkOfGD36BqsWwekntVyAqqV
         zDpdGooDmUCmbCDqSSmx2Rx3AZB9Q06X8dGMUA11lH/iGJNAyZZ/6vTDwFtGyHdtoX
         QA84bJZ1pye0W3sjMdX80AFMWU6FWPGU4KX7EU+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 032/143] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Date:   Mon, 18 Feb 2019 14:42:40 +0100
Message-Id: <20190218133530.313117596@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 1be6230a07af..8b6306dc5fc6 100644
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



