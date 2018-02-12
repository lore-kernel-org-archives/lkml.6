Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227xmL8m6lEjj42SVMNfQ0iahjPEyZ2ylrTJza3G4nPsB3xEtA1TcYAaKw4HH/qNAcIFfjHR
ARC-Seal: i=1; a=rsa-sha256; t=1518439995; cv=none;
        d=google.com; s=arc-20160816;
        b=R00dv9Fz6IKsQ8Lnz1UjnyG+mXw9S6/y2HbcHjYNCQhng7tb8kZ+x8kWIpKk8XUcVi
         h1d1/IH/8VEudqHsFdmpZEwzSyGm3I+PV4bJ4fPzTieJlmvbK+ukzq9xGJD/yhQMhAVt
         gzKrAy21a5MpZt6qWSAs43hNjEohbjgcN1esEoG+gtYFVgytIe1GD+N+RP96Pz6qMjg2
         uY3M6Yn3DzxFGnV8yxtAcm+cBZjKsK+PgdP0ocAH0iHOsrNAQfGnU3QBE5br33nzXwo1
         5TZZEEySV0AQXlsAGW04R555eXOMOqSuAleY0r/SuGlmjv3o2cjjnakOBEvJu7Gfa/EW
         qddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=190MSA6KHrSTK2yofS0WZXp/2shbW/rYmqGrbiYQIlc=;
        b=X8zoUzmZ0Fsn1+w70PYAbI+IfHG7xy82VurWbEc9kZKjL4ZV4lRDgG1R4iDW8PppEx
         uWyPdovy2Ggwm/fTWvnYG3XR9GTmFLRT/SlPZ81noij8bX9Y9QiQwNwX7fbNA3HB+GII
         qsXBzJo9J7l0ef3Hrq9JBkwoUz8Z1IFqFugql8kcPMOGA+LeYUJLqgXasXbIuiCQeCOc
         oG8yRQDre1Wg8Q4XDx7Ewb05hLu3gPnfYEiRRSDWpsKsoQS+939Z6hPCHBP1JBcShDEV
         NJH/9W8xHCSTmgfZBhhXBppZdFMXEbFrNG39wRIrNtl5u00vY/HvYhPJXIGhnmxTRuwj
         cB9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=BL1Eu+4E;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=soGrwzDp;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=BL1Eu+4E;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=soGrwzDp;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180212125033.346541648@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 12 Feb 2018 13:48:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Asit Mallick <asit.k.mallick@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 2/8] objtool: Add retpoline validation
References: <20180212124855.882405399@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-objtool-indirect.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199736159925781?=
X-GMAIL-MSGID: =?utf-8?q?1592199736159925781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

David requested a objtool validation pass for RETPOLINE enabled
builds, where it validates no unannotated indirect  jumps or calls are
left.

Add an additional .discard.retpoline_safe section to allow annotating
the few indirect sites that are required and safe.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Requested-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/Makefile.build        |    4 +
 tools/objtool/builtin-check.c |    3 -
 tools/objtool/builtin.h       |    2 
 tools/objtool/check.c         |   86 +++++++++++++++++++++++++++++++++++++++++-
 tools/objtool/check.h         |    1 
 5 files changed, 93 insertions(+), 3 deletions(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -264,6 +264,10 @@ objtool_args += --no-unreachable
 else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
+ifdef CONFIG_RETPOLINE
+  objtool_args += --retpoline
+endif
+
 
 ifdef CONFIG_MODVERSIONS
 objtool_o = $(@D)/.tmp_$(@F)
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable;
+bool no_fp, no_unreachable, retpoline;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -39,6 +39,7 @@ static const char * const check_usage[]
 const struct option check_options[] = {
 	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
+	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
 	OPT_END(),
 };
 
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -20,7 +20,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable;
+extern bool no_fp, no_unreachable, retpoline;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -496,6 +496,7 @@ static int add_jump_destinations(struct
 			 * disguise, so convert them accordingly.
 			 */
 			insn->type = INSN_JUMP_DYNAMIC;
+			insn->retpoline_safe = true;
 			continue;
 		} else {
 			/* sibling call */
@@ -547,7 +548,8 @@ static int add_call_destinations(struct
 			if (!insn->call_dest && !insn->ignore) {
 				WARN_FUNC("unsupported intra-function call",
 					  insn->sec, insn->offset);
-				WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
+				if (retpoline)
+					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
 				return -1;
 			}
 
@@ -1107,6 +1109,54 @@ static int read_unwind_hints(struct objt
 	return 0;
 }
 
+static int read_retpoline_hints(struct objtool_file *file)
+{
+	struct section *sec, *relasec;
+	struct instruction *insn;
+	struct rela *rela;
+	int i;
+
+	sec = find_section_by_name(file->elf, ".discard.retpoline_safe");
+	if (!sec)
+		return 0;
+
+	relasec = sec->rela;
+	if (!relasec) {
+		WARN("missing .rela.discard.retpoline_safe section");
+		return -1;
+	}
+
+	if (sec->len % sizeof(unsigned long)) {
+		WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
+		return -1;
+	}
+
+	for (i = 0; i < sec->len / sizeof(unsigned long); i++) {
+		rela = find_rela_by_dest(sec, i * sizeof(unsigned long));
+		if (!rela) {
+			WARN("can't find rela for retpoline_safe[%d]", i);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("can't find insn for retpoline_safe[%d]", i);
+			return -1;
+		}
+
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC) {
+			WARN_FUNC("retpoline_safe hint not a indirect jump/call",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		insn->retpoline_safe = true;
+	}
+
+	return 0;
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
@@ -1145,6 +1195,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_retpoline_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1890,6 +1944,29 @@ static int validate_unwind_hints(struct
 	return warnings;
 }
 
+static int validate_retpoline(struct objtool_file *file)
+{
+	struct instruction *insn;
+	int warnings = 0;
+
+	for_each_insn(file, insn) {
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC)
+			continue;
+
+		if (insn->retpoline_safe)
+			continue;
+
+		WARN_FUNC("indirect %s found in RETPOLINE build",
+			  insn->sec, insn->offset,
+			  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
+
+		warnings++;
+	}
+
+	return warnings;
+}
+
 static bool is_kasan_insn(struct instruction *insn)
 {
 	return (insn->type == INSN_CALL &&
@@ -2044,6 +2121,13 @@ int check(const char *_objname, bool orc
 	if (list_empty(&file.insn_list))
 		goto out;
 
+	if (retpoline) {
+		ret = validate_retpoline(&file);
+		if (ret < 0)
+			return ret;
+		warnings += ret;
+	}
+
 	ret = validate_functions(&file);
 	if (ret < 0)
 		goto out;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -45,6 +45,7 @@ struct instruction {
 	unsigned char type;
 	unsigned long immediate;
 	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool retpoline_safe;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
