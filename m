Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfElH0S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31C48605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeFFRmX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:42:23 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44932 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeFFRmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:42:21 -0400
X-Google-Smtp-Source: ADUXVKLRsUhz/dO6c+/2RMCROlXJEKCRwD/QATzjJEkSDSla4Pbmie+ud0W625GBw8mj/KAXQ5nFiQ==
From: Thomas Hebb <tommyhebb@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
        sebastian.hesselbarth@gmail.com, Jisheng.Zhang@synaptics.com,
        Thomas Hebb <tommyhebb@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM)
Subject: [PATCH v2] pwm: berlin: Don't use broken prescaler values
Date: Wed,  6 Jun 2018 13:42:10 -0400
Message-Id: <a4e1449967f3dbc95770b9ac2bbc1fd116e3cac7.1528306926.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Berlin PWM driver is currently broken on at least BG2CD. The
symptoms manifest as a very non-linear and erratic mapping from the duty
cycle configured in software to the duty cycle produced by hardware.

The cause of the bug is software's configuration of the prescaler, and
in particular its usage of the six prescaler values between the minimum
value of 1 and the maximum value of 4096. As it turns out, these six
values do not actually slow down the PWM clock; rather, they emulate
slowing down the clock by internally multiplying the value of TCNT.

This would be a fine trick, if not for the fact that the internal,
scaled TCNT value has no extra bits beyond the 16 already exposed to
software in the register. What this means is that, for a prescaler of 4,
the software must ensure that the top two bits of TCNT are not set,
because hardware will chop them off; for a prescaler of 8, the top three
bits must not be set, and so forth. Software does not currently ensure
this, resulting in a TCNT several orders of magnitude lower than
intended any time one of those six prescalers are selected.

Because hardware chops off the high bits in its internal shift, the
middle six prescalers don't actually allow *anything* that the first
doesn't. In fact, they are strictly worse than the first, since the
internal shift of TCNT prevents software from setting the low bits,
decreasing the resolution, without providing any extra high bits.

By skipping the useless prescalers entirely, this patch both fixes the
driver's behavior and increases its performance (since, when the 4096
prescaler is selected, it now does only a single shift rather than the
seven successive divisions it did before).

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
2.17.1
