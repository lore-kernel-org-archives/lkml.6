Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeDKCVb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:21:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41492 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbeDKCV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:21:29 -0400
X-Google-Smtp-Source: AIpwx4/NOEs7QwAN/Nhbx/TEgNUiOwaBmgeMEk4/6Zkect4Nq1GL4TDRLaexQP85t+HM4gXSRE7mbQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: bh74.an@samsung.com, ks.giri@samsung.com, vipul.pandya@samsung.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: samsung: sxgbe: Replace mdelay with usleep_range in sxgbe_sw_reset
Date: Wed, 11 Apr 2018 10:21:20 +0800
Message-Id: <1523413280-2336-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sxgbe_sw_reset() is never called in atomic context.

sxgbe_sw_reset() is only called by sxgbe_drv_probe(), which is 
only called by sxgbe_platform_probe().
sxgbe_platform_probe() is set as ".probe" in struct platform_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, sxgbe_sw_reset()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 89831ad..99cd586 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -2038,7 +2038,7 @@ static int sxgbe_sw_reset(void __iomem *addr)
 		if (!(readl(addr + SXGBE_DMA_MODE_REG) &
 		      SXGBE_DMA_SOFT_RESET))
 			break;
-		mdelay(10);
+		usleep(10000, 11000);
 	}
 
 	if (retry_count < 0)
-- 
1.9.1
