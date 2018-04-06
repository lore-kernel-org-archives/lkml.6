Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeDFNBW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752791AbeDFNBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4EF21840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130114.583922292@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [for-next][PATCH 16/18] tracing: Fixup logic inversion on setting trace_global_clock defaults
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0016-tracing-Fixup-logic-inversion-on-setting-trace_globa.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

In commit 932066a15335 ("tracing: Default to using trace_global_clock if
sched_clock is unstable"), the logic for deciding to override the
default clock if unstable was reversed from the earlier posting. I was
trying to reduce the width of the message by using an early return
rather than a if-block, but reverted back to using the if-block and
accidentally left the predicate inverted.

Link: http://lkml.kernel.org/r/20180404212450.26646-1-chris@chris-wilson.co.uk

Fixes: 932066a15335 ("tracing: Default to using trace_global_clock if sched_clock is unstable")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0f47e653ffd8..e18e69183c9a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8602,7 +8602,7 @@ late_initcall_sync(clear_boot_tracer);
 __init static int tracing_set_default_clock(void)
 {
 	/* sched_clock_stable() is determined in late_initcall */
-	if (trace_boot_clock || sched_clock_stable()) {
+	if (!trace_boot_clock && !sched_clock_stable()) {
 		printk(KERN_WARNING
 		       "Unstable clock detected, switching default tracing clock to \"global\"\n"
 		       "If you want to keep using the local clock, then add:\n"
-- 
2.15.1
