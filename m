Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeEBUCC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbeEBUAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:00:43 -0400
Message-Id: <20180502200041.670656386@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 02 May 2018 16:00:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 3/7] tracing: initcall: Ordered comparison of function pointers
References: <20180502200003.592877274@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-tracing-initcall-Ordered-comparison-of-function-poin.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rishabh Bhatnagar <rishabhb@codeaurora.org>

Using initcall_t in the __field macro generates the following warning
with clang version 6.0:

include/trace/events/initcall.h:34:3: warning: ordered comparison of
function pointers ('initcall_t' (aka 'int (*)(void)') and 'initcall_t')

__field macro expands to __field_ext macro which does is_signed_type
check on the type argument. Since initcall_t is defined as a function
pointer, using it as the type in the __field macro, leads to an ordered
comparison of function pointer warning, inside the check. Using
__field_struct macro avoids the issue.

Link: http://lkml.kernel.org/r/1524699755-29388-1-git-send-email-rishabhb@codeaurora.org

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
[ Added comment to why we are using field_struct() ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/initcall.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/initcall.h b/include/trace/events/initcall.h
index 8d6cf10d27c9..eb903c3f195f 100644
--- a/include/trace/events/initcall.h
+++ b/include/trace/events/initcall.h
@@ -31,7 +31,11 @@ TRACE_EVENT(initcall_start,
 	TP_ARGS(func),
 
 	TP_STRUCT__entry(
-		__field(initcall_t, func)
+		/*
+		 * Use field_struct to avoid is_signed_type()
+		 * comparison of a function pointer
+		 */
+		__field_struct(initcall_t, func)
 	),
 
 	TP_fast_assign(
@@ -48,8 +52,12 @@ TRACE_EVENT(initcall_finish,
 	TP_ARGS(func, ret),
 
 	TP_STRUCT__entry(
-		__field(initcall_t,	func)
-		__field(int,		ret)
+		/*
+		 * Use field_struct to avoid is_signed_type()
+		 * comparison of a function pointer
+		 */
+		__field_struct(initcall_t,	func)
+		__field(int,			ret)
 	),
 
 	TP_fast_assign(
-- 
2.17.0
