Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuzER9YG9lR1GwwmEIcQmqoWWQqqBnuyrgcMWUzupb4QxE196msHro56Nnlu+x0oxEvhRe0
ARC-Seal: i=1; a=rsa-sha256; t=1519411234; cv=none;
        d=google.com; s=arc-20160816;
        b=u5OvhbL69d0bK0B40ryDx8/XKi3Pv0eadYpN2JRtSEGotfhVkNEH3PXQnFWwWRnpBI
         kVPbSh0aXfZiGF0acQ90rtyzQjKdNSD7JbkLVvogGfO6nRYw+fm4Hep266Jfa8RYc2ZL
         lgoZ4H0JPDWC6DvLMFkEZdHH10XoXAKB007x8E/8F4GQaeZQMMu/4C91Q65TtuRHYEcW
         08A8UIo0Ho0FB6ENxqpyk+OmYsq2zPlU8RXV7lQ1mVWhA2fk8EwBiEuhnkYwq+1sV14n
         VcFYo8fkgzBB4IeC+SlOPP3J+T19LXmqjL9Tc+CAPAfyeUlX40vNSKFcXSuBcwDNo6gB
         Pr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NhQQLR9DHguN8LAemQXKVET1SpfnzGXLvrdwYU3nZv8=;
        b=CCfuS++7y5SRdsJ58GIFTaZG4e1PjmjM9Q5WcgDfiViQ0mnPDXAgx6XHVnmothxLQF
         UAf222VrlsMXyhcJQQci196yvrtUt/de/8teRPvWqaXlPrhHimtl2LaF0NVSCyIj1oIp
         b3bOMWSoMJacrqOt8jeeuN97TdAFh17s5PV9zXQsEjXJCPdTpY68X0gmmvzJFjOB73ch
         bfFd99vspiXE4ENMokeyGXUwWXOYYyqeU4frJwNTAXj1991XDlYXSmnCyT4ZZDsS4o4G
         KeKtKqAgPDHUFuUpHDKyHVkky9S4rKmlScgK60eSB9/be5pdd5YE/qQcrnd4n/T7qWr6
         omdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw2@infradead.org>,
	torvalds@linux-foundation.org,
	jeyu@kernel.org,
	arjan@linux.intel.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 168/193] module/retpoline: Warn about missing retpoline in module
Date: Fri, 23 Feb 2018 19:26:41 +0100
Message-Id: <20180223170352.316313885@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218155348830632?=
X-GMAIL-MSGID: =?utf-8?q?1593218155348830632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

(cherry picked from commit caf7501a1b4ec964190f31f9c3f163de252273b8)

There's a risk that a kernel which has full retpoline mitigations becomes
vulnerable when a module gets loaded that hasn't been compiled with the
right compiler or the right option.

To enable detection of that mismatch at module load time, add a module info
string "retpoline" at build time when the module was compiled with
retpoline support. This only covers compiled C source, but assembler source
or prebuilt object files are not checked.

If a retpoline enabled kernel detects a non retpoline protected module at
load time, print a warning and report it in the sysfs vulnerability file.

[ tglx: Massaged changelog ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org
Cc: jeyu@kernel.org
Cc: arjan@linux.intel.com
Link: https://lkml.kernel.org/r/20180125235028.31211-1-andi@firstfloor.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: port to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   18 +++++++++++++++++-
 include/linux/module.h     |    9 +++++++++
 kernel/module.c            |   11 +++++++++++
 scripts/mod/modpost.c      |    9 +++++++++
 4 files changed, 46 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/cpu.h>
+#include <linux/module.h>
 
 #include <asm/nospec-branch.h>
 #include <asm/cmdline.h>
@@ -93,6 +94,20 @@ static const char *spectre_v2_strings[]
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 
+static bool spectre_v2_bad_module;
+
+#ifdef RETPOLINE
+bool retpoline_module_ok(bool has_retpoline)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
+		return true;
+
+	pr_err("System may be vunerable to spectre v2\n");
+	spectre_v2_bad_module = true;
+	return false;
+}
+#endif
+
 static void __init spec2_print_if_insecure(const char *reason)
 {
 	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
@@ -277,6 +292,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s\n", spectre_v2_strings[spectre_v2_enabled]);
+	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
 }
 #endif
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -789,6 +789,15 @@ static inline void module_bug_finalize(c
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
 
+#ifdef RETPOLINE
+extern bool retpoline_module_ok(bool has_retpoline);
+#else
+static inline bool retpoline_module_ok(bool has_retpoline)
+{
+	return true;
+}
+#endif
+
 #ifdef CONFIG_MODULE_SIG
 static inline bool module_sig_ok(struct module *module)
 {
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2869,6 +2869,15 @@ static struct module *setup_load_info(st
 	return mod;
 }
 
+static void check_modinfo_retpoline(struct module *mod, struct load_info *info)
+{
+	if (retpoline_module_ok(get_modinfo(info, "retpoline")))
+		return;
+
+	pr_warn("%s: loading module not compiled with retpoline compiler.\n",
+		mod->name);
+}
+
 static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 {
 	const char *modmagic = get_modinfo(info, "vermagic");
@@ -2895,6 +2904,8 @@ static int check_modinfo(struct module *
 		add_taint_module(mod, TAINT_OOT_MODULE, LOCKDEP_STILL_OK);
 	}
 
+	check_modinfo_retpoline(mod, info);
+
 	if (get_modinfo(info, "staging")) {
 		add_taint_module(mod, TAINT_CRAP, LOCKDEP_STILL_OK);
 		pr_warn("%s: module is from the staging directory, the quality "
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2129,6 +2129,14 @@ static void add_intree_flag(struct buffe
 		buf_printf(b, "\nMODULE_INFO(intree, \"Y\");\n");
 }
 
+/* Cannot check for assembler */
+static void add_retpoline(struct buffer *b)
+{
+	buf_printf(b, "\n#ifdef RETPOLINE\n");
+	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
+	buf_printf(b, "#endif\n");
+}
+
 static void add_staging_flag(struct buffer *b, const char *name)
 {
 	static const char *staging_dir = "drivers/staging";
@@ -2473,6 +2481,7 @@ int main(int argc, char **argv)
 
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
+		add_retpoline(&buf);
 		add_staging_flag(&buf, mod->name);
 		err |= add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
