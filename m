Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B783FC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7243C21A1C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7243C21A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeHKQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbeHKQY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EBF421A31;
        Sat, 11 Aug 2018 13:50:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHU-00063p-Ax; Sat, 11 Aug 2018 09:50:12 -0400
Message-Id: <20180811135012.234437517@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 08/34] tracing: Remove orphaned function ftrace_nr_registered_ops()
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Remove ftrace_nr_registered_ops() because it is no longer used.

ftrace_nr_registered_ops() has been introduced by commit ea701f11da44
("ftrace: Add selftest to test function trace recursion protection"), but
its caller has been removed by commit 05cbbf643b8e ("tracing: Fix selftest
function recursion accounting"). So it is not called anymore.

Link: http://lkml.kernel.org/r/153260907227.12474.5234899025934963683.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  6 ------
 kernel/trace/ftrace.c  | 24 ------------------------
 2 files changed, 30 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ebb77674be90..63af5eb0ff46 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -234,10 +234,6 @@ extern void ftrace_stub(unsigned long a0, unsigned long a1,
  */
 #define register_ftrace_function(ops) ({ 0; })
 #define unregister_ftrace_function(ops) ({ 0; })
-static inline int ftrace_nr_registered_ops(void)
-{
-	return 0;
-}
 static inline void ftrace_kill(void) { }
 static inline void ftrace_free_init_mem(void) { }
 static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
@@ -328,8 +324,6 @@ struct seq_file;
 
 extern int ftrace_text_reserved(const void *start, const void *end);
 
-extern int ftrace_nr_registered_ops(void);
-
 struct ftrace_ops *ftrace_ops_trampoline(unsigned long addr);
 
 bool is_ftrace_trampoline(unsigned long addr);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b8b3324ca1c8..0d380a98a880 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -157,30 +157,6 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #endif
 }
 
-/**
- * ftrace_nr_registered_ops - return number of ops registered
- *
- * Returns the number of ftrace_ops registered and tracing functions
- */
-int ftrace_nr_registered_ops(void)
-{
-	struct ftrace_ops *ops;
-	int cnt = 0;
-
-	mutex_lock(&ftrace_lock);
-
-	for (ops = rcu_dereference_protected(ftrace_ops_list,
-					     lockdep_is_held(&ftrace_lock));
-	     ops != &ftrace_list_end;
-	     ops = rcu_dereference_protected(ops->next,
-					     lockdep_is_held(&ftrace_lock)))
-		cnt++;
-
-	mutex_unlock(&ftrace_lock);
-
-	return cnt;
-}
-
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct pt_regs *regs)
 {
-- 
2.18.0


