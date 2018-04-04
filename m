Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDDVZH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:25:07 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52267 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752492AbeDDVZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:25:06 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
From: Chris Wilson <chris@chris-wilson.co.uk>
To: linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] trace: Fixup logic inversion on setting trace_global_clock defaults
Date: Wed,  4 Apr 2018 22:24:50 +0100
Message-Id: <20180404212450.26646-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <7D320425-063C-4C54-BAD2-8843ADCD8D6A@goodmis.org>
References: <7D320425-063C-4C54-BAD2-8843ADCD8D6A@goodmis.org>
X-Originating-IP: 78.156.65.138
X-Country: code=GB country="United Kingdom" ip=78.156.65.138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 932066a15335 ("tracing: Default to using trace_global_clock if
sched_clock is unstable"), the logic for deciding to override the
default clock if unstable was reversed from the earlier posting. I was
trying to reduce the width of the message by using an early return
rather than a if-block, but reverted back to using the if-block and
accidentally left the predicate inverted.

Fixes: 932066a15335 ("tracing: Default to using trace_global_clock if sched_clock is unstable")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.16.3
