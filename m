Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225XA6FcYIUziupDFW3CbJCqMntVnMgXgTBzyCvFOJYhCaVG8jANEQeb3QWSpYFyI4YGT/6B
ARC-Seal: i=1; a=rsa-sha256; t=1517496547; cv=none;
        d=google.com; s=arc-20160816;
        b=sQT1mJhobqhWnNnLoiFy4aIlP9cRyQ0j8HUNywJflakECtP8bnH3z1U3oXk1CfuUCz
         +9D0KLCi46nryiELR0oXuNWzAVlnS8QRYNimRCUXz6E3kI/jzVmH7h7oiSZmaoROlS9p
         kzglXpdNaQZ0L82y7pSQXZ3w0vNTpjW64LWVHybFPh0+sMOMwfHIHWrET1dNFhtyCBy9
         nmdpd6t1MaAVuhrCCxno3XqZxzwG8SjHZN96OWPVkrBfzFm6VYQa1N0f82cbo3t06lfX
         uS8GwebNpWu3RREeUdDBkGJIOfdv++ByiHr12kO4zHyPiYnn2teWi6w9oEeCL3PRvzWT
         ruGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=or5tqe7zxvkdfG0TnHngjpf+uKEZ87Vbt/pp1Y4xpO8=;
        b=CgyL/dQbItZbIMNb77RZ+25ibp/p/KiOtp7g0puZV0aQ7f1vHLPJFh1rfsxka7IXDM
         G6KRFCN8LDtLYCLzytcFbIPjwYpNMTrTeB+5+blqP0nJvVvKm/FJ+a9cXlToJg8Yzmn3
         SHhQhQS7mJF1GE3UbJZ+k5perY5wRtfp6SOT5msKb2Spncg2gP96lXvthHxbRtrJtnou
         Inn2Q97oHnpwg3K1ZU0YJe5au/MK/z6p1nyU0qE0JdijmEjIOY/5mzSOlsaWTjm6wpeb
         3TKKuShzrSQ7cSs35LuRIJJ9Olvt0Z2xZxZxSsNJWrV3R3f9FSYActwpnPdP/8N6pvsg
         PqFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=SuJvfoiC;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=SuJvfoiC;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180201143821.856464827@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 01 Feb 2018 15:34:23 +0100
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
Subject: [PATCH 2/7] objtool: Add retpoline validation
References: <20180201143421.088202488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-objtool-indirect.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210459716546798?=
X-GMAIL-MSGID: =?utf-8?q?1591210459716546798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

David requested a objtool validation pass for RETPOLINE enabled
builds, where it validates no unannotated indirect  jumps or calls are
left.

Add an additional .discard.retpoline_safe section to allow annotating
the few indirect sites that are required and safe.

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
@@ -269,6 +269,10 @@ objtool_args += --no-unreachable
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
 
@@ -1070,6 +1072,54 @@ static int read_unwind_hints(struct objt
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
@@ -1108,6 +1158,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_retpoline_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1853,6 +1907,29 @@ static int validate_unwind_hints(struct
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
@@ -2028,6 +2105,13 @@ int check(const char *_objname, bool orc
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
 	struct list_head alts;
