Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED627264B1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED627264B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965381AbeFZDmB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:42:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965340AbeFZDl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:41:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2CF2400224C;
        Tue, 26 Jun 2018 03:41:58 +0000 (UTC)
Received: from virtlab404.virt.lab.eng.bos.redhat.com (virtlab404.virt.lab.eng.bos.redhat.com [10.19.152.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC5A111AF11;
        Tue, 26 Jun 2018 03:41:58 +0000 (UTC)
From:   Wei Huang <wei@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, hofsass@google.com, peng.hao2@zte.com.cn
Subject: [PATCH 1/1] kvm: selftests: add cr4_cpuid_sync_test
Date:   Mon, 25 Jun 2018 23:41:57 -0400
Message-Id: <1529984517-7843-1-git-send-email-wei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 03:41:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 03:41:58 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'wei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM is supposed to update some guest VM's CPUID bits (e.g. OSXSAVE) when
CR4 is changed. A bug was found in KVM recently and it was fixed by
Commit c4d2188206ba ("KVM: x86: Update cpuid properly when CR4.OSXAVE or
CR4.PKE is changed"). This patch adds a test to verify the synchronization
between guest VM's CR4 and CPUID bits.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 tools/testing/selftests/kvm/Makefile              |   1 +
 tools/testing/selftests/kvm/cr4_cpuid_sync_test.c | 129 ++++++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/cr4_cpuid_sync_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index d9d0031..65bda4f 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -9,6 +9,7 @@ LIBKVM_x86_64 = lib/x86.c lib/vmx.c
 TEST_GEN_PROGS_x86_64 = set_sregs_test
 TEST_GEN_PROGS_x86_64 += sync_regs_test
 TEST_GEN_PROGS_x86_64 += vmx_tsc_adjust_test
+TEST_GEN_PROGS_x86_64 += cr4_cpuid_sync_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/cr4_cpuid_sync_test.c
new file mode 100644
index 0000000..dbbaf3c
--- /dev/null
+++ b/tools/testing/selftests/kvm/cr4_cpuid_sync_test.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CR4 and CPUID sync test
+ *
+ * Copyright 2018, Red Hat, Inc. and/or its affiliates.
+ *
+ * Author:
+ *   Wei Huang <wei@redhat.com>
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "x86.h"
+
+#define X86_FEATURE_XSAVE	(1<<26)
+#define X86_FEATURE_OSXSAVE	(1<<27)
+#define VCPU_ID			1
+
+enum {
+	GUEST_UPDATE_CR4 = 0x1000,
+	GUEST_FAILED,
+	GUEST_DONE,
+};
+
+static void exit_to_hv(uint16_t port)
+{
+	__asm__ __volatile__("in %[port], %%al"
+			     :
+			     : [port]"d"(port)
+			     : "rax");
+}
+
+static inline bool cr4_cpuid_is_sync(void)
+{
+	int func, subfunc;
+	uint32_t eax, ebx, ecx, edx;
+	uint64_t cr4;
+
+	func = 0x1;
+	subfunc = 0x0;
+	__asm__ __volatile__("cpuid"
+			     : "=a"(eax), "=b"(ebx), "=c"(ecx), "=d"(edx)
+			     : "a"(func), "c"(subfunc));
+
+	cr4 = get_cr4();
+
+	return (!!(ecx & X86_FEATURE_OSXSAVE)) == (!!(cr4 & X86_CR4_OSXSAVE));
+}
+
+static void guest_code(void)
+{
+	uint64_t cr4;
+
+	/* turn on CR4.OSXSAVE */
+	cr4 = get_cr4();
+	cr4 |= X86_CR4_OSXSAVE;
+	set_cr4(cr4);
+
+	/* verify CR4.OSXSAVE == CPUID.OSXSAVE */
+	if (!cr4_cpuid_is_sync())
+		exit_to_hv(GUEST_FAILED);
+
+	/* notify hypervisor to change CR4 */
+	exit_to_hv(GUEST_UPDATE_CR4);
+
+	/* check again */
+	if (!cr4_cpuid_is_sync())
+		exit_to_hv(GUEST_FAILED);
+
+	exit_to_hv(GUEST_DONE);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	struct kvm_sregs sregs;
+	struct kvm_cpuid_entry2 *entry;
+	int rc;
+
+	entry = kvm_get_supported_cpuid_entry(1);
+	if (!(entry->ecx & X86_FEATURE_XSAVE)) {
+		printf("XSAVE feature not supported, skipping test\n");
+		return 0;
+	}
+
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	/* Create VM */
+	vm = vm_create_default_vmx(VCPU_ID, guest_code);
+	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+	run = vcpu_state(vm, VCPU_ID);
+
+	while (1) {
+		rc = _vcpu_run(vm, VCPU_ID);
+
+		if (run->exit_reason == KVM_EXIT_IO) {
+			switch (run->io.port) {
+			case GUEST_UPDATE_CR4:
+				/* emulate hypervisor clearing CR4.OSXSAVE */
+				vcpu_sregs_get(vm, VCPU_ID, &sregs);
+				sregs.cr4 &= ~X86_CR4_OSXSAVE;
+				vcpu_sregs_set(vm, VCPU_ID, &sregs);
+				break;
+			case GUEST_FAILED:
+				TEST_ASSERT(false, "Guest CR4 bit (OSXSAVE) unsynchronized with CPUID bit.");
+				break;
+			case GUEST_DONE:
+				goto done;
+			default:
+				TEST_ASSERT(false, "Unknown port 0x%x.",
+					    run->io.port);
+			}
+		}
+	}
+
+	kvm_vm_free(vm);
+
+done:
+	return 0;
+}
-- 
1.8.3.1

