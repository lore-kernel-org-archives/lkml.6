Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE882075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="CbhgQUnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE882075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeJXQ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:56:55 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56614 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJXQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540369786; x=1571905786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r9pFQ2+Kis40MqGPKw3NvesWLLEYany1nU1/R2zjamA=;
  b=CbhgQUnm1UL0B8nq7nYAE/w3q+Q7uJeygT6nR9iQcFDqfbdGHTUpI6AS
   k5ZIAUbgzi9c8zJumUsOqbvTVV5I+7P6J0AhTQV3gAUL6BoBEMJWH4xN+
   khHnM5SmQs7wBHdfVsXcUxZLMo+OjijGD2eKa739mSeinZUn3+T/sbAZC
   s=;
X-IronPort-AV: E=Sophos;i="5.54,419,1534809600"; 
   d="scan'208";a="766031222"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Oct 2018 08:29:45 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9O8TcdU044798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 24 Oct 2018 08:29:40 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9O8TcPL030186;
        Wed, 24 Oct 2018 10:29:38 +0200
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w9O8TcFB030185;
        Wed, 24 Oct 2018 10:29:38 +0200
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>, js@alien8.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] kvm, vmx: remove manually coded vmx instructions
Date:   Wed, 24 Oct 2018 10:28:59 +0200
Message-Id: <ba8f4a02e90f1dc95a900f6a34caddce40a358d4.1540369608.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
In-Reply-To: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the VMX code relied on manually assembled VMX instructions. This
was apparently done to ensure compatibility with old binutils. VMX
instructions were introduced with binutils 2.19 and the kernel currently
requires binutils 2.20.

Remove the manually assembled versions and replace them with the proper
inline assembly. This improves code generation (and source code
readability).

According to the bloat-o-meter this change removes ~1300 bytes from the
text segment.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Reviewed-by: Jan H. Schönherr <jschoenh@amazon.de>
Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
Reviewed-by: Razvan-Alin Ghitulete <rga@amazon.de>
---
 arch/x86/include/asm/virtext.h |  2 +-
 arch/x86/include/asm/vmx.h     | 13 -------------
 arch/x86/kvm/vmx.c             | 39 ++++++++++++++++++---------------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 0116b2e..c5395b3 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -40,7 +40,7 @@ static inline int cpu_has_vmx(void)
  */
 static inline void cpu_vmxoff(void)
 {
-	asm volatile (ASM_VMX_VMXOFF : : : "cc");
+	asm volatile ("vmxoff" : : : "cc");
 	cr4_clear_bits(X86_CR4_VMXE);
 }
 
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 9527ba5..ade0f15 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -503,19 +503,6 @@ enum vmcs_field {
 
 #define VMX_EPT_IDENTITY_PAGETABLE_ADDR		0xfffbc000ul
 
-
-#define ASM_VMX_VMCLEAR_RAX       ".byte 0x66, 0x0f, 0xc7, 0x30"
-#define ASM_VMX_VMLAUNCH          ".byte 0x0f, 0x01, 0xc2"
-#define ASM_VMX_VMRESUME          ".byte 0x0f, 0x01, 0xc3"
-#define ASM_VMX_VMPTRLD_RAX       ".byte 0x0f, 0xc7, 0x30"
-#define ASM_VMX_VMREAD_RDX_RAX    ".byte 0x0f, 0x78, 0xd0"
-#define ASM_VMX_VMWRITE_RAX_RDX   ".byte 0x0f, 0x79, 0xd0"
-#define ASM_VMX_VMWRITE_RSP_RDX   ".byte 0x0f, 0x79, 0xd4"
-#define ASM_VMX_VMXOFF            ".byte 0x0f, 0x01, 0xc4"
-#define ASM_VMX_VMXON_RAX         ".byte 0xf3, 0x0f, 0xc7, 0x30"
-#define ASM_VMX_INVEPT		  ".byte 0x66, 0x0f, 0x38, 0x80, 0x08"
-#define ASM_VMX_INVVPID		  ".byte 0x66, 0x0f, 0x38, 0x81, 0x08"
-
 struct vmx_msr_entry {
 	u32 index;
 	u32 reserved;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 82cfb909..bbbdccb 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2077,7 +2077,7 @@ static int __find_msr_index(struct vcpu_vmx *vmx, u32 msr)
 	return -1;
 }
 
-static inline void __invvpid(int ext, u16 vpid, gva_t gva)
+static inline void __invvpid(long ext, u16 vpid, gva_t gva)
 {
 	struct {
 		u64 vpid : 16;
@@ -2086,21 +2086,21 @@ static inline void __invvpid(int ext, u16 vpid, gva_t gva)
 	} operand = { vpid, 0, gva };
 	bool error;
 
-	asm volatile (__ex(ASM_VMX_INVVPID) CC_SET(na)
-		      : CC_OUT(na) (error) : "a"(&operand), "c"(ext)
+	asm volatile ("invvpid %1, %2" CC_SET(na)
+		      : CC_OUT(na) (error) : "m"(operand), "r"(ext)
 		      : "memory");
 	BUG_ON(error);
 }
 
-static inline void __invept(int ext, u64 eptp, gpa_t gpa)
+static inline void __invept(long ext, u64 eptp, gpa_t gpa)
 {
 	struct {
 		u64 eptp, gpa;
 	} operand = {eptp, gpa};
 	bool error;
 
-	asm volatile (__ex(ASM_VMX_INVEPT) CC_SET(na)
-		      : CC_OUT(na) (error) : "a" (&operand), "c" (ext)
+	asm volatile ("invept %1, %2" CC_SET(na)
+		      : CC_OUT(na) (error) : "m" (operand), "r" (ext)
 		      : "memory");
 	BUG_ON(error);
 }
@@ -2120,8 +2120,8 @@ static void vmcs_clear(struct vmcs *vmcs)
 	u64 phys_addr = __pa(vmcs);
 	bool error;
 
-	asm volatile (__ex(ASM_VMX_VMCLEAR_RAX) CC_SET(na)
-		      : CC_OUT(na) (error) : "a"(&phys_addr), "m"(phys_addr)
+	asm volatile ("vmclear %1" CC_SET(na)
+		      : CC_OUT(na) (error) : "m"(phys_addr)
 		      : "memory");
 	if (unlikely(error))
 		printk(KERN_ERR "kvm: vmclear fail: %p/%llx\n",
@@ -2145,8 +2145,8 @@ static void vmcs_load(struct vmcs *vmcs)
 	if (static_branch_unlikely(&enable_evmcs))
 		return evmcs_load(phys_addr);
 
-	asm volatile (__ex(ASM_VMX_VMPTRLD_RAX) CC_SET(na)
-		      : CC_OUT(na) (error) : "a"(&phys_addr), "m"(phys_addr)
+	asm volatile ("vmptrld %1" CC_SET(na)
+		      : CC_OUT(na) (error) : "m"(phys_addr)
 		      : "memory");
 	if (unlikely(error))
 		printk(KERN_ERR "kvm: vmptrld %p/%llx failed\n",
@@ -2323,8 +2323,7 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 {
 	unsigned long value;
 
-	asm volatile (__ex_clear(ASM_VMX_VMREAD_RDX_RAX, "%0")
-		      : "=a"(value) : "d"(field) : "cc");
+	asm volatile ("vmread %1, %0" : "=rm"(value) : "r"(field) : "cc");
 	return value;
 }
 
@@ -2375,8 +2374,8 @@ static __always_inline void __vmcs_writel(unsigned long field, unsigned long val
 {
 	bool error;
 
-	asm volatile (__ex(ASM_VMX_VMWRITE_RAX_RDX) CC_SET(na)
-		      : CC_OUT(na) (error) : "a"(value), "d"(field));
+	asm volatile ("vmwrite %1, %2" CC_SET(na)
+		      : CC_OUT(na) (error) : "rm"(value), "r"(field));
 	if (unlikely(error))
 		vmwrite_error(field, value);
 }
@@ -4397,9 +4396,7 @@ static void kvm_cpu_vmxon(u64 addr)
 	cr4_set_bits(X86_CR4_VMXE);
 	intel_pt_handle_vmx(1);
 
-	asm volatile (ASM_VMX_VMXON_RAX
-			: : "a"(&addr), "m"(addr)
-			: "memory", "cc");
+	asm volatile ("vmxon %0" : : "m"(addr) : "memory", "cc");
 }
 
 static int hardware_enable(void)
@@ -4468,7 +4465,7 @@ static void vmclear_local_loaded_vmcss(void)
  */
 static void kvm_cpu_vmxoff(void)
 {
-	asm volatile (__ex(ASM_VMX_VMXOFF) : : : "cc");
+	asm volatile ("vmxoff" : : : "cc");
 
 	intel_pt_handle_vmx(0);
 	cr4_clear_bits(X86_CR4_VMXE);
@@ -10748,7 +10745,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"mov %%" _ASM_SP ", (%%" _ASM_SI ") \n\t"
 		"jmp 1f \n\t"
 		"2: \n\t"
-		__ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"
+		"vmwrite %%" _ASM_SP ", %%" _ASM_DX "\n\t"
 		"1: \n\t"
 		/* Check if vmlaunch of vmresume is needed */
 		"cmpl $0, %c[launched](%0) \n\t"
@@ -10773,9 +10770,9 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 
 		/* Enter guest mode */
 		"jne 1f \n\t"
-		__ex(ASM_VMX_VMLAUNCH) "\n\t"
+		"vmlaunch \n\t"
 		"jmp 2f \n\t"
-		"1: " __ex(ASM_VMX_VMRESUME) "\n\t"
+		"1: vmresume \n\t"
 		"2: "
 		/* Save guest registers, load host registers, keep flags */
 		"mov %0, %c[wordsize](%%" _ASM_SP ") \n\t"
-- 
2.7.4

