Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D23A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW7IEa+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D23A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJLNmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:42:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45092 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeJLNmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:42:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id v18-v6so10396591edq.12;
        Thu, 11 Oct 2018 23:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3mKTaMS0kkK29raM86Ph12XNGlWwRBtnOn/l1IJR6M=;
        b=VW7IEa+v5cyp31pfQvM9SxxhqKiRB8tOZqS+vHt85/KirKBTK7bUHbvcKW0iqSiUGK
         eyYQ1yJVplYwFJpMhcjiXEuEqjS0ZHVPQkopF9AQ0u8pPiwtHqHFGZ/pKSLAXcWhADIv
         +jiMP4Hs6UJbx2LDLiCIBBv0uakkRw49AhPniWBnN9qRDgKdr//ds2Z9Zi7hlEMc23Sa
         kbuwT7tiRwI3374sEI8i+cn5FP0eH0tkng+W04WXBp71X7Mm9SwKvsoycVF7KcZpUg8q
         yyj1QRaVN+Wb4MsVQqzw4GHevtQb9h21YWHJaNGe+EL864g/1zWubaWdLUCVjl4PtAcd
         5Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3mKTaMS0kkK29raM86Ph12XNGlWwRBtnOn/l1IJR6M=;
        b=F3YixnMTPAZoeR/Zi6vnjvzHs/KyxTrwGldJw+d6g84uvPnAgrqtWmaMRKOuQoEhfW
         IaulOZ7441D4qweg3R7KOJiQHE2aByUgf+dTb/BSewZqUmSu8owYqx0eWDc/ugoLMAA4
         OSlia8/X9bmrw0iRFghHirW0wEbpDHDHQ1lUvaPQuyJq/xQXugmhxKaYpEtntMBAjn69
         rhJNX1001UijUKqac/UA05sg1ryoIqCp8WL7xMxBd5QoTXWiqZZbyje882iDiol8kobG
         iRjI3fU8HH4HW6xv80gQm4oT7a4viT7s7M9uMERaNpEgtVD95k5LXWTw7ugCYU8EHkE8
         GBoA==
X-Gm-Message-State: ABuFfogzdX/dWu59KqSyO+/vRyiyo4zCcX+m8wZWt6JJRCKopUCgWBbo
        74l5W8V9aqOtMSbixJOIxJU=
X-Google-Smtp-Source: ACcGV63dhubXzooGSXpcE420T2pBQWmdNQH43uxL9rDubNQKIJrwW+tnXZta9lxHMn/la0rSVXuYBA==
X-Received: by 2002:a17:906:228a:: with SMTP id p10-v6mr5543882eja.182.1539324698711;
        Thu, 11 Oct 2018 23:11:38 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id f39-v6sm240701ede.75.2018.10.11.23.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 23:11:37 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Vignesh R <vigneshr@ti.com>, Jeffrey Hugo <jhugo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] gpiolib: Initialize gdev field before is used
Date:   Fri, 12 Oct 2018 08:11:36 +0200
Message-Id: <20181012061136.11421-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio_hog depends on gdev field being initialized. This patch fixes an
OOPs during initialization of TI's AM335x-ICEv2.

Fixes: 3edfb7bd76bd1cba ("gpiolib: Show correct direction from the beginning")
Tested-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpio/gpiolib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e016b22658ff..bcd0ef49ce97 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1349,6 +1349,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
+	for (i = 0; i < chip->ngpio; i++)
+		gdev->descs[i].gdev = gdev;
+
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
@@ -1380,8 +1383,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	for (i = 0; i < chip->ngpio; i++) {
 		struct gpio_desc *desc = &gdev->descs[i];
 
-		desc->gdev = gdev;
-
 		if (chip->get_direction && gpiochip_line_is_valid(chip, i))
 			desc->flags = !chip->get_direction(chip, i) ?
 					(1 << FLAG_IS_OUT) : 0;
-- 
2.19.1

