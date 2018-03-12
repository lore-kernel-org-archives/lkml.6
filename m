Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtVQT6I1D0/JRkcvJadrSexWqrYQU8DM3PfPwU38qcybWdl1a4i/CY0iQGZPIBNv45jiPzN
ARC-Seal: i=1; a=rsa-sha256; t=1520824073; cv=none;
        d=google.com; s=arc-20160816;
        b=pntKuc6SJRIsyUGc/NfIN56ayz36bKLj2n8WhvVkUAg45Kl3CNFR39kzy67lfzWrDA
         hrzbBsxFpplADjCTIHOMR/6199SAXhSezm8cZrANzxJ1yeTgrDbMhgQ8fUpHrA+acLwg
         BpjR7gVEvVW88VrJqtdAiOhkdQecsUg7Lv64EN7WyLLIyqmLsQePt5Zviyn2YlJy+sjx
         1Zyzk+Vn1yq0bZzbR4WuF6plI3VvTHeEyDZwN5KCABPre6NXAsElUnzbfw4UAVQqoYVq
         COaoJ4csS/cScni0sX2aJnvM0h0/GRtYt8rgojNIx6rBcbHWk8Mxi5MRXcQi2xRaabgw
         /Y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=y7Sq/5p/Mzmn9Rufh5QX2xMIcVTQuhugi4HNSzt9SwY=;
        b=gyY6AWBpNIEiVkrt5FwylcXv3isNRGpg0s9WUZ8EuzDbSiTFcZXkXAh18Jay7BxKx8
         LiPo6XrlKKt1O5eNZwZUIR28QWdG3FnG1/iNgIT5NcLumxD7FOHTckU9+Gn4xc5NdahF
         z1zJc3Yb/gGaNQGtGPMZpMc02tv59cXP3olah7J/RfVHbYgbuUEMcMo4PDk9WRDZOPmK
         IHptu1CUYMURdyS5ihrh5s1mAtPe2mb3dYNYP7IKHST7VLibZLfmTFyANbWQcxOGUa/8
         S4a55vViwLi29FJWXYwC51KnMMWXpPX8pH5VX/QL8oaoEq1v9EoS6KJrfbOCAMFbhXGN
         PDgA==
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
 torvalds@linux-foundation.org, arjan@linux.intel.com, jeyu@kernel.org,
 gregkh@linuxfoundation.org,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.121191571@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 46/76] module/retpoline: Warn about missing retpoline
 in module
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699615683450276?=
X-GMAIL-MSGID: =?utf-8?q?1594699623840991604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit caf7501a1b4ec964190f31f9c3f163de252273b8 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 17 ++++++++++++++++-
 include/linux/module.h     |  9 +++++++++
 kernel/module.c            | 11 +++++++++++
 scripts/mod/modpost.c      |  9 +++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/cpu.h>
+#include <linux/module.h>
 
 #include <asm/nospec-branch.h>
 #include <asm/cmdline.h>
@@ -155,6 +156,19 @@ static const char *spectre_v2_strings[]
 #define pr_fmt(fmt)     "Spectre V2 mitigation: " fmt
 
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
 
 static void __init spec2_print_if_insecure(const char *reason)
 {
@@ -340,6 +354,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s\n", spectre_v2_strings[spectre_v2_enabled]);
+	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
 }
 #endif
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -656,4 +656,13 @@ static inline void module_bug_finalize(c
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
 #endif /* _LINUX_MODULE_H */
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2494,6 +2494,15 @@ static int elf_header_check(struct load_
 	return 0;
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
 /* Sets info->hdr and info->len. */
 static int copy_module_from_user(const void __user *umod, unsigned long len,
 				  struct load_info *info)
@@ -2698,6 +2707,8 @@ static int check_modinfo(struct module *
 	if (!get_modinfo(info, "intree"))
 		add_taint_module(mod, TAINT_OOT_MODULE, LOCKDEP_STILL_OK);
 
+	check_modinfo_retpoline(mod, info);
+
 	if (get_modinfo(info, "staging")) {
 		add_taint_module(mod, TAINT_CRAP, LOCKDEP_STILL_OK);
 		pr_warn("%s: module is from the staging directory, the quality "
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1952,6 +1952,14 @@ static void add_intree_flag(struct buffe
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
@@ -2282,6 +2290,7 @@ int main(int argc, char **argv)
 
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
+		add_retpoline(&buf);
 		add_staging_flag(&buf, mod->name);
 		err |= add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
