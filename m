Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeDIOjV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:39:21 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:32390 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeDIOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:38:31 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/7] clk: meson: migrate to devm_of_clk_add_hw_provider API
Date: Mon, 9 Apr 2018 22:37:43 +0800
Message-ID: <20180409143749.71197-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180409143749.71197-1-yixun.lan@amlogic.com>
References: <20180409143749.71197-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a protential memory leak, as of_clk_del_provider is
never called if of_clk_add_hw_provider has been executed.
Fix this by using devm variant API.

Fixes: f8c11f79912d ("clk: meson: Add GXBB AO Clock and Reset controller driver")
Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/gxbb-aoclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 9ec23ae9a219..eebb580b9e0f 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -191,7 +191,7 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 			&gxbb_aoclk_onecell_data);
 }
 
-- 
2.15.1
