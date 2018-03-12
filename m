Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvpgABArf3dWVXulW2g9vNejTexYNiM9k8rSFXw7F9tOUDkeuo4Wm3yYnwbIkuA+TpTTEap
ARC-Seal: i=1; a=rsa-sha256; t=1520824070; cv=none;
        d=google.com; s=arc-20160816;
        b=BhmjuwET6Xht0m4X2UwUz98nrWY0CckiuH3xYSZT4/BQNJw9+vSJGMkFafMedlkUSg
         UZVtbfStM0876n0wkg/++jhFO5+ctkMNWF0RHiODNYhE3BpTsamXxTA6veqkja2OVO2Z
         1V7HEuGmbI42QP/NZvto/7ZrKmGG3/eHhbc7fHpXEKd+GIFKxDw0Ixfptl5Y6vIXyG4r
         UqR4Bbvl9aScWg3tZ1kikPP2tptd9b7Q8+UwoAcx7g7juuUvnSnJcdl6IDMiIVTaqapu
         FWiGKOgGXjNBDJQEAdV8coZOG5Ovp8kiTbwEtultHWYItq2IVueDF6TEbSrbG1CfWXHH
         mgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=K74xiVb4BmT3W8soy4penFf9aNQ1orANoXS0LQX+bDI=;
        b=UP9XnGp3e1AXYuGGkWUStYIbKU++3lgCIyN8YbSLw0i/i0A/k9QbrZ/U51eOGWwao1
         BbeS2VxVrM5WkZacXzgMutVtSzQr/tY7WW/6doK5lU4zlIIRnnIymf8GGq2EvShFOmij
         3wcyYdIE++PULfvDLLHeKWQvfKw3xVbE9v291ECYK7ZvEeCVFgnCNXeXRXOE0O/6AV17
         omomWip1sdGPXcCeTVZsMf4tOiTeNXiY/pso9rsSxoxteyLIrRuAIPijx3pQ+FJ71cjn
         eddnsgb2S77Y7v/xQYTNhQ59umoWfksl01SledDjEG0a4xp+XxJOEU5iQT1y3jsLzwRI
         K24Q==
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
 "Andi Kleen" <ak@linux.intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Ananth N Mavinakayanahalli" <ananth@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.580508173@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 070/104] kprobes/x86: Blacklist indirect thunk
 functions for kprobes
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699620789335702?=
X-GMAIL-MSGID: =?utf-8?q?1594699620789335702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit c1804a236894ecc942da7dc6c5abe209e56cba93 upstream.

Mark __x86_indirect_thunk_* functions as blacklist for kprobes
because those functions can be called from anywhere in the kernel
including blacklist functions of kprobes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Link: https://lkml.kernel.org/r/151629209111.10241.5444852823378068683.stgit@devbox
[bwh: Backported to 3.2: We don't have _ASM_NOKPROBE etc., so add indirect
 thunks to the built-in blacklist]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -53,6 +53,9 @@
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <asm/uaccess.h>
+#ifdef CONFIG_RETPOLINE
+#include <asm/nospec-branch.h>
+#endif
 
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
@@ -99,6 +102,11 @@ static struct kprobe_blackpoint kprobe_b
 	{"irq_entries_start",},
 	{"common_interrupt",},
 	{"mcount",},	/* mcount can be called from everywhere */
+#ifdef CONFIG_RETPOLINE
+	{"__indirect_thunk_start",
+	 /* Linker scripts can't set symbol sizes */
+	 .range = (size_t)__indirect_thunk_size},
+#endif
 	{NULL}    /* Terminator */
 };
 
@@ -1986,7 +1994,7 @@ static int __init init_kprobes(void)
 				&size, &offset, &modname, namebuf);
 		if (!symbol_name)
 			kb->range = 0;
-		else
+		else if (size)
 			kb->range = size;
 	}
 
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -173,6 +173,7 @@ enum spectre_v2_mitigation {
 
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
+extern char __indirect_thunk_size[];
 
 /*
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -112,6 +112,7 @@ SECTIONS
 		__indirect_thunk_start = .;
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
+		__indirect_thunk_size = __indirect_thunk_end - __indirect_thunk_start;
 #endif
 
 		/* End of text section */
