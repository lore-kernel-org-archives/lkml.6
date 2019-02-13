Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DCCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D192086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391513AbfBMVh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:37:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:41474 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436863AbfBMVhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:37:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 13:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="274859868"
Received: from chang-linux-2.sc.intel.com ([10.3.52.165])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 13:37:03 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 09/12] selftests/x86/fsgsbase: Test WRGSBASE
Date:   Wed, 13 Feb 2019 13:36:21 -0800
Message-Id: <20190213213624.14354-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213213624.14354-1-chang.seok.bae@intel.com>
References: <20190213213624.14354-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

This validates that GS and GSBASE are independently preserved across
context switches.

[ chang: Use FSGSBASE instructions directly instead of .byte ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 102 ++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index f249e042b3b5..5956475972f1 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -23,6 +23,7 @@
 #include <pthread.h>
 #include <asm/ldt.h>
 #include <sys/mman.h>
+#include <setjmp.h>
 
 #ifndef __x86_64__
 # error This test is 64-bit only
@@ -71,6 +72,43 @@ static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
 
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
+	asm volatile("rdgsbase %0" : "=r" (gsbase) :: "memory");
+
+	return gsbase;
+}
+
+static inline unsigned long rdfsbase(void)
+{
+	unsigned long fsbase;
+
+	asm volatile("rdfsbase %0" : "=r" (fsbase) :: "memory");
+
+	return fsbase;
+}
+
+static inline void wrgsbase(unsigned long gsbase)
+{
+	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
+}
+
+static inline void wrfsbase(unsigned long fsbase)
+{
+	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
+}
+
 enum which_base { FS, GS };
 
 static unsigned long read_base(enum which_base which)
@@ -199,14 +237,16 @@ static void do_remote_base()
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
@@ -239,7 +279,7 @@ void do_unexpected_base(void)
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
 		memcpy(low_desc, &desc, sizeof(desc));
 
-		low_desc->entry_number = -1;
+		low_desc->entry_number = set_thread_area_entry_number;
 
 		/* 32-bit set_thread_area */
 		long ret;
@@ -254,6 +294,8 @@ void do_unexpected_base(void)
 			return;
 		}
 		printf("\tother thread: using GDT slot %d\n", desc.entry_number);
+		set_thread_area_entry_number = desc.entry_number;
+
 		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)((desc.entry_number << 3) | 0x3)));
 	}
 
@@ -265,6 +307,34 @@ void do_unexpected_base(void)
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
@@ -371,6 +441,17 @@ int main()
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
@@ -417,6 +498,21 @@ int main()
 
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

