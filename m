Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE48C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028202089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPK4aSJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028202089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbeJBUwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:52:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45665 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeJBUwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:52:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id v18-v6so1126188edq.12;
        Tue, 02 Oct 2018 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A8q4HRunLlkAco+4jlBx5T/JrGR3kj2TrYpY+ho239Q=;
        b=kPK4aSJ3Gh7LiW332hwJCU8Fm2Xj+qHsXvOug3t1aH1JI0bLYgWk+Nb6v2XlrwQvzI
         rRq/vtVLPh8Z8esBwZO/pXZgSeQ/tj6hqWFXrr5VNm+KEZpXUT5+KGglUTHm2X3xnzx7
         DBy7aThvrII5VEYMNFMM73ZLNO37f8wcrXoNK3YOlshjD5FEG4MOeqqfDO4ave5JjHFL
         Bz/fgAjKE7FFNjcF71xBtcp5eo34WRxiXzwJSG3Yyr0gbsO0nUgW9noLScrqokSMilvE
         pslgGys3F0Yz/gpVUj8UXludomroFVGaev27Dm14vHvQXklPoLsuzQr78xQt5hx8N28d
         IVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A8q4HRunLlkAco+4jlBx5T/JrGR3kj2TrYpY+ho239Q=;
        b=HHJ8vVbh6C97GSN504SMH4sAewD0/ZVnbROCG4+ZvJ7W3sd5jNY9Kn8Tojivo+kvNv
         JLJOnOD8NaW+DbuAM0Cj54/v2VZ8kW7DpCu+EvknJphuL0R0M5lCE5wzHM8slId68CwJ
         H79evgMbLnTUbgwEVtwf3jZLrDo6MizvGIjZyHRd1R/Vwv/CXLEg/ptjLa4aSVoLuwzR
         Y9ySLkm0Ll/yzjOfhRLTk4sOpwei+s53W0kpm4cZg8xbj+cZ5iZKD56kTYotp4RzO599
         s/Ge+fgFQ2MGRp3Ff440M4dZTUF/pevzV89yiIIASURDPRY6L7i0ar21DS6TbApyg9Su
         uEzw==
X-Gm-Message-State: ABuFfog43d4DrmMaNKIu8VCtBJMd+d4M3BiFflMzWqy90Ye3pSLfrAG+
        1EHLO1C+rSj5OtJocEdbDlY=
X-Google-Smtp-Source: ACcGV63CLj7Y8eJJGpTEL5Ir6WQf8NybQiquel1VeBxOzND0WomgJzD2+fJmDfGO8d86iJJ9+T1Y0Q==
X-Received: by 2002:a50:aed4:: with SMTP id f20-v6mr24049387edd.271.1538489341385;
        Tue, 02 Oct 2018 07:09:01 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2786621eja.44.2018.10.02.07.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:09:00 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v4 3/3] gpiolib: Show correct direction from the beginning
Date:   Tue,  2 Oct 2018 16:08:58 +0200
Message-Id: <20181002140858.16833-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code assumes that the direction is input if direction_input
function is set.
This might not be the case on GPIOs with programmable direction.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
Changelog v4:

timur@kernel.org:
Remove REVISIT comment

 drivers/gpio/gpiolib.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6925196136ce..cad859fece65 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1344,20 +1344,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
-	for (i = 0; i < chip->ngpio; i++) {
-		struct gpio_desc *desc = &gdev->descs[i];
-
-		desc->gdev = gdev;
-
-		/* REVISIT: most hardware initializes GPIOs as inputs (often
-		 * with pullups enabled) so power usage is minimized. Linux
-		 * code should set the gpio direction first thing; but until
-		 * it does, and in case chip->get_direction is not set, we may
-		 * expose the wrong direction in sysfs.
-		 */
-		desc->flags = !chip->direction_input ? (1 << FLAG_IS_OUT) : 0;
-	}
-
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
@@ -1374,6 +1360,19 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	if (status)
 		goto err_remove_irqchip_mask;
 
+	for (i = 0; i < chip->ngpio; i++) {
+		struct gpio_desc *desc = &gdev->descs[i];
+
+		desc->gdev = gdev;
+
+		if (chip->get_direction && gpiochip_line_is_valid(chip, i))
+			desc->flags = !chip->get_direction(chip, i) ?
+					(1 << FLAG_IS_OUT) : 0;
+		else
+			desc->flags = !chip->direction_input ?
+					(1 << FLAG_IS_OUT) : 0;
+	}
+
 	status = gpiochip_add_irqchip(chip, lock_key, request_key);
 	if (status)
 		goto err_remove_chip;
-- 
2.19.0

