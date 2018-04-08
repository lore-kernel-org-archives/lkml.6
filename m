Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDHSL6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 14:11:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39073 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeDHSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 14:11:56 -0400
X-Google-Smtp-Source: AIpwx49U0kAvZD8cEuqe9z01w7XpR4wPDJtNi2PviEJhNtY4vLj1GAlM91048KXS6LehXvD1A81h4w==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: tomasz.figa@gmail.com, krzk@kernel.org, s.nawrocki@samsung.com
Cc: linus.walleij@linaro.org, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH] pinctrl/samsung: Correct EINTG banks order
Date: Sun,  8 Apr 2018 20:07:47 +0200
Message-Id: <1523210867-3806-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All banks with GPIO interrupts should be at beginning
of bank array and without any other types of banks between them.
This order is expected by exynos_eint_gpio_irq, when doing
interrupt group to bank translation.
Otherwise, kernel NULL pointer dereference would happen
when trying to handle interrupt, due to wrong bank being looked up.
Observed on s5pv210, when trying to handle gpj0 interrupt,
where kernel was mapping it to gpi bank.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
index 90c2744..de4ab07 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -105,12 +105,12 @@ static const struct samsung_pin_bank_data s5pv210_pin_bank[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(7, 0x1c0, "gpg1", 0x38),
 	EXYNOS_PIN_BANK_EINTG(7, 0x1e0, "gpg2", 0x3c),
 	EXYNOS_PIN_BANK_EINTG(7, 0x200, "gpg3", 0x40),
-	EXYNOS_PIN_BANK_EINTN(7, 0x220, "gpi"),
 	EXYNOS_PIN_BANK_EINTG(8, 0x240, "gpj0", 0x44),
 	EXYNOS_PIN_BANK_EINTG(6, 0x260, "gpj1", 0x48),
 	EXYNOS_PIN_BANK_EINTG(8, 0x280, "gpj2", 0x4c),
 	EXYNOS_PIN_BANK_EINTG(8, 0x2a0, "gpj3", 0x50),
 	EXYNOS_PIN_BANK_EINTG(5, 0x2c0, "gpj4", 0x54),
+	EXYNOS_PIN_BANK_EINTN(7, 0x220, "gpi"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x2e0, "mp01"),
 	EXYNOS_PIN_BANK_EINTN(4, 0x300, "mp02"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x320, "mp03"),
@@ -158,9 +158,6 @@ static const struct samsung_pin_bank_data exynos3250_pin_banks0[] __initconst =
 
 /* pin banks of exynos3250 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos3250_pin_banks1[] __initconst = {
-	EXYNOS_PIN_BANK_EINTN(8, 0x120, "gpe0"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x140, "gpe1"),
-	EXYNOS_PIN_BANK_EINTN(3, 0x180, "gpe2"),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpk0", 0x08),
 	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
 	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
@@ -170,6 +167,9 @@ static const struct samsung_pin_bank_data exynos3250_pin_banks1[] __initconst =
 	EXYNOS_PIN_BANK_EINTG(5, 0x2a0, "gpm2", 0x2c),
 	EXYNOS_PIN_BANK_EINTG(8, 0x2c0, "gpm3", 0x30),
 	EXYNOS_PIN_BANK_EINTG(8, 0x2e0, "gpm4", 0x34),
+	EXYNOS_PIN_BANK_EINTN(8, 0x120, "gpe0"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x140, "gpe1"),
+	EXYNOS_PIN_BANK_EINTN(3, 0x180, "gpe2"),
 	EXYNOS_PIN_BANK_EINTW(8, 0xc00, "gpx0", 0x00),
 	EXYNOS_PIN_BANK_EINTW(8, 0xc20, "gpx1", 0x04),
 	EXYNOS_PIN_BANK_EINTW(8, 0xc40, "gpx2", 0x08),
@@ -630,7 +630,6 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst =
 	EXYNOS_PIN_BANK_EINTG(4, 0x100, "gpc3", 0x20),
 	EXYNOS_PIN_BANK_EINTG(7, 0x120, "gpc1", 0x24),
 	EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpc2", 0x28),
-	EXYNOS_PIN_BANK_EINTN(2, 0x160, "gpm5"),
 	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpd1", 0x2c),
 	EXYNOS_PIN_BANK_EINTG(8, 0x1A0, "gpe0", 0x30),
 	EXYNOS_PIN_BANK_EINTG(2, 0x1C0, "gpe1", 0x34),
@@ -641,6 +640,7 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst =
 	EXYNOS_PIN_BANK_EINTG(2, 0x260, "gpg2", 0x48),
 	EXYNOS_PIN_BANK_EINTG(4, 0x280, "gph0", 0x4c),
 	EXYNOS_PIN_BANK_EINTG(8, 0x2A0, "gph1", 0x50),
+	EXYNOS_PIN_BANK_EINTN(2, 0x160, "gpm5"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x2C0, "gpm7"),
 	EXYNOS_PIN_BANK_EINTN(6, 0x2E0, "gpy0"),
 	EXYNOS_PIN_BANK_EINTN(4, 0x300, "gpy1"),
-- 
2.7.4
