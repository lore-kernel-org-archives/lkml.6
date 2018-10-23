Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52445C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1958B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1958B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeJXDID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:08:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:55091 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbeJXDID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:08:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 11:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="243726594"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 11:43:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [v3 09/12] selftests/x86/fsgsbase: Test WRGSBASE
Date:   Tue, 23 Oct 2018 11:42:31 -0700
Message-Id: <20181023184234.14025-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023184234.14025-1-chang.seok.bae@intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

This validates that GS and GSBASE are independently preserved across
context switches.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 tools/testing/selftests/x86/fsgsbase.c | 110 ++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index f249e042b3b5..fe7acfef53ba 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -23,6 +23,7 @@
 #include <pthread.h>
 #include <asm/ldt.h>
 #include <sys/mman.h>
+#include <setjmp.h>
 
 #ifndef __x86_64__
 # error This test is 64-bit only
@@ -71,6 +72,51 @@ static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
 
 }
 
+static jmp_buf jmpbuf;
+
+static void sigill(int sig, siginfo_t *si, void *ctx_void)
+{
+	siglongjmp(jmpbuf, 1);
+}
+
+static bool have_fsgsbase;
+
+static inline unsigned long rdgsbase(void)
+{
+	unsigned long gsbase;
+
+	asm volatile(".byte 0xf3,0x48,0x0f,0xae,0xc8 # rdgsbaseq %%rax"
+			: "=a" (gsbase)
+			:: "memory");
+
+	return gsbase;
+}
+
+static inline unsigned long rdfsbase(void)
+{
+	unsigned long fsbase;
+
+	asm volatile(".byte 0xf3,0x48,0x0f,0xae,0xc0 # rdfsbaseq %%rax"
+			: "=a" (fsbase)
+			:: "memory");
+
+	return fsbase;
+}
+
+static inline void wrgsbase(unsigned long gsbase)
+{
+	asm volatile(".byte 0xf3,0x48,0x0f,0xae,0xd8 # wrgsbaseq %%rax"
+			:: "a" (gsbase)
+			: "memory");
+}
+
+static inline void wrfsbase(unsigned long fsbase)
+{
+	asm volatile(".byte 0xf3,0x48,0x0f,0xae,0xd0 # wrfsbaseq %%rax"
+			:: "a" (fsbase)
+			: "memory");
+}
+
 enum which_base { FS, GS };
 
 static unsigned long read_base(enum which_base which)
@@ -199,14 +245,16 @@ static void do_remote_base()
 	       to_set, hard_zero ? " and clear gs" : "", sel);
 }
 
-void do_unexpected_base(void)
+static __thread int set_thread_area_entry_number = -1;
+
+static void do_unexpected_base(void)
 {
 	/*
 	 * The goal here is to try to arrange for GS == 0, GSBASE !=
 	 * 0, and for the the kernel the think that GSBASE == 0.
 	 *
 	 * To make the test as reliable as possible, this uses
-	 * explicit descriptorss.  (This is not the only way.  This
+	 * explicit descriptors.  (This is not the only way.  This
 	 * could use ARCH_SET_GS with a low, nonzero base, but the
 	 * relevant side effect of ARCH_SET_GS could change.)
 	 */
@@ -239,7 +287,7 @@ void do_unexpected_base(void)
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
 		memcpy(low_desc, &desc, sizeof(desc));
 
-		low_desc->entry_number = -1;
+		low_desc->entry_number = set_thread_area_entry_number;
 
 		/* 32-bit set_thread_area */
 		long ret;
@@ -254,6 +302,8 @@ void do_unexpected_base(void)
 			return;
 		}
 		printf("\tother thread: using GDT slot %d\n", desc.entry_number);
+		set_thread_area_entry_number = desc.entry_number;
+
 		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)((desc.entry_number << 3) | 0x3)));
 	}
 
@@ -265,6 +315,34 @@ void do_unexpected_base(void)
 	asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0));
 }
 
+void test_wrbase(unsigned short index, unsigned long base)
+{
+	unsigned short newindex;
+	unsigned long newbase;
+
+	printf("[RUN]\tGS = 0x%hx, GSBASE = 0x%lx\n", index, base);
+
+	asm volatile ("mov %0, %%gs" : : "rm" (index));
+	wrgsbase(base);
+
+	remote_base = 0;
+	ftx = 1;
+	syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
+	while (ftx != 0)
+		syscall(SYS_futex, &ftx, FUTEX_WAIT, 1, NULL, NULL, 0);
+
+	asm volatile ("mov %%gs, %0" : "=rm" (newindex));
+	newbase = rdgsbase();
+
+	if (newindex == index && newbase == base) {
+		printf("[OK]\tIndex and base were preserved\n");
+	} else {
+		printf("[FAIL]\tAfter switch, GS = 0x%hx and GSBASE = 0x%lx\n",
+		       newindex, newbase);
+		nerrs++;
+	}
+}
+
 static void *threadproc(void *ctx)
 {
 	while (1) {
@@ -371,6 +449,17 @@ int main()
 {
 	pthread_t thread;
 
+	/* Probe FSGSBASE */
+	sethandler(SIGILL, sigill, 0);
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		rdfsbase();
+		have_fsgsbase = true;
+		printf("\tFSGSBASE instructions are enabled\n");
+	} else {
+		printf("\tFSGSBASE instructions are disabled\n");
+	}
+	clearhandler(SIGILL);
+
 	sethandler(SIGSEGV, sigsegv, 0);
 
 	check_gs_value(0);
@@ -417,6 +506,21 @@ int main()
 
 	test_unexpected_base();
 
+	if (have_fsgsbase) {
+		unsigned short ss;
+
+		asm volatile ("mov %%ss, %0" : "=rm" (ss));
+
+		test_wrbase(0, 0);
+		test_wrbase(0, 1);
+		test_wrbase(0, 0x200000000);
+		test_wrbase(0, 0xffffffffffffffff);
+		test_wrbase(ss, 0);
+		test_wrbase(ss, 1);
+		test_wrbase(ss, 0x200000000);
+		test_wrbase(ss, 0xffffffffffffffff);
+	}
+
 	ftx = 3;  /* Kill the thread. */
 	syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
 
-- 
2.19.1

