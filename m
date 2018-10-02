Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D1EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357912064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqZbFTAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357912064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJBPJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:09:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36289 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJBPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:09:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id d4-v6so780912lfa.3;
        Tue, 02 Oct 2018 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DAh2lGFM/YZYv7K7xmYxg/bmzfyJfL49NJ9CLn66MIA=;
        b=gqZbFTAD4iVUHsbJQJ19At9LFZ8wBnG1d7OtK2Ve6qoV8mcOL9BOApdXatfGVkzBbU
         T0LWW5q4TuviCVeGb3TDumGAH3T+azR7Dhoikm3Svq53S7DFPHqv6Gi9nn/N9vb7pumv
         FWiOGwkgG84phd56/+2IamAAky/p4zSWjUUjtvWdidmV6QSNRWV6Wt+AVAcNXEjK2kGf
         5c2FrL4cd5Qrw+7D6efZ7Q7tGs+e5XQWaXBFVlOResQkoB/Nw6Jz7hJ5XaHsbkLJ5ib4
         +eH7fS2lm643oWSb2pa7p0+Tk7oxNuWueOxzLmXH057uDcTNpBpIJmA+9NUQ/Ayzaqhz
         7evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DAh2lGFM/YZYv7K7xmYxg/bmzfyJfL49NJ9CLn66MIA=;
        b=b5W+egX8EbQaCgw3zGD2dGYJTZeecWgY3+ko4XmHLz84h5Hwb10PLVOLB0qsmaCd/W
         gAiFlio6PRGmSDbKl3DVxTauqn2EiEMK+HKaZwJTl9szomDo3ibG8ABT4coeVsanQp1D
         0fsAJhEdOYAumS4I41Zay39F+RSR+5r6so7mnxXskCyiGm9xB2d6U3uTDzv/XLtAr/hO
         GCkobjwbissV+f07CFbgx83OZfF3wguPzRbUlE6B39YlurjJVdAg7xJge1dcAEDSDG41
         MnqcGY+bw5fOd3RwdIdZhSh7Wvqc9dBXHAiviCyEwovsX3/+t5BDylSAS5RDk3aKqmsi
         2qRw==
X-Gm-Message-State: ABuFfog41DgydBInMgnSuy/TZ/MMLccdYC9Ox6jWTLdbtsCmiQBLsby9
        ck/ExSM5Z6DyURfyCv/3Qdo=
X-Google-Smtp-Source: ACcGV60mjG/W1kFIRJozONeiwSpxi1lPP9tm3mFDoLtdfQwUoaTeQNAVBwh+wHMyShQvyqWkAAWTdQ==
X-Received: by 2002:a19:541d:: with SMTP id i29-v6mr8245572lfb.30.1538468854056;
        Tue, 02 Oct 2018 01:27:34 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1493531lji.87.2018.10.02.01.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:27:32 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@codeaurora.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v3 1/3] gpiolib: Add init_valid_mask exported function
Date:   Tue,  2 Oct 2018 10:27:29 +0200
Message-Id: <20181002082731.20141-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function that allows initializing the valid_mask from
gpiochip_add_data.

This prevents race conditions during gpiochip initialization.

If the function is not exported, then the old behaviour is respected,
this is, set all gpios as valid.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpio/gpiolib.c      | 3 +++
 include/linux/gpio/driver.h | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8f8a1999393..6925196136ce 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -377,6 +377,9 @@ static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)
 	if (!gpiochip->valid_mask)
 		return -ENOMEM;
 
+	if (gpiochip->init_valid_mask)
+		return gpiochip->init_valid_mask(gpiochip);
+
 	return 0;
 }
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 0ea328e71ec9..df09749269ff 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -256,6 +256,9 @@ struct gpio_chip {
 
 	void			(*dbg_show)(struct seq_file *s,
 						struct gpio_chip *chip);
+
+	int			(*init_valid_mask)(struct gpio_chip *chip);
+
 	int			base;
 	u16			ngpio;
 	const char		*const *names;
@@ -294,7 +297,9 @@ struct gpio_chip {
 	/**
 	 * @need_valid_mask:
 	 *
-	 * If set core allocates @valid_mask with all bits set to one.
+	 * If set core allocates @valid_mask with all its values initialized
+	 * with init_valid_mask() or set to one if init_valid_mask() is not
+	 * defined
 	 */
 	bool need_valid_mask;
 
-- 
2.19.0

