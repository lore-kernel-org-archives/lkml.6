Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53330C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F5F2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F5F2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJHRKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:10:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50453 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:10:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989xKUA560553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:59:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989xKId560549;
        Mon, 8 Oct 2018 02:59:20 -0700
Date:   Mon, 8 Oct 2018 02:59:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-22245bdf0ad805d6c29f82b6d5e977ee94bb2166@git.kernel.org>
Cc:     bp@alien8.de, torvalds@linux-foundation.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, luto@kernel.org, mingo@kernel.org,
        chang.seok.bae@intel.com, ravi.v.shankar@intel.com,
        tglx@linutronix.de, markus.t.metzger@intel.com, riel@surriel.com,
        peterz@infradead.org, hpa@zytor.com, brgerst@gmail.com
Reply-To: bp@alien8.de, dave.hansen@linux.intel.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, luto@kernel.org, dvlasenk@redhat.com,
          chang.seok.bae@intel.com, markus.t.metzger@intel.com,
          ravi.v.shankar@intel.com, tglx@linutronix.de, brgerst@gmail.com,
          riel@surriel.com, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <1537312139-5580-2-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-2-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/segments: Introduce the 'CPUNODE' naming to
 better document the segment limit CPU/node NR trick
Git-Commit-ID: 22245bdf0ad805d6c29f82b6d5e977ee94bb2166
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  22245bdf0ad805d6c29f82b6d5e977ee94bb2166
Gitweb:     https://git.kernel.org/tip/22245bdf0ad805d6c29f82b6d5e977ee94bb2166
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon, 8 Oct 2018 10:41:59 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:45:02 +0200

x86/segments: Introduce the 'CPUNODE' naming to better document the segment limit CPU/node NR trick

We have a special segment descriptor entry in the GDT, whose sole purpose is to
encode the CPU and node numbers in its limit (size) field. There are user-space
instructions that allow the reading of the limit field, which gives us a really
fast way to read the CPU and node IDs from the vDSO for example.

But the naming of related functionality does not make this clear, at all:

	VDSO_CPU_SIZE
	VDSO_CPU_MASK
	__CPU_NUMBER_SEG
	GDT_ENTRY_CPU_NUMBER
	vdso_encode_cpu_node
	vdso_read_cpu_node

There's a number of problems:

 - The 'VDSO_CPU_SIZE' doesn't really make it clear that these are number
   of bits, nor does it make it clear which 'CPU' this refers to, i.e.
   that this is about a GDT entry whose limit encodes the CPU and node number.

 - Furthermore, the 'CPU_NUMBER' naming is actively misleading as well,
   because the segment limit encodes not just the CPU number but the
   node ID as well ...

So use a better nomenclature all around: name everything related to this trick
as 'CPUNODE', to make it clear that this is something special, and add
_BITS to make it clear that these are number of bits, and propagate this to
every affected name:

	VDSO_CPU_SIZE         =>  VDSO_CPUNODE_BITS
	VDSO_CPU_MASK         =>  VDSO_CPUNODE_MASK
	__CPU_NUMBER_SEG      =>  __CPUNODE_SEG
	GDT_ENTRY_CPU_NUMBER  =>  GDT_ENTRY_CPUNODE
	vdso_encode_cpu_node  =>  vdso_encode_cpunode
	vdso_read_cpu_node    =>  vdso_read_cpunode

This, beyond being less confusing, also makes it easier to grep for all related
functionality:

  $ git grep -i cpunode arch/x86

Also, while at it, fix "return is not a function" style sloppiness in vdso_encode_cpunode().

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/1537312139-5580-2-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vgetcpu.c  |  2 +-
 arch/x86/include/asm/segment.h | 22 +++++++++++-----------
 arch/x86/kernel/cpu/common.c   |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index de78fc9cd963..edd214f5264d 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -13,7 +13,7 @@
 notrace long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
 {
-	vdso_read_cpu_node(cpu, node);
+	vdso_read_cpunode(cpu, node);
 	return 0;
 }
 
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 4d1f6cc62e13..a314087add07 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -186,7 +186,7 @@
 #define GDT_ENTRY_TLS_MIN		12
 #define GDT_ENTRY_TLS_MAX		14
 
-#define GDT_ENTRY_CPU_NUMBER		15
+#define GDT_ENTRY_CPUNODE		15
 
 /*
  * Number of entries in the GDT table:
@@ -206,7 +206,7 @@
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
 #define __USER32_DS			__USER_DS
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
-#define __CPU_NUMBER_SEG		(GDT_ENTRY_CPU_NUMBER*8 + 3)
+#define __CPUNODE_SEG			(GDT_ENTRY_CPUNODE*8 + 3)
 
 #endif
 
@@ -227,24 +227,24 @@
 #ifdef CONFIG_X86_64
 
 /* Bit size and mask of CPU number stored in the per CPU data (and TSC_AUX) */
-#define VDSO_CPU_SIZE			12
-#define VDSO_CPU_MASK			0xfff
+#define VDSO_CPUNODE_BITS		12
+#define VDSO_CPUNODE_MASK		0xfff
 
 #ifndef __ASSEMBLY__
 
 /* Helper functions to store/load CPU and node numbers */
 
-static inline unsigned long vdso_encode_cpu_node(int cpu, unsigned long node)
+static inline unsigned long vdso_encode_cpunode(int cpu, unsigned long node)
 {
-	return ((node << VDSO_CPU_SIZE) | cpu);
+	return (node << VDSO_CPUNODE_BITS) | cpu;
 }
 
-static inline void vdso_read_cpu_node(unsigned *cpu, unsigned *node)
+static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 {
 	unsigned int p;
 
 	/*
-	 * Load CPU and node number from GDT.  LSL is faster than RDTSCP
+	 * Load CPU and node number from the GDT.  LSL is faster than RDTSCP
 	 * and works on all CPUs.  This is volatile so that it orders
 	 * correctly with respect to barrier() and to keep GCC from cleverly
 	 * hoisting it out of the calling function.
@@ -254,12 +254,12 @@ static inline void vdso_read_cpu_node(unsigned *cpu, unsigned *node)
 	alternative_io ("lsl %[seg],%[p]",
 			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
 			X86_FEATURE_RDPID,
-			[p] "=a" (p), [seg] "r" (__CPU_NUMBER_SEG));
+			[p] "=a" (p), [seg] "r" (__CPUNODE_SEG));
 
 	if (cpu)
-		*cpu = (p & VDSO_CPU_MASK);
+		*cpu = (p & VDSO_CPUNODE_MASK);
 	if (node)
-		*node = (p >> VDSO_CPU_SIZE);
+		*node = (p >> VDSO_CPUNODE_BITS);
 }
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a148d18a1ef0..7da587f4af52 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1672,7 +1672,7 @@ static void wait_for_master_cpu(int cpu)
 #ifdef CONFIG_X86_64
 static void setup_getcpu(int cpu)
 {
-	unsigned long cpudata = vdso_encode_cpu_node(cpu, early_cpu_to_node(cpu));
+	unsigned long cpudata = vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
 	struct desc_struct d = { };
 
 	if (static_cpu_has(X86_FEATURE_RDTSCP))
@@ -1688,7 +1688,7 @@ static void setup_getcpu(int cpu)
 	d.p = 1;		/* Present */
 	d.d = 1;		/* 32-bit */
 
-	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPU_NUMBER, &d, DESCTYPE_S);
+	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPUNODE, &d, DESCTYPE_S);
 }
 #endif
 
