Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDKCqt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:46:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37577 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeDKCqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:46:48 -0400
X-Google-Smtp-Source: AIpwx49dYcSK0B+U5hwbSQ0izhPnroq4R6Q4MLIpJYz6FXlSh/D4UK1gXTR7GI8S/Gtiq9mjvRIuNg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: pierre@ossman.eu, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/3] mmc: wbsd: Replace mdelay with usleep_range in wbsd_init
Date: Wed, 11 Apr 2018 10:46:43 +0800
Message-Id: <1523414803-2626-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wbsd_init() is never called in atomic context.

The call chains ending up at wbsd_init() are:
[1] wbsd_init() <- wbsd_probe()
[2] wbsd_init() <- wbsd_pnp_probe()

wbsd_probe() is set as ".probe" in struct platform_driver.
wbsd_pnp_probe() is set as ".probe" in struct pnp_driver.
These functions are not called in atomic context.

Despite never getting called from atomic context, wbsd_init()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mmc/host/wbsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 546aaf8..6224d12 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1709,7 +1709,7 @@ static int wbsd_init(struct device *dev, int base, int irq, int dma,
 	/*
 	 * Allow device to initialise itself properly.
 	 */
-	mdelay(5);
+	usleep_range(5000, 6000);
 
 	/*
 	 * Reset the chip into a known state.
-- 
1.9.1
