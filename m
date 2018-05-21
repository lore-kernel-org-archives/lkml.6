Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrIjdi/OltjkdTTa0vTla/eyUveOsrNFrW3j7h6ry4x3KbwE3OGIhDRF8QxsKX4vQwAvpiQ
ARC-Seal: i=1; a=rsa-sha256; t=1526937606; cv=none;
        d=google.com; s=arc-20160816;
        b=CmQP3FoXRnRbdrlgcb/C5/Q0VTS2jOaS90utGZHAXSNgwd7GVaLpQU81yeRWfZtdwz
         quwumRjpkI2Us5xSZK6EF9Bk/yV987Q7AmXm5rTOQ7ma/0G7JpMRqwr16LablzQEAwF4
         xnVzXg6m+wqP09qCiIRV620tR30jTTY0r/xtYUWwYzrUwN7cUQpHpdG9NI833JH+mJyu
         5IPPHKIceE3546UrDxOpIGbTcg7QvQolYaKiTNDc+iASNjxlQ3ZA6SiXsrwEuREuqWpP
         sfxPfg9LvFd7LJoHV28tP2NLUmEYIEUErxV0Pw5a2n5gMdV/B7cOAMaDBNVU+mfmUqVK
         q/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZcddQJwthTH28Achn9ILvQ48W8vqwxd5yxhaYiNZa6M=;
        b=zVM84o4SjV03xSWYCNx4nS9u7kwDhRmqO0b2Z7naw3Q4uWWkkH46DGZuCSYgjht/u8
         9P3XzdgYQdcM52lBOSY+5cmv/jo8aw2gdVtLUa0ozybkU1S+dSX6uYjdsYLJor4lHLac
         l4aHiC8mFczBea6PQD+qkuJtlVOIrpAkmkB7r6vOZwT3DcAley9fhMM5diR7rCBbJWyq
         dz3daAZpC+91QUKNRz6HXh7uF0priyyytXVa1lRtzrgV1l/UpWoZ1z3PwSlrPvbxmtgB
         nqNTHIuHWVPCdEaN7T3priCCFuB9fePHIzzpK8Ag6NIB4wG/ziQE7GudJrRem8ckT8uw
         n+5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=PoOFsZiH;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=PoOFsZiH;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 55/95] x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation
Date: Mon, 21 May 2018 23:11:45 +0200
Message-Id: <20180521210458.392769211@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109841389169027?=
X-GMAIL-MSGID: =?utf-8?q?1601110127409855237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 24f7fc83b9204d20f878c57cb77d261ae825e033 upstream

Contemporary high performance processors use a common industry-wide
optimization known as "Speculative Store Bypass" in which loads from
addresses to which a recent store has occurred may (speculatively) see an
older value. Intel refers to this feature as "Memory Disambiguation" which
is part of their "Smart Memory Access" capability.

Memory Disambiguation can expose a cache side-channel attack against such
speculatively read values. An attacker can create exploit code that allows
them to read memory outside of a sandbox environment (for example,
malicious JavaScript in a web page), or to perform more complex attacks
against code running within the same privilege level, e.g. via the stack.

As a first step to mitigate against such attacks, provide two boot command
line control knobs:

 nospec_store_bypass_disable
 spec_store_bypass_disable=[off,auto,on]

By default affected x86 processors will power on with Speculative
Store Bypass enabled. Hence the provided kernel parameters are written
from the point of view of whether to enable a mitigation or not.
The parameters are as follows:

 - auto - Kernel detects whether your CPU model contains an implementation
	  of Speculative Store Bypass and picks the most appropriate
	  mitigation.

 - on   - disable Speculative Store Bypass
 - off  - enable Speculative Store Bypass

[ tglx: Reordered the checks so that the whole evaluation is not done
  	when the CPU does not support RDS ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   33 +++++++
 arch/x86/include/asm/cpufeatures.h              |    1 
 arch/x86/include/asm/nospec-branch.h            |    6 +
 arch/x86/kernel/cpu/bugs.c                      |  103 ++++++++++++++++++++++++
 4 files changed, 143 insertions(+)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2600,6 +2600,9 @@
 			allow data leaks with this option, which is equivalent
 			to spectre_v2=off.
 
+	nospec_store_bypass_disable
+			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
+
 	noxsave		[BUGS=X86] Disables x86 extended register state save
 			and restore using xsave. The kernel will fallback to
 			enabling legacy floating-point and sse state.
@@ -3930,6 +3933,36 @@
 			Not specifying this option is equivalent to
 			spectre_v2=auto.
 
+	spec_store_bypass_disable=
+			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
+			(Speculative Store Bypass vulnerability)
+
+			Certain CPUs are vulnerable to an exploit against a
+			a common industry wide performance optimization known
+			as "Speculative Store Bypass" in which recent stores
+			to the same memory location may not be observed by
+			later loads during speculative execution. The idea
+			is that such stores are unlikely and that they can
+			be detected prior to instruction retirement at the
+			end of a particular speculation execution window.
+
+			In vulnerable processors, the speculatively forwarded
+			store can be used in a cache side channel attack, for
+			example to read memory to which the attacker does not
+			directly have access (e.g. inside sandboxed code).
+
+			This parameter controls whether the Speculative Store
+			Bypass optimization is used.
+
+			on     - Unconditionally disable Speculative Store Bypass
+			off    - Unconditionally enable Speculative Store Bypass
+			auto   - Kernel detects whether the CPU model contains an
+				 implementation of Speculative Store Bypass and
+				 picks the most appropriate mitigation
+
+			Not specifying this option is equivalent to
+			spec_store_bypass_disable=auto.
+
 	spia_io_base=	[HW,MTD]
 	spia_fio_base=
 	spia_pedr=
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -212,6 +212,7 @@
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
+#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -238,6 +238,12 @@ extern u64 x86_spec_ctrl_get_default(voi
 extern void x86_spec_ctrl_set_guest(u64);
 extern void x86_spec_ctrl_restore_host(u64);
 
+/* The Speculative Store Bypass disable variants */
+enum ssb_mitigation {
+	SPEC_STORE_BYPASS_NONE,
+	SPEC_STORE_BYPASS_DISABLE,
+};
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -27,6 +27,7 @@
 #include <asm/intel-family.h>
 
 static void __init spectre_v2_select_mitigation(void);
+static void __init ssb_select_mitigation(void);
 
 /*
  * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
@@ -53,6 +54,12 @@ void __init check_bugs(void)
 	/* Select the proper spectre mitigation before patching alternatives */
 	spectre_v2_select_mitigation();
 
+	/*
+	 * Select proper mitigation for any exposure to the Speculative Store
+	 * Bypass vulnerability.
+	 */
+	ssb_select_mitigation();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Check whether we are able to run this kernel safely on SMP.
@@ -358,6 +365,99 @@ retpoline_auto:
 }
 
 #undef pr_fmt
+#define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
+
+static enum ssb_mitigation ssb_mode = SPEC_STORE_BYPASS_NONE;
+
+/* The kernel command line selection */
+enum ssb_mitigation_cmd {
+	SPEC_STORE_BYPASS_CMD_NONE,
+	SPEC_STORE_BYPASS_CMD_AUTO,
+	SPEC_STORE_BYPASS_CMD_ON,
+};
+
+static const char *ssb_strings[] = {
+	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
+	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled"
+};
+
+static const struct {
+	const char *option;
+	enum ssb_mitigation_cmd cmd;
+} ssb_mitigation_options[] = {
+	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO }, /* Platform decides */
+	{ "on",		SPEC_STORE_BYPASS_CMD_ON },   /* Disable Speculative Store Bypass */
+	{ "off",	SPEC_STORE_BYPASS_CMD_NONE }, /* Don't touch Speculative Store Bypass */
+};
+
+static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
+{
+	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+	char arg[20];
+	int ret, i;
+
+	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable")) {
+		return SPEC_STORE_BYPASS_CMD_NONE;
+	} else {
+		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
+					  arg, sizeof(arg));
+		if (ret < 0)
+			return SPEC_STORE_BYPASS_CMD_AUTO;
+
+		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
+			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
+				continue;
+
+			cmd = ssb_mitigation_options[i].cmd;
+			break;
+		}
+
+		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
+			return SPEC_STORE_BYPASS_CMD_AUTO;
+		}
+	}
+
+	return cmd;
+}
+
+static enum ssb_mitigation_cmd __init __ssb_select_mitigation(void)
+{
+	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
+	enum ssb_mitigation_cmd cmd;
+
+	if (!boot_cpu_has(X86_FEATURE_RDS))
+		return mode;
+
+	cmd = ssb_parse_cmdline();
+	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) &&
+	    (cmd == SPEC_STORE_BYPASS_CMD_NONE ||
+	     cmd == SPEC_STORE_BYPASS_CMD_AUTO))
+		return mode;
+
+	switch (cmd) {
+	case SPEC_STORE_BYPASS_CMD_AUTO:
+	case SPEC_STORE_BYPASS_CMD_ON:
+		mode = SPEC_STORE_BYPASS_DISABLE;
+		break;
+	case SPEC_STORE_BYPASS_CMD_NONE:
+		break;
+	}
+
+	if (mode != SPEC_STORE_BYPASS_NONE)
+		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
+	return mode;
+}
+
+static void ssb_select_mitigation()
+{
+	ssb_mode = __ssb_select_mitigation();
+
+	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+		pr_info("%s\n", ssb_strings[ssb_mode]);
+}
+
+#undef pr_fmt
 
 #ifdef CONFIG_SYSFS
 
@@ -383,6 +483,9 @@ ssize_t cpu_show_common(struct device *d
 			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 			       spectre_v2_module_string());
 
+	case X86_BUG_SPEC_STORE_BYPASS:
+		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
+
 	default:
 		break;
 	}
