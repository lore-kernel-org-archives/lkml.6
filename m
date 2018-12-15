Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CBEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 23:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C586E2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 23:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeLOXB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 18:01:57 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39854 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeLOXB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 18:01:57 -0500
Received: from localhost.localdomain (unknown [85.140.177.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0D3B554006B;
        Sun, 16 Dec 2018 02:01:53 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] mailbox: imx: Fix clk handling in imx_mu_probe()
Date:   Sun, 16 Dec 2018 02:01:44 +0300
Message-Id: <1544914904-3809-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling of devm_clk_get() suggests that the driver should support
lack of priv->clk. But imx_mu_probe() fails on clk_prepare_enable(NULL)
in that case.

The patch removes the try to enable absent clk and adds error handling
for mbox_controller_register().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/mailbox/imx-mailbox.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 363d35d5e49d..ddde398f576e 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -292,10 +292,12 @@ static int imx_mu_probe(struct platform_device *pdev)
 		priv->clk = NULL;
 	}
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable clock\n");
-		return ret;
+	if (priv->clk) {
+		ret = clk_prepare_enable(priv->clk);
+		if (ret) {
+			dev_err(dev, "Failed to enable clock\n");
+			return ret;
+		}
 	}
 
 	for (i = 0; i < IMX_MU_CHANS; i++) {
@@ -324,7 +326,13 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	imx_mu_init_generic(priv);
 
-	return mbox_controller_register(&priv->mbox);
+	ret = mbox_controller_register(&priv->mbox);
+	if (ret) {
+		clk_disable_unprepare(priv->clk);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int imx_mu_remove(struct platform_device *pdev)
-- 
2.7.4

