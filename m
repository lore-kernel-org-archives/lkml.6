Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeCUCXn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752025AbeCUCVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DD22185D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022131.031659836@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 40/46] tracing: Use trace_seq instead of open code string appending
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0040-tracing-Use-trace_seq-instead-of-open-code-string-ap.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The filter code does open code string appending to produce an error message.
Instead it can be simplified by using trace_seq function helpers.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 57 +++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 819a13c3e13c..f42442cd423a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -675,47 +675,36 @@ static int replace_filter_string(struct event_filter *filter,
 	return 0;
 }
 
-static int append_filter_string(struct event_filter *filter,
-				char *string)
-{
-	int newlen;
-	char *new_filter_string;
-
-	if (WARN_ON(!filter->filter_string))
-		return -EINVAL;
-	newlen = strlen(filter->filter_string) + strlen(string) + 1;
-	new_filter_string = kmalloc(newlen, GFP_KERNEL);
-	if (!new_filter_string)
-		return -ENOMEM;
-
-	strcpy(new_filter_string, filter->filter_string);
-	strcat(new_filter_string, string);
-	kfree(filter->filter_string);
-	filter->filter_string = new_filter_string;
-
-	return 0;
-}
-
 static void append_filter_err(struct filter_parse_state *ps,
 			      struct event_filter *filter)
 {
+	struct trace_seq *s;
 	int pos = ps->lasterr_pos;
-	char *buf, *pbuf;
+	char *buf;
+	int len;
 
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
+	if (WARN_ON(!filter->filter_string))
 		return;
 
-	append_filter_string(filter, "\n");
-	memset(buf, ' ', PAGE_SIZE);
-	if (pos > PAGE_SIZE - 128)
-		pos = 0;
-	buf[pos] = '^';
-	pbuf = &buf[pos] + 1;
-
-	sprintf(pbuf, "\nparse_error: %s\n", err_text[ps->lasterr]);
-	append_filter_string(filter, buf);
-	free_page((unsigned long) buf);
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return;
+	trace_seq_init(s);
+
+	len = strlen(filter->filter_string);
+	if (pos > len)
+		len = pos;
+
+	trace_seq_puts(s, filter->filter_string);
+	trace_seq_printf(s, "\n%*s", pos, "^");
+	trace_seq_printf(s, "\nparse_error: %s\n", err_text[ps->lasterr]);
+	trace_seq_putc(s, 0);
+	buf = kmemdup_nul(s->buffer, s->seq.len, GFP_KERNEL);
+	if (buf) {
+		kfree(filter->filter_string);
+		filter->filter_string = buf;
+	}
+	kfree(s);
 }
 
 static inline struct event_filter *event_filter(struct trace_event_file *file)
-- 
2.15.1
