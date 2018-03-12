Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuTK3I4gGNpiASsOqRRTUh/gD6y0az6ydf4CpvfhJ51vhsRuOv1UwQfUXYoTHF607CrXt6I
ARC-Seal: i=1; a=rsa-sha256; t=1520824062; cv=none;
        d=google.com; s=arc-20160816;
        b=ru+RYELa5rY4sCJNQck5pzMpIuO8L3EH/Qveaz6h1EPhWqQYpWehSfYkHmG7QUAl7/
         ZHS/hIrgs3fVccv8YTrM4gPgg1f2aTxdZY9s9kSRINktxqoG/xqlbIrBelxNO+62VL8K
         P1/swIUCCJ7n5UTO4aXKJCzs1aNn+UaSDjuXYNSBsX6kjU4T7uYmGmUOiTUIonBg82LC
         LPEXuj94i432Ym7gZJxiizQmbdgu1MP7EkwziEiR7crxs1Q3/pRZTZKx52FALizybDRJ
         QmLkH111y77aBVTHrLYaAqPck/wObbxNGaRyTrPpkrO//Gu8a7YkcM7UOVl0AF1P4yRn
         oLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=QvE1RJxvKx4nUoFVc29/00uiYmbFvF4sqfadeBgASjc=;
        b=Kl1WJx17w2rR5ThRjfU7WmniCeUEEF6wYFpSIaaL4hLVDK/oQYSkkeB9uefMMp6xZJ
         uJjDbPHeN81dMAL1Qof8jPThl8qtnZsn23M/yaKBIhKe5lWBSGMN9ra3VH+v1MDlYgaP
         XUrGCst5wmDstHqwE8ZS37TmJnpg3j/66kRJr651X6qryvrqWTVTA37HJJfF5QSbFalA
         T/K2KaPsUTkJWACQmAR2mUazHy8ThR0dnCgU0/KFe+zXOjP08bQx3EN5xEEcYMuzeynb
         EhWaRPbHnBZjfnMF3oVIDVPmBiN5pKoBZYGAhI80aWzd83EmRfBkVLZ6LLbWWI2+7PJj
         t69Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Andrew Honig" <ahonig@google.com>,
 "Benjamin Serebrin" <serebrin@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Eric Northup" <digitaleric@google.com>,
 "Jim Mattson" <jmattson@google.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.174970866@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 037/104] kvm: vmx: Scrub hardware GPRs at VM-exit
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699612224973082?=
X-GMAIL-MSGID: =?utf-8?q?1594699612224973082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit 0cb5b30698fdc8f6b4646012e3acb4ddce430788 upstream.

Guest GPR values are live in the hardware GPRs at VM-exit.  Do not
leave any guest values in hardware GPRs after the guest GPR values are
saved to the vcpu_vmx structure.

This is a partial mitigation for CVE 2017-5715 and CVE 2017-5753.
Specifically, it defeats the Project Zero PoC for CVE 2017-5715.

Suggested-by: Eric Northup <digitaleric@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Eric Northup <digitaleric@google.com>
Reviewed-by: Benjamin Serebrin <serebrin@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
[Paolo: Add AMD bits, Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/svm.c | 19 +++++++++++++++++++
 arch/x86/kvm/vmx.c | 14 +++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3748,6 +3748,25 @@ static void svm_vcpu_run(struct kvm_vcpu
 		"mov %%r14, %c[r14](%[svm]) \n\t"
 		"mov %%r15, %c[r15](%[svm]) \n\t"
 #endif
+		/*
+		* Clear host registers marked as clobbered to prevent
+		* speculative use.
+		*/
+		"xor %%" _ASM_BX ", %%" _ASM_BX " \n\t"
+		"xor %%" _ASM_CX ", %%" _ASM_CX " \n\t"
+		"xor %%" _ASM_DX ", %%" _ASM_DX " \n\t"
+		"xor %%" _ASM_SI ", %%" _ASM_SI " \n\t"
+		"xor %%" _ASM_DI ", %%" _ASM_DI " \n\t"
+#ifdef CONFIG_X86_64
+		"xor %%r8, %%r8 \n\t"
+		"xor %%r9, %%r9 \n\t"
+		"xor %%r10, %%r10 \n\t"
+		"xor %%r11, %%r11 \n\t"
+		"xor %%r12, %%r12 \n\t"
+		"xor %%r13, %%r13 \n\t"
+		"xor %%r14, %%r14 \n\t"
+		"xor %%r15, %%r15 \n\t"
+#endif
 		"pop %%" _ASM_BP
 		:
 		: [svm]"a"(svm),
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6228,6 +6228,7 @@ static void __noclone vmx_vcpu_run(struc
 		/* Save guest registers, load host registers, keep flags */
 		"mov %0, %c[wordsize](%%" _ASM_SP ") \n\t"
 		"pop %0 \n\t"
+		"setbe %c[fail](%0)\n\t"
 		"mov %%" _ASM_AX ", %c[rax](%0) \n\t"
 		"mov %%" _ASM_BX ", %c[rbx](%0) \n\t"
 		__ASM_SIZE(pop) " %c[rcx](%0) \n\t"
@@ -6244,12 +6245,23 @@ static void __noclone vmx_vcpu_run(struc
 		"mov %%r13, %c[r13](%0) \n\t"
 		"mov %%r14, %c[r14](%0) \n\t"
 		"mov %%r15, %c[r15](%0) \n\t"
+		"xor %%r8d,  %%r8d \n\t"
+		"xor %%r9d,  %%r9d \n\t"
+		"xor %%r10d, %%r10d \n\t"
+		"xor %%r11d, %%r11d \n\t"
+		"xor %%r12d, %%r12d \n\t"
+		"xor %%r13d, %%r13d \n\t"
+		"xor %%r14d, %%r14d \n\t"
+		"xor %%r15d, %%r15d \n\t"
 #endif
 		"mov %%cr2, %%" _ASM_AX "   \n\t"
 		"mov %%" _ASM_AX ", %c[cr2](%0) \n\t"
 
+		"xor %%eax, %%eax \n\t"
+		"xor %%ebx, %%ebx \n\t"
+		"xor %%esi, %%esi \n\t"
+		"xor %%edi, %%edi \n\t"
 		"pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
-		"setbe %c[fail](%0) \n\t"
 	      : : "c"(vmx), "d"((unsigned long)HOST_RSP),
 		[launched]"i"(offsetof(struct vcpu_vmx, __launched)),
 		[fail]"i"(offsetof(struct vcpu_vmx, fail)),
