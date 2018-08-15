Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491B9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFA72168D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFA72168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeHOM1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:27:41 -0400
Received: from exmail.andestech.com ([59.124.169.137]:55396 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbeHOM1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:27:40 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7F9YQdn011314;
        Wed, 15 Aug 2018 17:34:26 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 15 Aug 2018
 17:35:51 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 5/6] nds32/ftrace: Support dynamic function graph tracer
Date:   Wed, 15 Aug 2018 17:35:22 +0800
Message-ID: <d4c9abe5e2ddd85448fb3662636017646b12751f.1534323834.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534323834.git.zong@andestech.com>
References: <cover.1534323834.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7F9YQdn011314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the implementation of dynamic function graph tracer.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/kernel/ftrace.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index 3ca676b..a646a83 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -74,6 +74,14 @@ void _ftrace_caller(unsigned long parent_ip)
 		"nop			\n\t"
 		"nop			\n\t");
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	/* a placeholder for the call to ftrace_graph_caller */
+	__asm__ __volatile__ (
+		"ftrace_graph_call:	\n\t"
+		"nop			\n\t"
+		"nop			\n\t"
+		"nop			\n\t");
+#endif
 	/* restore all state needed by the compiler epilogue */
 }
 
@@ -258,4 +266,32 @@ void __naked return_to_handler(void)
 		"lmw.bim $r0,[$sp],$r1,#0x0  \n\t");
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+extern unsigned long ftrace_graph_call;
+
+static int ftrace_modify_graph_caller(bool enable)
+{
+	unsigned long pc = (unsigned long)&ftrace_graph_call;
+	unsigned long nop_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
+	unsigned long call_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
+
+	ftrace_gen_call_insn(call_insn, (unsigned long)ftrace_graph_caller);
+
+	if (enable)
+		return ftrace_modify_code(pc, nop_insn, call_insn, true);
+	else
+		return ftrace_modify_code(pc, call_insn, nop_insn, true);
+}
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_graph_caller(true);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_graph_caller(false);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.7.4

