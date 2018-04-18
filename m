Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeDRR0h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:26:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36921 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeDRR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:26:36 -0400
From: Colin King <colin.king@canonical.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: make several const arrays static, shrinks object size
Date: Wed, 18 Apr 2018 18:26:34 +0100
Message-Id: <20180418172634.14734-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const read-only arrays 'port' on the stack but
instead make them static. Makes the object code smaller:

Before:
  text    data     bss     dec    hex filename
  8542    4088     672   13302   33f6 drivers/gpio/gpio-gpio-mm.o
 10959    4952     832   16743   4167 drivers/gpio/gpio-104-dio-48e.o
  9022    5064    1408   15494   3c86 drivers/gpio/gpio-104-idi-48.o

After:
  text    data     bss     dec    hex filename
  8372    4144     672   13188   3384 drivers/gpio/gpio-gpio-mm.o
 10790    5008     832   16630   40f6 drivers/gpio/gpio-104-dio-48e.o
  8853    5152    1408   15413   3c35 linux/drivers/gpio/gpio-104-idi-48.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpio/gpio-104-dio-48e.c | 2 +-
 drivers/gpio/gpio-104-idi-48.c  | 2 +-
 drivers/gpio/gpio-gpio-mm.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index f35632609379..2c9738adb3a6 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -94,7 +94,7 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
 	size_t i;
-	const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
 	const unsigned int gpio_reg_size = 8;
 	unsigned int bits_offset;
 	size_t word_index;
diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index d496cc56c2a2..b56ff2efbf36 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -177,7 +177,7 @@ static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 	size_t i;
-	const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
 	const unsigned int gpio_reg_size = 8;
 	unsigned int bits_offset;
 	size_t word_index;
-- 
2.17.0
