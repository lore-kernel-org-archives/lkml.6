Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeDIONK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:13:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44536 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeDIONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:13:08 -0400
X-Google-Smtp-Source: AIpwx4+pnNSohnXFq1W8IGuFoUlNzJtDdfLzWkIhmTy2xf12zV9qkYRESjED1qYIdRaD9FhfNIPa2w==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: bulk: silently error out on EPROBE_DEFER
Date: Mon,  9 Apr 2018 16:13:03 +0200
Message-Id: <20180409141303.14537-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk_bulk_get(), if we fail to get the clock due to probe deferal, we
shouldn't print an error message. Just be silent in this case.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk-bulk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 4c10456f8a32..6904ed6da504 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -42,8 +42,9 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 		clks[i].clk = clk_get(dev, clks[i].id);
 		if (IS_ERR(clks[i].clk)) {
 			ret = PTR_ERR(clks[i].clk);
-			dev_err(dev, "Failed to get clk '%s': %d\n",
-				clks[i].id, ret);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to get clk '%s': %d\n",
+					clks[i].id, ret);
 			clks[i].clk = NULL;
 			goto err;
 		}
-- 
2.14.3
