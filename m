Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeCXXlF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 19:41:05 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:55826 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbeCXXlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 19:41:03 -0400
From: Alban Bedel <albeu@free.fr>
To: linux-gpio@vger.kernel.org
Cc: Wei Yongjun <weiyongjun1@huawei.com>, Alban Bedel <albeu@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpio: ath79: Fix potential NULL dereference in ath79_gpio_probe()
Date: Sun, 25 Mar 2018 00:40:48 +0100
Message-Id: <1521934848-5674-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

platform_get_resource() may return NULL, add proper
check to avoid potential NULL dereferencing.

This is detected by Coccinelle semantic patch.

@@
expression pdev, res, n, t, e, e1, e2;
@@

res = platform_get_resource(pdev, t, n);
+ if (!res)
+   return -EINVAL;
... when != res == NULL
e = devm_ioremap(e1, res->start, e2);

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
[albeu@free.fr: Fixed patch to apply on current tree]
Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/gpio/gpio-ath79.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index 3ae7c18..684e9d6 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -258,6 +258,8 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 	ctrl->base = devm_ioremap_nocache(
 		&pdev->dev, res->start, resource_size(res));
 	if (!ctrl->base)
-- 
2.7.4
