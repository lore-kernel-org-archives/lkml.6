Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225O0NfcyIAnD1ZzkK0YXPPBqy9aVfoNhFUUk9qWoLE72eAa3iT12P3NUaxnFAEvn9vWyZpM
ARC-Seal: i=1; a=rsa-sha256; t=1518440010; cv=none;
        d=google.com; s=arc-20160816;
        b=a8gG7fcW5Ywo4oPEDe7QiTL31mqCM2RfR5fayuy8ylM6/225jAKG4WzmJ034M/Eutk
         qAgUFI5yDZAc2RtLuAPU6N7RR7v9HjEKQ3QMaXjLwpRVJ2MMJ1zbxOVkGiOO1BYBOJ5o
         ypzAKkGLeVklQG+YvUu4pWxC7P04qEhS8MD84a4r6op62wbCcTVK5VMYMFm8VRaNbA5W
         0pUMt5mDXH12W5Hi4rPI9Fg5EfusX8vdubYVcZZOOYIdO1n+xvbKN+k0uja+AttYFVOc
         xGB6wqtHAw5raWsCtC3V3bwE+NKe8YyNIi/PmR1k0aCb1jSmVg3n1WR6f249ScJYu2Iq
         ORkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=4sZtD0QYz3Ym4kjroDoNytM7odHz4B4gagkukcCUsWI=;
        b=eSedMz4O6HQghnPxa4ALFfgb+mXL2Te6WGhM5FV633WEWnKpu6aFbupTiuDTWaCDNl
         KDwHQ23xIZonDO0zD/lY5lKZRQHeaWmaOS1jC1eNgLx0kfmHis6ivOyUxBgj6y/DhzU1
         cpEXAXjomYopfybBJQUcEjToNgGRo8Oh/WjBzDlxdg3v5NIBsYJxJnX2viF6va3CFsDd
         ADyE5BGY73JGVt+5co3nPrDKI7EcpXAw/5emlGy4+jKmKTJWVGZLPydRs60y3iEs6EPt
         9tBQljQmfN92Z/ck5pgXPSeGni1qv+tjdecy9kE9R0cJIznMegfU/IsWBqWbwlcGkqZ0
         WSTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=kdoObB6F;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=u60tXNQb;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=kdoObB6F;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=u60tXNQb;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180212125033.397696174@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 12 Feb 2018 13:48:58 +0100
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
Subject: [PATCH v2 3/8] objtool: Add module specific retpoline rules
References: <20180212124855.882405399@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-objtool-module-rules.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199752031574952?=
X-GMAIL-MSGID: =?utf-8?q?1592199752031574952?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

David wanted to not use retpolines in .init.text but that will trip up
objtool retpoline validation, fix that.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
