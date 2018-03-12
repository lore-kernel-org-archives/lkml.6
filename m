Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvmEv74+uIKc674NfOoQizWb9SquiqJqODUC+bGFZty3UncBfg81ULG2snQT5NpBiq3+O1e
ARC-Seal: i=1; a=rsa-sha256; t=1520824073; cv=none;
        d=google.com; s=arc-20160816;
        b=m54wg1owkk7x5eNhKpELLd46U4wygFmIooveeXRFCMTMHH1ArimtdliIT33jO8Crvy
         6F5H2ow7NDbZpjyXPnWIsMHRYaSijgOyCuWl7dOZHin5jSty5fnT0zlbgFPrqhCFajaG
         5JRjDlP3c+XhUEJRbSr+SoWfBWqNekc3TGe+clSlzLtxAGQqA+EU0Asg9h5fzfCvLC/2
         tbHikRm15ljR/svhOGOgh9I2q6XWW6XBvqrJgmbsNB8VgboCXbmfEhdQTBe1kjcFkwPV
         BSId80dFPXHn4WWLxwaD/j2dj/h28vVDqMKizVaUX5txRYv32p50f99Gf6SJMLCK3pwl
         zn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=oSbJTygxv/Ex00SnU01aY1C94dv/Ta9BhZ/8vqsd6hU=;
        b=0FfdIh8c0eBUWxOb1s0k6w+Eu7MSsOONnUFUWBFC7V4I9Np+10yhFC5riLCJRwlth2
         +1CYsfZkEvAvXTBi6paudITWSCEfAT9prcKil+pq6gDGl9U40Kjb616K9MXdbiR1FZ6Q
         98eLMJB4WxyWulDLlJ//HYyZ3yoZLmI3XwQ8jn/mN+ZN0HqdSFlZz/IC0TR3FbrYmeuV
         ClVxBRJA7Q9qKaL1UBUZQr3WAKcmJi+nqwsQgXdvrjVO1+KMTTatEcx6UUCFvPsa0vXE
         hQkHWAmSPGCob0qJ0kDbPGNgKKjIl0ysMdcWgrfMHkxqS/vNq9iSxZm/AhKqihBw6Ewg
         qktw==
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
 "Benjamin Serebrin" <serebrin@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Eric Northup" <digitaleric@google.com>,
 "Andrew Honig" <ahonig@google.com>,
 "Jim Mattson" <jmattson@google.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.108025975@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 01/76] kvm: vmx: Scrub hardware GPRs at VM-exit
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699612224973082?=
X-GMAIL-MSGID: =?utf-8?q?1594699623843707255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/svm.c | 19 +++++++++++++++++++
 arch/x86/kvm/vmx.c | 14 +++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3915,6 +3915,25 @@ static void svm_vcpu_run(struct kvm_vcpu
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
@@ -7487,6 +7487,7 @@ static void __noclone vmx_vcpu_run(struc
 		/* Save guest registers, load host registers, keep flags */
 		"mov %0, %c[wordsize](%%" _ASM_SP ") \n\t"
 		"pop %0 \n\t"
+		"setbe %c[fail](%0)\n\t"
 		"mov %%" _ASM_AX ", %c[rax](%0) \n\t"
 		"mov %%" _ASM_BX ", %c[rbx](%0) \n\t"
 		__ASM_SIZE(pop) " %c[rcx](%0) \n\t"
@@ -7503,12 +7504,23 @@ static void __noclone vmx_vcpu_run(struc
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
 		".pushsection .rodata \n\t"
 		".global vmx_return \n\t"
 		"vmx_return: " _ASM_PTR " 2b \n\t"
