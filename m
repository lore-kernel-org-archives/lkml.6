Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeDFNCa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752753AbeDFNBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961812183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130113.532283895@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 12/18] lockdep: Add print_irqtrace_events() to __warn
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0012-lockdep-Add-print_irqtrace_events-to-__warn.patch
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
2.15.1
