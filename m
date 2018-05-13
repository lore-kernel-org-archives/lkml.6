Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeEMTvy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 15:51:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeEMTvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 15:51:52 -0400
Date: Sun, 13 May 2018 12:51:46 -0700
From: tip-bot for Alexei Starovoitov <tipbot@zytor.com>
Message-ID: <tip-b1ae32dbab50ed19cfc16d225b0fb0114fb13025@git.kernel.org>
Cc: tglx@linutronix.de, ast@kernel.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: ast@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180513193222.1997938-1-ast@kernel.org>
References: <20180513193222.1997938-1-ast@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpufeature: Guard asm_volatile_goto usage for
 BPF compilation
Git-Commit-ID: b1ae32dbab50ed19cfc16d225b0fb0114fb13025
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b1ae32dbab50ed19cfc16d225b0fb0114fb13025
Gitweb:     https://git.kernel.org/tip/b1ae32dbab50ed19cfc16d225b0fb0114fb13025
Author:     Alexei Starovoitov <ast@kernel.org>
AuthorDate: Sun, 13 May 2018 12:32:22 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 21:49:14 +0200

x86/cpufeature: Guard asm_volatile_goto usage for BPF compilation

Workaround for the sake of BPF compilation which utilizes kernel
headers, but clang does not support ASM GOTO and fails the build.

Fixes: d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: daniel@iogearbox.net
Cc: peterz@infradead.org
Cc: netdev@vger.kernel.org
Cc: bp@alien8.de
Cc: yhs@fb.com
Cc: kernel-team@fb.com
Cc: torvalds@linux-foundation.org
Cc: davem@davemloft.net
Link: https://lkml.kernel.org/r/20180513193222.1997938-1-ast@kernel.org

---
 arch/x86/include/asm/cpufeature.h | 15 +++++++++++++++
 samples/bpf/Makefile              |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index b27da9602a6d..aced6c9290d6 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,6 +140,20 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
+#if defined(__clang__) && !defined(CC_HAVE_ASM_GOTO)
+
+/*
+ * Workaround for the sake of BPF compilation which utilizes kernel
+ * headers, but clang does not support ASM GOTO and fails the build.
+ */
+#ifndef __BPF_TRACING__
+#warning "Compiler lacks ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
+#endif
+
+#define static_cpu_has(bit)            boot_cpu_has(bit)
+
+#else
+
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
  * These will statically patch the target code for additional
@@ -195,6 +209,7 @@ t_no:
 		boot_cpu_has(bit) :				\
 		_static_cpu_has(bit)				\
 )
+#endif
 
 #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
 #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4d6a6edd4bf6..092947676143 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -255,7 +255,7 @@ $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
 $(obj)/%.o: $(src)/%.c
 	$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
 		-I$(srctree)/tools/testing/selftests/bpf/ \
-		-D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
+		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(ARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
