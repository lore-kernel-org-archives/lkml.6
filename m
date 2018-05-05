Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEEBQb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:16:31 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50521 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeEEBQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:16:29 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, pbonzini@redhat.com, hofsass@google.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/24] selftests: kvm: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:18 -0600
Message-Id: <20180505011328.32078-14-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kvm test is skipped because of unmet dependencies and/or unsupported
configuration, it exits with error which is treated as a fail by the
Kselftest framework. This leads to false negative result even when the test
could not be run.

Change it to return kselftest skip code when a test gets skipped to clearly
report that the test could not be run.

Change it to use ksft_exit_skip() when the test is skipped. In addition,
refine test_assert() message to include strerror() string and add explicit
check for root user to clearly identofy non-root user skip case.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/kvm/lib/assert.c          | 10 ++++++++--
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c |  4 +++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index c9f5b7d4ce38..4705729d847e 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -13,6 +13,8 @@
 #include <execinfo.h>
 #include <sys/syscall.h>
 
+#include "../../kselftest.h"
+
 /* Dumps the current stack trace to stderr. */
 static void __attribute__((noinline)) test_dump_stack(void);
 static void test_dump_stack(void)
@@ -65,13 +67,17 @@ test_assert(bool exp, const char *exp_str,
 {
 	va_list ap;
 
+	if (getuid() != 0)
+		ksft_exit_skip("Please run the test as root - Exiting.\n");
+
 	if (!(exp)) {
 		va_start(ap, fmt);
 
 		fprintf(stderr, "==== Test Assertion Failure ====\n"
 			"  %s:%u: %s\n"
-			"  pid=%d tid=%d\n",
-			file, line, exp_str, getpid(), gettid());
+			"  pid=%d tid=%d - %s\n",
+			file, line, exp_str, getpid(), gettid(),
+			strerror(errno));
 		test_dump_stack();
 		if (fmt) {
 			fputs("  ", stderr);
diff --git a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
index 8f7f62093add..62fb73699eb6 100644
--- a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
@@ -28,6 +28,8 @@
 #include <string.h>
 #include <sys/ioctl.h>
 
+#include "../kselftest.h"
+
 #ifndef MSR_IA32_TSC_ADJUST
 #define MSR_IA32_TSC_ADJUST 0x3b
 #endif
@@ -190,7 +192,7 @@ int main(int argc, char *argv[])
 
 	if (!(entry->ecx & CPUID_VMX)) {
 		printf("nested VMX not enabled, skipping test");
-		return 0;
+		return KSFT_SKIP;
 	}
 
 	vm = vm_create_default_vmx(VCPU_ID, (void *) l1_guest_code);
-- 
2.14.1
