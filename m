Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825F2C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B551920657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jordan-borgner.de header.i=@jordan-borgner.de header.b="F790KzKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B551920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jordan-borgner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeKCAG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:06:58 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:35254 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeKCAG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541170773;
        s=strato-dkim-0002; d=jordan-borgner.de;
        h=Message-ID:Subject:Cc:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=57lJ8pm2k5wsvbvbwNyeY2mHXaQseQbXxOJz9Y2jjMw=;
        b=F790KzKP2MiAc2kcMDsV+F6wyd1l9m8WlgZp9uk3wG9q1EP+jeWLlcZ2cmRwTkbHWF
        p02WZItn9whHql6N74e/bN6kHE4qfI6mvrqawHcttWUrejb6qIc9lag2K3YwZ6TL2ZSg
        IdheO3p4rY+kSq9onqbEZfipoeDakJFcQ+f+L3Lq7j1Q0R40kkVll7AQO1rT3esTSfr4
        vvPVANv0AU6iykmsPiUst2uxmlHjOP5b1J+WAL6bneSZpkvIyCYtq7SOrRoviFI/dO89
        gNBNLdz8UZYcgPzZ3GKzsTKkDGTMz4WBKxSlVUmGD+BGWkZDx0940ICWI7bTJMk8CGEO
        u5hA==
X-RZG-AUTH: ":IW0NeWCidO14P1liib3FUweRdVVCz7ay1c0SPzCKsLZUvHozh80V6gGoQeGJaantMcUcRJe5mIbtCrgHkxiccBaMa+VKYZNxzaaeoDv7K+jgyw=="
X-RZG-CLASS-ID: mo00
Received: from JordanDesktop
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id z07cbcuA2EuNHiX
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 2 Nov 2018 15:56:23 +0100 (CET)
Date:   Fri, 2 Nov 2018 14:56:22 +0000
From:   Jordan Borgner <mail@jordan-borgner.de>
To:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: boot: Simplified memory.c
Message-ID: <20181102145622.zjx2t3mdu3rv6sgy@JordanDesktop>
MIME-Version: 1.0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-x86-boot-Simplified-memory.c.patch"
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory.c contains functions that retrieve the memory-map of the
available RAM.

They are all called inside of "detect_memory()" which is 
called in x86/boot/main.c. The return value of "detect_memory()" is 
not checked so none of all the return values have any effect 
on the program flow.

Define them as void-functions to save overhead.

Done by motivation of Ingo Molnar.

Signed-off-by: Jordan Borgner <mail@jordan-borgner.de>
---
 arch/x86/boot/boot.h   |  2 +-
 arch/x86/boot/memory.c | 31 ++++++++++---------------------
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index ef5a9cc..32a09eb 100644
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
index 7df2b28..f06c147 100644
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
-- 
2.11.0

