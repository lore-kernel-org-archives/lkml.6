Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB5DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C15219CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C15219CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeHFEid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:38:33 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47245 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeHFEic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:38:32 -0400
X-Originating-IP: 112.215.208.161
Received: from ubuntuVM.localdomain (unknown [112.215.208.161])
        (Authenticated sender: aditya@kobol.io)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 453CAC0007;
        Mon,  6 Aug 2018 02:31:33 +0000 (UTC)
From:   Aditya Prayoga <aditya@kobol.io>
To:     linux-gpio@vger.kernel.org
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Gauthier Provost <gauthier@kobol.io>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Gilmore <dennis@ausil.us>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH RESEND 2/2] gpio: mvebu: Allow to use non-default PWM counter
Date:   Mon,  6 Aug 2018 10:29:16 +0800
Message-Id: <1533522556-55055-3-git-send-email-aditya@kobol.io>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533522556-55055-1-git-send-email-aditya@kobol.io>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On multiple PWM lines, if the other PWM counter is unused, allocate it
to next PWM request. The priority would be:
1. Default counter assigned to the bank
2. Unused counter that is assigned to other bank
3. Fallback to default counter

For example on second bank there are three PWM request, first one would
use default counter (counter B), second one would try to use counter A,
and the third one would use counter B.

Signed-off-by: Aditya Prayoga <aditya@kobol.io>
---
 drivers/gpio/gpio-mvebu.c | 58 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 0617e66..5a39478 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -92,6 +92,11 @@
 
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
+enum mvebu_pwm_counter {
+	MVEBU_PWM_COUNTER_A = 0,
+	MVEBU_PWM_COUNTER_B,
+};
+
 struct mvebu_pwm_item {
 	struct gpio_desc	*gpiod;
 	struct pwm_device	*device;
@@ -101,7 +106,8 @@ struct mvebu_pwm_item {
 struct mvebu_pwm {
 	void __iomem		*membase;
 	unsigned long		 clk_rate;
-	int	 id;
+	enum mvebu_pwm_counter	 id;
+	struct list_head	 node;
 	struct list_head	 pwms;
 	struct pwm_chip		 chip;
 	spinlock_t		 lock;
@@ -113,6 +119,8 @@ struct mvebu_pwm {
 	u32			 blink_off_duration;
 };
 
+static LIST_HEAD(mvebu_pwm_list);
+
 struct mvebu_gpio_chip {
 	struct gpio_chip   chip;
 	struct regmap     *regs;
@@ -601,12 +609,24 @@ static struct mvebu_pwm *to_mvebu_pwm(struct pwm_chip *chip)
 	return container_of(chip, struct mvebu_pwm, chip);
 }
 
+static struct mvebu_pwm *mvebu_pwm_get_avail_counter(void)
+{
+	struct mvebu_pwm *counter;
+
+	list_for_each_entry(counter, &mvebu_pwm_list, node) {
+		if (list_empty(&counter->pwms))
+			return counter;
+	}
+	return NULL;
+}
+
 static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
 	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
 	struct gpio_desc *desc;
 	struct mvebu_pwm_item *item;
+	struct mvebu_pwm *counter;
 	unsigned long flags;
 	int ret = 0;
 
@@ -615,6 +635,14 @@ static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return -ENODEV;
 
 	spin_lock_irqsave(&mvpwm->lock, flags);
+	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset,
+		    &mvchip->blink_en_reg);
+
+	if (mvchip->blink_en_reg & BIT(pwm->hwpwm)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	desc = gpiochip_request_own_desc(&mvchip->chip,
 					 pwm->hwpwm, "mvebu-pwm");
 	if (IS_ERR(desc)) {
@@ -627,10 +655,25 @@ static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		gpiochip_free_own_desc(desc);
 		goto out;
 	}
+
+	counter = mvpwm;
+	if (!list_empty(&mvpwm->pwms)) {
+		counter = mvebu_pwm_get_avail_counter();
+		if (counter)
+			pwm->chip_data = counter;
+		else
+			counter = mvpwm;
+	}
+
+	regmap_update_bits(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
+				mvchip->offset,	BIT(pwm->hwpwm),
+				counter->id ? BIT(pwm->hwpwm) : 0);
+	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
+			mvchip->offset, &mvpwm->blink_select);
 	item->gpiod = desc;
 	item->device = pwm;
 	INIT_LIST_HEAD(&item->node);
-	list_add_tail(&item->node, &mvpwm->pwms);
+	list_add_tail(&item->node, &counter->pwms);
 out:
 	spin_unlock_irqrestore(&mvpwm->lock, flags);
 	return ret;
@@ -642,6 +685,9 @@ static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mvebu_pwm_item *item, *tmp;
 	unsigned long flags;
 
+	if (pwm->chip_data)
+		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
+
 	list_for_each_entry_safe(item, tmp, &mvpwm->pwms, node) {
 		if (item->device == pwm) {
 			spin_lock_irqsave(&mvpwm->lock, flags);
@@ -665,6 +711,9 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	unsigned long flags;
 	u32 u;
 
+	if (pwm->chip_data)
+		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
+
 	spin_lock_irqsave(&mvpwm->lock, flags);
 
 	val = (unsigned long long)
@@ -712,6 +761,9 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long flags;
 	unsigned int on, off;
 
+	if (pwm->chip_data)
+		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
+
 	val = (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
 	do_div(val, NSEC_PER_SEC);
 	if (val > UINT_MAX)
@@ -823,6 +875,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	mvpwm->mvchip = mvchip;
 	mvpwm->id     = id;
 	INIT_LIST_HEAD(&mvpwm->pwms);
+	INIT_LIST_HEAD(&mvpwm->node);
 
 	mvpwm->membase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(mvpwm->membase))
@@ -846,6 +899,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	mvpwm->chip.base = -1;
 
 	spin_lock_init(&mvpwm->lock);
+	list_add_tail(&mvpwm->node, &mvebu_pwm_list);
 
 	return pwmchip_add(&mvpwm->chip);
 }
-- 
2.7.4

