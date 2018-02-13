Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeBMFma (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:42:30 -0500
Received: from exmail.andestech.com ([59.124.169.137]:41160 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754159AbeBMFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:42:26 -0500
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        <patches@groups.riscv.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>
CC: Alan Kao <alankao@andestech.com>
Subject: [PATCH v4 6/6] riscv/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
Date: Tue, 13 Feb 2018 13:13:21 +0800
Message-ID: <1518498801-677-7-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518498801-677-1-git-send-email-alankao@andestech.com>
References: <1518498801-677-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w1D5GQRV046280
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In walk_stackframe, the pc now receives the address from calling
ftrace_graph_ret_addr instead of manual calculation.

Note that the original calculation,
        pc = frame->ra - 4
is buggy when the instruction at the return address happened to be a
compressed inst. But since it is not a critical part of ftrace, it is
ignored for now to ease the review process.

Cc: Greentime Hu <greentime@andestech.com>
Signed-off-by: Alan Kao <alankao@andestech.com>
---
 arch/riscv/kernel/ftrace.c     | 2 +-
 arch/riscv/kernel/stacktrace.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 48b5353691c3..1157b6b52d25 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -151,7 +151,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 		return;
 
 	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
-				       frame_pointer, NULL);
+				       frame_pointer, parent);
 	if (err == -EBUSY)
 		return;
 	*parent = return_hooker;
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 559aae781154..a4b1d94371a0 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -18,6 +18,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
+#include <linux/ftrace.h>
 
 #ifdef CONFIG_FRAME_POINTER
 
@@ -63,7 +64,12 @@ static void notrace walk_stackframe(struct task_struct *task,
 		frame = (struct stackframe *)fp - 1;
 		sp = fp;
 		fp = frame->fp;
+#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
+		pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
+					   (unsigned long *)(fp - 8));
+#else
 		pc = frame->ra - 0x4;
+#endif
 	}
 }
 
-- 
2.15.1
