Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsX+X6U/+QA/0EPXbpKEsKtlIRIey8MG3fkmPqorF1JXqd0I+0nFjoBx3Z1dknJS3jSGA03
ARC-Seal: i=1; a=rsa-sha256; t=1520824094; cv=none;
        d=google.com; s=arc-20160816;
        b=JTEBjiTpAjgtspG3YJG0iIaMZR8W2VMclqwsrnx9bQf03rbosyBKf9CD9DwkC0izLw
         9724WEWJOEZUWdMDw5BunWZiQiIgycGQpZ/6gMRsQzRmH/qtV+57LGMcAj4dTODAPhGw
         dsZJuMvjTZxsFJORSe57KqQEFtWyQBjlA1d9t0+GpjmXMnmlYrM6uhGlg2OrnxUMwrBm
         HfAEfYQRBVP5VBaIgAsvQacULNErmDyhz6g4Eq14jGC2cvMVaAxHe7NlwmfecPg0Wqu7
         f6H5/ULsfjM9inZIN3E7F6qJz+xRNvrqpCnY3m70/cGwVgTFWhxaatstrryR9seHJjny
         R0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=RPn/Ccm2vjRfp0/cqhmZDr3YEI7jQnMFR1w5FLXLjVQ=;
        b=j8G0zXNOrHOWEpSAWpQDl+VR8LhXY8iaATcSmUOdAf7WjevFhTW9LJzT5EnOs6IpMr
         kzsqiwwaLVGaKSaRITRNL8LH+jv89y7CWpPCV5Q8/fjRvnKm1XiVK18CHXBJpV8IYN/J
         it09hveQRTwbXFiSb/mKbSqT86NForrApOcr0KFjiDa9Qn5i2DCihGbkwIkY1vNxgxL2
         IFPBGQ/YbmMkVlR/qPZIP3/ANueqnVgbbUztKlYA7MuLbyjtlwYDNXRjibsZe4YQNLoe
         ZVv9icCCyM8HLBPpTpQauZGlTgKRljnXchW07Uq7cQogTfsf3nf8SfBQwJ9KKW20jgAq
         t0GQ==
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
 "Peter Zijlstra" <peterz@infradead.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Jiri Slaby" <jslaby@suse.cz>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 thomas.lendacky@amd.com
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.33407648@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 075/104] x86/retpoline: Fill RSB on context switch for
 affected CPUs
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699645839999485?=
X-GMAIL-MSGID: =?utf-8?q?1594699645839999485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit c995efd5a740d9cbafbf58bde4973e8b50b4d761 upstream.

On context switch from a shallow call stack to a deeper one, as the CPU
does 'ret' up the deeper side it may encounter RSB entries (predictions for
where the 'ret' goes to) which were populated in userspace.

This is problematic if neither SMEP nor KPTI (the latter of which marks
userspace pages as NX for the kernel) are active, as malicious code in
userspace may then be executed speculatively.

Overwrite the CPU's return prediction stack with calls which are predicted
to return to an infinite loop, to "capture" speculation if this
happens. This is required both for retpoline, and also in conjunction with
IBRS for !SMEP && !KPTI.

On Skylake+ the problem is slightly different, and an *underflow* of the
RSB may cause errant branch predictions to occur. So there it's not so much
overwrite, as *filling* the RSB to attempt to prevent it getting
empty. This is only a partial solution for Skylake+ since there are many
other conditions which may result in the RSB becoming empty. The full
solution on Skylake+ is to use IBRS, which will prevent the problem even
when the RSB becomes empty. With IBRS, the RSB-stuffing will not be
required on context switch.

[ tglx: Added missing vendor check and slighty massaged comments and
  	changelog ]

[js] backport to 4.4 -- __switch_to_asm does not exist there, we
     have to patch the switch_to macros for both x86_32 and x86_64.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515779365-9032-1-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
[bwh: Backported to 3.2:
 - Use the first available feature number
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h |    1 +
 arch/x86/include/asm/system.h     |   38 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c        |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -178,6 +178,7 @@
 #define X86_FEATURE_PTS		(7*32+ 6) /* Intel Package Thermal Status */
 #define X86_FEATURE_DTHERM	(7*32+ 7) /* Digital Thermal Sensor */
 #define X86_FEATURE_INVPCID_SINGLE (7*32+ 8) /* Effectively INVPCID && CR4.PCIDE=1 */
+#define X86_FEATURE_RSB_CTXSW	(7*32+9) /* Fill RSB on context switches */
 
 #define X86_FEATURE_RETPOLINE	(7*32+29) /* Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* AMD Retpoline mitigation for Spectre variant 2 */
--- a/arch/x86/include/asm/system.h
+++ b/arch/x86/include/asm/system.h
@@ -6,6 +6,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cmpxchg.h>
 #include <asm/nops.h>
+#include <asm/nospec-branch.h>
 
 #include <linux/kernel.h>
 #include <linux/irqflags.h>
@@ -41,6 +42,23 @@ extern void show_regs_common(void);
 #define __switch_canary_iparam
 #endif	/* CC_STACKPROTECTOR */
 
+#ifdef CONFIG_RETPOLINE
+	/*
+	 * When switching from a shallower to a deeper call stack
+	 * the RSB may either underflow or use entries populated
+	 * with userspace addresses. On CPUs where those concerns
+	 * exist, overwrite the RSB with entries which capture
+	 * speculative execution to prevent attack.
+	 */
+#define __retpoline_fill_return_buffer					\
+	ALTERNATIVE("jmp 910f",						\
+		__stringify(__FILL_RETURN_BUFFER(%%ebx, RSB_CLEAR_LOOPS, %%esp)),\
+		X86_FEATURE_RSB_CTXSW)					\
+	"910:\n\t"
+#else
+#define __retpoline_fill_return_buffer
+#endif
+
 /*
  * Saving eflags is important. It switches not only IOPL between tasks,
  * it also protects other tasks from NT leaking through sysenter etc.
@@ -63,6 +81,7 @@ do {									\
 		     "movl $1f,%[prev_ip]\n\t"	/* save    EIP   */	\
 		     "pushl %[next_ip]\n\t"	/* restore EIP   */	\
 		     __switch_canary					\
+		     __retpoline_fill_return_buffer			\
 		     "jmp __switch_to\n"	/* regparm call  */	\
 		     "1:\t"						\
 		     "popl %%ebp\n\t"		/* restore EBP   */	\
@@ -117,6 +136,23 @@ do {									\
 #define __switch_canary_iparam
 #endif	/* CC_STACKPROTECTOR */
 
+#ifdef CONFIG_RETPOLINE
+	/*
+	 * When switching from a shallower to a deeper call stack
+	 * the RSB may either underflow or use entries populated
+	 * with userspace addresses. On CPUs where those concerns
+	 * exist, overwrite the RSB with entries which capture
+	 * speculative execution to prevent attack.
+	 */
+#define __retpoline_fill_return_buffer					\
+	ALTERNATIVE("jmp 910f",						\
+		__stringify(__FILL_RETURN_BUFFER(%%r12, RSB_CLEAR_LOOPS, %%rsp)),\
+		X86_FEATURE_RSB_CTXSW)					\
+	"910:\n\t"
+#else
+#define __retpoline_fill_return_buffer
+#endif
+
 /* Save restore flags to clear handle leaking NT */
 #define switch_to(prev, next, last) \
 	asm volatile(SAVE_CONTEXT					  \
@@ -125,6 +161,7 @@ do {									\
 	     "call __switch_to\n\t"					  \
 	     "movq "__percpu_arg([current_task])",%%rsi\n\t"		  \
 	     __switch_canary						  \
+	     __retpoline_fill_return_buffer				  \
 	     "movq %P[thread_info](%%rsi),%%r8\n\t"			  \
 	     "movq %%rax,%%rdi\n\t" 					  \
 	     "testl  %[_tif_fork],%P[ti_flags](%%r8)\n\t"		  \
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -22,6 +22,7 @@
 #include <asm/alternative.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
+#include <asm/intel-family.h>
 
 static void __init spectre_v2_select_mitigation(void);
 
@@ -297,6 +298,23 @@ disable:
 	return SPECTRE_V2_CMD_NONE;
 }
 
+/* Check for Skylake-like CPUs (for RSB handling) */
+static bool __init is_skylake_era(void)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86 == 6) {
+		switch (boot_cpu_data.x86_model) {
+		case INTEL_FAM6_SKYLAKE_MOBILE:
+		case INTEL_FAM6_SKYLAKE_DESKTOP:
+		case INTEL_FAM6_SKYLAKE_X:
+		case INTEL_FAM6_KABYLAKE_MOBILE:
+		case INTEL_FAM6_KABYLAKE_DESKTOP:
+			return true;
+		}
+	}
+	return false;
+}
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -355,6 +373,24 @@ retpoline_auto:
 
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
+
+	/*
+	 * If neither SMEP or KPTI are available, there is a risk of
+	 * hitting userspace addresses in the RSB after a context switch
+	 * from a shallow call stack to a deeper one. To prevent this fill
+	 * the entire RSB, even when using IBRS.
+	 *
+	 * Skylake era CPUs have a separate issue with *underflow* of the
+	 * RSB, when they will predict 'ret' targets from the generic BTB.
+	 * The proper mitigation for this is IBRS. If IBRS is not supported
+	 * or deactivated in favour of retpolines the RSB fill on context
+	 * switch is required.
+	 */
+	if ((!boot_cpu_has(X86_FEATURE_KAISER) &&
+	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
+		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
+		pr_info("Filling RSB on context switch\n");
+	}
 }
 
 #undef pr_fmt
