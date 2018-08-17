Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A8B218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A8B218A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeHQPsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeHQPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:48:11 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A88B2191D;
        Fri, 17 Aug 2018 12:44:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fqe7Y-0004sp-AI; Fri, 17 Aug 2018 08:44:52 -0400
Message-Id: <20180817124452.214949179@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Aug 2018 08:44:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [for-next][PATCH 3/8] tracing: Add -mcount-nop option support
References: <20180817124418.038744612@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

-mcount-nop gcc option generates the calls to the profiling functions
as nops which allows to avoid patching mcount jump with NOP instructions
initially.

-mcount-nop gcc option will be activated if platform selects
HAVE_NOP_MCOUNT and gcc actually supports it.
In addition to that CC_USING_NOP_MCOUNT is defined and could be used by
architectures to adapt ftrace patching behavior.

Link: http://lkml.kernel.org/r/patch-3.thread-aa7b8d.git-e02ed2dc082b.your-ad-here.call-01533557518-ext-9465@work.hours

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Makefile              | 6 ++++++
 kernel/trace/Kconfig  | 5 +++++
 kernel/trace/ftrace.c | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 2c92ebf59a34..c5b0cd7f3c2a 100644
--- a/Makefile
+++ b/Makefile
@@ -749,6 +749,12 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
     CC_FLAGS_FTRACE	+= -mrecord-mcount
     export CC_USING_RECORD_MCOUNT := 1
   endif
+  ifdef CONFIG_HAVE_NOP_MCOUNT
+    ifeq ($(call cc-option-yn, -mnop-mcount),y)
+      CC_FLAGS_FTRACE	+= -mnop-mcount
+      CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+    endif
+  endif
 endif
 ifdef CONFIG_HAVE_FENTRY
   ifeq ($(call cc-option-yn, -mfentry),y)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 036cec1fcd24..fd6754b88f87 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -47,6 +47,11 @@ config HAVE_FENTRY
 	help
 	  Arch supports the gcc options -pg with -mfentry
 
+config HAVE_NOP_MCOUNT
+	bool
+	help
+	  Arch supports the gcc options -pg with -mrecord-mcount and -nop-mcount
+
 config HAVE_C_RECORDMCOUNT
 	bool
 	help
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 48b5b466ec7a..468e8527e979 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2950,12 +2950,14 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 			p = &pg->records[i];
 			p->flags = rec_flags;
 
+#ifndef CC_USING_NOP_MCOUNT
 			/*
 			 * Do the initial record conversion from mcount jump
 			 * to the NOP instructions.
 			 */
 			if (!ftrace_code_disable(mod, p))
 				break;
+#endif
 
 			update_cnt++;
 		}
-- 
2.18.0


