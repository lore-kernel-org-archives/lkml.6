Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833CBC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548AA2073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfBCO3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:29:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55410 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729944AbfBCOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:28 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdG-0006JJ-Tm; Sun, 03 Feb 2019 14:20:27 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9g-0007C1-VS; Sun, 03 Feb 2019 14:49:52 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Christian Hoff" <christian_hoff@gmx.net>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.57189783@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 195/305] Input: matrix_keypad - check for errors from
 of_get_named_gpio()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Hoff <christian_hoff@gmx.net>

commit d55bda1b3e7c5a87f10da54fdda866a9a9cef30b upstream.

"of_get_named_gpio()" returns a negative error value if it fails
and drivers should check for this. This missing check was now
added to the matrix_keypad driver.

In my case "of_get_named_gpio()" returned -EPROBE_DEFER because
the referenced GPIOs belong to an I/O expander, which was not yet
probed at the point in time when the matrix_keypad driver was
loading. Because the driver did not check for errors from the
"of_get_named_gpio()" routine, it was assuming that "-EPROBE_DEFER"
is actually a GPIO number and continued as usual, which led to further
errors like this later on:

WARNING: CPU: 3 PID: 167 at drivers/gpio/gpiolib.c:114
gpio_to_desc+0xc8/0xd0
invalid GPIO -517

Note that the "GPIO number" -517 in the error message above is
actually "-EPROBE_DEFER".

As part of the patch a misleading error message "no platform data defined"
was also removed. This does not lead to information loss because the other
error paths in matrix_keypad_parse_dt() already print an error.

Signed-off-by: Christian Hoff <christian_hoff@gmx.net>
Suggested-by: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/keyboard/matrix_keypad.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -404,7 +404,7 @@ matrix_keypad_parse_dt(struct device *de
 	struct matrix_keypad_platform_data *pdata;
 	struct device_node *np = dev->of_node;
 	unsigned int *gpios;
-	int i, nrow, ncol;
+	int ret, i, nrow, ncol;
 
 	if (!np) {
 		dev_err(dev, "device lacks DT data\n");
@@ -444,12 +444,19 @@ matrix_keypad_parse_dt(struct device *de
 		return ERR_PTR(-ENOMEM);
 	}
 
-	for (i = 0; i < pdata->num_row_gpios; i++)
-		gpios[i] = of_get_named_gpio(np, "row-gpios", i);
+	for (i = 0; i < nrow; i++) {
+		ret = of_get_named_gpio(np, "row-gpios", i);
+		if (ret < 0)
+			return ERR_PTR(ret);
+		gpios[i] = ret;
+	}
 
-	for (i = 0; i < pdata->num_col_gpios; i++)
-		gpios[pdata->num_row_gpios + i] =
-			of_get_named_gpio(np, "col-gpios", i);
+	for (i = 0; i < ncol; i++) {
+		ret = of_get_named_gpio(np, "col-gpios", i);
+		if (ret < 0)
+			return ERR_PTR(ret);
+		gpios[nrow + i] = ret;
+	}
 
 	pdata->row_gpios = gpios;
 	pdata->col_gpios = &gpios[pdata->num_row_gpios];
@@ -476,10 +483,8 @@ static int matrix_keypad_probe(struct pl
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
 		pdata = matrix_keypad_parse_dt(&pdev->dev);
-		if (IS_ERR(pdata)) {
-			dev_err(&pdev->dev, "no platform data defined\n");
+		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
-		}
 	} else if (!pdata->keymap_data) {
 		dev_err(&pdev->dev, "no keymap data defined\n");
 		return -EINVAL;

