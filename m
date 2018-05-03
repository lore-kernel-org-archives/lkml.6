Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeECMqc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:46:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52837 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeECMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:46:27 -0400
X-Google-Smtp-Source: AB8JxZq1AftPYmxrHovOsuowxdY72d9T+v1HF7iTZ/LlmsnBrhxnqYB9hLoM9pHtd02lxiXhDrl3EA==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: ge: Fix build warning
Date: Thu,  3 May 2018 14:46:24 +0200
Message-Id: <20180503124624.14461-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Casting a pointer to u16 can produce a compiler warning such as this:

    drivers/gpio/gpio-ge.c: In function 'gef_gpio_probe':
    drivers/gpio/gpio-ge.c:83:14: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
        gc->ngpio = (u16)of_device_get_match_data(&pdev->dev);
                    ^

Cast the pointer through a uintptr_t to avoid the warning.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-ge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 4c43562434cf..636952769bc8 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -80,7 +80,7 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 	}
 
 	gc->base = -1;
-	gc->ngpio = (u16)of_device_get_match_data(&pdev->dev);
+	gc->ngpio = (u16)(uintptr_t)of_device_get_match_data(&pdev->dev);
 	gc->of_gpio_n_cells = 2;
 	gc->of_node = pdev->dev.of_node;
 
-- 
2.17.0
