Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E94C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A9E2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Mg1mxkDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A9E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeKAWq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:46:28 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:1226 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbeKAWq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1541079807; x=1572615807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YEPsFPbjB1UlGbv7nVUMRcnG6kWtRYAVCKeChzRjd00=;
  b=Mg1mxkDF5gl0p0q8zv3w3W+8zcgBgvy61E0xC/FZmY6QKoZTsLtTkCSS
   vF4kMgXyg8hfiYgfBS/90FeCx7R9qndMrDoxhXms8oMTKmZJvLae2nLSH
   vmfXVtqNKNaoHTlDXtuQThVdrJnJ34d3NtTtN6zqJLXjpYe0XCfB/BBrI
   A=;
X-IronPort-AV: E=Sophos;i="5.54,452,1534809600"; 
   d="scan'208";a="639833343"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Nov 2018 13:43:24 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wA1DhHdZ053102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 1 Nov 2018 13:43:19 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wA1DhG9a004815;
        Thu, 1 Nov 2018 14:43:16 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id wA1DhF9m004814;
        Thu, 1 Nov 2018 14:43:15 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Julian Stecklina <js@alien8.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] kvm, vmx: move CR2 context switch out of assembly path
Date:   Thu,  1 Nov 2018 14:42:47 +0100
Message-Id: <0b290ddce11ab78951592b9435469cd16773629c.1541079752.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VM entry/exit path is a giant inline assembly statement. Simplify it
by doing CR2 context switching in plain C. Move CR2 restore behind IBRS
clearing, so we reduce the amount of code we execute with IBRS on.

Using {read,write}_cr2() means KVM will use pv_mmu_ops instead of open
coding native_{read,write}_cr2(). The CR2 code has been done in
assembly since KVM's genesis[1], which predates the addition of the
paravirt ops[2], i.e. KVM isn't deliberately avoiding the paravirt
ops.

[1] Commit 6aa8b732ca01 ("[PATCH] kvm: userspace interface")
[2] Commit d3561b7fa0fb ("[PATCH] paravirt: header and stubs for paravirtualisation")

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Reviewed-by: Jan H. Schönherr <jschoenh@amazon.de>
Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ccc6a01..a6e5a5c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11212,6 +11212,9 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	evmcs_rsp = static_branch_unlikely(&enable_evmcs) ?
 		(unsigned long)&current_evmcs->host_rsp : 0;
 
+	if (read_cr2() != vcpu->arch.cr2)
+		write_cr2(vcpu->arch.cr2);
+
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
 
@@ -11231,13 +11234,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"2: \n\t"
 		__ex("vmwrite %%" _ASM_SP ", %%" _ASM_DX) "\n\t"
 		"1: \n\t"
-		/* Reload cr2 if changed */
-		"mov %c[cr2](%0), %%" _ASM_AX " \n\t"
-		"mov %%cr2, %%" _ASM_DX " \n\t"
-		"cmp %%" _ASM_AX ", %%" _ASM_DX " \n\t"
-		"je 3f \n\t"
-		"mov %%" _ASM_AX", %%cr2 \n\t"
-		"3: \n\t"
 		/* Check if vmlaunch of vmresume is needed */
 		"cmpl $0, %c[launched](%0) \n\t"
 		/* Load guest registers.  Don't clobber flags. */
@@ -11298,8 +11294,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"xor %%r14d, %%r14d \n\t"
 		"xor %%r15d, %%r15d \n\t"
 #endif
-		"mov %%cr2, %%" _ASM_AX "   \n\t"
-		"mov %%" _ASM_AX ", %c[cr2](%0) \n\t"
 
 		"xor %%eax, %%eax \n\t"
 		"xor %%ebx, %%ebx \n\t"
@@ -11331,7 +11325,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		[r14]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R14])),
 		[r15]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_R15])),
 #endif
-		[cr2]"i"(offsetof(struct vcpu_vmx, vcpu.arch.cr2)),
 		[wordsize]"i"(sizeof(ulong))
 	      : "cc", "memory"
 #ifdef CONFIG_X86_64
@@ -11365,6 +11358,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
+	vcpu->arch.cr2 = read_cr2();
+
 	/* All fields are clean at this point */
 	if (static_branch_unlikely(&enable_evmcs))
 		current_evmcs->hv_clean_fields |=
-- 
2.7.4

