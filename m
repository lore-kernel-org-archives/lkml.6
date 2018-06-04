Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeFDScx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:32:53 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46373 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeFDScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:32:46 -0400
X-Google-Smtp-Source: ADUXVKIu6m3YkDj8pHHBweXMdudmhC3FyDFgzGNCBVGA3ILjkDOg06g4wdhVSyAgt5sPJdN+7DYoaw==
From: Thomas Hebb <tommyhebb@gmail.com>
To: linux-arm-kernel@vger.kernel.org
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
        sebastian.hesselbarth@gmail.com, jszhang@marvell.com,
        Thomas Hebb <tommyhebb@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND] pwm: berlin: Don't use broken prescaler values
Date: Mon,  4 Jun 2018 14:32:41 -0400
Message-Id: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1528137144.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Six of the eight prescaler values available for Berlin PWM are not true
prescalers but rather internal shifts that throw away the high bits of
TCNT. Currently, we attempt to use those high bits, leading to erratic
behavior. Restrict the prescaler configurations we select to only the
two that respect the full range of TCNT.

Tested on BG2CD.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
 drivers/pwm/pwm-berlin.c | 45 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 771859aca4be..7c8d6a168ceb 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -21,8 +21,18 @@
 #define BERLIN_PWM_EN			0x0
 #define  BERLIN_PWM_ENABLE		BIT(0)
 #define BERLIN_PWM_CONTROL		0x4
-#define  BERLIN_PWM_PRESCALE_MASK	0x7
-#define  BERLIN_PWM_PRESCALE_MAX	4096
+/*
+ * The prescaler claims to support 8 different moduli, configured using the
+ * low three bits of PWM_CONTROL. (Sequentially, they are 1, 4, 8, 16, 64,
+ * 256, 1024, and 4096.)  However, the moduli from 4 to 1024 appear to be
+ * implemented by internally shifting TCNT left without adding additional
+ * bits. So, the max TCNT that actually works for a modulus of 4 is 0x3fff;
+ * for 8, 0x1fff; and so on. This means that those moduli are entirely
+ * useless, as we could just do the shift ourselves. The 4096 modulus is
+ * implemented with a real prescaler, so we do use that, but we treat it
+ * as a flag instead of pretending the modulus is actually configurable.
+ */
+#define  BERLIN_PWM_PRESCALE_4096	0x7
 #define  BERLIN_PWM_INVERT_POLARITY	BIT(3)
 #define BERLIN_PWM_DUTY			0x8
 #define BERLIN_PWM_TCNT			0xc
@@ -46,10 +56,6 @@ static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct berlin_pwm_chip, chip);
 }
 
-static const u32 prescaler_table[] = {
-	1, 4, 8, 16, 64, 256, 1024, 4096
-};
-
 static inline u32 berlin_pwm_readl(struct berlin_pwm_chip *chip,
 				   unsigned int channel, unsigned long offset)
 {
@@ -86,33 +92,32 @@ static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 			     int duty_ns, int period_ns)
 {
 	struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);
-	unsigned int prescale;
+	bool prescale_4096 = false;
 	u32 value, duty, period;
-	u64 cycles, tmp;
+	u64 cycles;
 
 	cycles = clk_get_rate(pwm->clk);
 	cycles *= period_ns;
 	do_div(cycles, NSEC_PER_SEC);
 
-	for (prescale = 0; prescale < ARRAY_SIZE(prescaler_table); prescale++) {
-		tmp = cycles;
-		do_div(tmp, prescaler_table[prescale]);
+	if (cycles > BERLIN_PWM_MAX_TCNT) {
+		prescale_4096 = true;
+		cycles >>= 12; // Prescaled by 4096
 
-		if (tmp <= BERLIN_PWM_MAX_TCNT)
-			break;
+		if (cycles > BERLIN_PWM_MAX_TCNT)
+			return -ERANGE;
 	}
 
-	if (tmp > BERLIN_PWM_MAX_TCNT)
-		return -ERANGE;
-
-	period = tmp;
-	cycles = tmp * duty_ns;
+	period = cycles;
+	cycles *= duty_ns;
 	do_div(cycles, period_ns);
 	duty = cycles;
 
 	value = berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
-	value &= ~BERLIN_PWM_PRESCALE_MASK;
-	value |= prescale;
+	if (prescale_4096)
+		value |= BERLIN_PWM_PRESCALE_4096;
+	else
+		value &= ~BERLIN_PWM_PRESCALE_4096;
 	berlin_pwm_writel(pwm, pwm_dev->hwpwm, value, BERLIN_PWM_CONTROL);
 
 	berlin_pwm_writel(pwm, pwm_dev->hwpwm, duty, BERLIN_PWM_DUTY);
-- 
2.17.0
