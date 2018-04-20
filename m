Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755141AbeDTNuk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:50:40 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39516 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754953AbeDTNuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:50:39 -0400
X-Google-Smtp-Source: AIpwx486w2UH4KveeVfmooL3diVBobXEcwnXgF+rL0F4Mmvp79p7zFqSQaenRKDOHOxRXwjoh/ofxQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop
Date: Fri, 20 Apr 2018 09:50:20 -0400
Message-Id: <20180420135020.23423-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe-IDIO-24 features 8 bits of TTL GPIO which may be configured for
output or input. This patch fixes an off-by-one error in the loop
conditional for the get_multiple callback so that the TTL GPIO are
handled.

Fixes: ca37081595a2 ("gpio: pcie-idio-24: Implement get_multiple/set_multiple callbacks")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pcie-idio-24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 835607ecf658..32bcbd9a52aa 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -217,7 +217,7 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 	bitmap_zero(bits, chip->ngpio);
 
 	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
+	for (i = 0; i < ARRAY_SIZE(ports) + 1; i++) {
 		/* gpio offset in bits array */
 		bits_offset = i * gpio_reg_size;
 
-- 
2.16.2
