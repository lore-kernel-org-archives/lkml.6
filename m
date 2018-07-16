Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670EDECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3BF2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3BF2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbeGPIK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:10:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeGPIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:10:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3185CA4;
        Mon, 16 Jul 2018 07:44:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave@sr71.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 30/43] x86/cpufeature, x86/mm/pkeys: Add protection keys related CPUID definitions
Date:   Mon, 16 Jul 2018 09:36:35 +0200
Message-Id: <20180716073515.229992015@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit dfb4a70f20c5b3880da56ee4c9484bdb4e8f1e65 upstream

There are two CPUID bits for protection keys.  One is for whether
the CPU contains the feature, and the other will appear set once
the OS enables protection keys.  Specifically:

	Bit 04: OSPKE. If 1, OS has set CR4.PKE to enable
	Protection keys (and the RDPKRU/WRPKRU instructions)

This is because userspace can not see CR4 contents, but it can
see CPUID contents.

X86_FEATURE_PKU is referred to as "PKU" in the hardware documentation:

	CPUID.(EAX=07H,ECX=0H):ECX.PKU [bit 3]

X86_FEATURE_OSPKE is "OSPKU":

	CPUID.(EAX=07H,ECX=0H):ECX.OSPKE [bit 4]

These are the first CPU features which need to look at the
ECX word in CPUID leaf 0x7, so this patch also includes
fetching that word in to the cpuinfo->x86_capability[] array.

Add it to the disabled-features mask when its config option is
off.  Even though we are not using it here, we also extend the
REQUIRED_MASK_BIT_SET() macro to keep it mirroring the
DISABLED_MASK_BIT_SET() version.

This means that in almost all code, you should use:

	cpu_has(c, X86_FEATURE_PKU)

and *not* the CONFIG option.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave@sr71.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20160212210201.7714C250@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeature.h        |   59 ++++++++++++++++++++-----------
 arch/x86/include/asm/cpufeatures.h       |    2 -
 arch/x86/include/asm/disabled-features.h |   15 +++++++
 arch/x86/include/asm/required-features.h |    7 +++
 arch/x86/kernel/cpu/common.c             |    1 
 5 files changed, 63 insertions(+), 21 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -26,6 +26,7 @@ enum cpuid_leafs
 	CPUID_8000_0008_EBX,
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
+	CPUID_7_ECX,
 };
 
 #ifdef CONFIG_X86_FEATURE_NAMES
@@ -48,28 +49,42 @@ extern const char * const x86_bug_flags[
 	 test_bit(bit, (unsigned long *)((c)->x86_capability))
 
 #define REQUIRED_MASK_BIT_SET(bit)					\
-	 ( (((bit)>>5)==0 && (1UL<<((bit)&31) & REQUIRED_MASK0)) ||	\
-	   (((bit)>>5)==1 && (1UL<<((bit)&31) & REQUIRED_MASK1)) ||	\
-	   (((bit)>>5)==2 && (1UL<<((bit)&31) & REQUIRED_MASK2)) ||	\
-	   (((bit)>>5)==3 && (1UL<<((bit)&31) & REQUIRED_MASK3)) ||	\
-	   (((bit)>>5)==4 && (1UL<<((bit)&31) & REQUIRED_MASK4)) ||	\
-	   (((bit)>>5)==5 && (1UL<<((bit)&31) & REQUIRED_MASK5)) ||	\
-	   (((bit)>>5)==6 && (1UL<<((bit)&31) & REQUIRED_MASK6)) ||	\
-	   (((bit)>>5)==7 && (1UL<<((bit)&31) & REQUIRED_MASK7)) ||	\
-	   (((bit)>>5)==8 && (1UL<<((bit)&31) & REQUIRED_MASK8)) ||	\
-	   (((bit)>>5)==9 && (1UL<<((bit)&31) & REQUIRED_MASK9)) )
+	 ( (((bit)>>5)==0  && (1UL<<((bit)&31) & REQUIRED_MASK0 )) ||	\
+	   (((bit)>>5)==1  && (1UL<<((bit)&31) & REQUIRED_MASK1 )) ||	\
+	   (((bit)>>5)==2  && (1UL<<((bit)&31) & REQUIRED_MASK2 )) ||	\
+	   (((bit)>>5)==3  && (1UL<<((bit)&31) & REQUIRED_MASK3 )) ||	\
+	   (((bit)>>5)==4  && (1UL<<((bit)&31) & REQUIRED_MASK4 )) ||	\
+	   (((bit)>>5)==5  && (1UL<<((bit)&31) & REQUIRED_MASK5 )) ||	\
+	   (((bit)>>5)==6  && (1UL<<((bit)&31) & REQUIRED_MASK6 )) ||	\
+	   (((bit)>>5)==7  && (1UL<<((bit)&31) & REQUIRED_MASK7 )) ||	\
+	   (((bit)>>5)==8  && (1UL<<((bit)&31) & REQUIRED_MASK8 )) ||	\
+	   (((bit)>>5)==9  && (1UL<<((bit)&31) & REQUIRED_MASK9 )) ||	\
+	   (((bit)>>5)==10 && (1UL<<((bit)&31) & REQUIRED_MASK10)) ||	\
+	   (((bit)>>5)==11 && (1UL<<((bit)&31) & REQUIRED_MASK11)) ||	\
+	   (((bit)>>5)==12 && (1UL<<((bit)&31) & REQUIRED_MASK12)) ||	\
+	   (((bit)>>5)==13 && (1UL<<((bit)&31) & REQUIRED_MASK13)) ||	\
+	   (((bit)>>5)==13 && (1UL<<((bit)&31) & REQUIRED_MASK14)) ||	\
+	   (((bit)>>5)==13 && (1UL<<((bit)&31) & REQUIRED_MASK15)) ||	\
+	   (((bit)>>5)==14 && (1UL<<((bit)&31) & REQUIRED_MASK16)) )
 
 #define DISABLED_MASK_BIT_SET(bit)					\
-	 ( (((bit)>>5)==0 && (1UL<<((bit)&31) & DISABLED_MASK0)) ||	\
-	   (((bit)>>5)==1 && (1UL<<((bit)&31) & DISABLED_MASK1)) ||	\
-	   (((bit)>>5)==2 && (1UL<<((bit)&31) & DISABLED_MASK2)) ||	\
-	   (((bit)>>5)==3 && (1UL<<((bit)&31) & DISABLED_MASK3)) ||	\
-	   (((bit)>>5)==4 && (1UL<<((bit)&31) & DISABLED_MASK4)) ||	\
-	   (((bit)>>5)==5 && (1UL<<((bit)&31) & DISABLED_MASK5)) ||	\
-	   (((bit)>>5)==6 && (1UL<<((bit)&31) & DISABLED_MASK6)) ||	\
-	   (((bit)>>5)==7 && (1UL<<((bit)&31) & DISABLED_MASK7)) ||	\
-	   (((bit)>>5)==8 && (1UL<<((bit)&31) & DISABLED_MASK8)) ||	\
-	   (((bit)>>5)==9 && (1UL<<((bit)&31) & DISABLED_MASK9)) )
+	 ( (((bit)>>5)==0  && (1UL<<((bit)&31) & DISABLED_MASK0 )) ||	\
+	   (((bit)>>5)==1  && (1UL<<((bit)&31) & DISABLED_MASK1 )) ||	\
+	   (((bit)>>5)==2  && (1UL<<((bit)&31) & DISABLED_MASK2 )) ||	\
+	   (((bit)>>5)==3  && (1UL<<((bit)&31) & DISABLED_MASK3 )) ||	\
+	   (((bit)>>5)==4  && (1UL<<((bit)&31) & DISABLED_MASK4 )) ||	\
+	   (((bit)>>5)==5  && (1UL<<((bit)&31) & DISABLED_MASK5 )) ||	\
+	   (((bit)>>5)==6  && (1UL<<((bit)&31) & DISABLED_MASK6 )) ||	\
+	   (((bit)>>5)==7  && (1UL<<((bit)&31) & DISABLED_MASK7 )) ||	\
+	   (((bit)>>5)==8  && (1UL<<((bit)&31) & DISABLED_MASK8 )) ||	\
+	   (((bit)>>5)==9  && (1UL<<((bit)&31) & DISABLED_MASK9 )) ||	\
+	   (((bit)>>5)==10 && (1UL<<((bit)&31) & DISABLED_MASK10)) ||	\
+	   (((bit)>>5)==11 && (1UL<<((bit)&31) & DISABLED_MASK11)) ||	\
+	   (((bit)>>5)==12 && (1UL<<((bit)&31) & DISABLED_MASK12)) ||	\
+	   (((bit)>>5)==13 && (1UL<<((bit)&31) & DISABLED_MASK13)) ||	\
+	   (((bit)>>5)==13 && (1UL<<((bit)&31) & DISABLED_MASK14)) ||	\
+	   (((bit)>>5)==13 && (1UL<<((bit)&31) & DISABLED_MASK15)) ||	\
+	   (((bit)>>5)==14 && (1UL<<((bit)&31) & DISABLED_MASK16)) )
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
@@ -79,6 +94,10 @@ extern const char * const x86_bug_flags[
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : 	\
 	 x86_this_cpu_test_bit(bit, (unsigned long *)&cpu_info.x86_capability))
 
+/* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx), word 16 */
+#define X86_FEATURE_PKU		(16*32+ 3) /* Protection Keys for Userspace */
+#define X86_FEATURE_OSPKE	(16*32+ 4) /* OS Protection Keys Enable */
+
 /*
  * This macro is for detection of features which need kernel
  * infrastructure to be used.  It may *not* directly test the CPU
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -12,7 +12,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS	16	/* N 32-bit words worth of info */
+#define NCAPINTS	17	/* N 32-bit words worth of info */
 #define NBUGINTS	1	/* N 32-bit bug flags */
 
 /*
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -30,6 +30,14 @@
 # define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
 #endif /* CONFIG_X86_64 */
 
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+# define DISABLE_PKU		(1<<(X86_FEATURE_PKU))
+# define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE))
+#else
+# define DISABLE_PKU		0
+# define DISABLE_OSPKE		0
+#endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -43,5 +51,12 @@
 #define DISABLED_MASK7	0
 #define DISABLED_MASK8	0
 #define DISABLED_MASK9	(DISABLE_MPX)
+#define DISABLED_MASK10	0
+#define DISABLED_MASK11	0
+#define DISABLED_MASK12	0
+#define DISABLED_MASK13	0
+#define DISABLED_MASK14	0
+#define DISABLED_MASK15	0
+#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -92,5 +92,12 @@
 #define REQUIRED_MASK7	0
 #define REQUIRED_MASK8	0
 #define REQUIRED_MASK9	0
+#define REQUIRED_MASK10	0
+#define REQUIRED_MASK11	0
+#define REQUIRED_MASK12	0
+#define REQUIRED_MASK13	0
+#define REQUIRED_MASK14	0
+#define REQUIRED_MASK15	0
+#define REQUIRED_MASK16	0
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -693,6 +693,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_7_0_EBX] = ebx;
 
 		c->x86_capability[CPUID_6_EAX] = cpuid_eax(0x00000006);
+		c->x86_capability[CPUID_7_ECX] = ecx;
 	}
 
 	/* Extended state features: level 0x0000000d */


