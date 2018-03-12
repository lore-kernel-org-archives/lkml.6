Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELu7EIt+EIOu3zraupL51jSkwPmgRveMuFTJhGACuKrnpRnpExjH1YeSZSTulyooW3D/lZgf
ARC-Seal: i=1; a=rsa-sha256; t=1520824104; cv=none;
        d=google.com; s=arc-20160816;
        b=LqzkXyKQxmiI54hCVOBjBt5qBpKKtig5GmHT9OsHzIiupHGdmeKLvdRADBONST6m4L
         ynBZaBvXX1KePK+iB0DM6YfdTvWAz91Dup8cEQGyROIARkvn7m+8fngGSjTYgNEoSYbm
         06Lsjx/b9kFt02gNxnYifkODhY5FpBnfAVQ0hMA8SxKTd4GRZJhl9JcrATI1eD/+0KyW
         xeZapte3CQB4RPSiqz0UejBu6PGq0OccGWvWE4/k1m19GXbWrWKfEWdKghcNfxTX3iAu
         5vo8WAAZTESYAN047TKG+V+Ep0TP7cvQenhaeQr37Kyn5B3FCafd0DScIUlkNzCz1vKQ
         dCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=Iuhnw8eg88y2Gy8WeESYAwpuomJ0JfhTT3/l87PF00k=;
        b=Cj0I8Ldsbim720V2DPtNNleb1E++0rRr8Lpn7ifPqLXSYqSOQ5Th/1/eiDD+X7lGBc
         4FNmpQeSpvzDQ5jLMdNAibk1PNYpb1/sx0OqSN79m5Ut5OLfNXWw+17/3kNzLX79RrMM
         COG3zlwfgoDvhSfy+xauQ9wyDbUn6oKi1RwpxIOVxjPArhphTruX0owm35zOnYQNgqCh
         ElSwrxMI6CGYbUrlHA7xo+6+y4Kk7lR7OOIhl2sWQEVKJRi9KP7TRSU8DsVCZPjByVQN
         Ji3oCIIKaFxAVzXvmkkFY9vHZgjxF/s0TOrxKr0+cDUIDgkdmtGELK48Nfn4OH3DalFS
         IUEA==
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
CC: akpm@linux-foundation.org, gnomes@lxorguk.ukuu.org.uk,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Rik van Riel" <riel@redhat.com>,
 thomas.lendacky@amd.com,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.489922200@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 24/76] x86/spectre: Add boot time option to select
 Spectre v2 mitigation
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699655663035914?=
X-GMAIL-MSGID: =?utf-8?q?1594699655663035914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit da285121560e769cc31797bba6422eea71d473e0 upstream.

Add a spectre_v2= option to select the mitigation used for the indirect
branch speculation vulnerability.

Currently, the only option available is retpoline, in its various forms.
This will be expanded to cover the new IBRS/IBPB microcode features.

The RETPOLINE_AMD feature relies on a serializing LFENCE for speculation
control. For AMD hardware, only set RETPOLINE_AMD if LFENCE is a
serializing instruction, which is indicated by the LFENCE_RDTSC feature.

[ tglx: Folded back the LFENCE/AMD fixes and reworked it so IBRS
  	integration becomes simple ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
Link: https://lkml.kernel.org/r/1515707194-20531-5-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/kernel-parameters.txt  |  28 +++++
 arch/x86/include/asm/nospec-branch.h |  10 ++
 arch/x86/kernel/cpu/bugs.c           | 158 +++++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c         |   4 -
 4 files changed, 195 insertions(+), 5 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2167,6 +2167,11 @@ bytes respectively. Such letter suffixes
 			register save and restore. The kernel will only save
 			legacy floating-point registers on task switch.
 
+	nospectre_v2	[X86] Disable all mitigations for the Spectre variant 2
+			(indirect branch prediction) vulnerability. System may
+			allow data leaks with this option, which is equivalent
+			to spectre_v2=off.
+
 	noxsave		[BUGS=X86] Disables x86 extended register state save
 			and restore using xsave. The kernel will fallback to
 			enabling legacy floating-point and sse state.
@@ -3168,6 +3173,29 @@ bytes respectively. Such letter suffixes
 	sonypi.*=	[HW] Sony Programmable I/O Control Device driver
 			See Documentation/laptops/sonypi.txt
 
+	spectre_v2=	[X86] Control mitigation of Spectre variant 2
+			(indirect branch speculation) vulnerability.
+
+			on   - unconditionally enable
+			off  - unconditionally disable
+			auto - kernel detects whether your CPU model is
+			       vulnerable
+
+			Selecting 'on' will, and 'auto' may, choose a
+			mitigation method at run time according to the
+			CPU, the available microcode, the setting of the
+			CONFIG_RETPOLINE configuration option, and the
+			compiler with which the kernel was built.
+
+			Specific mitigations can also be selected manually:
+
+			retpoline	  - replace indirect branches
+			retpoline,generic - google's original retpoline
+			retpoline,amd     - AMD-specific minimal thunk
+
+			Not specifying this option is equivalent to
+			spectre_v2=auto.
+
 	spia_io_base=	[HW,MTD]
 	spia_fio_base=
 	spia_pedr=
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -102,5 +102,15 @@
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #endif
 
+/* The Spectre V2 mitigation variants */
+enum spectre_v2_mitigation {
+	SPECTRE_V2_NONE,
+	SPECTRE_V2_RETPOLINE_MINIMAL,
+	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
+	SPECTRE_V2_RETPOLINE_GENERIC,
+	SPECTRE_V2_RETPOLINE_AMD,
+	SPECTRE_V2_IBRS,
+};
+
 #endif /* __ASSEMBLY__ */
 #endif /* __NOSPEC_BRANCH_H__ */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -10,6 +10,9 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/cpu.h>
+
+#include <asm/nospec-branch.h>
+#include <asm/cmdline.h>
 #include <asm/bugs.h>
 #include <asm/processor.h>
 #include <asm/processor-flags.h>
@@ -20,6 +23,8 @@
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 
+static void __init spectre_v2_select_mitigation(void);
+
 #ifdef CONFIG_X86_32
 
 static double __initdata x = 4195835.0;
@@ -87,6 +92,9 @@ void __init check_bugs(void)
 		print_cpu_info(&boot_cpu_data);
 	}
 
+	/* Select the proper spectre mitigation before patching alternatives */
+	spectre_v2_select_mitigation();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Check whether we are able to run this kernel safely on SMP.
@@ -124,6 +132,153 @@ void __init check_bugs(void)
 #endif
 }
 
+/* The kernel command line selection */
+enum spectre_v2_mitigation_cmd {
+	SPECTRE_V2_CMD_NONE,
+	SPECTRE_V2_CMD_AUTO,
+	SPECTRE_V2_CMD_FORCE,
+	SPECTRE_V2_CMD_RETPOLINE,
+	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
+	SPECTRE_V2_CMD_RETPOLINE_AMD,
+};
+
+static const char *spectre_v2_strings[] = {
+	[SPECTRE_V2_NONE]			= "Vulnerable",
+	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
+	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
+	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
+	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
+};
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "Spectre V2 mitigation: " fmt
+
+static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
+
+static void __init spec2_print_if_insecure(const char *reason)
+{
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		pr_info("%s\n", reason);
+}
+
+static void __init spec2_print_if_secure(const char *reason)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		pr_info("%s\n", reason);
+}
+
+static inline bool retp_compiler(void)
+{
+	return __is_defined(RETPOLINE);
+}
+
+static inline bool match_option(const char *arg, int arglen, const char *opt)
+{
+	int len = strlen(opt);
+
+	return len == arglen && !strncmp(arg, opt, len);
+}
+
+static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
+{
+	char arg[20];
+	int ret;
+
+	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
+				  sizeof(arg));
+	if (ret > 0)  {
+		if (match_option(arg, ret, "off")) {
+			goto disable;
+		} else if (match_option(arg, ret, "on")) {
+			spec2_print_if_secure("force enabled on command line.");
+			return SPECTRE_V2_CMD_FORCE;
+		} else if (match_option(arg, ret, "retpoline")) {
+			spec2_print_if_insecure("retpoline selected on command line.");
+			return SPECTRE_V2_CMD_RETPOLINE;
+		} else if (match_option(arg, ret, "retpoline,amd")) {
+			if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+				pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
+				return SPECTRE_V2_CMD_AUTO;
+			}
+			spec2_print_if_insecure("AMD retpoline selected on command line.");
+			return SPECTRE_V2_CMD_RETPOLINE_AMD;
+		} else if (match_option(arg, ret, "retpoline,generic")) {
+			spec2_print_if_insecure("generic retpoline selected on command line.");
+			return SPECTRE_V2_CMD_RETPOLINE_GENERIC;
+		} else if (match_option(arg, ret, "auto")) {
+			return SPECTRE_V2_CMD_AUTO;
+		}
+	}
+
+	if (!cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+		return SPECTRE_V2_CMD_AUTO;
+disable:
+	spec2_print_if_insecure("disabled on command line.");
+	return SPECTRE_V2_CMD_NONE;
+}
+
+static void __init spectre_v2_select_mitigation(void)
+{
+	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
+	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
+
+	/*
+	 * If the CPU is not affected and the command line mode is NONE or AUTO
+	 * then nothing to do.
+	 */
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
+	    (cmd == SPECTRE_V2_CMD_NONE || cmd == SPECTRE_V2_CMD_AUTO))
+		return;
+
+	switch (cmd) {
+	case SPECTRE_V2_CMD_NONE:
+		return;
+
+	case SPECTRE_V2_CMD_FORCE:
+		/* FALLTRHU */
+	case SPECTRE_V2_CMD_AUTO:
+		goto retpoline_auto;
+
+	case SPECTRE_V2_CMD_RETPOLINE_AMD:
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_amd;
+		break;
+	case SPECTRE_V2_CMD_RETPOLINE_GENERIC:
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_generic;
+		break;
+	case SPECTRE_V2_CMD_RETPOLINE:
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_auto;
+		break;
+	}
+	pr_err("kernel not compiled with retpoline; no mitigation available!");
+	return;
+
+retpoline_auto:
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	retpoline_amd:
+		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
+			pr_err("LFENCE not serializing. Switching to generic retpoline\n");
+			goto retpoline_generic;
+		}
+		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
+					 SPECTRE_V2_RETPOLINE_MINIMAL_AMD;
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_AMD);
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+	} else {
+	retpoline_generic:
+		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_GENERIC :
+					 SPECTRE_V2_RETPOLINE_MINIMAL;
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+	}
+
+	spectre_v2_enabled = mode;
+	pr_info("%s\n", spectre_v2_strings[mode]);
+}
+
+#undef pr_fmt
+
 #ifdef CONFIG_SYSFS
 ssize_t cpu_show_meltdown(struct device *dev,
 			  struct device_attribute *attr, char *buf)
@@ -148,6 +303,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
-	return sprintf(buf, "Vulnerable\n");
+
+	return sprintf(buf, "%s\n", spectre_v2_strings[spectre_v2_enabled]);
 }
 #endif
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -810,10 +810,6 @@ static void __init early_identify_cpu(st
 
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
-
-#ifdef CONFIG_RETPOLINE
-	setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
-#endif
 }
 
 void __init early_cpu_init(void)
