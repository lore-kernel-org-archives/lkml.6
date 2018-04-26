Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757049AbeDZRge (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:36:34 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.175]:14730 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756822AbeDZRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:35:18 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0Jfyqs9nA==
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
Subject: [PATCH v4 5/7] gpio: pca953x: fix address calculation for pcal6524
Date: Thu, 26 Apr 2018 19:35:00 +0200
Message-Id: <478f5d6b7fe3738dc631a0d848985bec5987465d.1524764101.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
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

Therefore, we add code to the 24 bit accessor functions to
adjust the register number for these exended registers.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index fc863faa3ce4..4194495a7990 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -221,9 +221,11 @@ static int pca957x_write_regs_16(struct pca953x_chip *chip, int reg, u8 *val)
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
 
@@ -263,9 +265,11 @@ static int pca953x_read_regs_16(struct pca953x_chip *chip, int reg, u8 *val)
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
