Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeCTGgl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:36:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56397 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeCTGgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:36:37 -0400
Date: Mon, 19 Mar 2018 23:36:17 -0700
From: tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-d0461794a1dcaf552b507e23788777f718b736a1@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        acme@redhat.com, mingo@kernel.org, mhiramat@kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, tom.zanussi@linux.intel.com,
        hpa@zytor.com, tglx@linutronix.de, namhyung@kernel.org
Reply-To: ravi.bangoria@linux.vnet.ibm.com, hpa@zytor.com,
        tom.zanussi@linux.intel.com, tglx@linutronix.de, namhyung@kernel.org,
        rostedt@goodmis.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, mingo@kernel.org, mhiramat@kernel.org
In-Reply-To: <152129114502.31874.2474068470011496356.stgit@devbox>
References: <152129114502.31874.2474068470011496356.stgit@devbox>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf probe: Use right type to access array elements
Git-Commit-ID: d0461794a1dcaf552b507e23788777f718b736a1
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

Commit-ID:  d0461794a1dcaf552b507e23788777f718b736a1
Gitweb:     https://git.kernel.org/tip/d0461794a1dcaf552b507e23788777f718b736a1
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Sat, 17 Mar 2018 21:52:25 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Mar 2018 13:51:53 -0300

perf probe: Use right type to access array elements

Current 'perf probe' converts the type of array-elements incorrectly. It
always converts the types as a pointer of array. This passes the "array"
type DIE to the type converter so that it can get correct "element of
array" type DIE from it.

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-trace-users@vger.kernel.org
Fixes: b2a3c12b7442 ("perf probe: Support tracing an entry of array")
Link: http://lkml.kernel.org/r/152129114502.31874.2474068470011496356.stgit@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 13 +++++--------
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
