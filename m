Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvaxvRfVcdraeguIcrxg2QCyA9G3OoSfzy9yAZ+UXahDbyhpDP/iyOP5s2x2PNG9siesqor
ARC-Seal: i=1; a=rsa-sha256; t=1520824082; cv=none;
        d=google.com; s=arc-20160816;
        b=ZJFANsrE4ZqOEpZqnweXTNH3zzJsVBkV+0KuI8BT07ShQUCZKa/ZN5le2dQaT7Nrb5
         huPnvshxNSuuRPnPc13UGwTLuGGkL8OvabN8olE56ZSFcPMvk4fchvlZULUJdWu38yVl
         INywJ8nne72T0wMEdzC36FT18EiH62iV8xgHyhPOuEZrBc60FdGWGzfwLu4F0MrCIFjv
         IGZkqXAlg7G9Qo4VjjWeTvaoITsLwslIfLa5YAaMuOqxaMJAGot/Xh1N0bOVszZhpA3U
         qOxpuxWEwLBu2GCtXYerEwVh7Y0u2y4sbxYO+P0Olr7aFqjy1mr+nTlmLuzI6snG03dU
         Q45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=ry8n58R+lZd5upNIuMI3/kpr/FzSY+TPpBTlHwyPuaA=;
        b=RQLK7hI+43OJ4o6tQqPWaxRBx48ko/LzZqCWAd9+KjTWXYmB1qb4GySzdeTy39k24h
         OzspyXhCeonQXaQvw6zn+6viSpArdTJjY9wxwdZYZ2OjURRNq48Hh4OwvAHGYlt4JN2c
         fx7xzlfDcLKKSZOUZEg9Dmz9DKIkN+2XxkGHikysjtT+dF7rJJkphNrQWpRai9EApebp
         0TkbrKytYVeTFUgI8UuvmxKjkRtP8IhH2BkPZ/2hFJroItlGfZb8T3EIDmWlHzyYnc4x
         pNXAmOZuYqow/Wp9RH9fmt3OX4URwlavvc98AxL3dRYqpYkLHw9SaF3ItM/sj85vO8rK
         vr8Q==
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
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>,
 thomas.lendacky@amd.com,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.844034669@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 059/104] x86/spectre: Add boot time option to select
 Spectre v2 mitigation
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699655663035914?=
X-GMAIL-MSGID: =?utf-8?q?1594699633315519285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/kernel-parameters.txt  |  28 +++++
 arch/x86/include/asm/nospec-branch.h |  10 ++
 arch/x86/kernel/cpu/bugs.c           | 158 +++++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c         |   4 -
 4 files changed, 195 insertions(+), 5 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1753,6 +1753,11 @@ bytes respectively. Such letter suffixes
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
@@ -2468,6 +2473,29 @@ bytes respectively. Such letter suffixes
 	specialix=	[HW,SERIAL] Specialix multi-serial port adapter
 			See Documentation/serial/specialix.txt.
 
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
 
 static int __init no_halt(char *s)
@@ -180,6 +185,9 @@ void __init check_bugs(void)
 		print_cpu_info(&boot_cpu_data);
 	}
 
+	/* Select the proper spectre mitigation before patching alternatives */
+	spectre_v2_select_mitigation();
+
 #ifdef CONFIG_X86_32
 	check_config();
 	check_fpu();
@@ -204,6 +212,153 @@ void __init check_bugs(void)
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
 ssize_t cpu_show_meltdown(struct sysdev_class *dev,
 			  struct sysdev_class_attribute *attr, char *buf)
@@ -228,6 +383,7 @@ ssize_t cpu_show_spectre_v2(struct sysde
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
@@ -773,10 +773,6 @@ static void __init early_identify_cpu(st
 
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
-
-#ifdef CONFIG_RETPOLINE
-	setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
-#endif
 }
 
 void __init early_cpu_init(void)
