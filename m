Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227cVHBRBYApy3PySi+pi1986LSPUZWWUecJnpup9Us2uwzTA9rdKn0elgCwDhUh2ixHlSVf
ARC-Seal: i=1; a=rsa-sha256; t=1517496543; cv=none;
        d=google.com; s=arc-20160816;
        b=oIuzdtxY51JbEizjJI1ouMNJXSSm20Ld7K6NPw0LEl+ol9Md/sA4nEtYppUgP47ucx
         PN7NRIdqjtBhDT7IMBrvPh5LIm3RPjysEXVD0pYWo9JIBMPGLBrakMqhyVHML0amKC87
         OTDBUAEj1iu7VGK5qSweFdwuOGAb4jdLOTKcFrqrDDAkBR7WmY4oPaRMCLB0UVndLmKd
         I8qwLDgy/aIIgGFuZqpvFDb8+P8qgZIPzAcLjkKYtvXbBRTv0m7MQ1Oytl7HCfRqN9uG
         TudJWm6c9liH1J0ZyRAKawhroDPHS47iLOS/Kvvucu6kOsc+F6l4Wz/BE8Zx6NofR9uK
         EzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=AIBWkI4LdpU7mTzjnYWYXaOmS33+h62F+RkOERNcBj4=;
        b=JxqfZU0nNrsAfd4rr6lTsulH9hbMRm39it1wsV2xAzS/4Jomgb7G9i5UwbCXql3+dK
         riyxO5LSh7Lsfs651zl050h/rh0nuQLxc46SkBFlMAxWgWpbwH9X6IId8JotD7LocFJF
         yknHfMYzOu33IRTG97zBijJ3GiQo7+UVCj8zAr/wHJtMS+CPGG8KFPmwcEj91uw/L66I
         SofeC231kQUuH4NznCZ5XS+m7QO/FU3VwEybsugCN8PjKw5kVf6xOOKeikc/OObEllqV
         yLoW/y5QhQ5aWK4LZbReXjBBMMKllJK5+UkOCwNGG6Vs/0qRQqcQ16qS6XOJKuOgDwfb
         oRjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=BH3ilVhX;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=BH3ilVhX;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180201143821.907988792@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 01 Feb 2018 15:34:24 +0100
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
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/7] objtool: Add module specific retpoline rules
References: <20180201143421.088202488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-objtool-module-rules.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210455032946473?=
X-GMAIL-MSGID: =?utf-8?q?1591210455032946473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

David wanted to not use retpolines in .init.text but that will trip up
objtool retpoline validation, fix that.

Requested-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/Makefile.build        |    2 ++
 tools/objtool/builtin-check.c |    3 ++-
 tools/objtool/builtin.h       |    2 +-
 tools/objtool/check.c         |    9 +++++++++
 4 files changed, 14 insertions(+), 2 deletions(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -256,6 +256,8 @@ __objtool_obj := $(objtree)/tools/objtoo
 
 objtool_args = $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
 
+objtool_args += $(if $(part-of-module), --module,)
+
 ifndef CONFIG_FRAME_POINTER
 objtool_args += --no-fp
 endif
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline;
+bool no_fp, no_unreachable, retpoline, module;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -40,6 +40,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
+	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
 	OPT_END(),
 };
 
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -20,7 +20,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline;
+extern bool no_fp, no_unreachable, retpoline, module;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1920,6 +1920,15 @@ static int validate_retpoline(struct obj
 		if (insn->retpoline_safe)
 			continue;
 
+		/*
+		 * .init.text code is ran before userspace and thus doesn't
+		 * strictly need retpolines, except for modules which are
+		 * loaded late, they very much do need retpoline in their
+		 * .init.text
+		 */
+		if (!strcmp(insn->sec->name, ".init.text") && !module)
+			continue;
+
 		WARN_FUNC("indirect %s found in RETPOLINE build",
 			  insn->sec, insn->offset,
 			  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
