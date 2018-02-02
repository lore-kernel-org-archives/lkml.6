Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeBBLsY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 06:48:24 -0500
Received: from terminus.zytor.com ([65.50.211.136]:41715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeBBLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 06:48:16 -0500
Date: Fri, 2 Feb 2018 03:47:08 -0800
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-9005c6834c0ffdfe46afa76656bd9276cca864f6@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, dwmw@amazon.co.uk,
        karahmed@amazon.de, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, karahmed@amazon.de,
        tglx@linutronix.de, hpa@zytor.com, dwmw@amazon.co.uk
In-Reply-To: <1517484441-1420-3-git-send-email-dwmw@amazon.co.uk>
References: <1517484441-1420-3-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/spectre: Simplify spectre_v2 command line parsing
Git-Commit-ID: 9005c6834c0ffdfe46afa76656bd9276cca864f6
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

Commit-ID:  9005c6834c0ffdfe46afa76656bd9276cca864f6
Gitweb:     https://git.kernel.org/tip/9005c6834c0ffdfe46afa76656bd9276cca864f6
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Thu, 1 Feb 2018 11:27:21 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 2 Feb 2018 12:28:27 +0100

x86/spectre: Simplify spectre_v2 command line parsing

[dwmw2: Use ARRAY_SIZE]

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-3-git-send-email-dwmw@amazon.co.uk

---
 arch/x86/kernel/cpu/bugs.c | 86 ++++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dd3a3cc..71949bf 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -119,13 +119,13 @@ static inline const char *spectre_v2_module_string(void) { return ""; }
 static void __init spec2_print_if_insecure(const char *reason)
 {
 	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s\n", reason);
+		pr_info("%s selected on command line.\n", reason);
 }
 
 static void __init spec2_print_if_secure(const char *reason)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s\n", reason);
+		pr_info("%s selected on command line.\n", reason);
 }
 
 static inline bool retp_compiler(void)
@@ -140,42 +140,68 @@ static inline bool match_option(const char *arg, int arglen, const char *opt)
 	return len == arglen && !strncmp(arg, opt, len);
 }
 
+static const struct {
+	const char *option;
+	enum spectre_v2_mitigation_cmd cmd;
+	bool secure;
+} mitigation_options[] = {
+	{ "off",               SPECTRE_V2_CMD_NONE,              false },
+	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
+	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
+	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
+	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
+	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
+};
+
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
 	char arg[20];
-	int ret;
-
-	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
-				  sizeof(arg));
-	if (ret > 0)  {
-		if (match_option(arg, ret, "off")) {
-			goto disable;
-		} else if (match_option(arg, ret, "on")) {
-			spec2_print_if_secure("force enabled on command line.");
-			return SPECTRE_V2_CMD_FORCE;
-		} else if (match_option(arg, ret, "retpoline")) {
-			spec2_print_if_insecure("retpoline selected on command line.");
-			return SPECTRE_V2_CMD_RETPOLINE;
-		} else if (match_option(arg, ret, "retpoline,amd")) {
-			if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-				pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
-				return SPECTRE_V2_CMD_AUTO;
-			}
-			spec2_print_if_insecure("AMD retpoline selected on command line.");
-			return SPECTRE_V2_CMD_RETPOLINE_AMD;
-		} else if (match_option(arg, ret, "retpoline,generic")) {
-			spec2_print_if_insecure("generic retpoline selected on command line.");
-			return SPECTRE_V2_CMD_RETPOLINE_GENERIC;
-		} else if (match_option(arg, ret, "auto")) {
+	int ret, i;
+	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+
+	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+		return SPECTRE_V2_CMD_NONE;
+	else {
+		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
+					  sizeof(arg));
+		if (ret < 0)
+			return SPECTRE_V2_CMD_AUTO;
+
+		for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
+			if (!match_option(arg, ret, mitigation_options[i].option))
+				continue;
+			cmd = mitigation_options[i].cmd;
+			break;
+		}
+
+		if (i >= ARRAY_SIZE(mitigation_options)) {
+			pr_err("unknown option (%s). Switching to AUTO select\n",
+			       mitigation_options[i].option);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
 
-	if (!cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
+	    !IS_ENABLED(CONFIG_RETPOLINE)) {
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
+		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
-disable:
-	spec2_print_if_insecure("disabled on command line.");
-	return SPECTRE_V2_CMD_NONE;
+	}
+
+	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
+		return SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (mitigation_options[i].secure)
+		spec2_print_if_secure(mitigation_options[i].option);
+	else
+		spec2_print_if_insecure(mitigation_options[i].option);
+
+	return cmd;
 }
 
 /* Check for Skylake-like CPUs (for RSB handling) */
