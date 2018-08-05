Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCBAC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E12921782
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E12921782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeHEN3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:29:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42638 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeHEN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:29:54 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fmHAD-00016T-WE; Sun, 05 Aug 2018 13:25:34 +0200
Date:   Sun, 5 Aug 2018 13:25:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf fixes for 4.18
Message-ID: <alpine.DEB.2.21.1808051321321.17359@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

A set of fixes for perf:

 drivers:

  - Fix the hardcoded index of extra PCI devices on Broadwell which causes
    a resource conflict and triggers warnings on CPU hotplug.
 
 tools:

  - Update the tools copy of several files, including perf_event.h,
    powerpc's asm/unistd.h (new io_pgetevents syscall), bpf.h and
    x86's memcpy_64.s (used in 'perf bench mem'), silencing the
    respective warnings during the perf tools build.
    
  - Fix the build on the alpine:edge distro.


Thanks,

	tglx

------------------>
Arnaldo Carvalho de Melo (5):
      tools headers uapi: Update tools's copy of linux/perf_event.h
      tools headers powerpc: Update asm/unistd.h copy to pick new
      tools headers uapi: Refresh linux/bpf.h copy
      tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
      perf tools: Fix the build on the alpine:edge distro

Kan Liang (1):
      perf/x86/intel/uncore: Fix hardcoded index of Broadwell extra PCI devices


 arch/x86/events/intel/uncore.h               |   2 +-
 arch/x86/events/intel/uncore_snbep.c         |  10 ++-
 tools/arch/powerpc/include/uapi/asm/unistd.h |   1 +
 tools/arch/x86/include/asm/mcsafe_test.h     |  13 ++++
 tools/arch/x86/lib/memcpy_64.S               | 112 +++++++++++++--------------
 tools/include/uapi/linux/bpf.h               |  28 +++++--
 tools/include/uapi/linux/perf_event.h        |   2 +
 tools/perf/arch/x86/util/pmu.c               |   1 +
 tools/perf/arch/x86/util/tsc.c               |   1 +
 tools/perf/bench/Build                       |   1 +
 tools/perf/bench/mem-memcpy-x86-64-asm.S     |   1 +
 tools/perf/bench/mem-memcpy-x86-64-lib.c     |  24 ++++++
 tools/perf/perf.h                            |   1 +
 tools/perf/util/header.h                     |   1 +
 tools/perf/util/namespaces.h                 |   1 +
 15 files changed, 132 insertions(+), 67 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/mcsafe_test.h
 create mode 100644 tools/perf/bench/mem-memcpy-x86-64-lib.c

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c9e1e0bef3c3..e17ab885b1e9 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -28,7 +28,7 @@
 #define UNCORE_PCI_DEV_TYPE(data)	((data >> 8) & 0xff)
 #define UNCORE_PCI_DEV_IDX(data)	(data & 0xff)
 #define UNCORE_EXTRA_PCI_DEV		0xff
-#define UNCORE_EXTRA_PCI_DEV_MAX	3
+#define UNCORE_EXTRA_PCI_DEV_MAX	4
 
 #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 87dc0263a2e1..51d7c117e3c7 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1029,6 +1029,7 @@ void snbep_uncore_cpu_init(void)
 enum {
 	SNBEP_PCI_QPI_PORT0_FILTER,
 	SNBEP_PCI_QPI_PORT1_FILTER,
+	BDX_PCI_QPI_PORT2_FILTER,
 	HSWEP_PCI_PCU_3,
 };
 
@@ -3286,15 +3287,18 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
 	},
 	{ /* QPI Port 0 filter  */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f86),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 0),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   SNBEP_PCI_QPI_PORT0_FILTER),
 	},
 	{ /* QPI Port 1 filter  */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f96),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 1),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   SNBEP_PCI_QPI_PORT1_FILTER),
 	},
 	{ /* QPI Port 2 filter  */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   BDX_PCI_QPI_PORT2_FILTER),
 	},
 	{ /* PCU.3 (for Capability registers) */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
diff --git a/tools/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
index ac5ba55066dd..985534d0b448 100644
--- a/tools/arch/powerpc/include/uapi/asm/unistd.h
+++ b/tools/arch/powerpc/include/uapi/asm/unistd.h
@@ -399,5 +399,6 @@
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
+#define __NR_io_pgetevents	388
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
diff --git a/tools/arch/x86/include/asm/mcsafe_test.h b/tools/arch/x86/include/asm/mcsafe_test.h
new file mode 100644
index 000000000000..2ccd588fbad4
--- /dev/null
+++ b/tools/arch/x86/include/asm/mcsafe_test.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MCSAFE_TEST_H_
+#define _MCSAFE_TEST_H_
+
+.macro MCSAFE_TEST_CTL
+.endm
+
+.macro MCSAFE_TEST_SRC reg count target
+.endm
+
+.macro MCSAFE_TEST_DST reg count target
+.endm
+#endif /* _MCSAFE_TEST_H_ */
diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 9a53a06e5a3e..298ef1479240 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -3,6 +3,7 @@
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
+#include <asm/mcsafe_test.h>
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 
@@ -183,12 +184,15 @@ ENTRY(memcpy_orig)
 ENDPROC(memcpy_orig)
 
 #ifndef CONFIG_UML
+
+MCSAFE_TEST_CTL
+
 /*
- * memcpy_mcsafe_unrolled - memory copy with machine check exception handling
+ * __memcpy_mcsafe - memory copy with machine check exception handling
  * Note that we only catch machine checks when reading the source addresses.
  * Writes to target are posted and don't generate machine checks.
  */
-ENTRY(memcpy_mcsafe_unrolled)
+ENTRY(__memcpy_mcsafe)
 	cmpl $8, %edx
 	/* Less than 8 bytes? Go to byte copy loop */
 	jb .L_no_whole_words
@@ -204,58 +208,33 @@ ENTRY(memcpy_mcsafe_unrolled)
 	subl $8, %ecx
 	negl %ecx
 	subl %ecx, %edx
-.L_copy_leading_bytes:
+.L_read_leading_bytes:
 	movb (%rsi), %al
+	MCSAFE_TEST_SRC %rsi 1 .E_leading_bytes
+	MCSAFE_TEST_DST %rdi 1 .E_leading_bytes
+.L_write_leading_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_leading_bytes
+	jnz .L_read_leading_bytes
 
 .L_8byte_aligned:
-	/* Figure out how many whole cache lines (64-bytes) to copy */
-	movl %edx, %ecx
-	andl $63, %edx
-	shrl $6, %ecx
-	jz .L_no_whole_cache_lines
-
-	/* Loop copying whole cache lines */
-.L_cache_w0: movq (%rsi), %r8
-.L_cache_w1: movq 1*8(%rsi), %r9
-.L_cache_w2: movq 2*8(%rsi), %r10
-.L_cache_w3: movq 3*8(%rsi), %r11
-	movq %r8, (%rdi)
-	movq %r9, 1*8(%rdi)
-	movq %r10, 2*8(%rdi)
-	movq %r11, 3*8(%rdi)
-.L_cache_w4: movq 4*8(%rsi), %r8
-.L_cache_w5: movq 5*8(%rsi), %r9
-.L_cache_w6: movq 6*8(%rsi), %r10
-.L_cache_w7: movq 7*8(%rsi), %r11
-	movq %r8, 4*8(%rdi)
-	movq %r9, 5*8(%rdi)
-	movq %r10, 6*8(%rdi)
-	movq %r11, 7*8(%rdi)
-	leaq 64(%rsi), %rsi
-	leaq 64(%rdi), %rdi
-	decl %ecx
-	jnz .L_cache_w0
-
-	/* Are there any trailing 8-byte words? */
-.L_no_whole_cache_lines:
 	movl %edx, %ecx
 	andl $7, %edx
 	shrl $3, %ecx
 	jz .L_no_whole_words
 
-	/* Copy trailing words */
-.L_copy_trailing_words:
+.L_read_words:
 	movq (%rsi), %r8
-	mov %r8, (%rdi)
-	leaq 8(%rsi), %rsi
-	leaq 8(%rdi), %rdi
+	MCSAFE_TEST_SRC %rsi 8 .E_read_words
+	MCSAFE_TEST_DST %rdi 8 .E_write_words
+.L_write_words:
+	movq %r8, (%rdi)
+	addq $8, %rsi
+	addq $8, %rdi
 	decl %ecx
-	jnz .L_copy_trailing_words
+	jnz .L_read_words
 
 	/* Any trailing bytes? */
 .L_no_whole_words:
@@ -264,38 +243,55 @@ ENTRY(memcpy_mcsafe_unrolled)
 
 	/* Copy trailing bytes */
 	movl %edx, %ecx
-.L_copy_trailing_bytes:
+.L_read_trailing_bytes:
 	movb (%rsi), %al
+	MCSAFE_TEST_SRC %rsi 1 .E_trailing_bytes
+	MCSAFE_TEST_DST %rdi 1 .E_trailing_bytes
+.L_write_trailing_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_trailing_bytes
+	jnz .L_read_trailing_bytes
 
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
 	xorq %rax, %rax
 	ret
-ENDPROC(memcpy_mcsafe_unrolled)
-EXPORT_SYMBOL_GPL(memcpy_mcsafe_unrolled)
+ENDPROC(__memcpy_mcsafe)
+EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 
 	.section .fixup, "ax"
-	/* Return -EFAULT for any failure */
-.L_memcpy_mcsafe_fail:
-	mov	$-EFAULT, %rax
+	/*
+	 * Return number of bytes not copied for any failure. Note that
+	 * there is no "tail" handling since the source buffer is 8-byte
+	 * aligned and poison is cacheline aligned.
+	 */
+.E_read_words:
+	shll	$3, %ecx
+.E_leading_bytes:
+	addl	%edx, %ecx
+.E_trailing_bytes:
+	mov	%ecx, %eax
 	ret
 
+	/*
+	 * For write fault handling, given the destination is unaligned,
+	 * we handle faults on multi-byte writes with a byte-by-byte
+	 * copy up to the write-protected page.
+	 */
+.E_write_words:
+	shll	$3, %ecx
+	addl	%edx, %ecx
+	movl	%ecx, %edx
+	jmp mcsafe_handle_tail
+
 	.previous
 
-	_ASM_EXTABLE_FAULT(.L_copy_leading_bytes, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w0, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w1, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w2, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w3, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w4, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w5, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w6, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w7, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_words, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_bytes, .L_memcpy_mcsafe_fail)
+	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE_FAULT(.L_read_words, .E_read_words)
+	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .E_trailing_bytes)
+	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE(.L_write_words, .E_write_words)
+	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
 #endif
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 59b19b6a40d7..b7db3261c62d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1857,7 +1857,8 @@ union bpf_attr {
  *		is resolved), the nexthop address is returned in ipv4_dst
  *		or ipv6_dst based on family, smac is set to mac address of
  *		egress device, dmac is set to nexthop mac address, rt_metric
- *		is set to metric from route (IPv4/IPv6 only).
+ *		is set to metric from route (IPv4/IPv6 only), and ifindex
+ *		is set to the device index of the nexthop from the FIB lookup.
  *
  *             *plen* argument is the size of the passed in struct.
  *             *flags* argument can be a combination of one or more of the
@@ -1873,9 +1874,10 @@ union bpf_attr {
  *             *ctx* is either **struct xdp_md** for XDP programs or
  *             **struct sk_buff** tc cls_act programs.
  *     Return
- *             Egress device index on success, 0 if packet needs to continue
- *             up the stack for further processing or a negative error in case
- *             of failure.
+ *		* < 0 if any input argument is invalid
+ *		*   0 on success (packet is forwarded, nexthop neighbor exists)
+ *		* > 0 one of **BPF_FIB_LKUP_RET_** codes explaining why the
+ *		*     packet is not forwarded or needs assist from full stack
  *
  * int bpf_sock_hash_update(struct bpf_sock_ops_kern *skops, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -2612,6 +2614,18 @@ struct bpf_raw_tracepoint_args {
 #define BPF_FIB_LOOKUP_DIRECT  BIT(0)
 #define BPF_FIB_LOOKUP_OUTPUT  BIT(1)
 
+enum {
+	BPF_FIB_LKUP_RET_SUCCESS,      /* lookup successful */
+	BPF_FIB_LKUP_RET_BLACKHOLE,    /* dest is blackholed; can be dropped */
+	BPF_FIB_LKUP_RET_UNREACHABLE,  /* dest is unreachable; can be dropped */
+	BPF_FIB_LKUP_RET_PROHIBIT,     /* dest not allowed; can be dropped */
+	BPF_FIB_LKUP_RET_NOT_FWDED,    /* packet is not forwarded */
+	BPF_FIB_LKUP_RET_FWD_DISABLED, /* fwding is not enabled on ingress */
+	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
+	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
+	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+};
+
 struct bpf_fib_lookup {
 	/* input:  network family for lookup (AF_INET, AF_INET6)
 	 * output: network family of egress nexthop
@@ -2625,7 +2639,11 @@ struct bpf_fib_lookup {
 
 	/* total length of packet from network header - used for MTU check */
 	__u16	tot_len;
-	__u32	ifindex;  /* L3 device index for lookup */
+
+	/* input: L3 device index for lookup
+	 * output: device index from FIB lookup
+	 */
+	__u32	ifindex;
 
 	union {
 		/* inputs to lookup */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b8e288a1f740..eeb787b1c53c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -143,6 +143,8 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
 };
 
 /*
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 63a74c32ddc5..e33ef5bc31c5 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 
 #include "../../util/intel-pt.h"
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 06bae7023a51..950539f9a4f7 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -2,6 +2,7 @@
 #include <stdbool.h>
 #include <errno.h>
 
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 
 #include "../../perf.h"
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 60bf11943047..eafce1a130a1 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -7,6 +7,7 @@ perf-y += futex-wake-parallel.o
 perf-y += futex-requeue.o
 perf-y += futex-lock-pi.o
 
+perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
 
diff --git a/tools/perf/bench/mem-memcpy-x86-64-asm.S b/tools/perf/bench/mem-memcpy-x86-64-asm.S
index b43f8d2a34ec..9ad015a1e202 100644
--- a/tools/perf/bench/mem-memcpy-x86-64-asm.S
+++ b/tools/perf/bench/mem-memcpy-x86-64-asm.S
@@ -6,6 +6,7 @@
 #define altinstr_replacement text
 #define globl p2align 4; .globl
 #define _ASM_EXTABLE_FAULT(x, y)
+#define _ASM_EXTABLE(x, y)
 
 #include "../../arch/x86/lib/memcpy_64.S"
 /*
diff --git a/tools/perf/bench/mem-memcpy-x86-64-lib.c b/tools/perf/bench/mem-memcpy-x86-64-lib.c
new file mode 100644
index 000000000000..4130734dde84
--- /dev/null
+++ b/tools/perf/bench/mem-memcpy-x86-64-lib.c
@@ -0,0 +1,24 @@
+/*
+ * From code in arch/x86/lib/usercopy_64.c, copied to keep tools/ copy
+ * of the kernel's arch/x86/lib/memcpy_64.s used in 'perf bench mem memcpy'
+ * happy.
+ */
+#include <linux/types.h>
+
+unsigned long __memcpy_mcsafe(void *dst, const void *src, size_t cnt);
+unsigned long mcsafe_handle_tail(char *to, char *from, unsigned len);
+
+unsigned long mcsafe_handle_tail(char *to, char *from, unsigned len)
+{
+	for (; len; --len, to++, from++) {
+		/*
+		 * Call the assembly routine back directly since
+		 * memcpy_mcsafe() may silently fallback to memcpy.
+		 */
+		unsigned long rem = __memcpy_mcsafe(to, from, 1);
+
+		if (rem)
+			break;
+	}
+	return len;
+}
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index a1a97956136f..d215714f48df 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -5,6 +5,7 @@
 #include <time.h>
 #include <stdbool.h>
 #include <linux/types.h>
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 
 extern bool test_attr__enabled;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 90d4577a92dc..6d7fe44aadc0 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -2,6 +2,7 @@
 #ifndef __PERF_HEADER_H
 #define __PERF_HEADER_H
 
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <sys/types.h>
 #include <stdbool.h>
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 760558dcfd18..cae1a9a39722 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -10,6 +10,7 @@
 #define __PERF_NAMESPACES_H
 
 #include <sys/types.h>
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
