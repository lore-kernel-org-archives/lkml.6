Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F84DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C996122419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C996122419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeKOHdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:33:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49980 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeKOHdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:33:47 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Rby9QwvJTikq; Wed, 14 Nov 2018 22:28:52 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0D200D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:d200:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC4FF1EC00EB;
        Wed, 14 Nov 2018 22:28:51 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] x86/cpuid: Make cpuinfo_x86.x86_vendor_id global
Date:   Wed, 14 Nov 2018 22:28:41 +0100
Message-Id: <20181114212843.16954-2-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114212843.16954-1-bp@alien8.de>
References: <20181114212843.16954-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Make x86_vendor_id __ro_after_init and global as it is not needed
per-CPU. Thus, save 16 bytes of per-CPU memory. Remove the vendor ID
readout early in head_32.S because it is not needed that early either.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/processor.h |  4 ++--
 arch/x86/kernel/asm-offsets_32.c |  1 -
 arch/x86/kernel/cpu/common.c     | 15 +++++++--------
 arch/x86/kernel/cpu/cyrix.c      |  2 +-
 arch/x86/kernel/cpu/proc.c       |  2 +-
 arch/x86/kernel/head_32.S        |  5 -----
 arch/x86/kernel/setup.c          |  1 +
 7 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 071b2a6fff85..2f6f7939dfe0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -69,12 +69,13 @@ extern u16 __read_mostly tlb_lld_2m[NR_INFO];
 extern u16 __read_mostly tlb_lld_4m[NR_INFO];
 extern u16 __read_mostly tlb_lld_1g[NR_INFO];
 
+extern char x86_vendor_id[16];
+
 /*
  *  CPU type and hardware bug flags. Kept separately for each CPU.
  *  Members of this structure are referenced in head_32.S, so think twice
  *  before touching them. [mj]
  */
-
 struct cpuinfo_x86 {
 	__u8			x86;		/* CPU family */
 	__u8			x86_vendor;	/* CPU vendor */
@@ -94,7 +95,6 @@ struct cpuinfo_x86 {
 	/* Maximum supported CPUID level, -1=no CPUID: */
 	int			cpuid_level;
 	__u32			x86_capability[NCAPINTS + NBUGINTS];
-	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index 82826f2275cc..0b577c40c710 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -21,7 +21,6 @@ void foo(void)
 	OFFSET(CPUINFO_x86_stepping, cpuinfo_x86, x86_stepping);
 	OFFSET(CPUINFO_cpuid_level, cpuinfo_x86, cpuid_level);
 	OFFSET(CPUINFO_x86_capability, cpuinfo_x86, x86_capability);
-	OFFSET(CPUINFO_x86_vendor_id, cpuinfo_x86, x86_vendor_id);
 	BLANK();
 
 	OFFSET(PT_EBX, pt_regs, bx);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ffb181f959d2..8a6071614652 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -708,7 +708,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 
 static void get_cpu_vendor(struct cpuinfo_x86 *c)
 {
-	char *v = c->x86_vendor_id;
+	char *v = x86_vendor_id;
 	int i;
 
 	for (i = 0; i < X86_VENDOR_NUM; i++) {
@@ -736,9 +736,9 @@ void cpu_detect(struct cpuinfo_x86 *c)
 {
 	/* Get vendor name */
 	cpuid(0x00000000, (unsigned int *)&c->cpuid_level,
-	      (unsigned int *)&c->x86_vendor_id[0],
-	      (unsigned int *)&c->x86_vendor_id[8],
-	      (unsigned int *)&c->x86_vendor_id[4]);
+	      (unsigned int *)&x86_vendor_id[0],
+	      (unsigned int *)&x86_vendor_id[8],
+	      (unsigned int *)&x86_vendor_id[4]);
 
 	c->x86 = 4;
 	/* Intel-defined flags: level 0x00000001 */
@@ -938,9 +938,9 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 
 	for (i = 0; i < X86_VENDOR_NUM; i++)
 		if (cpu_devs[i] && cpu_devs[i]->c_identify) {
-			c->x86_vendor_id[0] = 0;
+			x86_vendor_id[0] = 0;
 			cpu_devs[i]->c_identify(c);
-			if (c->x86_vendor_id[0]) {
+			if (x86_vendor_id[0]) {
 				get_cpu_vendor(c);
 				break;
 			}
@@ -1301,7 +1301,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
-	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
 	c->x86_coreid_bits = 0;
@@ -1480,7 +1479,7 @@ void print_cpu_info(struct cpuinfo_x86 *c)
 		vendor = this_cpu->c_vendor;
 	} else {
 		if (c->cpuid_level >= 0)
-			vendor = c->x86_vendor_id;
+			vendor = x86_vendor_id;
 	}
 
 	if (vendor && !strstr(c->x86_model_id, vendor))
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index d12226f60168..1f1f724dd4c3 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -415,7 +415,7 @@ static void cyrix_identify(struct cpuinfo_x86 *c)
 	if (c->x86 == 4 && test_cyrix_52div()) {
 		unsigned char dir0, dir1;
 
-		strcpy(c->x86_vendor_id, "CyrixInstead");
+		strcpy(x86_vendor_id, "CyrixInstead");
 		c->x86_vendor = X86_VENDOR_CYRIX;
 
 		/* Actually enable cpuid on the older cyrix */
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 2c8522a39ed5..999371ddfedb 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -67,7 +67,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   "model\t\t: %u\n"
 		   "model name\t: %s\n",
 		   cpu,
-		   c->x86_vendor_id[0] ? c->x86_vendor_id : "unknown",
+		   x86_vendor_id[0] ? x86_vendor_id : "unknown",
 		   c->x86,
 		   c->x86_model,
 		   c->x86_model_id[0] ? c->x86_model_id : "unknown");
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 30f9cb2c0b55..7ee8a1325abe 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -41,8 +41,6 @@
 #define X86_HARD_MATH	new_cpu_data+CPUINFO_hard_math
 #define X86_CPUID	new_cpu_data+CPUINFO_cpuid_level
 #define X86_CAPABILITY	new_cpu_data+CPUINFO_x86_capability
-#define X86_VENDOR_ID	new_cpu_data+CPUINFO_x86_vendor_id
-
 
 #define SIZEOF_PTREGS 17*4
 
@@ -316,9 +314,6 @@ ENTRY(startup_32_smp)
 	xorl %eax,%eax			# call CPUID with 0 -> return vendor ID
 	cpuid
 	movl %eax,X86_CPUID		# save CPUID level
-	movl %ebx,X86_VENDOR_ID		# lo 4 chars
-	movl %edx,X86_VENDOR_ID+4	# next 4 chars
-	movl %ecx,X86_VENDOR_ID+8	# last 4 chars
 
 	orl %eax,%eax			# do we have processor info as well?
 	je .Lis486
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b74e7bfed6ab..9f21f595f0de 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -161,6 +161,7 @@ static struct resource bss_resource = {
 	.flags	= IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM
 };
 
+char x86_vendor_id[16] __ro_after_init;
 
 #ifdef CONFIG_X86_32
 /* cpu data as detected by the assembly code in head_32.S */
-- 
2.19.1

