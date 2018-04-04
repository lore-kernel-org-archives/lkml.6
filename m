Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeDDTBv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:01:51 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:26697 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeDDTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:00:43 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pA1dWeZVY=
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
Subject: [PATCH v2 3/5] [RFC] gpio: pca953x: hack to map LEVEL irqs to EDGE irqs (may loose interrupts/hang)
Date: Wed,  4 Apr 2018 21:00:22 +0200
Message-Id: <637f00dd7da98cfeffdc6080914a5f67b433da50.1522868423.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1522868422.git.hns@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com>
In-Reply-To: <cover.1522868422.git.hns@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the interrupt type from the DTS is ignored, i.e.

	interrupt-parent = <&pcal6524>
	interrupts = <10 IRQ_TYPE_EDGE_RISING>

does not overwrite a

	devm_request_threaded_irq(..., IRQ_TYPE_LEVEL_LOW, ...)

in driver code. Therefore, the pca953x driver rejects the
setup of the irq because it can only handle EDGE interrupts
so far.

This hack translates level interrupts to edge interrupts
for the pca953x chips. This is enough for initial testing,
but not a good solution since interrupts may be lost.

If for example the connected chip requests a IRQ_TYPE_LEVEL_LOW
this may have the reason that there may be multiple different
interrupt sources in the chip - wired-or together to the
input of the pca953x. Now if we do edge detecion only,
the first interrupt will generate an EDGE_FALLING, but a
second one won't ever if the first interrupt wasn't already
processed.

IMHO a better solution would be to make the pca953x interrupt
handler check if the irq input is still in the active
level and run the device specific handler again.

But this is a major rework that I must leave to others
with more knowledge and time to work on it. This RFC
patch is for having a reminder.

Not Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index c70acba710c7..c21cfdee2eb6 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -521,6 +521,11 @@ static int pca953x_irq_set_type(struct irq_data *d, unsigned int type)
 	int bank_nb = d->hwirq / BANK_SZ;
 	u8 mask = 1 << (d->hwirq % BANK_SZ);
 
+	if (type & IRQ_TYPE_LEVEL_LOW)
+		type |= IRQ_TYPE_EDGE_FALLING;
+	if (type & IRQ_TYPE_LEVEL_HIGH)
+		type |= IRQ_TYPE_EDGE_RISING;
+
 	if (!(type & IRQ_TYPE_EDGE_BOTH)) {
 		dev_err(&chip->client->dev, "irq %d: unsupported type %d\n",
 			d->irq, type);
-- 
2.12.2
