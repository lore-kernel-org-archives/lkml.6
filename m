Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeBXWnr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:43:47 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:33100 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeBXWnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:43:46 -0500
Date: Sat, 24 Feb 2018 23:43:45 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: imx-lpi2c: Fix PM device usage count
Message-ID: <20180224224345.owigkyvxarlcfpnu@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() increases the device's usage count even when
reporting an error, so add a call to pm_runtime_put_noidle() in the
error branch.

Fixes: 13d6eb20fc79 ("i2c: imx-lpi2c: add runtime pm support")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
This is one of a number of patches for problems found using coccinelle 
scripting in the SIL2LinuxMP project. The patch has been compile-tested;
it's based on linux-next-20180223.

For a discussion of the corresponding issue, see
https://marc.info/?l=linux-pm&m=151904483924999&w=2

 drivers/i2c/busses/i2c-imx-lpi2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e6da2c7a9a3e..793050da3ae3 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -278,8 +278,10 @@ static int lpi2c_imx_master_enable(struct lpi2c_imx_struct *lpi2c_imx)
 	int ret;
 
 	ret = pm_runtime_get_sync(lpi2c_imx->adapter.dev.parent);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(lpi2c_imx->adapter.dev.parent);
 		return ret;
+	}
 
 	temp = MCR_RST;
 	writel(temp, lpi2c_imx->base + LPI2C_MCR);
-- 
2.11.0
