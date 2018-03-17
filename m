Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuOMBtQZTj4vBliuU/2EiDQynJYoeW/OY3GR1qniQ6REoqQia9BywZXALPN7cAlVJowIzVx
ARC-Seal: i=1; a=rsa-sha256; t=1521291190; cv=none;
        d=google.com; s=arc-20160816;
        b=wDoHWtuusuQQmVzT7Wiie092PDQfSZHD9mWR9cahGDBqSs/hHb3ITQfa4JKgF5cfKb
         93sw8BeRiKqhdmP0V1p10wEhH9cFbQfvT0CAjCEdN8VLACpVAOIIl7fF0MQzV4zYpr6X
         UIaXOTwD4sB9lBIjT7E2oI0CzOjtqw80XZRoRoQazrEDRljY3cMUza/bu+8tagA4agi0
         Ti3IOyZgzNAkQuxdjll5tkxRtBUXLyY4MYo13s+tNfrBi+OQgrxdV1KkJ6QdvloEM4Pj
         +GYJ4JCaZtnjqFGUylDL6sTfP7gxMa4qc3He9w6DJej9OuyyEolHGX4G2XszKer7zcAL
         7sWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=NlsqrPBiAlyTRIOAFeI1N19TaJfZpJoRW0xpkysgTJU=;
        b=hNbHmSNHh5DZQ21KDsyxYD7rp5sesSoLK49PGaTVhfge9Yti6gl3Q99UAJoUUaE98N
         dI38GCcFtNneuphxI0mRuaTsjLbVpATEhNmb97yeGgGMR62/qbftkdwVZBe3zYa4okZR
         RRacFtPn5fY2kehugFBY/M00gMOBaeEf3dlkxbtvFCOGKsMFIXESUAyGAEbe5YvWwqUs
         IJCKCQTdSoSg0SrqZVy/R6d+C4OqyW2G6HRQsUFu7vcc2aOZRy99AiXhU/+ZMnXtIHaA
         PkwBsZqQA95/uj+pmS38pZSuGcPK3aHpDbHKk1SOglbE7hjMzN+WnQHjd6Sz+lx0wddB
         bbbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeCQMxK (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752775AbeCQMxJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:53:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095A621720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v6 20/21] [RESEND] perf-probe: Fix to convert array type collectly
Date: Sat, 17 Mar 2018 21:52:25 +0900
Message-Id: <152129114502.31874.2474068470011496356.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152129024033.31874.15800253385376959274.stgit@devbox>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595189431330587599?=
X-GMAIL-MSGID: =?utf-8?q?1595189431330587599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix to convert array element type collectly.
Current perf-probe converts the type of array-elements
incorrectly. It always converts the types as a pointer
of array. This passes the "array" type DIE to the type
converter so that it can get correct "element of array"
type DIE from it.

E.g.
  ====
  $ cat hello.c
  #include <stdio.h>

  void foo(int a[])
  {
	  printf("%d\n", a[1]);
  }

  void main()
  {
	  int a[3] = {4, 5, 6};
	  printf("%d\n", a[0]);
	  foo(a);
  }

  $ gcc -g hello.c -o hello
  $ perf probe -x ./hello -D "foo a[1]"
  ====

Without this fix, above outputs
  ====
  p:probe_hello/foo /tmp/hello:0x4d3 a=+4(-8(%bp)):u64
  ====
The "u64" means "int *", but a[1] is "int".

With this,
  ====
  p:probe_hello/foo /tmp/hello:0x4d3 a=+4(-8(%bp)):s32
  ====
So, "int" correctly converted to "s32"

Fixes: b2a3c12b7442 ("perf probe: Support tracing an entry of array")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index a5731de0e5eb..c37fbef1711d 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -423,20 +423,20 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		pr_warning("Failed to get the type of %s.\n", varname);
 		return -ENOENT;
 	}
-	pr_debug2("Var real type: (%x)\n", (unsigned)dwarf_dieoffset(&type));
+	pr_debug2("Var real type: %s (%x)\n", dwarf_diename(&type),
+		  (unsigned)dwarf_dieoffset(&type));
 	tag = dwarf_tag(&type);
 
 	if (field->name[0] == '[' &&
 	    (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)) {
-		if (field->next)
-			/* Save original type for next field */
-			memcpy(die_mem, &type, sizeof(*die_mem));
+		/* Save original type for next field or type */
+		memcpy(die_mem, &type, sizeof(*die_mem));
 		/* Get the type of this array */
 		if (die_get_real_type(&type, &type) == NULL) {
 			pr_warning("Failed to get the type of %s.\n", varname);
 			return -ENOENT;
 		}
-		pr_debug2("Array real type: (%x)\n",
+		pr_debug2("Array real type: %s (%x)\n", dwarf_diename(&type),
 			 (unsigned)dwarf_dieoffset(&type));
 		if (tag == DW_TAG_pointer_type) {
 			ref = zalloc(sizeof(struct probe_trace_arg_ref));
@@ -448,9 +448,6 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 				*ref_ptr = ref;
 		}
 		ref->offset += dwarf_bytesize(&type) * field->index;
-		if (!field->next)
-			/* Save vr_die for converting types */
-			memcpy(die_mem, vr_die, sizeof(*die_mem));
 		goto next;
 	} else if (tag == DW_TAG_pointer_type) {
 		/* Check the pointer and dereference */

