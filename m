Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvhk3a4u8GKLefvOk3vol5xJPTdgPAY9Kd9971KGUid1mmNwjjMyE1pyS41GHbNSPoqucwr
ARC-Seal: i=1; a=rsa-sha256; t=1521486200; cv=none;
        d=google.com; s=arc-20160816;
        b=x6RZ9+A/PfKXgWfb0eJogeOXuYstTZbG5NQBeGPXKktUips2x5WignB1VqA0nNbSsI
         85tVxmp8hg7H3M6vkVezOaXxmQQlWIKxbPC06xze8wKFB8t2whoovc/+STdwhWnPBkh9
         HeLjo29heVszTxVD2HX21ldjLc/VQAVf1BkAigdCgLSuiyoUog3x0d1yO9vEvLpjeUcO
         EomhL5XD7nja4NFTf+L7iRcM01JeMNyCA+d48ZHLhxNMtkeVahjfvbv9uDFO1zCeVyhv
         i5vIgspP4ynBpXd8ykSdKE7u/VkfoOOyvWTHS2siF0qcVgupCNtfB8pmJnCDbcgBO2O6
         yjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Uy7RalgXfEQ7otTEqf2fKfsuVbqGZsUNmxogIHNRa+I=;
        b=0SP3IHYVO5A9VK74qveLnVR6fmruXJZ9Q/vhoZLpYbChNHgtRgyajdHTEIuMJe6ODX
         nJ+Q0WHAB7hOgSlegq1gzMhc6Yu3nOYBXVeKnm5aKjnypk8/GFhS9zgXWjpOscWkI5xd
         vP/knClqj/698rW36B/qjbnT7i2hWInXdj9eG8nmF3M7CIk3ymErzffi0AQGswh7xoBu
         29QVxpQtU9A6o0cCAt672pZmmJNu3Rmw1DaVMSJTdb+wtVhqncu4BRd2r/3c/Ferzc2Q
         +CMW1YWSj9oNEeAuyJvyYAeq3B4hE9u9JanIoezP6xxRlGiLiMAA+iq71LINy3bq7DGs
         a2Kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968451AbeCSTDT (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 19 Mar 2018 15:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970805AbeCSTCX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Mar 2018 15:02:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF63217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/14] perf probe: Use right type to access array elements
Date: Mon, 19 Mar 2018 16:01:34 -0300
Message-Id: <20180319190136.7441-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595393913613486395?=
X-GMAIL-MSGID: =?utf-8?q?1595393913613486395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masami Hiramatsu <mhiramat@kernel.org>

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
-- 
2.14.3

