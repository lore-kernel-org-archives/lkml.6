Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBDEC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C195720880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C195720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeI3EVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:21:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52039 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728768AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000H4-TR; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006rV-7A; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Borislav Petkov" <bp@suse.de>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "=?UTF-8?Q?J=C3=B6rg=20?=Otte" <jrg.otte@gmail.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.290055127@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 033/131] x86/speculation: Use synthetic bits for
 IBRS/IBPB/STIBP
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit e7c587da125291db39ddf1f49b18e5970adbac17 upstream.

Intel and AMD have different CPUID bits hence for those use synthetic bits
which get set on the respective vendor's in init_speculation_control(). So
that debacles like what the commit message of

  c65732e4f721 ("x86/cpu: Restore CPUID_8000_0008_EBX reload")

talks about don't happen anymore.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Jörg Otte <jrg.otte@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/20180504161815.GG9257@pd.tnic
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Use the next available bit numbers in CPU feature word 7
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h |  9 ++++++---
 arch/x86/kernel/cpu/common.c      | 14 ++++++++++----
 arch/x86/kvm/cpuid.c              | 10 +++++-----
 arch/x86/kvm/cpuid.h              |  4 ++--
 4 files changed, 23 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -193,6 +193,9 @@
 #define X86_FEATURE_USE_IBRS_FW (7*32+13) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE (7*32+14) /* "" Disable Speculative Store Bypass. */
 #define X86_FEATURE_AMD_SSBD	(7*32+15)  /* "" AMD SSBD implementation */
+#define X86_FEATURE_IBRS	(7*32+16) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_IBPB	(7*32+17) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_STIBP	(7*32+18) /* Single Thread Indirect Branch Predictors */
 
 #define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
@@ -246,9 +249,9 @@
 #define X86_FEATURE_SSBD		(10*32+31) /* Speculative Store Bypass Disable */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 11 */
-#define X86_FEATURE_IBPB		(11*32+12) /* Indirect Branch Prediction Barrier */
-#define X86_FEATURE_IBRS		(11*32+14) /* Indirect Branch Restricted Speculation */
-#define X86_FEATURE_STIBP		(11*32+15) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_IBPB		(11*32+12) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_AMD_IBRS		(11*32+14) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_AMD_STIBP		(11*32+15) /* Single Thread Indirect Branch Predictors */
 
 /*
  * BUG word(s)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -690,17 +690,23 @@ static void init_speculation_control(str
 	 * and they also have a different bit for STIBP support. Also,
 	 * a hypervisor might have set the individual AMD bits even on
 	 * Intel CPUs, for finer-grained selection of what's available.
-	 *
-	 * We use the AMD bits in 0x8000_0008 EBX as the generic hardware
-	 * features, which are visible in /proc/cpuinfo and used by the
-	 * kernel. So set those accordingly from the Intel bits.
 	 */
 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_IBPB);
 	}
+
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
+
+	if (cpu_has(c, X86_FEATURE_AMD_IBRS))
+		set_cpu_cap(c, X86_FEATURE_IBRS);
+
+	if (cpu_has(c, X86_FEATURE_AMD_IBPB))
+		set_cpu_cap(c, X86_FEATURE_IBPB);
+
+	if (cpu_has(c, X86_FEATURE_AMD_STIBP))
+		set_cpu_cap(c, X86_FEATURE_STIBP);
 }
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -302,7 +302,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(IBPB) | F(IBRS);
+		F(AMD_IBPB) | F(AMD_IBRS);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_supported_word5_x86_features =
@@ -525,10 +525,10 @@ static inline int __do_cpuid_ent(struct
 		entry->eax = g_phys_as | (virt_as << 8);
 		entry->edx = 0;
 		/* IBRS and IBPB aren't necessarily present in hardware cpuid */
-		if (boot_cpu_has(X86_FEATURE_IBPB))
-			entry->ebx |= F(IBPB);
-		if (boot_cpu_has(X86_FEATURE_IBRS))
-			entry->ebx |= F(IBRS);
+		if (boot_cpu_has(X86_FEATURE_AMD_IBPB))
+			entry->ebx |= F(AMD_IBPB);
+		if (boot_cpu_has(X86_FEATURE_AMD_IBRS))
+			entry->ebx |= F(AMD_IBRS);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, 11);
 		break;
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -109,7 +109,7 @@ static inline bool guest_cpuid_has_ibpb(
 	struct kvm_cpuid_entry2 *best;
 
 	best = kvm_find_cpuid_entry(vcpu, 0x80000008, 0);
-	if (best && (best->ebx & bit(X86_FEATURE_IBPB)))
+	if (best && (best->ebx & bit(X86_FEATURE_AMD_IBPB)))
 		return true;
 	best = kvm_find_cpuid_entry(vcpu, 7, 0);
 	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
@@ -120,7 +120,7 @@ static inline bool guest_cpuid_has_spec_
 	struct kvm_cpuid_entry2 *best;
 
 	best = kvm_find_cpuid_entry(vcpu, 0x80000008, 0);
-	if (best && (best->ebx & bit(X86_FEATURE_IBRS)))
+	if (best && (best->ebx & bit(X86_FEATURE_AMD_IBRS)))
 		return true;
 	best = kvm_find_cpuid_entry(vcpu, 7, 0);
 	return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | bit(X86_FEATURE_SSBD)));

