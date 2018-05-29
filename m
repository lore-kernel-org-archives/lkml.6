Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964915AbeE2P1N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934963AbeE2PXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:30 -0400
Message-Id: <20180529152327.390448532@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [for-next][PATCH 10/19] tracing: Prevent further users of zero size static arrays in trace
 events
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0010-tracing-Prevent-further-users-of-zero-size-static-ar.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

A zero size static array has special meaning in the ftrace infrastructure.
Trace events are for recording data in the trace buffers that is normally
difficult to obtain via probes or function tracing. There is no reason for
any trace event to declare a zero size static array.

If one does, BUILD_BUG_ON() will trigger and prevent the kernel from
compiling.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index bfda803b0a09..4ecdfe2e3580 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -422,6 +422,7 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 	do {								\
 		char *type_str = #type"["__stringify(len)"]";		\
 		BUILD_BUG_ON(len > MAX_FILTER_STR_VAL);			\
+		BUILD_BUG_ON(len <= 0);					\
 		ret = trace_define_field(event_call, type_str, #item,	\
 				 offsetof(typeof(field), item),		\
 				 sizeof(field.item),			\
-- 
2.17.0
