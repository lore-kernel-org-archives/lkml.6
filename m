Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D1BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0377218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549201246;
	bh=Ah1tNRJGgrCgeKGpywZ3lCLCzTxC+vz/xHTYV6pdbqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+cu383jXxSDlYpoWLOCWBEYC4RFYHkzKt7por3AI1WPNzvSenxhNgazPW6PKx1uT
	 r50lIeb5NmfnpImnYvlXbtjzhw0klVqldsuGX3B3rOtDQAgLmqjb1oG+RvYFT9XUJh
	 52ktQz4PjL4SJSSSl+Yzp9pri6ROG7YMcUxTTYps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfBCNkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:40:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57524 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfBCNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GXI1MtsIhmcQ974iRTmjpWmjsRXrYgeNfDwmfPbl/68=; b=dlC7sYmEosC9VKr/Lo6mR0uYx+
        wwnIVoMYEaCNx0WZ8AemE4DCMIatUeyTX+TPBJ2+2SMEg7W6+kUMjvE51OBWXeLdHQqMtcmOCxZwY
        RUzJzyv2mTD81calLCjaTVZ+oaIlZiPn0EVXRIKGJ3ERuhMutGwWq3xCGjooLq1ng8Hs=;
Received: from [2001:67c:1810:f055:877d:5801:eba7:24a1] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqI0b-0000WJ-0r; Sun, 03 Feb 2019 13:40:29 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8D9D1440071; Sun,  3 Feb 2019 13:40:26 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] selftests/x86/fsgsbase: Indirect output through a wrapper function
Date:   Sun,  3 Feb 2019 14:40:16 +0100
Message-Id: <20190203134017.9375-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203134017.9375-1-broonie@kernel.org>
References: <20190203134017.9375-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for a change to make this test run repeatedly which
would generate huge amounts of output as is indirect all the printf()
calls in the program through a wrapper and add a quiet flag which can
be used to suppress the output.  This is fairly quick and dirty, I'm not
100% sure what would be idiomatic here.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 52 ++++++++++++++++----------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index f249e042b3b5..6cda6daa1f8c 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -7,6 +7,7 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <stdbool.h>
 #include <string.h>
 #include <sys/syscall.h>
@@ -32,6 +33,17 @@ static volatile sig_atomic_t want_segv;
 static volatile unsigned long segv_addr;
 
 static int nerrs;
+static bool quiet;
+
+static void logger(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	if (!quiet)
+		vprintf(fmt, args);
+	va_end(args);
+}
 
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
@@ -118,29 +130,29 @@ static void check_gs_value(unsigned long value)
 	unsigned long base;
 	unsigned short sel;
 
-	printf("[RUN]\tARCH_SET_GS to 0x%lx\n", value);
+	logger("[RUN]\tARCH_SET_GS to 0x%lx\n", value);
 	if (syscall(SYS_arch_prctl, ARCH_SET_GS, value) != 0)
 		err(1, "ARCH_SET_GS");
 
 	asm volatile ("mov %%gs, %0" : "=rm" (sel));
 	base = read_base(GS);
 	if (base == value) {
-		printf("[OK]\tGSBASE was set as expected (selector 0x%hx)\n",
+		logger("[OK]\tGSBASE was set as expected (selector 0x%hx)\n",
 		       sel);
 	} else {
 		nerrs++;
-		printf("[FAIL]\tGSBASE was not as expected: got 0x%lx (selector 0x%hx)\n",
+		logger("[FAIL]\tGSBASE was not as expected: got 0x%lx (selector 0x%hx)\n",
 		       base, sel);
 	}
 
 	if (syscall(SYS_arch_prctl, ARCH_GET_GS, &base) != 0)
 		err(1, "ARCH_GET_GS");
 	if (base == value) {
-		printf("[OK]\tARCH_GET_GS worked as expected (selector 0x%hx)\n",
+		logger("[OK]\tARCH_GET_GS worked as expected (selector 0x%hx)\n",
 		       sel);
 	} else {
 		nerrs++;
-		printf("[FAIL]\tARCH_GET_GS was not as expected: got 0x%lx (selector 0x%hx)\n",
+		logger("[FAIL]\tARCH_GET_GS was not as expected: got 0x%lx (selector 0x%hx)\n",
 		       base, sel);
 	}
 }
@@ -149,7 +161,7 @@ static void mov_0_gs(unsigned long initial_base, bool schedule)
 {
 	unsigned long base, arch_base;
 
-	printf("[RUN]\tARCH_SET_GS to 0x%lx then mov 0 to %%gs%s\n", initial_base, schedule ? " and schedule " : "");
+	logger("[RUN]\tARCH_SET_GS to 0x%lx then mov 0 to %%gs%s\n", initial_base, schedule ? " and schedule " : "");
 	if (syscall(SYS_arch_prctl, ARCH_SET_GS, initial_base) != 0)
 		err(1, "ARCH_SET_GS");
 
@@ -161,10 +173,10 @@ static void mov_0_gs(unsigned long initial_base, bool schedule)
 	if (syscall(SYS_arch_prctl, ARCH_GET_GS, &arch_base) != 0)
 		err(1, "ARCH_GET_GS");
 	if (base == arch_base) {
-		printf("[OK]\tGSBASE is 0x%lx\n", base);
+		logger("[OK]\tGSBASE is 0x%lx\n", base);
 	} else {
 		nerrs++;
-		printf("[FAIL]\tGSBASE changed to 0x%lx but kernel reports 0x%lx\n", base, arch_base);
+		logger("[FAIL]\tGSBASE changed to 0x%lx but kernel reports 0x%lx\n", base, arch_base);
 	}
 }
 
@@ -195,7 +207,7 @@ static void do_remote_base()
 
 	unsigned short sel;
 	asm volatile ("mov %%gs, %0" : "=rm" (sel));
-	printf("\tother thread: ARCH_SET_GS(0x%lx)%s -- sel is 0x%hx\n",
+	logger("\tother thread: ARCH_SET_GS(0x%lx)%s -- sel is 0x%hx\n",
 	       to_set, hard_zero ? " and clear gs" : "", sel);
 }
 
@@ -228,7 +240,7 @@ void do_unexpected_base(void)
 		.useable         = 0
 	};
 	if (syscall(SYS_modify_ldt, 1, &desc, sizeof(desc)) == 0) {
-		printf("\tother thread: using LDT slot 0\n");
+		logger("\tother thread: using LDT slot 0\n");
 		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0x7));
 	} else {
 		/* No modify_ldt for us (configured out, perhaps) */
@@ -250,10 +262,10 @@ void do_unexpected_base(void)
 		munmap(low_desc, sizeof(desc));
 
 		if (ret != 0) {
-			printf("[NOTE]\tcould not create a segment -- test won't do anything\n");
+			logger("[NOTE]\tcould not create a segment -- test won't do anything\n");
 			return;
 		}
-		printf("\tother thread: using GDT slot %d\n", desc.entry_number);
+		logger("\tother thread: using GDT slot %d\n", desc.entry_number);
 		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)((desc.entry_number << 3) | 0x3)));
 	}
 
@@ -298,10 +310,10 @@ static void set_gs_and_switch_to(unsigned long local,
 		local = 0;
 	}
 
-	printf("[RUN]\tARCH_SET_GS(0x%lx)%s, then schedule to 0x%lx\n",
+	logger("[RUN]\tARCH_SET_GS(0x%lx)%s, then schedule to 0x%lx\n",
 	       local, hard_zero ? " and clear gs" : "", remote);
 	if (force_sel)
-		printf("\tBefore schedule, set selector to 0x%hx\n", force_sel);
+		logger("\tBefore schedule, set selector to 0x%hx\n", force_sel);
 	if (syscall(SYS_arch_prctl, ARCH_SET_GS, local) != 0)
 		err(1, "ARCH_SET_GS");
 	if (hard_zero)
@@ -309,7 +321,7 @@ static void set_gs_and_switch_to(unsigned long local,
 
 	if (read_base(GS) != local) {
 		nerrs++;
-		printf("[FAIL]\tGSBASE wasn't set as expected\n");
+		logger("[FAIL]\tGSBASE wasn't set as expected\n");
 	}
 
 	if (force_sel) {
@@ -335,11 +347,11 @@ static void set_gs_and_switch_to(unsigned long local,
 	asm volatile ("mov %%gs, %0" : "=rm" (sel_post_sched));
 	base = read_base(GS);
 	if (base == local && sel_pre_sched == sel_post_sched) {
-		printf("[OK]\tGS/BASE remained 0x%hx/0x%lx\n",
+		logger("[OK]\tGS/BASE remained 0x%hx/0x%lx\n",
 		       sel_pre_sched, local);
 	} else {
 		nerrs++;
-		printf("[FAIL]\tGS/BASE changed from 0x%hx/0x%lx to 0x%hx/0x%lx\n",
+		logger("[FAIL]\tGS/BASE changed from 0x%hx/0x%lx to 0x%hx/0x%lx\n",
 		       sel_pre_sched, local, sel_post_sched, base);
 	}
 }
@@ -348,7 +360,7 @@ static void test_unexpected_base(void)
 {
 	unsigned long base;
 
-	printf("[RUN]\tARCH_SET_GS(0), clear gs, then manipulate GSBASE in a different thread\n");
+	logger("[RUN]\tARCH_SET_GS(0), clear gs, then manipulate GSBASE in a different thread\n");
 	if (syscall(SYS_arch_prctl, ARCH_SET_GS, 0) != 0)
 		err(1, "ARCH_SET_GS");
 	asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0));
@@ -360,10 +372,10 @@ static void test_unexpected_base(void)
 
 	base = read_base(GS);
 	if (base == 0) {
-		printf("[OK]\tGSBASE remained 0\n");
+		logger("[OK]\tGSBASE remained 0\n");
 	} else {
 		nerrs++;
-		printf("[FAIL]\tGSBASE changed to 0x%lx\n", base);
+		logger("[FAIL]\tGSBASE changed to 0x%lx\n", base);
 	}
 }
 
-- 
2.20.1

