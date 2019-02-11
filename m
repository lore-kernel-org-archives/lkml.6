Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF47C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281B7222A8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899801;
	bh=H3C65U0+mqSQHb4iBJuqzfQolRnglP/QxzgsHmQAJn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H6C0qGydY+uHmLdfiW0XaQvTcZl2iAS+12TtpeW2rXYt2k4nRKBo3SIywr9ymvbCz
	 J3+zcw5ap7VGQ/c6GnMg5dGdaVcCAZ8SmGuCjY4V/WhC1lVI0Nt9YFWiYbcWeXbT0C
	 bFkAAzRza/gjCZKJ/fU/bhvrEbYCJfZXNiPLFZOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbfBKPnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfBKOpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4090A206BA;
        Mon, 11 Feb 2019 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896345;
        bh=H3C65U0+mqSQHb4iBJuqzfQolRnglP/QxzgsHmQAJn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hp75XCQC9RYcKLapwz7nPJgWhGvW343qsn5gQS1O6eQ2b8Ohj1Bz/+ICsCN3GQ2K9
         gmLPLgAxd5IIjoQJ3R9uLEULuXjJ6osM/SOuaqpRjz4rITx9Q+bd/gEX14H6aKGqoR
         jPoZ5RLux57YssyQtGs9guFZVijAKy/PxHm2PQco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 124/313] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Date:   Mon, 11 Feb 2019 15:16:44 +0100
Message-Id: <20190211141902.062327232@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index eb6bcbf345a3..390e3e0ecc45 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -17,6 +17,8 @@
 
 #include "clk.h"
 
+#define CCDR				0x4
+#define BM_CCM_CCDR_MMDC_CH0_MASK	(1 << 17)
 #define CCSR			0xc
 #define BM_CCSR_PLL1_SW_CLK_SEL	(1 << 2)
 #define CACRR			0x10
@@ -409,6 +411,10 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
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



