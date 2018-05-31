Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeEaR7a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:59:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:18561 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756000AbeEaR7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:59:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60725551"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 15/15] x86/fsgsbase/64: Add documentation for FSGSBASE
Date: Thu, 31 May 2018 10:58:45 -0700
Message-Id: <1527789525-8857-16-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

v2: Minor updates to documentation requested in review.
v3: Update for new gcc and various improvements.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
[chang: Minor edit and include descriptions for entry
changes by FSGSBASE]
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/entry_64.txt |   9 ++++
 Documentation/x86/fsgs.txt     | 104 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/x86/fsgs.txt

diff --git a/Documentation/x86/entry_64.txt b/Documentation/x86/entry_64.txt
index c1df8eb..9ff38d9 100644
--- a/Documentation/x86/entry_64.txt
+++ b/Documentation/x86/entry_64.txt
@@ -102,3 +102,12 @@ We try to only use IST entries and the paranoid entry code for vectors
 that absolutely need the more expensive check for the GS base - and we
 generate all 'normal' entry points with the regular (faster) paranoid=0
 variant.
+
+When FSGSBASE enabled, an arbitrary GS base (including negative value)
+is possible in user space. Thus, current GS base does not offer any
+useful guesses of the origin, whether from kernel or from user space.
+Also, finding the proper kernel GS base is efficiently possible;
+doing RDPID/LSL to get CPU number and indexing it into a table will
+take per-CPU base. With that, paranoid entry with FSGSBASE will always
+overwrite GS base with the per-CPU base, while the original GS base is
+stored and restored back to GS base on its paranoid exit.
diff --git a/Documentation/x86/fsgs.txt b/Documentation/x86/fsgs.txt
new file mode 100644
index 0000000..ebe15f3
--- /dev/null
+++ b/Documentation/x86/fsgs.txt
@@ -0,0 +1,104 @@
+
+Using FS and GS prefixes on 64bit x86 linux
+
+The x86 architecture supports segment prefixes per instruction to add an
+offset to an address.  On 64bit x86, these are mostly nops, except for FS
+and GS.
+
+This offers an efficient way to reference a global pointer.
+
+The compiler has to generate special code to use these base registers,
+or they can be accessed with inline assembler.
+
+	mov %gs:offset,%reg
+	mov %fs:offset,%reg
+
+On 64bit code, FS is used to address the thread local segment (TLS), declared using
+__thread.  The compiler then automatically generates the correct prefixes and
+relocations to access these values.
+
+FS is normally managed by the runtime code or the threading library
+Overwriting it can break a lot of things (including syscalls and gdb),
+but it can make sense to save/restore it for threading purposes.
+
+GS is freely available, but may need special (compiler or inline assembler)
+code to use.
+
+Traditionally 64bit FS and GS could be set by the arch_prctl system call
+
+	arch_prctl(ARCH_SET_GS, value)
+	arch_prctl(ARCH_SET_FS, value)
+
+[There was also an older method using modify_ldt(), inherited from 32bit,
+but this is not discussed here.]
+
+However using a syscall is problematic for user space threading libraries
+that want to context switch in user space. The whole point of them
+is avoiding the overhead of a syscall. It's also cleaner for compilers
+wanting to use the extra register to use instructions to write
+it, or read it directly to compute addresses and offsets.
+
+Newer Intel CPUs (Ivy Bridge and later) added new instructions to directly
+access these registers quickly from user context
+
+	RDFSBASE %reg	read the FS base	(or _readfsbase_u64)
+	RDGSBASE %reg	read the GS base	(or _readgsbase_u64)
+
+	WRFSBASE %reg	write the FS base	(or _writefsbase_u64)
+	WRGSBASE %reg	write the GS base	(or _writegsbase_u64)
+
+If you use the intrinsics include <immintrin.h> and set the -mfsgsbase option.
+
+The instructions are supported by the CPU when the "fsgsbase" string is shown in
+/proc/cpuinfo (or directly retrieved through the CPUID instruction,
+7:0 (ebx), word 9, bit 0)
+
+The instructions are only available to 64bit binaries.
+
+In addition the kernel needs to explicitly enable these instructions, as it
+may otherwise not correctly context switch the state. Newer Linux
+kernels enable this. When the kernel did not enable the instruction
+they will fault with an #UD exception.
+
+An FSGSBASE enabled kernel can be detected by checking the AT_HWCAP2
+bitmask in the aux vector. When the HWCAP2_FSGSBASE bit is set the
+kernel supports RDFSGSBASE.
+
+	#include <sys/auxv.h>
+	#include <elf.h>
+
+	/* Will be eventually in asm/hwcap.h */
+	#define HWCAP2_FSGSBASE        (1 << 1)
+
+        unsigned val = getauxval(AT_HWCAP2);
+        if (val & HWCAP2_FSGSBASE) {
+                asm("wrgsbase %0" :: "r" (ptr));
+        }
+
+No extra CPUID check needed as the kernel will not set this bit if the CPU
+does not support it.
+
+gcc 6 will have special support to directly access data relative
+to fs/gs using the __seg_fs and __seg_gs address space pointer
+modifiers.
+
+#ifndef __SEG_GS
+#error "Need gcc 6 or later"
+#endif
+
+struct gsdata {
+	int a;
+	int b;
+} gsdata = { 1, 2 };
+
+int __seg_gs *valp = 0;		/* offset relative to GS */
+
+	/* Check if kernel supports FSGSBASE as above */
+
+	/* Set up new GS */
+	asm("wrgsbase %0" :: "r" (&gsdata));
+
+	/* Now the global pointer can be used normally */
+	printf("gsdata.a = %d\n", valp->a);
+
+Andi Kleen
-- 
2.7.4
