Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeBMFmY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:42:24 -0500
Received: from exmail.andestech.com ([59.124.169.137]:6480 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeBMFmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:42:20 -0500
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        <patches@groups.riscv.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>
CC: Alan Kao <alankao@andestech.com>
Subject: [PATCH v4 3/6] riscv/ftrace: Add dynamic function graph tracer support
Date: Tue, 13 Feb 2018 13:13:18 +0800
Message-ID: <1518498801-677-4-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518498801-677-1-git-send-email-alankao@andestech.com>
References: <1518498801-677-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w1D5GBbW046236
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the function_graph tracer is enabled, a filtered function has the
following call sequence:

* ftracer_caller         ==> on/off by ftrace_make_call/ftrace_make_nop
* ftrace_graph_caller
* ftrace_graph_call      ==> on/off by ftrace_en/disable_ftrace_graph_caller
* prepare_ftrace_return

Considering the following DYNAMIC_FTRACE_WITH_REGS feature, it would be
more extendable to have a ftrace_graph_caller function, instead of
calling prepare_ftrace_return directly in ftrace_caller.

Cc: Greentime Hu <greentime@andestech.com>
Signed-off-by: Alan Kao <alankao@andestech.com>
---
 arch/riscv/kernel/ftrace.c     | 55 +++++++++++++++++++++++++++++++++++-
 arch/riscv/kernel/mcount-dyn.S | 64 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index be4b24332d97..5bbe1afd9463 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -139,4 +139,57 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 		return;
 	*parent = return_hooker;
 }
-#endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+extern void ftrace_graph_call(void);
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	unsigned int call[2];
+	static int init_graph = 1;
+	int ret;
+
+	make_call(&ftrace_graph_call, &ftrace_stub, call);
+
+	/*
+	 * When enabling graph tracer for the first time, ftrace_graph_call
+	 * should contains a call to ftrace_stub.  Once it has been disabled,
+	 * the 8-bytes at the position becomes NOPs.
+	 */
+	if (init_graph) {
+		ret = ftrace_check_current_call((unsigned long)&ftrace_graph_call,
+						call);
+		init_graph = 0;
+	} else {
+		ret = ftrace_check_current_call((unsigned long)&ftrace_graph_call,
+						NULL);
+	}
+
+	if (ret)
+		return ret;
+
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
+				    (unsigned long)&prepare_ftrace_return, true);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	unsigned int call[2];
+	int ret;
+
+	make_call(&ftrace_graph_call, &prepare_ftrace_return, call);
+
+	/*
+	 * This is to make sure that ftrace_enable_ftrace_graph_caller
+	 * did the right thing.
+	 */
+	ret = ftrace_check_current_call((unsigned long)&ftrace_graph_call,
+					call);
+
+	if (ret)
+		return ret;
+
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
+				    (unsigned long)&prepare_ftrace_return, false);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index a3ebeadbe698..739e07a6fd85 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -14,18 +14,62 @@
 	.text
 
 	.macro SAVE_ABI_STATE
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	addi    sp, sp, -48
+	sd      s0, 32(sp)
+	sd      ra, 40(sp)
+	addi    s0, sp, 48
+	sd      t0, 24(sp)
+	sd      t1, 16(sp)
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	sd      t2, 8(sp)
+#endif
+#else
 	addi	sp, sp, -16
 	sd	s0, 0(sp)
 	sd	ra, 8(sp)
 	addi	s0, sp, 16
+#endif
 	.endm
 
 	.macro RESTORE_ABI_STATE
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	ld	s0, 32(sp)
+	ld	ra, 40(sp)
+	addi	sp, sp, 48
+#else
 	ld	ra, 8(sp)
 	ld	s0, 0(sp)
 	addi	sp, sp, 16
+#endif
 	.endm
 
+	.macro RESTORE_GRAPH_ARGS
+	ld	a0, 24(sp)
+	ld	a1, 16(sp)
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	ld	a2, 8(sp)
+#endif
+	.endm
+
+ENTRY(ftrace_graph_caller)
+	addi	sp, sp, -16
+	sd	s0, 0(sp)
+	sd	ra, 8(sp)
+	addi	s0, sp, 16
+ftrace_graph_call:
+	.global ftrace_graph_call
+	/*
+	 * Calling ftrace_enable/disable_ftrace_graph_caller would overwrite the
+	 * call below.  Check ftrace_modify_all_code for details.
+	 */
+	call	ftrace_stub
+	ld	ra, 8(sp)
+	ld	s0, 0(sp)
+	addi	sp, sp, 16
+	ret
+ENDPROC(ftrace_graph_caller)
+
 ENTRY(ftrace_caller)
 	/*
 	 * a0: the address in the caller when calling ftrace_caller
@@ -33,6 +77,20 @@ ENTRY(ftrace_caller)
 	 */
 	ld	a1, -8(s0)
 	addi	a0, ra, -MCOUNT_INSN_SIZE
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	/*
+	 * the graph tracer (specifically, prepare_ftrace_return) needs these
+	 * arguments but for now the function tracer occupies the regs, so we
+	 * save them in temporary regs to recover later.
+	 */
+	addi	t0, s0, -8
+	mv	t1, a0
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	ld	t2, -16(s0)
+#endif
+#endif
+
 	SAVE_ABI_STATE
 ftrace_call:
 	.global ftrace_call
@@ -45,6 +103,12 @@ ftrace_call:
 	 * Check ftrace_modify_all_code for details.
 	 */
 	call	ftrace_stub
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	RESTORE_GRAPH_ARGS
+	call	ftrace_graph_caller
+#endif
+
 	RESTORE_ABI_STATE
 	ret
 ENDPROC(ftrace_caller)
-- 
2.15.1
