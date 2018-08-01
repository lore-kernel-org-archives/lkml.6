Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028DBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E2020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E2020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbeHAGDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:03:55 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:60485 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbeHAGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:03:55 -0400
Received: from localhost.localdomain (10.18.20.250) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Wed, 1 Aug 2018
 12:20:13 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Qin <jianxin.qin@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: meson-axg: pcie: drop the mpll3 clock parent
Date:   Wed, 1 Aug 2018 12:16:24 +0000
Message-ID: <20180801121625.9488-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found the PCIe driver doesn't really work with
the mpll3 clock which is actually reserved for debug,
So drop it from the mux list.

Fixes: 33b89db68236 ("clk: meson-axg: add clocks required by pcie driver")
Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
hi Jerome:
  I'm sorry we found this during latest PCIe driver test.

  I'm fine with either pull this as a fixup for 4.18 or
queued for next 4.19, since the PCIe driver is not merged yet,
just do as you feel what's fit best, thanks.

Yixun
---
 drivers/clk/meson/axg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 2d458092884a..246c23df64a8 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -700,12 +700,14 @@ static struct clk_regmap axg_pcie_mux = {
 		.offset = HHI_PCIE_PLL_CNTL6,
 		.mask = 0x1,
 		.shift = 2,
+		/* skip the parent mpll3, reserved for debug */
+		.table = (u32[]){ 1 },
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_mux",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "mpll3", "pcie_pll" },
-		.num_parents = 2,
+		.parent_names = (const char *[]){ "pcie_pll" },
+		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.18.0

