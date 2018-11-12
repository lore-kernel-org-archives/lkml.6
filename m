Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3C4C0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903D0214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903D0214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbeKLOiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:38:23 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48554 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeKLOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:22 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 75868297D8; Sun, 11 Nov 2018 23:46:55 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-Id: <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementations of arch_gettimeoffset are generally not re-entrant
and assume that interrupts have been disabled. Unfortunately this
pre-condition got broken in v2.6.32.

Fixes: 5cfc8ee0bb51 ("ARM: convert arm to arch_gettimeoffset()")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/arm/mach-ebsa110/core.c | 5 +++++
 arch/arm/mach-rpc/time.c     | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index 688e5fed49a7..479f89a1accf 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -160,12 +160,17 @@ static void __init ebsa110_init_early(void)
  */
 static u32 ebsa110_gettimeoffset(void)
 {
+	unsigned long flags;
 	unsigned long offset, count;
 
+	local_irq_save(flags);
+
 	__raw_writeb(0x40, PIT_CTRL);
 	count = __raw_readb(PIT_T1);
 	count |= __raw_readb(PIT_T1) << 8;
 
+	local_irq_restore(flags);
+
 	/*
 	 * If count > COUNT, make the number negative.
 	 */
diff --git a/arch/arm/mach-rpc/time.c b/arch/arm/mach-rpc/time.c
index 2689771c1d38..852bb3801638 100644
--- a/arch/arm/mach-rpc/time.c
+++ b/arch/arm/mach-rpc/time.c
@@ -29,9 +29,12 @@
 
 static u32 ioc_timer_gettimeoffset(void)
 {
+	unsigned long flags;
 	unsigned int count1, count2, status;
 	long offset;
 
+	local_irq_save(flags);
+
 	ioc_writeb (0, IOC_T0LATCH);
 	barrier ();
 	count1 = ioc_readb(IOC_T0CNTL) | (ioc_readb(IOC_T0CNTH) << 8);
@@ -42,6 +45,8 @@ static u32 ioc_timer_gettimeoffset(void)
 	barrier ();
 	count2 = ioc_readb(IOC_T0CNTL) | (ioc_readb(IOC_T0CNTH) << 8);
 
+	local_irq_restore(flags);
+
 	offset = count2;
 	if (count2 < count1) {
 		/*
-- 
2.18.1

