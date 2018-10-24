Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FC7C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A52D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WALh6Y4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A52D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJXWJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:09:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46379 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJXWJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:09:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id a5-v6so1437372pgt.13;
        Wed, 24 Oct 2018 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9mWsTcPqMY0qr/vSPSqluFvmjGHdFxVw9fd9KQt4RmY=;
        b=WALh6Y4rJtkQz6yytTGoV03d3AsVA8UmtFo7nfO8GSICFjO0oMa6xLu0ChpU6NYfzs
         3sYiS2NeMnWGe9/Cg9jXHpip/3pUDx7tqEcSUmJMWZZw7EBHsMGoLrZ3Rfyekcrz+4Iv
         hG1VVDw02Q5HsWXbWA1Lu0AG28mzIIBqLm+KYzUOvSI2CvQGB8+qK9QVjA0570ycadog
         WMR/LTusvlIeJDs2kGp1Mnzh7MmJAg/JqzZCKsk/iVlR33b0oO+YvLCeK+qokk7Rt+Kr
         FwQyE7xmG14QriowVfrMA3QGk+kifAkQ9pwdc8+R+e2s2l2fQ/Pgoy+mL2TcBJaiV375
         tXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9mWsTcPqMY0qr/vSPSqluFvmjGHdFxVw9fd9KQt4RmY=;
        b=m04QtnFYeh1nZNjK6NI8gJCq/V5VouKGmuMwTxTzUvakGHaB3YCTbyWPF6kuENaKxt
         dTMvj8Pe0xbFPs8vwhkFgd6VfvzG4WOWzGOGl2Xs1ZJVVjzMbgOUvaB8GSZiQRrBnPAA
         1opQhC8qX5EtqbTnmLFULJ44CG0coXKhnO54brPt/If+MYVrOSeCBKph91+6JE/soHot
         8G0HyEv8dDyRJMOtKxKxt6T81Pnr9GLRDOpts4hphKbW1ZgZvHb+1uNZntdi0egi+z58
         G8cXGlyHw7JA3/eSH/WomrFp+1z47SZ8Gm1HOTbdYPKjZ/ticr/Tvbk/BXyFuyOKJiuJ
         6Pow==
X-Gm-Message-State: AGRZ1gL3FO8zp6I11DUK1VGY3PJmR53N9KTTdzD6+E4i2suw0yqy947J
        gjwC6oX4EfuVhiclEnbiCG0=
X-Google-Smtp-Source: AJdET5c9RxaNq2ycb4X1QMRfBNVYLG323HGKXewOC8Ar+tOhiwrbUk9Q1Z98AtaLCuSPG/VIM9/A4Q==
X-Received: by 2002:a62:c2c1:: with SMTP id w62-v6mr2694322pfk.35.1540388459727;
        Wed, 24 Oct 2018 06:40:59 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id a64-v6sm6277399pfe.32.2018.10.24.06.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 06:40:58 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpiolib: fix possible use after free on label
Date:   Wed, 24 Oct 2018 21:40:40 +0800
Message-Id: <20181024134040.115413-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiod_request_commit() copies the pointer to the label
passed as an argument only to be used later. But there's a
chance the caller could immediately free the passed string
(e.g., local variable). This could trigger a use after free
when we use gpio label(e.g., gpiochip_unlock_as_irq(),
gpiochip_is_requested()).

To be on the safe side: duplicate the string with
kstrdup_const() so that if an unaware user passes an address
to a stack-allocated buffer, we won't get the arbitrary label.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 drivers/gpio/gpiolib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 25187403e3ac..e600c5f5d9a7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2270,6 +2270,12 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	unsigned long		flags;
 	unsigned		offset;
 
+	if (label) {
+		label = kstrdup_const(label, GFP_KERNEL);
+		if (!label)
+			return -ENOMEM;
+	}
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	/* NOTE:  gpio_request() can be called in early boot,
@@ -2280,6 +2286,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		desc_set_label(desc, label ? : "?");
 		status = 0;
 	} else {
+		kfree_const(label);
 		status = -EBUSY;
 		goto done;
 	}
@@ -2296,6 +2303,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 
 		if (status < 0) {
 			desc_set_label(desc, NULL);
+			kfree_const(label);
 			clear_bit(FLAG_REQUESTED, &desc->flags);
 			goto done;
 		}
@@ -2391,6 +2399,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 			chip->free(chip, gpio_chip_hwgpio(desc));
 			spin_lock_irqsave(&gpio_lock, flags);
 		}
+		kfree_const(desc->label);
 		desc_set_label(desc, NULL);
 		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
 		clear_bit(FLAG_REQUESTED, &desc->flags);
-- 
2.17.1

