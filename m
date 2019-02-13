Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397E3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7492086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436918AbfBMVhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:37:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:41502 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436884AbfBMVhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:37:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 13:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="274859883"
Received: from chang-linux-2.sc.intel.com ([10.3.52.165])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 13:37:06 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 12/12] x86/fsgsbase/64: Add documentation for FSGSBASE
Date:   Wed, 13 Feb 2019 13:36:24 -0800
Message-Id: <20190213213624.14354-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213213624.14354-1-chang.seok.bae@intel.com>
References: <20190213213624.14354-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

v2: Minor updates to documentation requested in review.
v3: Update for new gcc and various improvements.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/fsgs.txt | 104 +++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/x86/fsgs.txt

diff --git a/Documentation/x86/fsgs.txt b/Documentation/x86/fsgs.txt
new file mode 100644
index 000000000000..7a973a5c1767
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
+kernel supports FSGSBASE.
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
+	printf("gsdata.a = %d\n", *valp);
+
+Andi Kleen
-- 
2.19.1

