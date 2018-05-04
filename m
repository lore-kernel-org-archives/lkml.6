Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeEDQ67 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:58:59 -0400
Received: from mx2.spb.prosoft.ru ([195.218.156.34]:39204 "EHLO
        mx2.spb.prosoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeEDQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:58:57 -0400
From: Grigoryev Denis <grigoryev@fastwel.ru>
CC: Grigoryev Denis <grigoryev@fastwel.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpio: pca953x: Clear irq trigger type on irq shutdown
Thread-Topic: [PATCH] gpio: pca953x: Clear irq trigger type on irq shutdown
Thread-Index: AQHT48hnaETFee+44UiHIjJQzz2sQw==
Date: Fri, 4 May 2018 16:53:18 +0000
Message-ID: <no_message-id@ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.16.15]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver stores the result of irq_set_type() in the internal variables
irq_trig_raise and irq_trig_fall, which later are used to determine
the GPIOs that must be re-configured as input. These variables retain their
value between gpiolib's  export / unexport, resulting in an incorrect
state in some cases. The corresponding bits in the variables
irq_trig_raise and irq_trig_fall should be cleared in irq_shutdown().

Signed-off-by: Denis Grigoryev <grigoryev@fastwel.ru>
---
 drivers/gpio/gpio-pca953x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d2ead4b..b41be8c 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -522,6 +522,15 @@ static int pca953x_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static void pca953x_irq_shutdown(struct irq_data *d)
+{
+	struct pca953x_chip *chip = irq_data_get_irq_chip_data(d);
+	u8 mask = 1 << (d->hwirq % BANK_SZ);
+
+	chip->irq_trig_raise[d->hwirq / BANK_SZ] &= ~mask;
+	chip->irq_trig_fall[d->hwirq / BANK_SZ] &= ~mask;
+}
+
 static struct irq_chip pca953x_irq_chip = {
 	.name			= "pca953x",
 	.irq_mask		= pca953x_irq_mask,
@@ -529,6 +538,7 @@ static struct irq_chip pca953x_irq_chip = {
 	.irq_bus_lock		= pca953x_irq_bus_lock,
 	.irq_bus_sync_unlock	= pca953x_irq_bus_sync_unlock,
 	.irq_set_type		= pca953x_irq_set_type,
+	.irq_shutdown		= pca953x_irq_shutdown,
 };
 
 static bool pca953x_irq_pending(struct pca953x_chip *chip, u8 *pending)
-- 
2.7.4
