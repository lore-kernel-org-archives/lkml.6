Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0416C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E09C20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E09C20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeJNXaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:30:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37352 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728974AbeJNXaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:30:20 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM6-0004cg-Ba; Sun, 14 Oct 2018 16:30:58 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLR-0000IJ-8U; Sun, 14 Oct 2018 16:30:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Rich Felker" <dalias@libc.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@elte.hu>,
        "Russell King" <linux@arm.linux.org.uk>,
        "Huacai Chen" <chenhc@lemote.com>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Kees Cook" <keescook@chromium.org>,
        "James Hogan" <jhogan@kernel.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.625953450@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 113/366] zboot: fix stack protector in compressed
 boot phase
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

From: Huacai Chen <chenhc@lemote.com>

commit 7bbaf27d9c83037b6e60a818e57bdbedf6bc15be upstream.

Calling __stack_chk_guard_setup() in decompress_kernel() is too late
that stack checking always fails for decompress_kernel() itself.  So
remove __stack_chk_guard_setup() and initialize __stack_chk_guard before
we call decompress_kernel().

Original code comes from ARM but also used for MIPS and SH, so fix them
together.  If without this fix, compressed booting of these archs will
fail because stack checking is enabled by default (>=4.16).

Link: http://lkml.kernel.org/r/1522226933-29317-1-git-send-email-chenhc@lemote.com
Fixes: 8779657d29c0 ("stackprotector: Introduce CONFIG_CC_STACKPROTECTOR_STRONG")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Acked-by: James Hogan <jhogan@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Rich Felker <dalias@libc.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: Only ARM has this problem]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -127,12 +127,7 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
@@ -149,8 +144,6 @@ decompress_kernel(unsigned long output_s
 {
 	int ret;
 
-	__stack_chk_guard_setup();
-
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;

