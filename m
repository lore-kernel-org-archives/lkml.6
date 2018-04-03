Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeDCOgC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbeDCOfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:35:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D01A204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 3 Apr 2018 10:35:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lockdep: Add print_irqtrace_events() to __warn
Message-ID: <20180403103540.2d407eb8@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Running a test on a x86_32 kernel I triggered a bug that an interrupt
disable/enable isn't being catched by lockdep. At least knowing where the
last one was found would be helpful, but the warnings that are produced do
not show this information. Even without debugging lockdep, having the WARN()
display the last place hard and soft irqs were enabled or disabled is
valuable.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 2cfef408fec9..fa8d4cc4956a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -554,6 +554,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	else
 		dump_stack();
 
+	print_irqtrace_events(current);
+
 	print_oops_end_marker();
 
 	/* Just a warning, don't kill lockdep. */
-- 
2.13.6
