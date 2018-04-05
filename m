Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeDEMAR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:00:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48411 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeDEMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:00:15 -0400
From: Colin King <colin.king@canonical.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: 104-dio-48e: make array 'ports' static, shrinks object size
Date: Thu,  5 Apr 2018 13:00:12 +0100
Message-Id: <20180405120012.7671-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const read-only array 'ports' on the stack but instead
make it static. Makes the object code smaller by over 100 buytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  10959	   4952	    832	  16743	   4167	drivers/gpio/gpio-104-dio-48e.o

After:
   text	   data	    bss	    dec	    hex	filename
  10790	   5008	    832	  16630	   40f6	drivers/gpio/gpio-104-dio-48e.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpio/gpio-104-dio-48e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 31e22c93e844..9c4e07fcb74b 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -188,7 +188,7 @@ static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	size_t i;
-	const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
 	const unsigned int gpio_reg_size = 8;
 	unsigned int bits_offset;
 	size_t word_index;
-- 
2.15.1
