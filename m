Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0541C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947A420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947A420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLFQ6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:58:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeLFQ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:58:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C512688E5F;
        Thu,  6 Dec 2018 16:58:46 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8068619C7D;
        Thu,  6 Dec 2018 16:58:44 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 6/6] KVM: selftests: Add hyperv_cpuid test
Date:   Thu,  6 Dec 2018 17:58:25 +0100
Message-Id: <20181206165825.1832-7-vkuznets@redhat.com>
In-Reply-To: <20181206165825.1832-1-vkuznets@redhat.com>
References: <20181206165825.1832-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 06 Dec 2018 16:58:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple (and stupid) hyperv_cpuid test: check that we got the
expected number of entries with and without Enlightened VMCS enabled
and that all currently reserved fields are zeroed.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 142 ++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 01a219229238..a5f0f11f4381 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -14,6 +14,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86_64 += x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
+TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 
 TEST_GEN_PROGS_aarch64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
new file mode 100644
index 000000000000..3a9e938f23ca
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test for x86 KVM_CAP_HYPERV_CPUID
+ *
+ * Copyright (C) 2018, Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ */
+
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define VCPU_ID 0
+
+static void guest_code(void)
+{
+}
+
+static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
+			  int evmcs_enabled)
+{
+	int i;
+
+	if (!evmcs_enabled)
+		TEST_ASSERT(hv_cpuid_entries->nent == 6,
+			    "KVM_GET_SUPPORTED_HV_CPUID should return 6 entries"
+			    " when Enlightened VMCS is disabled (returned %d)",
+			    hv_cpuid_entries->nent);
+	else
+		TEST_ASSERT(hv_cpuid_entries->nent == 7,
+			    "KVM_GET_SUPPORTED_HV_CPUID should return 7 entries"
+			    " when Enlightened VMCS is enabled (returned %d)",
+			    hv_cpuid_entries->nent);
+
+	for (i = 0; i < hv_cpuid_entries->nent; i++) {
+		struct kvm_cpuid_entry2 *entry = &hv_cpuid_entries->entries[i];
+
+		TEST_ASSERT((entry->function >= 0x40000000) &&
+			    (entry->function <= 0x4000000A),
+			    "function %lx is our of supported range",
+			    entry->function);
+
+		TEST_ASSERT(entry->index == 0,
+			    ".index field should be zero");
+
+		TEST_ASSERT(entry->index == 0,
+			    ".index field should be zero");
+
+		TEST_ASSERT(entry->flags == 0,
+			    ".flags field should be zero");
+
+		TEST_ASSERT(entry->padding[0] == entry->padding[1]
+			    == entry->padding[2] == 0,
+			    ".index field should be zero");
+
+		/*
+		 * If needed for debug:
+		 * fprintf(stdout,
+		 *	"CPUID%lx EAX=0x%lx EBX=0x%lx ECX=0x%lx EDX=0x%lx\n",
+		 *	entry->function, entry->eax, entry->ebx, entry->ecx,
+		 *	entry->edx);
+		 */
+	}
+
+}
+
+struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(struct kvm_vm *vm)
+{
+	int nent = 20; /* should be enough */
+	static struct kvm_cpuid2 *cpuid;
+	int ret;
+
+	cpuid = malloc(sizeof(*cpuid) + nent * sizeof(struct kvm_cpuid_entry2));
+
+	if (!cpuid) {
+		perror("malloc");
+		abort();
+	}
+
+	cpuid->nent = nent;
+
+	vcpu_ioctl(vm, VCPU_ID, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
+
+	return cpuid;
+}
+
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	int rv;
+	uint16_t evmcs_ver;
+	struct kvm_cpuid2 *hv_cpuid_entries;
+	struct kvm_enable_cap enable_evmcs_cap = {
+		.cap = KVM_CAP_HYPERV_ENLIGHTENED_VMCS,
+		 .args[0] = (unsigned long)&evmcs_ver
+	};
+
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	rv = kvm_check_cap(KVM_CAP_HYPERV_CPUID);
+	if (!rv) {
+		fprintf(stderr,
+			"KVM_CAP_HYPERV_CPUID not supported, skip test\n");
+		exit(KSFT_SKIP);
+	}
+
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, 0, guest_code);
+
+	hv_cpuid_entries = kvm_get_supported_hv_cpuid(vm);
+	if (!hv_cpuid_entries)
+		return 1;
+
+	test_hv_cpuid(hv_cpuid_entries, 0);
+
+	free(hv_cpuid_entries);
+
+	vcpu_ioctl(vm, VCPU_ID, KVM_ENABLE_CAP, &enable_evmcs_cap);
+
+	hv_cpuid_entries = kvm_get_supported_hv_cpuid(vm);
+	if (!hv_cpuid_entries)
+		return 1;
+
+	test_hv_cpuid(hv_cpuid_entries, 1);
+
+	free(hv_cpuid_entries);
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.19.2

