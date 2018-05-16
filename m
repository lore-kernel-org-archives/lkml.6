Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeEPRCG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:02:06 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:25206 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeEPRBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:01:46 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij05fypFHKw=="
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
Subject: [PATCH v6 3/3] gpio: pca953x: fix address calculation for pcal6524
Date: Wed, 16 May 2018 19:01:26 +0200
Message-Id: <f64bae3796cdf365ffeeb2f06708c5e2799e3604.1526490085.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1526490085.git.hns@goldelico.com>
References: <cover.1526490085.git.hns@goldelico.com>
In-Reply-To: <cover.1526490085.git.hns@goldelico.com>
References: <cover.1526490085.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register constants are so far defined in a way that they fit
for the pcal9555a when shifted by the number of banks, i.e. are
multiplied by 2 in the accessor function.

Now, the pcal6524 has 3 banks which means the relative offset
is multiplied by 4 for the standard registers.

Simply applying the bit shift to the extended registers gives
a wrong result, since the base offset is already included in
the offset.

Therefore, we have to add code to the 24 bit accessor functions
that adjusts the register number for these exended registers.

The formula finally used was developed and proposed by
Andy Shevchenko <andy.shevchenko@gmail.com>.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index c0eb679e60d4..8c63664d0e74 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -222,9 +222,11 @@ static int pca957x_write_regs_16(struct pca953x_chip *chip, int reg, u8 *val)
 static int pca953x_write_regs_24(struct pca953x_chip *chip, int reg, u8 *val)
 {
 	int bank_shift = fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
+	int addr = (reg & PCAL_GPIO_MASK) << bank_shift;
+	int pinctrl = (reg & PCAL_PINCTRL_MASK) << 1;
 
 	return i2c_smbus_write_i2c_block_data(chip->client,
-					      (reg << bank_shift) | REG_ADDR_AI,
+					      pinctrl | addr | REG_ADDR_AI,
 					      NBANK(chip), val);
 }
 
@@ -264,9 +266,11 @@ static int pca953x_read_regs_16(struct pca953x_chip *chip, int reg, u8 *val)
 static int pca953x_read_regs_24(struct pca953x_chip *chip, int reg, u8 *val)
 {
 	int bank_shift = fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
+	int addr = (reg & PCAL_GPIO_MASK) << bank_shift;
+	int pinctrl = (reg & PCAL_PINCTRL_MASK) << 1;
 
 	return i2c_smbus_read_i2c_block_data(chip->client,
-					     (reg << bank_shift) | REG_ADDR_AI,
+					     pinctrl | addr | REG_ADDR_AI,
 					     NBANK(chip), val);
 }
 
-- 
2.12.2
