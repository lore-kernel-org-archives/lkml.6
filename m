Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D197C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2262086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2262086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeKSLok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:44:40 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49282 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeKSLoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:44:18 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0236329DFE; Sun, 18 Nov 2018 20:22:17 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1542589838.git.fthain@telegraphics.com.au>
References: <cover.1542589838.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v2 09/14] m68k: hp300: Remove hp300_gettimeoffset()
Date:   Mon, 19 Nov 2018 12:10:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hp300_gettimeoffset() never checks the timer interrupt flag and will
fail to notice when the timer counter gets reloaded. That means the
clock could jump backwards.

Remove this code and leave this platform on the 'jiffies' clocksource.
Note that this amounts to a regression in clock precision. However,
adopting the 'jiffies' clocksource does resolve the monotonicity issue.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
hp300_gettimeoffset() cannot be used in a clocksource conversion
unless it can be made monotonic. I can't fix this without knowing the
details of the timer implementation, such as the relationship between
the timer count and the interrupt flag.
---
 arch/m68k/hp300/time.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index d30b03ea93a2..37cccdb46def 100644
--- a/arch/m68k/hp300/time.c
+++ b/arch/m68k/hp300/time.c
@@ -31,9 +31,6 @@
 #define	CLKMSB2		0x9
 #define	CLKMSB3		0xD
 
-/* This is for machines which generate the exact clock. */
-#define USECS_PER_JIFFY (1000000/HZ)
-
 #define INTVAL ((10000 / 4) - 1)
 
 static irqreturn_t hp300_tick(int irq, void *dev_id)
@@ -53,22 +50,6 @@ static irqreturn_t hp300_tick(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-u32 hp300_gettimeoffset(void)
-{
-  /* Read current timer 1 value */
-  unsigned char lsb, msb1, msb2;
-  unsigned short ticks;
-
-  msb1 = in_8(CLOCKBASE + 5);
-  lsb = in_8(CLOCKBASE + 7);
-  msb2 = in_8(CLOCKBASE + 5);
-  if (msb1 != msb2)
-    /* A carry happened while we were reading.  Read it again */
-    lsb = in_8(CLOCKBASE + 7);
-  ticks = INTVAL - ((msb2 << 8) | lsb);
-  return ((USECS_PER_JIFFY * ticks) / INTVAL) * 1000;
-}
-
 void __init hp300_sched_init(irq_handler_t vector)
 {
   out_8(CLOCKBASE + CLKCR2, 0x1);		/* select CR1 */
-- 
2.18.1

