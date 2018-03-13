Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsxBlr+V0GMvDVf4jR7EP0v45DGJd4yr0TasXlGo/S+7t95L+svglGTnNmyLLhE8qz07Xo6
ARC-Seal: i=1; a=rsa-sha256; t=1520955150; cv=none;
        d=google.com; s=arc-20160816;
        b=KZ6x4VDq3yNlzh1uMmz9ie80C+4l1fZDWEtKVReC0IpMU5WXpInhd4augSwMaR2KrJ
         nhVfNn4Iagg9dIQtFhmPHIZf++biJAzBWCeKt+q+aYOpzUXeafy3GjIApn9OXGymk7vC
         E+BqwfWQmvYOATEeoKyjqR1s3//Q/5LL0kfTZMCFtFKbXRmmPoSmYrgXv+3/I3+ac1mP
         gaaSVK8Ept+la9Ag1Fk2088KzW8QKVUuO6XFoxnHYcbWAFLVRYN18nuZ0anodYlkxdSl
         /HSFuhlGc9kzN/DlfhngkBrnCgGCOvSLAWmNp5lX4DVCJu0Qh0KXvtqaYZs8vxePGMtQ
         bigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g6J/usBJ0Q0CI5oLKVLjLkmLFm3gghFUysmKA2WRz/I=;
        b=EFBdGuH8XPjl+7JuC7Ae9Np59kE9MG4vPcHMbAqTLZgxHKkCpWZsREzXrowoHygwsE
         +keiqd6RMsoYblVIZ8JGyS1Zr1/6icDNa2SKOgpqE/bEwuZq1cINYynxRbYlIwYwdWej
         ybP4lu4m08vHVly4Ymf5LehyM3yvfIbTtzGvo6RfjovTxfqHiUCKBQOJ4W5JIYS4jSmD
         BAL7Tm6+2ozSs7JB06YxlrsmFp69FFBpSLW67hP4NEJg69WRSXgVedRGnVZbX1v3V8vX
         e7vYYCAFrQDUMZvlyX8CKicCZjtAWUMh2z869aTqax4bpFPRsZvEzL+d7Ya0Eexg7frm
         5AYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 098/146] objtool: Add retpoline validation
Date: Tue, 13 Mar 2018 16:24:25 +0100
Message-Id: <20180313152328.145234083@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837067702875910?=
X-GMAIL-MSGID: =?utf-8?q?1594837067702875910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit b5bc2231b8ad4387c9641f235ca0ad8cd300b6df upstream.

David requested a objtool validation pass for CONFIG_RETPOLINE=y enabled
builds, where it validates no unannotated indirect  jumps or calls are
left.

Add an additional .discard.retpoline_safe section to allow annotating
the few indirect sites that are required and safe.

Requested-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
@@ -2050,6 +2127,13 @@ int check(const char *_objname, bool orc
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
