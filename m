Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeEKTyw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbeEKTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:53:42 -0400
Message-Id: <20180511195341.034688188@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 11 May 2018 15:49:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>, Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-rt-users@vger.kernel.org
Subject: [RFC][PATCH 07/10] tracing: Have zero size length in filter logic be full string
References: <20180511194927.190877137@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0007-tracing-Have-zero-size-length-in-filter-logic-be-ful.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As strings in trace events may not have a nul terminating character, the
filter string compares use the defined string length for the field for the
compares.

The trace_marker records data slightly different than do normal events. It's
size is zero, meaning that the string is the rest of the array, and that the
string also ends with '\0'.

If the size is zero, assume that the string is nul terminated and read the
string in question as is.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 7d306b74230f..675392b9edd2 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -750,31 +750,32 @@ static int filter_pred_none(struct filter_pred *pred, void *event)
  *
  * Note:
  * - @str might not be NULL-terminated if it's of type DYN_STRING
- *   or STATIC_STRING
+ *   or STATIC_STRING, unless @len is zero.
  */
 
 static int regex_match_full(char *str, struct regex *r, int len)
 {
-	if (strncmp(str, r->pattern, len) == 0)
-		return 1;
-	return 0;
+	/* len means str is dynamic and ends with '\0' */
+	if (!len)
+		return strcmp(str, r->pattern) == 0;
+
+	return strncmp(str, r->pattern, len) == 0;
 }
 
 static int regex_match_front(char *str, struct regex *r, int len)
 {
-	if (len < r->len)
+	if (len && len < r->len)
 		return 0;
 
-	if (strncmp(str, r->pattern, r->len) == 0)
-		return 1;
-	return 0;
+	return strncmp(str, r->pattern, len) == 0;
 }
 
 static int regex_match_middle(char *str, struct regex *r, int len)
 {
-	if (strnstr(str, r->pattern, len))
-		return 1;
-	return 0;
+	if (!len)
+		return strstr(str, r->pattern) != NULL;
+
+	return strnstr(str, r->pattern, len) != NULL;
 }
 
 static int regex_match_end(char *str, struct regex *r, int len)
-- 
2.17.0
