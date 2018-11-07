Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAA82081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAA82081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbeKGRgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:36:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeKGRgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:36:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA7871fT1220976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 00:07:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA7871Wk1220969;
        Wed, 7 Nov 2018 00:07:01 -0800
Date:   Wed, 7 Nov 2018 00:07:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jordan Borgner <tipbot@zytor.com>
Message-ID: <tip-e8eeb3c8aab044ee8faf5e0389db8518629a9324@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, mail@jordan-borgner.de,
        bp@alien8.de, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
          bp@alien8.de, torvalds@linux-foundation.org,
          mail@jordan-borgner.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20181102145622.zjx2t3mdu3rv6sgy@JordanDesktop>
References: <20181102145622.zjx2t3mdu3rv6sgy@JordanDesktop>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Simplify the detect_memory*() control flow
Git-Commit-ID: e8eeb3c8aab044ee8faf5e0389db8518629a9324
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e8eeb3c8aab044ee8faf5e0389db8518629a9324
Gitweb:     https://git.kernel.org/tip/e8eeb3c8aab044ee8faf5e0389db8518629a9324
Author:     Jordan Borgner <mail@jordan-borgner.de>
AuthorDate: Fri, 2 Nov 2018 14:56:22 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Nov 2018 21:05:01 +0100

x86/boot: Simplify the detect_memory*() control flow

The return values of these functions are not used - so simplify the functions.

No change in functionality.

[ mingo: Simplified the changelog. ]

Suggested: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Jordan Borgner <mail@jordan-borgner.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181102145622.zjx2t3mdu3rv6sgy@JordanDesktop
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/boot.h   |  2 +-
 arch/x86/boot/memory.c | 31 ++++++++++---------------------
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index ef5a9cc66fb8..32a09eb5c101 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -309,7 +309,7 @@ void query_edd(void);
 void __attribute__((noreturn)) die(void);
 
 /* memory.c */
-int detect_memory(void);
+void detect_memory(void);
 
 /* pm.c */
 void __attribute__((noreturn)) go_to_protected_mode(void);
diff --git a/arch/x86/boot/memory.c b/arch/x86/boot/memory.c
index 7df2b28207be..f06c147b5140 100644
--- a/arch/x86/boot/memory.c
+++ b/arch/x86/boot/memory.c
@@ -17,7 +17,7 @@
 
 #define SMAP	0x534d4150	/* ASCII "SMAP" */
 
-static int detect_memory_e820(void)
+static void detect_memory_e820(void)
 {
 	int count = 0;
 	struct biosregs ireg, oreg;
@@ -68,10 +68,10 @@ static int detect_memory_e820(void)
 		count++;
 	} while (ireg.ebx && count < ARRAY_SIZE(boot_params.e820_table));
 
-	return boot_params.e820_entries = count;
+	boot_params.e820_entries = count;
 }
 
-static int detect_memory_e801(void)
+static void detect_memory_e801(void)
 {
 	struct biosregs ireg, oreg;
 
@@ -80,7 +80,7 @@ static int detect_memory_e801(void)
 	intcall(0x15, &ireg, &oreg);
 
 	if (oreg.eflags & X86_EFLAGS_CF)
-		return -1;
+		return;
 
 	/* Do we really need to do this? */
 	if (oreg.cx || oreg.dx) {
@@ -89,7 +89,7 @@ static int detect_memory_e801(void)
 	}
 
 	if (oreg.ax > 15*1024) {
-		return -1;	/* Bogus! */
+		return;	/* Bogus! */
 	} else if (oreg.ax == 15*1024) {
 		boot_params.alt_mem_k = (oreg.bx << 6) + oreg.ax;
 	} else {
@@ -102,11 +102,9 @@ static int detect_memory_e801(void)
 		 */
 		boot_params.alt_mem_k = oreg.ax;
 	}
-
-	return 0;
 }
 
-static int detect_memory_88(void)
+static void detect_memory_88(void)
 {
 	struct biosregs ireg, oreg;
 
@@ -115,22 +113,13 @@ static int detect_memory_88(void)
 	intcall(0x15, &ireg, &oreg);
 
 	boot_params.screen_info.ext_mem_k = oreg.ax;
-
-	return -(oreg.eflags & X86_EFLAGS_CF); /* 0 or -1 */
 }
 
-int detect_memory(void)
+void detect_memory(void)
 {
-	int err = -1;
-
-	if (detect_memory_e820() > 0)
-		err = 0;
-
-	if (!detect_memory_e801())
-		err = 0;
+	detect_memory_e820();
 
-	if (!detect_memory_88())
-		err = 0;
+	detect_memory_e801();
 
-	return err;
+	detect_memory_88();
 }
