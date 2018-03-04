Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeCDMp5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 07:45:57 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43514 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbeCDMpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 07:45:55 -0500
X-Google-Smtp-Source: AG47ELsYfmobYxK6iKM2mFsQiNhSvECtUEyYnskf9OnREmM/ApFir6fqqVhyXn77US+ZpMtqQzmHJw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
        Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] gpio: mockup: fix a potential crash when creating debugfs entries
Date: Sun,  4 Mar 2018 13:45:51 +0100
Message-Id: <20180304124551.22565-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we failed to create the top debugfs directory, we must not try to
create the child nodes. We currently only check if gpio_mockup_dbg_dir
is not NULL, but it can also contain an errno if debugfs is disabled
in build options. Use IS_ERR_OR_NULL() instead.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-mockup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 3a545ad17817..b5876b07b0f7 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -314,7 +314,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	if (rv)
 		return rv;
 
-	if (gpio_mockup_dbg_dir)
+	if (!IS_ERR_OR_NULL(gpio_mockup_dbg_dir))
 		gpio_mockup_debugfs_setup(dev, chip);
 
 	return 0;
-- 
2.16.1
