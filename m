Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Qn7eBAs0HVtUSQAAmS7hNA
	; Sun, 10 Jun 2018 14:56:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4E552607A4; Sun, 10 Jun 2018 14:56:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DBA5C604D4;
	Sun, 10 Jun 2018 14:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBA5C604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeFJO4Z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 10:56:25 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:21892 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751292AbeFJO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 10:56:21 -0400
X-IronPort-AV: E=Sophos;i="5.49,498,1520895600";
   d="scan'208";a="331181269"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 10 Jun 2018 16:56:19 +0200
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] omapfb: encoder-tpd12s015: fix error return code
Date: Sun, 10 Jun 2018 16:24:13 +0200
Message-Id: <1528640655-18948-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return an error code on failure.

Problem found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c |   12 +++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
index 80dc473..2b58bfc 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
@@ -240,22 +240,28 @@ static int tpd_probe(struct platform_device *pdev)
 
 	gpio = devm_gpiod_get_index_optional(&pdev->dev, NULL, 0,
 		GPIOD_OUT_LOW);
-	if (IS_ERR(gpio))
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
 		goto err_gpio;
+	}
 
 	ddata->ct_cp_hpd_gpio = gpio;
 
 	gpio = devm_gpiod_get_index_optional(&pdev->dev, NULL, 1,
 		GPIOD_OUT_LOW);
-	if (IS_ERR(gpio))
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
 		goto err_gpio;
+	}
 
 	ddata->ls_oe_gpio = gpio;
 
 	gpio = devm_gpiod_get_index(&pdev->dev, NULL, 2,
 		GPIOD_IN);
-	if (IS_ERR(gpio))
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
 		goto err_gpio;
+	}
 
 	ddata->hpd_gpio = gpio;
 
