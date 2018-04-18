Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeDRRQ5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:16:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35271 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbeDRRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:16:54 -0400
X-Google-Smtp-Source: AIpwx4/sbNkP8eeKyiUeVep+juAGTDJ9tuoFCXrLvrlmt3wfNGGkjOEqy2p2raB4kXq7G+97sn3V7Q==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: rkrcmar@redhat.com
Subject: [PATCH] KVM: selftests: exit with 0 status code when tests cannot be run
Date: Wed, 18 Apr 2018 19:16:49 +0200
Message-Id: <1524071809-20673-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, skipped tests are returning a failure exit code if /dev/kvm does
not exists.  Consistently return a zero status code so that various scripts
over the interwebs do not complain.  Also return a zero status code if
the KVM_CAP_SYNC_REGS capability is not present, and hardcode in the
test the register kinds that are covered (rather than just using whatever
value of KVM_SYNC_X86_VALID_FIELDS is provided by the kernel headers).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile              |  2 +-
 tools/testing/selftests/kvm/include/test_util.h   |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c        | 16 ++++-----
 tools/testing/selftests/kvm/sync_regs_test.c      | 40 ++++++++++++++++++-----
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c |  4 +--
 5 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 2ddcc96ae456..d9d00319b07c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -15,7 +15,7 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
-CFLAGS += -O2 -g -std=gnu99 -I$(LINUX_HDR_PATH) -Iinclude -I$(<D)
+CFLAGS += -O2 -g -std=gnu99 -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -I..
 
 # After inclusion, $(OUTPUT) is defined and
 # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 7ab98e41324f..ac53730b30aa 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include "kselftest.h"
 
 ssize_t test_write(int fd, const void *buf, size_t count);
 ssize_t test_read(int fd, void *buf, size_t count);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2cedfda181d4..37e2a787d2fc 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -50,8 +50,8 @@ int kvm_check_cap(long cap)
 	int kvm_fd;
 
 	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
-	TEST_ASSERT(kvm_fd >= 0, "open %s failed, rc: %i errno: %i",
-		KVM_DEV_PATH, kvm_fd, errno);
+	if (kvm_fd < 0)
+		exit(KSFT_SKIP);
 
 	ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, cap);
 	TEST_ASSERT(ret != -1, "KVM_CHECK_EXTENSION IOCTL failed,\n"
@@ -91,8 +91,8 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 
 	vm->mode = mode;
 	kvm_fd = open(KVM_DEV_PATH, perm);
-	TEST_ASSERT(kvm_fd >= 0, "open %s failed, rc: %i errno: %i",
-		KVM_DEV_PATH, kvm_fd, errno);
+	if (kvm_fd < 0)
+		exit(KSFT_SKIP);
 
 	/* Create VM. */
 	vm->fd = ioctl(kvm_fd, KVM_CREATE_VM, NULL);
@@ -418,8 +418,8 @@ struct kvm_cpuid2 *kvm_get_supported_cpuid(void)
 
 	cpuid = allocate_kvm_cpuid2();
 	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
-	TEST_ASSERT(kvm_fd >= 0, "open %s failed, rc: %i errno: %i",
-		KVM_DEV_PATH, kvm_fd, errno);
+	if (kvm_fd < 0)
+		exit(KSFT_SKIP);
 
 	ret = ioctl(kvm_fd, KVM_GET_SUPPORTED_CPUID, cpuid);
 	TEST_ASSERT(ret == 0, "KVM_GET_SUPPORTED_CPUID failed %d %d\n",
@@ -675,8 +675,8 @@ static int vcpu_mmap_sz(void)
 	int dev_fd, ret;
 
 	dev_fd = open(KVM_DEV_PATH, O_RDONLY);
-	TEST_ASSERT(dev_fd >= 0, "%s open %s failed, rc: %i errno: %i",
-		__func__, KVM_DEV_PATH, dev_fd, errno);
+	if (dev_fd < 0)
+		exit(KSFT_SKIP);
 
 	ret = ioctl(dev_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
 	TEST_ASSERT(ret >= sizeof(struct kvm_run),
diff --git a/tools/testing/selftests/kvm/sync_regs_test.c b/tools/testing/selftests/kvm/sync_regs_test.c
index 428e9473f5e2..eae1ece3c31b 100644
--- a/tools/testing/selftests/kvm/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/sync_regs_test.c
@@ -85,6 +85,9 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
 {
 }
 
+#define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
+#define INVALID_SYNC_FIELD 0x80000000
+
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
@@ -98,9 +101,14 @@ int main(int argc, char *argv[])
 	setbuf(stdout, NULL);
 
 	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
-	TEST_ASSERT((unsigned long)cap == KVM_SYNC_X86_VALID_FIELDS,
-		    "KVM_CAP_SYNC_REGS (0x%x) != KVM_SYNC_X86_VALID_FIELDS (0x%lx)\n",
-		    cap, KVM_SYNC_X86_VALID_FIELDS);
+	if ((cap & TEST_SYNC_FIELDS) != TEST_SYNC_FIELDS) {
+		fprintf(stderr, "KVM_CAP_SYNC_REGS not supported, skipping test\n");
+		exit(KSFT_SKIP);
+	}
+	if ((cap & INVALID_SYNC_FIELD) != 0) {
+		fprintf(stderr, "The \"invalid\" field is not invalid, skipping test\n");
+		exit(KSFT_SKIP);
+	}
 
 	/* Create VM */
 	vm = vm_create_default(VCPU_ID, guest_code);
@@ -108,7 +116,14 @@ int main(int argc, char *argv[])
 	run = vcpu_state(vm, VCPU_ID);
 
 	/* Request reading invalid register set from VCPU. */
-	run->kvm_valid_regs = KVM_SYNC_X86_VALID_FIELDS << 1;
+	run->kvm_valid_regs = INVALID_SYNC_FIELD;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv < 0 && errno == EINVAL,
+		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
+		    rv);
+	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
+
+	run->kvm_valid_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
 	rv = _vcpu_run(vm, VCPU_ID);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
@@ -116,7 +131,14 @@ int main(int argc, char *argv[])
 	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
 
 	/* Request setting invalid register set into VCPU. */
-	run->kvm_dirty_regs = KVM_SYNC_X86_VALID_FIELDS << 1;
+	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv < 0 && errno == EINVAL,
+		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
+		    rv);
+	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
+
+	run->kvm_dirty_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
 	rv = _vcpu_run(vm, VCPU_ID);
 	TEST_ASSERT(rv < 0 && errno == EINVAL,
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
@@ -125,7 +147,7 @@ int main(int argc, char *argv[])
 
 	/* Request and verify all valid register sets. */
 	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
-	run->kvm_valid_regs = KVM_SYNC_X86_VALID_FIELDS;
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	rv = _vcpu_run(vm, VCPU_ID);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 		    "Unexpected exit reason: %u (%s),\n",
@@ -146,7 +168,7 @@ int main(int argc, char *argv[])
 	run->s.regs.sregs.apic_base = 1 << 11;
 	/* TODO run->s.regs.events.XYZ = ABC; */
 
-	run->kvm_valid_regs = KVM_SYNC_X86_VALID_FIELDS;
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	run->kvm_dirty_regs = KVM_SYNC_X86_REGS | KVM_SYNC_X86_SREGS;
 	rv = _vcpu_run(vm, VCPU_ID);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
@@ -172,7 +194,7 @@ int main(int argc, char *argv[])
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
 	 * overwritten with existing guest values.
 	 */
-	run->kvm_valid_regs = KVM_SYNC_X86_VALID_FIELDS;
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.r11 = 0xDEADBEEF;
 	rv = _vcpu_run(vm, VCPU_ID);
@@ -211,7 +233,7 @@ int main(int argc, char *argv[])
 	 * with kvm_sync_regs values.
 	 */
 	run->kvm_valid_regs = 0;
-	run->kvm_dirty_regs = KVM_SYNC_X86_VALID_FIELDS;
+	run->kvm_dirty_regs = TEST_SYNC_FIELDS;
 	run->s.regs.regs.r11 = 0xBBBB;
 	rv = _vcpu_run(vm, VCPU_ID);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
diff --git a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
index 8f7f62093add..aaa633263b2c 100644
--- a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
@@ -189,8 +189,8 @@ int main(int argc, char *argv[])
 	struct kvm_cpuid_entry2 *entry = kvm_get_supported_cpuid_entry(1);
 
 	if (!(entry->ecx & CPUID_VMX)) {
-		printf("nested VMX not enabled, skipping test");
-		return 0;
+		fprintf(stderr, "nested VMX not enabled, skipping test\n");
+		exit(KSFT_SKIP);
 	}
 
 	vm = vm_create_default_vmx(VCPU_ID, (void *) l1_guest_code);
-- 
1.8.3.1
