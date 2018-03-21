Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeCUCWv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbeCUCVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E31F2185E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022130.033848252@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 36/46] tracing: Use the ring-buffer nesting to allow synthetic events to be
 traced
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0036-tracing-Use-the-ring-buffer-nesting-to-allow-synthet.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Synthetic events can be done within the recording of other events. Notify
the ring buffer via ring_buffer_nest_start() and ring_buffer_nest_end() that
this is intended and not to block it due to its recursion protection.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f7d0da20c5c8..4f027642ceef 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -640,6 +640,7 @@ static notrace void trace_event_raw_event_synth(void *__data,
 	struct trace_event_file *trace_file = __data;
 	struct synth_trace_event *entry;
 	struct trace_event_buffer fbuffer;
+	struct ring_buffer *buffer;
 	struct synth_event *event;
 	unsigned int i, n_u64;
 	int fields_size = 0;
@@ -651,10 +652,17 @@ static notrace void trace_event_raw_event_synth(void *__data,
 
 	fields_size = event->n_u64 * sizeof(u64);
 
+	/*
+	 * Avoid ring buffer recursion detection, as this event
+	 * is being performed within another event.
+	 */
+	buffer = trace_file->tr->trace_buffer.buffer;
+	ring_buffer_nest_start(buffer);
+
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + fields_size);
 	if (!entry)
-		return;
+		goto out;
 
 	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
 		if (event->fields[i]->is_string) {
@@ -670,6 +678,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
 	}
 
 	trace_event_buffer_commit(&fbuffer);
+out:
+	ring_buffer_nest_end(buffer);
 }
 
 static void free_synth_event_print_fmt(struct trace_event_call *call)
-- 
2.15.1
