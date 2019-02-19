Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF99C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E91F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qlZ8eZ5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfBSQHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:07:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37725 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfBSQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:07:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id x10so3344580wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03DPhzkzBjEgdOWVhFdZb0AzmHi0UfZRp68bha7kwZI=;
        b=qlZ8eZ5OnPTUP3S7fsfm6Rz+FwI6kyN4SBm00r768z2nHTu5qAAQZjdsEmmiwMQHPU
         8co+L58+8cb5KQk+Hnbu29h6/P32JxpQh7761v4tM/0xYhdRaZUwlBU6nDduNlaOyH3m
         6eYMRxpqhJJ0ehucGhg10uj/NFIfWDuchrNoVa7wlIh0ek78J64WlXr89qgdpivG+hyj
         kmsvXOxRUQiwFMdYj9vkxVWhvnSWKqoHeYq8JRwc6cJgN7WAhaQpxwmC6r8VmqV5ogtA
         PvWfGXcGGxUbW58wR/Rkwid3DgBBF9zLPebfZavk6VgB1jIkBGuxIgPL0oCMDsETPRZu
         /53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03DPhzkzBjEgdOWVhFdZb0AzmHi0UfZRp68bha7kwZI=;
        b=oy/MOvmrJyw9DUr9Nr0vXYYeydkd1oqa2wBGvZ3LnoKu+jQtbNHH5w1eD4PiRcKE/5
         eFxQ90olq9L/H5+aGj/Q8jnvm9V8cXhzajbVkkpsPoI1JNPZFSL79jDvVquc9QqldqbF
         hEZVzKscVgJtP+5E4sq1VWOxUz0o7Zpfa1mgHGQdfIrP9KI5nMrArEamaw7OrRuyF1aa
         /M3Y45xALFeWXL2+jytnYxWdJQSA50QtNgpoh1eer6sJK3xAkf5hVNlGk7cHPFWAHf00
         s86O0SRyfhedbTkdVBBYTXw1d+dZbpo+Xw793D2a2YBTXrqYhQzaCPFew1x7cpAYJXb/
         zcfA==
X-Gm-Message-State: AHQUAuaUkR49+v+8PBGIvu9qaTSrmO5mw5nQJAtmi05F8slm5Nx/ibqi
        u1N02Y04lkgzxeKxgc4PaY5oow==
X-Google-Smtp-Source: AHgI3IaAn8AYuHkTeR4leU5qH0d8Hbg2i3ONE9nCXv+dMrX92kHXx5kMvxa3aILYNf6dvM3BxaUfug==
X-Received: by 2002:a1c:4884:: with SMTP id v126mr3483841wma.118.1550592420920;
        Tue, 19 Feb 2019 08:07:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h17sm12161381wrq.17.2019.02.19.08.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:07:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 4/7] gpio: mockup: don't create the debugfs link named after the label
Date:   Tue, 19 Feb 2019 17:06:47 +0100
Message-Id: <20190219160650.9614-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219160650.9614-1-brgl@bgdev.pl>
References: <20190219160650.9614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

User-space tests no longer use it and we're breaking the interface
anyway.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 1c945c967f60..0317917a3678 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -234,7 +234,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 				      struct gpio_mockup_chip *chip)
 {
 	struct gpio_mockup_dbgfs_private *priv;
-	struct dentry *evfile, *link;
+	struct dentry *evfile;
 	struct gpio_chip *gc;
 	const char *devname;
 	char *name;
@@ -247,10 +247,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	if (IS_ERR_OR_NULL(chip->dbg_dir))
 		goto err;
 
-	link = debugfs_create_symlink(gc->label, gpio_mockup_dbg_dir, devname);
-	if (IS_ERR_OR_NULL(link))
-		goto err;
-
 	for (i = 0; i < gc->ngpio; i++) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", i);
 		if (!name)
-- 
2.20.1

