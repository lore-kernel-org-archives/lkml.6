Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeDJQHS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:07:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:16076 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDJQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:07:15 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0NfySCnhA==
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 2/4] gpio: pca953x: add register definitions for pcal6524 and fix address calculation
Date: Tue, 10 Apr 2018 18:07:02 +0200
Message-Id: <0e9bea79eae7504e61fabdb4a0311f8fdc2f6b25.1523376423.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1523376423.git.hns@goldelico.com>
References: <cover.1523376423.git.hns@goldelico.com>
In-Reply-To: <cover.1523376423.git.hns@goldelico.com>
References: <cover.1523376423.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCAL chips ("L" seems to stand for "latched") have additional
registers starting at address 0x40 to control the latches,
interrupt mask, pull-up and pull down etc.

The constants are so far defined in a way that they fit for
the pcal9555a when shifted by the number of banks, i.e. multiplied
by 2.

Now the pcal6524 has 3 banks which means the relative offset
must be multiplied by 4 which gives a wrong result if not done
carefully, since the base offset is already included in the offset.

For the basic registers shared with all pca93xx/tca64xx chips
there is no such offset.

Therefore, we add code to adjust the register number for exended
registers to the 24 bit accessor functions.

And we add additional register offset constants (not yet used by
the driver code) which are specific to the pcal6524.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 50 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 4a075619b93e..022307d328ff 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -25,25 +25,35 @@
 
 #include <asm/unaligned.h>
 
-#define PCA953X_INPUT		0
-#define PCA953X_OUTPUT		1
-#define PCA953X_INVERT		2
-#define PCA953X_DIRECTION	3
+#define PCA953X_INPUT		0x0
+#define PCA953X_OUTPUT		0x1
+#define PCA953X_INVERT		0x2
+#define PCA953X_DIRECTION	0x3
 
 #define REG_ADDR_AI		0x80
 
-#define PCA957X_IN		0
-#define PCA957X_INVRT		1
-#define PCA957X_BKEN		2
-#define PCA957X_PUPD		3
-#define PCA957X_CFG		4
-#define PCA957X_OUT		5
-#define PCA957X_MSK		6
-#define PCA957X_INTS		7
-
-#define PCAL953X_IN_LATCH	34
-#define PCAL953X_INT_MASK	37
-#define PCAL953X_INT_STAT	38
+#define PCA957X_IN		0x00
+#define PCA957X_INVRT		0x01
+#define PCA957X_BKEN		0x02
+#define PCA957X_PUPD		0x03
+#define PCA957X_CFG		0x04
+#define PCA957X_OUT		0x05
+#define PCA957X_MSK		0x06
+#define PCA957X_INTS		0x07
+
+#define PCAL953X_OUT_STRENGTH	0x20
+#define PCAL953X_IN_LATCH	0x22
+#define PCAL953X_PULL_EN	0x23
+#define PCAL953X_PULL_SEL	0x24
+#define PCAL953X_INT_MASK	0x25
+#define PCAL953X_INT_STAT	0x26
+#define PCAL953X_OUT_CONF	0x27
+
+#define PCAL6524_INT_EDGE	0x28
+#define PCAL6524_INT_CLR	0x2a
+#define PCAL6524_IN_STATUS	0x2b
+#define PCAL6524_OUT_INDCONF	0x2c
+#define PCAL6524_DEBOUNCE	0x2d
 
 #define PCA_GPIO_MASK		0x00FF
 #define PCA_INT			0x0100
@@ -208,6 +218,10 @@ static int pca953x_write_regs_24(struct pca953x_chip *chip, int reg, u8 *val)
 {
 	int bank_shift = fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
 
+	/* adjust register address for pcal6524 */
+	if (reg >= PCAL953X_OUT_STRENGTH)
+		reg -= PCAL953X_OUT_STRENGTH >> 1;
+
 	return i2c_smbus_write_i2c_block_data(chip->client,
 					      (reg << bank_shift) | REG_ADDR_AI,
 					      NBANK(chip), val);
@@ -250,6 +264,10 @@ static int pca953x_read_regs_24(struct pca953x_chip *chip, int reg, u8 *val)
 {
 	int bank_shift = fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
 
+	/* adjust register address for pcal6524 */
+	if (reg >= PCAL953X_OUT_STRENGTH)
+		reg -= PCAL953X_OUT_STRENGTH >> 1;
+
 	return i2c_smbus_read_i2c_block_data(chip->client,
 					     (reg << bank_shift) | REG_ADDR_AI,
 					     NBANK(chip), val);
-- 
2.12.2
