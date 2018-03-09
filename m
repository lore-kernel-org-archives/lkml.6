Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbeCIMjl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeCIMjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:39:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE41206B2
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
Subject: [RFC PATCH -tip 8/9] error-injection: Fix to not enabling preemption in pre_handler
Date: Fri,  9 Mar 2018 21:39:16 +0900
Message-Id: <152059915597.4214.4086303893931787678.stgit@devbox>
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
 kernel/fail_function.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 21b0122cb39c..b1713521f096 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -176,7 +176,6 @@ static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 		override_function_with_return(regs);
 		/* Kprobe specific fixup */
 		reset_current_kprobe();
-		preempt_enable_no_resched();
 		return 1;
 	}
 
