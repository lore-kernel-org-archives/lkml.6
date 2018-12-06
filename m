Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0DCC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7373D20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107505;
	bh=xC6jaI3OwGf7Ya5tZYUwaTpGNezgkSnjHWG49AlHHx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xppZWxZ5NuE2FVbkOiT5Uiqd1CL7M1W0O0iUMD6487GyxRLrH2MAHO1GjKaAZLNLY
	 jNKv5pbm5tW+vLloVVgve35I6EWbmIPZ0lkyUft9MQHGJ4fzx7CI8bn7SjptNW1UUy
	 2dhFmVBI7hEMuE0HG+OlaA9NagVqxuRKOP43m7nA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7373D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbeLFOpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730971AbeLFOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECBA2082B;
        Thu,  6 Dec 2018 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107499;
        bh=xC6jaI3OwGf7Ya5tZYUwaTpGNezgkSnjHWG49AlHHx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=os9GSmWdZsZByIjV9GNcJtUx956V4YbQFxvhgMk7i1AWhOe9nRBU3lYp/9amjqKWA
         AMAICpLe/jlhtsHxW0XfIjrcx68waV8+DaAhLxntVLs/V6rDtDWHcj7Y3nxs71aWs/
         uftyJW8U2Okr4zuQjzwDN1vanJ7wcictNe2PazJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Hoff <christian_hoff@gmx.net>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 029/101] Input: matrix_keypad - check for errors from of_get_named_gpio()
Date:   Thu,  6 Dec 2018 15:38:28 +0100
Message-Id: <20181206143013.240876328@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/keyboard/matrix_keypad.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -405,7 +405,7 @@ matrix_keypad_parse_dt(struct device *de
 	struct matrix_keypad_platform_data *pdata;
 	struct device_node *np = dev->of_node;
 	unsigned int *gpios;
-	int i, nrow, ncol;
+	int ret, i, nrow, ncol;
 
 	if (!np) {
 		dev_err(dev, "device lacks DT data\n");
@@ -447,12 +447,19 @@ matrix_keypad_parse_dt(struct device *de
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
@@ -479,10 +486,8 @@ static int matrix_keypad_probe(struct pl
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


