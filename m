Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x2269HAQ95osY0uzdq1RyFqkbuqqGipgIFSWRrBFJg7sOlGEA6huxUn22Kn0DXlXRAV+sR6VZ
ARC-Seal: i=1; a=rsa-sha256; t=1518439975; cv=none;
        d=google.com; s=arc-20160816;
        b=zhr2oN+lluaNchzUKqK6Q9vs7dAenOh02gN4vx4aW4No9+i6Se0tIPR67c/aAfdk3D
         6ses5defBsA0/JFdsZfWNL8g/EFk+MR4oyMo83DOnFP4AyfC1arn6XV7QrGCxfpRfIpB
         oKl9NAFlLP5gvAkSMs/By7CcPtYT99/NCHoX+79VOTv29iK6ykhI16Y+NPUT0+D+1/38
         fdGwqybCRh2MBXR+EfZ/lt+AUO7H9vd1mphQhRNR5f5rusTZsg76lS/mOtBky/OLZf4A
         J86W6hurCgDS306gSYEOvbZeeKW+XkXVJC8m+lqjqyPTsqjMJuOnm+Xh6X7S1FMgnzxD
         qlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=NTa+a6PKsFuxcFpzaD86Xa0gJ0h2GJ3/9OLLLWzj0AE=;
        b=tSuYz0jul/F47Wrp/40oKveDyWiSeNq2V1V6MrR9EcDusAMImafJQe0BZJV5AMAIxg
         u+DPjaAQUAhAM2uCnZgsT+4c1eS6X1TZ8Ag4MQSka3YyITrFEeMO1rPYGL4gDcmNFxGO
         wc+4DT/1FUt2IlVRpQFNnfHEknDsZS5V4VFNkGXuEG+IO8w+mXxmAzAA2+Kkkf3o3U/T
         KfHC7+wnK8kFct+QaESTg/JNaXyYdlyKeFZ9pCVYdfkJFNO8+/64aqkY6FIGnaqxePmQ
         rCkrgMG9mnw+DtjKDFU4fif1ssc6hdF2L3nuTkQxfcWCMd4eQVW6sWVc63f8/MIQPT0r
         OvJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=tSUx4EyT;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=tSUx4EyT;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180212125033.295653095@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 12 Feb 2018 13:48:56 +0100
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
Subject: [PATCH v2 1/8] objtool: Use existing global variables for options
References: <20180212124855.882405399@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-objtool-unclutter.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199715737846143?=
X-GMAIL-MSGID: =?utf-8?q?1592199715737846143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the existing global variables instead of passing them around and
creating duplicate global variables.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c |    2 +-
 tools/objtool/builtin-orc.c   |    6 +-----
 tools/objtool/builtin.h       |    5 +++++
 tools/objtool/check.c         |    5 ++---
 tools/objtool/check.h         |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -53,5 +53,5 @@ int cmd_check(int argc, const char **arg
 
 	objname = argv[0];
 
-	return check(objname, no_fp, no_unreachable, false);
+	return check(objname, false);
 }
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -25,7 +25,6 @@
  */
 
 #include <string.h>
-#include <subcmd/parse-options.h>
 #include "builtin.h"
 #include "check.h"
 
@@ -36,9 +35,6 @@ static const char *orc_usage[] = {
 	NULL,
 };
 
-extern const struct option check_options[];
-extern bool no_fp, no_unreachable;
-
 int cmd_orc(int argc, const char **argv)
 {
 	const char *objname;
@@ -54,7 +50,7 @@ int cmd_orc(int argc, const char **argv)
 
 		objname = argv[0];
 
-		return check(objname, no_fp, no_unreachable, true);
+		return check(objname, true);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -17,6 +17,11 @@
 #ifndef _BUILTIN_H
 #define _BUILTIN_H
 
+#include <subcmd/parse-options.h>
+
+extern const struct option check_options[];
+extern bool no_fp, no_unreachable;
+
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include "builtin.h"
 #include "check.h"
 #include "elf.h"
 #include "special.h"
@@ -33,7 +34,6 @@ struct alternative {
 };
 
 const char *objname;
-static bool no_fp;
 struct cfi_state initial_func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
@@ -1978,13 +1978,12 @@ static void cleanup(struct objtool_file
 	elf_close(file->elf);
 }
 
-int check(const char *_objname, bool _no_fp, bool no_unreachable, bool orc)
+int check(const char *_objname, bool orc)
 {
 	struct objtool_file file;
 	int ret, warnings = 0;
 
 	objname = _objname;
-	no_fp = _no_fp;
 
 	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
 	if (!file.elf)
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -62,7 +62,7 @@ struct objtool_file {
 	bool ignore_unreachables, c_file, hints;
 };
 
-int check(const char *objname, bool no_fp, bool no_unreachable, bool orc);
+int check(const char *objname, bool orc);
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
