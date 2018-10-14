Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4079C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BBD20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BBD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbeJNXgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:36:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36060 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727719AbeJNXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:55 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLh-0004co-TD; Sun, 14 Oct 2018 16:30:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000jW-Ea; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "=?UTF-8?q?=C5=81ukasz=20Stelmach?=" <l.stelmach@samsung.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.719353733@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 336/366] ARM: 8753/1: decompressor: add a missing
 parameter to the addruart macro
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Łukasz Stelmach <l.stelmach@samsung.com>

commit e07e3c33b9c0b5751ade624f44325c9bf2487ea6 upstream.

In commit 639da5ee374b ("ARM: add an extra temp register to the low
level debugging addruart macro") an additional temporary register was
added to the addruart macro, but the decompressor code wasn't updated.

Fixes: 639da5ee374b ("ARM: add an extra temp register to the low level debugging addruart macro")
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/boot/compressed/head.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -24,19 +24,19 @@
 #if defined(CONFIG_DEBUG_ICEDCC)
 
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c0, c5, 0
 		.endm
 #elif defined(CONFIG_CPU_XSCALE)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c8, c0, 0
 		.endm
 #else
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c1, c0, 0
@@ -52,7 +52,7 @@
 		.endm
 
 #if defined(CONFIG_ARCH_SA1100)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		mov	\rb, #0x80000000	@ physical base address
 #ifdef CONFIG_DEBUG_LL_SER3
 		add	\rb, \rb, #0x00050000	@ Ser3
@@ -61,8 +61,8 @@
 #endif
 		.endm
 #else
-		.macro	loadsp,	rb, tmp
-		addruart \rb, \tmp
+		.macro	loadsp,	rb, tmp1, tmp2
+		addruart \rb, \tmp1, \tmp2
 		.endm
 #endif
 #endif
@@ -1219,7 +1219,7 @@ phex:		adr	r3, phexbuf
 		b	1b
 
 @ puts corrupts {r0, r1, r2, r3}
-puts:		loadsp	r3, r1
+puts:		loadsp	r3, r2, r1
 1:		ldrb	r2, [r0], #1
 		teq	r2, #0
 		moveq	pc, lr
@@ -1236,8 +1236,8 @@ puts:		loadsp	r3, r1
 @ putc corrupts {r0, r1, r2, r3}
 putc:
 		mov	r2, r0
+		loadsp	r3, r1, r0
 		mov	r0, #0
-		loadsp	r3, r1
 		b	2b
 
 @ memdump corrupts {r0, r1, r2, r3, r10, r11, r12, lr}

