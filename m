Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeCIMkK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeCIMkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:40:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA91206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH -tip 9/9] tracing: kprobes: Fix to not enabling preemption
Date: Fri,  9 Mar 2018 21:39:45 +0900
Message-Id: <152059918532.4214.8326814684091028387.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152059891712.4214.9539716544254881611.stgit@devbox>
References: <152059891712.4214.9539716544254881611.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kprobes pre_handler doesn't need to recover preemption
even if it modifies regs->ip anymore, this fixes to remove
the preempt_enable_no_resched() from pre_handler.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5ce9b8cf7be3..6c894e2be8d6 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1221,12 +1221,9 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 		 * We need to check and see if we modified the pc of the
 		 * pt_regs, and if so clear the kprobe and return 1 so that we
 		 * don't do the single stepping.
-		 * The ftrace kprobe handler leaves it up to us to re-enable
-		 * preemption here before returning if we've modified the ip.
 		 */
 		if (orig_ip != instruction_pointer(regs)) {
 			reset_current_kprobe();
-			preempt_enable_no_resched();
 			return 1;
 		}
 		if (!ret)
