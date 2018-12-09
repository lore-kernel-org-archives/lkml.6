Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A07C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071C320661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071C320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeLIWYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:24:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35058 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbeLIVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:18 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002iY-Ro; Sun, 09 Dec 2018 21:55:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003SQ-Uk; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Borislav Petkov" <bp@suse.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.559911835@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 176/328] x86/microcode/intel: Add a helper which
 gives the microcode revision
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 4167709bbf826512a52ebd6aafda2be104adaec9 upstream.

Since on Intel we're required to do CPUID(1) first, before reading
the microcode revision MSR, let's add a special helper which does the
required steps so that we don't forget to do them next time, when we
want to read the microcode revision.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: http://lkml.kernel.org/r/20170109114147.5082-4-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16:
 - Don't touch prev_rev variable in apply_microcode()
 - Keep using sync_core(), which will alway includes the necessary CPUID
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -63,6 +63,21 @@ extern int get_matching_sig(unsigned int
 extern int
 update_match_revision(struct microcode_header_intel *mc_header, int rev);
 
+static inline u32 intel_get_microcode_revision(void)
+{
+	u32 rev, dummy;
+
+	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
+
+	/* As documented in the SDM: Do a CPUID 1 here */
+	sync_core();
+
+	/* get the current revision from MSR 0x8B */
+	native_rdmsr(MSR_IA32_UCODE_REV, dummy, rev);
+
+	return rev;
+}
+
 #ifdef CONFIG_MICROCODE_INTEL_EARLY
 extern void __init load_ucode_intel_bsp(void);
 extern void load_ucode_intel_ap(void);
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -14,6 +14,7 @@
 #include <asm/bugs.h>
 #include <asm/cpu.h>
 #include <asm/intel-family.h>
+#include <asm/microcode_intel.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -103,14 +104,8 @@ static void early_init_intel(struct cpui
 		(c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 
-	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64)) {
-		unsigned lower_word;
-
-		wrmsr(MSR_IA32_UCODE_REV, 0, 0);
-		/* Required by the SDM */
-		sync_core();
-		rdmsr(MSR_IA32_UCODE_REV, lower_word, c->microcode);
-	}
+	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64))
+		c->microcode = intel_get_microcode_revision();
 
 	/* Now if any of them are set, check the blacklist and clear the lot */
 	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -134,9 +134,9 @@ int apply_microcode(int cpu)
 {
 	struct microcode_intel *mc_intel;
 	struct ucode_cpu_info *uci;
-	unsigned int val[2];
 	int cpu_num = raw_smp_processor_id();
 	struct cpuinfo_x86 *c = &cpu_data(cpu_num);
+	u32 rev;
 
 	uci = ucode_cpu_info + cpu;
 	mc_intel = uci->mc;
@@ -159,27 +159,22 @@ int apply_microcode(int cpu)
 	wrmsr(MSR_IA32_UCODE_WRITE,
 	      (unsigned long) mc_intel->bits,
 	      (unsigned long) mc_intel->bits >> 16 >> 16);
-	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
 
-	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
+	rev = intel_get_microcode_revision();
 
-	/* get the current revision from MSR 0x8B */
-	rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
-
-	if (val[1] != mc_intel->hdr.rev) {
+	if (rev != mc_intel->hdr.rev) {
 		pr_err("CPU%d update to revision 0x%x failed\n",
 		       cpu_num, mc_intel->hdr.rev);
 		return -1;
 	}
 	pr_info("CPU%d updated to revision 0x%x, date = %04x-%02x-%02x\n",
-		cpu_num, val[1],
+		cpu_num, rev,
 		mc_intel->hdr.date & 0xffff,
 		mc_intel->hdr.date >> 24,
 		(mc_intel->hdr.date >> 16) & 0xff);
 
-	uci->cpu_sig.rev = val[1];
-	c->microcode = val[1];
+	uci->cpu_sig.rev = rev;
+	c->microcode = rev;
 
 	return 0;
 }
--- a/arch/x86/kernel/cpu/microcode/intel_early.c
+++ b/arch/x86/kernel/cpu/microcode/intel_early.c
@@ -391,15 +391,8 @@ static int collect_cpu_info_early(struct
 		native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
 		csig.pf = 1 << ((val[1] >> 18) & 7);
 	}
-	native_wrmsr(MSR_IA32_UCODE_REV, 0, 0);
 
-	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
-
-	/* get the current revision from MSR 0x8B */
-	native_rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
-
-	csig.rev = val[1];
+	csig.rev = intel_get_microcode_revision();
 
 	uci->cpu_sig = csig;
 	uci->valid = 1;
@@ -654,7 +647,7 @@ static int apply_microcode_early(struct
 				 struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc_intel;
-	unsigned int val[2];
+	u32 rev;
 
 	mc_intel = uci->mc;
 	if (mc_intel == NULL)
@@ -664,21 +657,16 @@ static int apply_microcode_early(struct
 	native_wrmsr(MSR_IA32_UCODE_WRITE,
 	      (unsigned long) mc_intel->bits,
 	      (unsigned long) mc_intel->bits >> 16 >> 16);
-	native_wrmsr(MSR_IA32_UCODE_REV, 0, 0);
-
-	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
 
-	/* get the current revision from MSR 0x8B */
-	native_rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
-	if (val[1] != mc_intel->hdr.rev)
+	rev = intel_get_microcode_revision();
+	if (rev != mc_intel->hdr.rev)
 		return -1;
 
 #ifdef CONFIG_X86_64
 	/* Flush global tlb. This is precaution. */
 	flush_tlb_early();
 #endif
-	uci->cpu_sig.rev = val[1];
+	uci->cpu_sig.rev = rev;
 
 	print_ucode(uci);
 

