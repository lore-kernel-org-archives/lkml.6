Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A8FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F049206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dsoo9Em/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F049206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJDEoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:44:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725723AbeJDEoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:44:16 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93LqwjI030903
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 14:54:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=8v/OaRfCIq6hjMBXjXMlTdF1MTIrj2kto/3IUQCAfzA=;
 b=dsoo9Em/nH1Dgb2k68Pjmh+QIksYy292uE2kDM4qskCgMDR02HKnewGgBGgjV3bfbbhI
 +kjbhf4UxENwZ11oHqeyWjO5xtE+YzGrB3RzDd+y4sXunqNCbaW68Ym4GsgVyTZcma7L
 laft0HZ+1nlauX3hY3Av0qEvxdTyfQ75UO4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2mw0mwhafa-11
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 14:54:03 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.20) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Oct
 2018 14:53:57 -0700
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176) id
 150B2655CD42; Wed,  3 Oct 2018 14:53:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt register access
Date:   Wed, 3 Oct 2018 14:53:50 -0700
Message-ID: <20181003215350.3550926-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIMER_INTR_MASK register (Base Address of Timer + 0x38) is not designed
for masking interrupts on ast2500 chips, and it's not even listed in
ast2400 datasheet, so it's not safe to access TIMER_INTR_MASK on aspeed
chips.

Similarly, TIMER_INTR_STATE register (Base Address of Timer + 0x34) is
not interrupt status register on ast2400 and ast2500 chips. Although
there is no side effect to reset the register in fttmr010_common_init(),
it's just misleading to do so.

Besides, "count_down" is renamed to "is_aspeed" in "fttmr010" structure,
and more comments are added so the code is more readble.

Signed-off-by: Tao Ren <taoren@fb.com>
---
Changes in v2:
  - "count_down" is renamed to "is_aspeed" in "fttmr010" structure.
  - more comments are added to make the code more readable.

Tested the patch on:
  - Facebook Backpack CMM AST2500 BMC.
  - Facebook Wedge100 AST2400 BMC.

 drivers/clocksource/timer-fttmr010.c | 73 ++++++++++++++++------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index cf93f6419b51..fadff7915dd9 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -21,7 +21,7 @@
 #include <linux/delay.h>
 
 /*
- * Register definitions for the timers
+ * Register definitions common for all the timer variants.
  */
 #define TIMER1_COUNT		(0x00)
 #define TIMER1_LOAD		(0x04)
@@ -36,9 +36,10 @@
 #define TIMER3_MATCH1		(0x28)
 #define TIMER3_MATCH2		(0x2c)
 #define TIMER_CR		(0x30)
-#define TIMER_INTR_STATE	(0x34)
-#define TIMER_INTR_MASK		(0x38)
 
+/*
+ * Control register (TMC30) bit fields for fttmr010/gemini/moxart timers.
+ */
 #define TIMER_1_CR_ENABLE	BIT(0)
 #define TIMER_1_CR_CLOCK	BIT(1)
 #define TIMER_1_CR_INT		BIT(2)
@@ -53,8 +54,9 @@
 #define TIMER_3_CR_UPDOWN	BIT(11)
 
 /*
- * The Aspeed AST2400 moves bits around in the control register
- * and lacks bits for setting the timer to count upwards.
+ * Control register (TMC30) bit fields for aspeed ast2400/ast2500 timers.
+ * The aspeed timers move bits around in the control register and lacks
+ * bits for setting the timer to count upwards.
  */
 #define TIMER_1_CR_ASPEED_ENABLE	BIT(0)
 #define TIMER_1_CR_ASPEED_CLOCK		BIT(1)
@@ -66,6 +68,18 @@
 #define TIMER_3_CR_ASPEED_CLOCK		BIT(9)
 #define TIMER_3_CR_ASPEED_INT		BIT(10)
 
+/*
+ * Interrupt status/mask register definitions for fttmr010/gemini/moxart
+ * timers.
+ * The registers don't exist and they are not needed on aspeed timers
+ * because:
+ *   - aspeed timer overflow interrupt is controlled by bits in Control
+ *     Register (TMC30).
+ *   - aspeed timers always generate interrupt when either one of the
+ *     Match registers equals to Status register.
+ */
+#define TIMER_INTR_STATE	(0x34)
+#define TIMER_INTR_MASK		(0x38)
 #define TIMER_1_INT_MATCH1	BIT(0)
 #define TIMER_1_INT_MATCH2	BIT(1)
 #define TIMER_1_INT_OVERFLOW	BIT(2)
@@ -80,7 +94,7 @@
 struct fttmr010 {
 	void __iomem *base;
 	unsigned int tick_rate;
-	bool count_down;
+	bool is_aspeed;
 	u32 t1_enable_val;
 	struct clock_event_device clkevt;
 #ifdef CONFIG_ARM
@@ -130,7 +144,7 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	cr &= ~fttmr010->t1_enable_val;
 	writel(cr, fttmr010->base + TIMER_CR);
 
-	if (fttmr010->count_down) {
+	if (fttmr010->is_aspeed) {
 		/*
 		 * ASPEED Timer Controller will load TIMER1_LOAD register
 		 * into TIMER1_COUNT register when the timer is re-enabled.
@@ -175,16 +189,17 @@ static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
 
 	/* Setup counter start from 0 or ~0 */
 	writel(0, fttmr010->base + TIMER1_COUNT);
-	if (fttmr010->count_down)
+	if (fttmr010->is_aspeed) {
 		writel(~0, fttmr010->base + TIMER1_LOAD);
-	else
+	} else {
 		writel(0, fttmr010->base + TIMER1_LOAD);
 
-	/* Enable interrupt */
-	cr = readl(fttmr010->base + TIMER_INTR_MASK);
-	cr &= ~(TIMER_1_INT_OVERFLOW | TIMER_1_INT_MATCH2);
-	cr |= TIMER_1_INT_MATCH1;
-	writel(cr, fttmr010->base + TIMER_INTR_MASK);
+		/* Enable interrupt */
+		cr = readl(fttmr010->base + TIMER_INTR_MASK);
+		cr &= ~(TIMER_1_INT_OVERFLOW | TIMER_1_INT_MATCH2);
+		cr |= TIMER_1_INT_MATCH1;
+		writel(cr, fttmr010->base + TIMER_INTR_MASK);
+	}
 
 	return 0;
 }
@@ -201,9 +216,8 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
 	writel(cr, fttmr010->base + TIMER_CR);
 
 	/* Setup timer to fire at 1/HZ intervals. */
-	if (fttmr010->count_down) {
+	if (fttmr010->is_aspeed) {
 		writel(period, fttmr010->base + TIMER1_LOAD);
-		writel(0, fttmr010->base + TIMER1_MATCH1);
 	} else {
 		cr = 0xffffffff - (period - 1);
 		writel(cr, fttmr010->base + TIMER1_COUNT);
@@ -281,23 +295,21 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	}
 
 	/*
-	 * The Aspeed AST2400 moves bits around in the control register,
-	 * otherwise it works the same.
+	 * The Aspeed timers move bits around in the control register.
 	 */
 	if (is_aspeed) {
 		fttmr010->t1_enable_val = TIMER_1_CR_ASPEED_ENABLE |
 			TIMER_1_CR_ASPEED_INT;
-		/* Downward not available */
-		fttmr010->count_down = true;
+		fttmr010->is_aspeed = true;
 	} else {
 		fttmr010->t1_enable_val = TIMER_1_CR_ENABLE | TIMER_1_CR_INT;
-	}
 
-	/*
-	 * Reset the interrupt mask and status
-	 */
-	writel(TIMER_INT_ALL_MASK, fttmr010->base + TIMER_INTR_MASK);
-	writel(0, fttmr010->base + TIMER_INTR_STATE);
+		/*
+		 * Reset the interrupt mask and status
+		 */
+		writel(TIMER_INT_ALL_MASK, fttmr010->base + TIMER_INTR_MASK);
+		writel(0, fttmr010->base + TIMER_INTR_STATE);
+	}
 
 	/*
 	 * Enable timer 1 count up, timer 2 count up, except on Aspeed,
@@ -306,9 +318,8 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	if (is_aspeed)
 		val = TIMER_2_CR_ASPEED_ENABLE;
 	else {
-		val = TIMER_2_CR_ENABLE;
-		if (!fttmr010->count_down)
-			val |= TIMER_1_CR_UPDOWN | TIMER_2_CR_UPDOWN;
+		val = TIMER_2_CR_ENABLE | TIMER_1_CR_UPDOWN |
+			TIMER_2_CR_UPDOWN;
 	}
 	writel(val, fttmr010->base + TIMER_CR);
 
@@ -321,7 +332,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	writel(0, fttmr010->base + TIMER2_MATCH1);
 	writel(0, fttmr010->base + TIMER2_MATCH2);
 
-	if (fttmr010->count_down) {
+	if (fttmr010->is_aspeed) {
 		writel(~0, fttmr010->base + TIMER2_LOAD);
 		clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
 				      "FTTMR010-TIMER2",
@@ -371,7 +382,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 
 #ifdef CONFIG_ARM
 	/* Also use this timer for delays */
-	if (fttmr010->count_down)
+	if (fttmr010->is_aspeed)
 		fttmr010->delay_timer.read_current_timer =
 			fttmr010_read_current_timer_down;
 	else
-- 
2.17.1

