Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941AEC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5129121470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5129121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJQAmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:42:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbeJQAmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:42:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F43E3082144;
        Tue, 16 Oct 2018 16:50:46 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF4792CFD2;
        Tue, 16 Oct 2018 16:50:42 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v6 10/13] KVM: selftests: state_test: test bare VMXON migration
Date:   Tue, 16 Oct 2018 18:50:08 +0200
Message-Id: <20181016165011.6607-11-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 16 Oct 2018 16:50:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split prepare_for_vmx_operation() into prepare_for_vmx_operation() and
load_vmcs() so we can inject GUEST_SYNC() in between.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../selftests/kvm/include/x86_64/vmx.h        |  1 +
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |  5 +++++
 .../testing/selftests/kvm/x86_64/state_test.c | 22 ++++++++++---------
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |  1 +
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 12ebd836f7ef..4bbee8560292 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -548,5 +548,6 @@ struct vmx_pages {
 struct vmx_pages *vcpu_alloc_vmx(struct kvm_vm *vm, vm_vaddr_t *p_vmx_gva);
 bool prepare_for_vmx_operation(struct vmx_pages *vmx);
 void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp);
+bool load_vmcs(struct vmx_pages *vmx);
 
 #endif /* SELFTEST_KVM_VMX_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index d7c401472247..cc356da9b3d8 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -107,6 +107,11 @@ bool prepare_for_vmx_operation(struct vmx_pages *vmx)
 	if (vmxon(vmx->vmxon_gpa))
 		return false;
 
+	return true;
+}
+
+bool load_vmcs(struct vmx_pages *vmx)
+{
 	/* Load a VMCS. */
 	*(uint32_t *)(vmx->vmcs) = vmcs_revision();
 	if (vmclear(vmx->vmcs_gpa))
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 43df194a7c1e..03da41f0f736 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -26,20 +26,20 @@ static bool have_nested_state;
 
 void l2_guest_code(void)
 {
-	GUEST_SYNC(5);
+	GUEST_SYNC(6);
 
         /* Exit to L1 */
 	vmcall();
 
 	/* L1 has now set up a shadow VMCS for us.  */
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
-	GUEST_SYNC(9);
+	GUEST_SYNC(10);
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
 	GUEST_ASSERT(!vmwrite(GUEST_RIP, 0xc0fffee));
-	GUEST_SYNC(10);
+	GUEST_SYNC(11);
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0fffee);
 	GUEST_ASSERT(!vmwrite(GUEST_RIP, 0xc0ffffee));
-	GUEST_SYNC(11);
+	GUEST_SYNC(12);
 
 	/* Done, exit to L1 and never come back.  */
 	vmcall();
@@ -52,15 +52,17 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	GUEST_SYNC(3);
+	GUEST_ASSERT(load_vmcs(vmx_pages));
 	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
 
-	GUEST_SYNC(3);
+	GUEST_SYNC(4);
 	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
 
 	prepare_vmcs(vmx_pages, l2_guest_code,
 		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
-	GUEST_SYNC(4);
+	GUEST_SYNC(5);
 	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(!vmlaunch());
 	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
@@ -72,7 +74,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(!vmresume());
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
-	GUEST_SYNC(6);
+	GUEST_SYNC(7);
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	GUEST_ASSERT(!vmresume());
@@ -85,12 +87,12 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 
 	GUEST_ASSERT(!vmptrld(vmx_pages->shadow_vmcs_gpa));
 	GUEST_ASSERT(vmlaunch());
-	GUEST_SYNC(7);
+	GUEST_SYNC(8);
 	GUEST_ASSERT(vmlaunch());
 	GUEST_ASSERT(vmresume());
 
 	vmwrite(GUEST_RIP, 0xc0ffee);
-	GUEST_SYNC(8);
+	GUEST_SYNC(9);
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
 
 	GUEST_ASSERT(!vmptrld(vmx_pages->vmcs_gpa));
@@ -101,7 +103,7 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffffee);
 	GUEST_ASSERT(vmlaunch());
 	GUEST_ASSERT(vmresume());
-	GUEST_SYNC(12);
+	GUEST_SYNC(13);
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffffee);
 	GUEST_ASSERT(vmlaunch());
 	GUEST_ASSERT(vmresume());
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 38a91a5f04ac..18fa64db0d7a 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -94,6 +94,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	check_ia32_tsc_adjust(-1 * TSC_ADJUST_VALUE);
 
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	GUEST_ASSERT(load_vmcs(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
 	prepare_vmcs(vmx_pages, l2_guest_code,
-- 
2.17.1

