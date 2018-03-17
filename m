Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELueqFSdz1q5yWOWs6ZellU9gsTzoIX2+YQRGdGwcz0wepE05zFSSlbCReMCS2EwoLfsbwjV
ARC-Seal: i=1; a=rsa-sha256; t=1521291233; cv=none;
        d=google.com; s=arc-20160816;
        b=MYVRX1yQevF8rEgq/OePHHB+8OAV4cTCBodMEH8Qk8xqpSJN0BkPiOyuqByDLlyXwH
         rlU0CfkB2ORDnPl9aiwdDvMylgIc/btSfXETd4aeDbLkImG9n1qRU2Vo670FJMd7Lzri
         vk8uIU2oRCZ6EinCO/QEYXe5FTFtojDTAZsS0S7CT2T0DKXRsIVY/Up+1DsxswEG+LtR
         9TYrTLjlfwayq7A5kNq49Yd1CLcSFsyo7sE+aufOO9MGAE5U3ihrOl79lgRGX3GqaP/e
         pjlB4DBfZMkDe/+niBdcEM+ioOqkd/zPY1VYRBbj0VqoaDKtmoWwC7zQiSZZvz3V0m7v
         Xmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=vVUYOow+wFI3wvjMQORh6vhlVuOvYD0d/lf9L4usQIc=;
        b=C3JYVxYFEAqOUKttQMGb6c2aZoulFjR2pBEgLZsHHRi+l9nC4u9fFMteipvItmIdzu
         c9TZr4x/vANoM0tZqgOU8TbvoNCk4RQeYh6YtS6sVgYNDXGtZuk81KKCws0m1G/QwpzH
         PI4zy5V9yIQ2rDTWy2Ep5puHubpwrfvnqKxs/am5eAWaI4RpM65us1h3oJcxVndVxp8s
         f3EMNvDQnQDRaFfhB23scfr+Ds+goxUcCpPIfx1homITqABoc6OQPEnM8nJe/XZU/sw6
         mRfex8tV8OkNK0kltiVF+yYjRfmvcPw/ItIY4snfktv3N43c/CiCRQub4OFMuCr11m4O
         XDZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeCQMxx (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752775AbeCQMxw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:53:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AC121737
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
Subject: [PATCH v6 21/21] perf-probe: Add array argument support
Date: Sat, 17 Mar 2018 21:53:10 +0900
Message-Id: <152129118998.31874.16273532808298489908.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1595189477266437642?=
X-GMAIL-MSGID: =?utf-8?q?1595189477266437642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since kprobes events support an array argument, perf-probe
can also support dumping array now.
The syntax are

 <array-var>[<range>]
or
 <pointer-var>[<range>]

where the <range> is <start>..<end>. e.g. array[0..5].
This can also be available with string type. In this
case, the string array should be "char *array[]" or
"char **array_ptr".

Note that this feature is only available on the kernel which
supports array type.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/Documentation/perf-probe.txt |    2 -
 tools/perf/util/probe-event.c           |   20 ++++++-
 tools/perf/util/probe-event.h           |    2 +
 tools/perf/util/probe-file.c            |    5 ++
 tools/perf/util/probe-file.h            |    1 
 tools/perf/util/probe-finder.c          |   95 ++++++++++++++++++-------------
 6 files changed, 84 insertions(+), 41 deletions(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index b6866a05edd2..a68e423cac48 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -196,7 +196,7 @@ Each probe argument follows below syntax.
 
  [NAME=]LOCALVAR|$retval|%REG|@SYMBOL[:TYPE]
 
-'NAME' specifies the name of this argument (optional). You can use the name of local variable, local data structure member (e.g. var->field, var.field2), local array with fixed index (e.g. array[1], var->array[0], var->pointer[2]), or kprobe-tracer argument format (e.g. $retval, %ax, etc). Note that the name of this argument will be set as the last member name if you specify a local data structure member (e.g. field2 for 'var->field1.field2'.)
+'NAME' specifies the name of this argument (optional). You can use the name of local variable, local data structure member (e.g. var->field, var.field2), local array with fixed index (e.g. array[1], var->array[0], var->pointer[2]) or range (e.g. array[1..4], var->array[0..2]), or kprobe-tracer argument format (e.g. $retval, %ax, etc). Note that the name of this argument will be set as the last member name if you specify a local data structure member (e.g. field2 for 'var->field1.field2'.)
 '$vars' and '$params' special arguments are also available for NAME, '$vars' is expanded to the local variables (including function parameters) which can access at given probe point. '$params' is expanded to only the function parameters.
 'TYPE' casts the type of this argument (optional). If omitted, perf probe automatically set the type based on debuginfo (*). Currently, basic types (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal integers (x/x8/x16/x32/x64), signedness casting (u/s), "string" and bitfield are supported. (see TYPES for detail)
 On x86 systems %REG is always the short form of the register: for example %AX. %RAX or %EAX is not valid.
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e1dbc9821617..e07a1957c9cd 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1570,6 +1570,7 @@ static int parse_perf_probe_arg(char *str, struct perf_probe_arg *arg)
 {
 	char *tmp, *goodname;
 	struct perf_probe_arg_field **fieldp;
+	long end;
 
 	pr_debug("parsing arg: %s into ", str);
 
@@ -1617,7 +1618,18 @@ static int parse_perf_probe_arg(char *str, struct perf_probe_arg *arg)
 			str = tmp;
 			(*fieldp)->index = strtol(str + 1, &tmp, 0);
 			(*fieldp)->ref = true;
-			if (*tmp != ']' || tmp == str + 1) {
+			if (tmp[0] == '.' && tmp[1] == '.') { /* dump array */
+				end = strtol(tmp + 2, &tmp, 0);
+				if (end < (*fieldp)->index || *tmp != ']') {
+					semantic_error("Invalid array range\n");
+					return -EINVAL;
+				}
+				arg->length = end - (*fieldp)->index + 1;
+				if (tmp[1] != '\0') {
+					semantic_error("Array range must not follow anything.");
+					return -EINVAL;
+				}
+			} else if (*tmp != ']' || tmp == str + 1) {
 				semantic_error("Array index must be a"
 						" number.\n");
 				return -EINVAL;
@@ -2022,6 +2034,12 @@ static int synthesize_probe_trace_arg(struct probe_trace_arg *arg,
 	if (!err && arg->type)
 		err = strbuf_addf(buf, ":%s", arg->type);
 
+	if (!err && arg->length) {
+		if (!arg->type)
+			return -EINVAL;
+		err = strbuf_addf(buf, "[%d]", arg->length);
+	}
+
 	return err;
 }
 
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 45b14f020558..e5ca1bf33ee7 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -42,6 +42,7 @@ struct probe_trace_arg {
 	char				*name;	/* Argument name */
 	char				*value;	/* Base value */
 	char				*type;	/* Type name */
+	unsigned int			length;	/* Length of array */
 	struct probe_trace_arg_ref	*ref;	/* Referencing offset */
 };
 
@@ -79,6 +80,7 @@ struct perf_probe_arg {
 	char				*name;	/* Argument name */
 	char				*var;	/* Variable name */
 	char				*type;	/* Type name */
+	unsigned int			length;	/* Length of array */
 	struct perf_probe_arg_field	*field;	/* Structure fields */
 };
 
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 4ae1123c6794..a879fe8eede3 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -999,6 +999,7 @@ int probe_cache__show_all_caches(struct strfilter *filter)
 enum ftrace_readme {
 	FTRACE_README_PROBE_TYPE_X = 0,
 	FTRACE_README_KRETPROBE_OFFSET,
+	FTRACE_README_ARRAY_TYPE,
 	FTRACE_README_END,
 };
 
@@ -1010,6 +1011,8 @@ static struct {
 	[idx] = {.pattern = pat, .avail = false}
 	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
 	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
+	DEFINE_TYPE(FTRACE_README_ARRAY_TYPE,
+		    "*<type>\\\\\\[<array-size>\\\\\\]*"),
 };
 
 static bool scan_ftrace_readme(enum ftrace_readme type)
@@ -1057,6 +1060,8 @@ bool probe_type_is_available(enum probe_type type)
 		return false;
 	else if (type == PROBE_TYPE_X)
 		return scan_ftrace_readme(FTRACE_README_PROBE_TYPE_X);
+	else if (type == PROBE_TYPE_ARRAY)
+		return scan_ftrace_readme(FTRACE_README_ARRAY_TYPE);
 
 	return true;
 }
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index 63f29b1d22c1..654290b2fd9c 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -27,6 +27,7 @@ enum probe_type {
 	PROBE_TYPE_X,
 	PROBE_TYPE_STRING,
 	PROBE_TYPE_BITFIELD,
+	PROBE_TYPE_ARRAY,
 	PROBE_TYPE_END,
 };
 
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c37fbef1711d..a1df7926edfc 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -290,13 +290,52 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	return ret2;
 }
 
+static int convert_variable_string_type(Dwarf_Die *vr_die, Dwarf_Die *type,
+					struct probe_trace_arg *tvar)
+{
+	struct probe_trace_arg_ref **ref_ptr = &tvar->ref;
+	int ret;
+
+	ret = dwarf_tag(type);
+	if (ret != DW_TAG_pointer_type && ret != DW_TAG_array_type) {
+		pr_warning("Failed to cast into string: "
+			   "%s(%s) is not a pointer nor array.\n",
+			   dwarf_diename(vr_die), dwarf_diename(type));
+		return -EINVAL;
+	}
+	if (ret == DW_TAG_pointer_type && tvar->length == 0) {
+		while (*ref_ptr)
+			ref_ptr = &(*ref_ptr)->next;
+		/* Add new reference with offset +0 */
+		*ref_ptr = zalloc(sizeof(struct probe_trace_arg_ref));
+		if (*ref_ptr == NULL) {
+			pr_warning("Out of memory error\n");
+			return -ENOMEM;
+		}
+	}
+	if (die_get_real_type(type, type) == NULL) {
+		pr_warning("Failed to get a type"
+			   " information.\n");
+		return -ENOENT;
+	}
+	if (!die_compare_name(type, "char") &&
+	    !die_compare_name(type, "unsigned char")) {
+		pr_warning("Failed to cast into string: "
+			   "%s is not (unsigned) char *.\n",
+			   dwarf_diename(vr_die));
+		return -EINVAL;
+	}
+	tvar->type = strdup("string");
+	return (tvar->type == NULL) ? -ENOMEM : 0;
+}
+
 #define BYTES_TO_BITS(nb)	((nb) * BITS_PER_LONG / sizeof(long))
 
 static int convert_variable_type(Dwarf_Die *vr_die,
 				 struct probe_trace_arg *tvar,
-				 const char *cast)
+				 struct perf_probe_arg *pvar)
 {
-	struct probe_trace_arg_ref **ref_ptr = &tvar->ref;
+	const char *cast = pvar->type;
 	Dwarf_Die type;
 	char buf[16];
 	char sbuf[STRERR_BUFSIZE];
@@ -304,6 +343,12 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	int ret;
 	char prefix;
 
+	tvar->length = pvar->length;
+	if (tvar->length && !probe_type_is_available(PROBE_TYPE_ARRAY)) {
+		pr_warning("This kerneld doesn't support array type.\n");
+		return -ENOTSUP;
+	}
+
 	/* TODO: check all types */
 	if (cast && strcmp(cast, "string") != 0 && strcmp(cast, "x") != 0 &&
 	    strcmp(cast, "s") != 0 && strcmp(cast, "u") != 0) {
@@ -334,40 +379,8 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	pr_debug("%s type is %s.\n",
 		 dwarf_diename(vr_die), dwarf_diename(&type));
 
-	if (cast && strcmp(cast, "string") == 0) {	/* String type */
-		ret = dwarf_tag(&type);
-		if (ret != DW_TAG_pointer_type &&
-		    ret != DW_TAG_array_type) {
-			pr_warning("Failed to cast into string: "
-				   "%s(%s) is not a pointer nor array.\n",
-				   dwarf_diename(vr_die), dwarf_diename(&type));
-			return -EINVAL;
-		}
-		if (die_get_real_type(&type, &type) == NULL) {
-			pr_warning("Failed to get a type"
-				   " information.\n");
-			return -ENOENT;
-		}
-		if (ret == DW_TAG_pointer_type) {
-			while (*ref_ptr)
-				ref_ptr = &(*ref_ptr)->next;
-			/* Add new reference with offset +0 */
-			*ref_ptr = zalloc(sizeof(struct probe_trace_arg_ref));
-			if (*ref_ptr == NULL) {
-				pr_warning("Out of memory error\n");
-				return -ENOMEM;
-			}
-		}
-		if (!die_compare_name(&type, "char") &&
-		    !die_compare_name(&type, "unsigned char")) {
-			pr_warning("Failed to cast into string: "
-				   "%s is not (unsigned) char *.\n",
-				   dwarf_diename(vr_die));
-			return -EINVAL;
-		}
-		tvar->type = strdup(cast);
-		return (tvar->type == NULL) ? -ENOMEM : 0;
-	}
+	if (cast && strcmp(cast, "string") == 0)	/* String type */
+		return convert_variable_string_type(vr_die, &type, tvar);
 
 	if (cast && (strcmp(cast, "u") == 0))
 		prefix = 'u';
@@ -381,9 +394,13 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 			 probe_type_is_available(PROBE_TYPE_X) ? 'x' : 'u';
 
 	ret = dwarf_bytesize(&type);
-	if (ret <= 0)
-		/* No size ... try to use default type */
+	if (ret <= 0) { /* No size ... try to use default type */
+		if (tvar->length) {	/* But array can not be dumped */
+			pr_warning("Failed to convert array with unsupported type\n");
+			return -EINVAL;
+		}
 		return 0;
+	}
 	ret = BYTES_TO_BITS(ret);
 
 	/* Check the bitwidth */
@@ -559,7 +576,7 @@ static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 		vr_die = &die_mem;
 	}
 	if (ret == 0)
-		ret = convert_variable_type(vr_die, pf->tvar, pf->pvar->type);
+		ret = convert_variable_type(vr_die, pf->tvar, pf->pvar);
 	/* *expr will be cached in libdw. Don't free it. */
 	return ret;
 }

