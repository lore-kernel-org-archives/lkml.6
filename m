Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426131AbeBOQg7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:36:59 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:57791 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1426076AbeBOQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:36:19 -0500
From: Nadav Amit <namit@vmware.com>
To: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH RFC v2 6/6] selftest: x86: test using CS64 on compatibility-mode
Date: Thu, 15 Feb 2018 08:36:02 -0800
Message-ID: <20180215163602.61162-7-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215163602.61162-1-namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we mask the 64-bit code segment in compatibility-mode, and since
applications, most notably CRIU, might still use it, add a test to
ensure it does not break.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 tools/testing/selftests/x86/ldt_gdt.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
index 1aef72df20a1..40b442e5c514 100644
--- a/tools/testing/selftests/x86/ldt_gdt.c
+++ b/tools/testing/selftests/x86/ldt_gdt.c
@@ -50,6 +50,11 @@
 # define INT80_CLOBBERS "r8", "r9", "r10", "r11"
 #else
 # define INT80_CLOBBERS
+
+/* copied from asm/segment.h */
+#define GDT_ENTRY_DEFAULT_USER_CS	14
+#define GDT_ENTRY_DEFAULT_USER_DS	15
+
 #endif
 
 static int nerrs;
@@ -907,6 +912,40 @@ static void test_gdt_invalidation(void)
 #endif
 }
 
+struct far_jmp_addr {
+	unsigned long addr;
+	unsigned short seg;
+} __packed;
+
+static void switch_to_cs64(void)
+{
+#ifdef __i386__
+	struct far_jmp_addr far_jmp_compat, far_jmp_64;
+	unsigned short ds;
+
+	/* Poor's man detection of compatibility mode;  */
+	asm volatile ("mov %%ds, %0" : [ds]"=r"(ds));
+	if (ds >> 3 != 5)
+		return;
+
+	far_jmp_64.seg = (6 << 3) | 3;		/* __USER_CS */
+	far_jmp_compat.seg = (4 << 3) | 3;	/* __USER32_CS */
+
+	asm volatile ("movl $.cs64_target, (%[target64])\n\t"
+		      "movl $.cs32_target, (%[target32])\n\t"
+		      "ljmp *%[jmp_addr_64]\n\t"
+		      ".cs64_target:\n\t"
+		      "ljmp *%[jmp_addr_32]\n\t"
+		      ".cs32_target:\n\t" : :
+		      [jmp_addr_64]"m"(far_jmp_64),
+		      [jmp_addr_32]"m"(far_jmp_compat),
+		      [target64]"r"(&far_jmp_64.addr),
+		      [target32]"r"(&far_jmp_compat.addr) : "memory");
+
+	printf("[OK]\tSwitching to CS64 and back\n");
+#endif
+}
+
 int main(int argc, char **argv)
 {
 	if (argc == 1 && !strcmp(argv[0], "ldt_gdt_test_exec"))
@@ -923,5 +962,7 @@ int main(int argc, char **argv)
 
 	test_gdt_invalidation();
 
+	switch_to_cs64();
+
 	return nerrs ? 1 : 0;
 }
-- 
2.14.1
