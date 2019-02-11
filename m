Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9549221773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897200;
	bh=Sm/6yHg/ZlqRz49T243GbfD3QH3rt3KBgV2Aa1AtQHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bYHy6RFBKmFHl+Ku9KodQvXI9VDMHta6wRVO8/v7VKcrmjAnOVI6k3jETUGwANcnI
	 vOllljiyJ2yLjoJc+yJIuS09hJUxwIMce/9iEylXJy5g/we3ku/yCsPNXQHS3hjvlk
	 e8xbFxc2rsH14xZYZnfgr8ZWacFtiXxvGdzC5cIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbfBKO77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbfBKO75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:59:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B7C21773;
        Mon, 11 Feb 2019 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897197;
        bh=Sm/6yHg/ZlqRz49T243GbfD3QH3rt3KBgV2Aa1AtQHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w28gGySOmbSVmRe0TGY4Or5nuMJMZ4PQDrFziLsTuQWyBqBtAZWhRwqp+899T3OcW
         sSnEd2mi8ovqWwQh9J58PI0Kwi/SqOR+GqmyryRAhhp/8Y3Ht4iASU9K3v0PPSKlS7
         dV8fqPQWZZ0DZIb76QQNkRKBdJ8EpEnXxCRWS7vA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 083/205] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Date:   Mon, 11 Feb 2019 15:18:01 +0100
Message-Id: <20190211141834.118409000@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 9642cdf0fb88..c264a744fae8 100644
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



