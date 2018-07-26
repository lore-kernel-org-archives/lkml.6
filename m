Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1741BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C233620844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMeJkSX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C233620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbeGZOBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbeGZOBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:01:36 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48B222083F;
        Thu, 26 Jul 2018 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532609095;
        bh=UiyNGI6LovwtDMYQ+ibBAjBEHYqjuWcOhHMI7/9CDyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMeJkSX5UfI6LNLKQsOws9E2kYcQAhftzlqoehXYcosqPk9vKBo04xZLWDOPpPxpj
         rOX9IEy1inIu5by8+RxWxd7nEZQix7J2lKB/8yF7H6RCwp2zHtYDdP22JRcltknsTA
         n3sakc5uPrsZBs3CGaRY1VLWPwQPwEoCDO7abGvk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tracing: Remove orphaned function ftrace_nr_registered_ops()
Date:   Thu, 26 Jul 2018 21:44:32 +0900
Message-Id: <153260907227.12474.5234899025934963683.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153260898648.12474.8316095450186108842.stgit@devbox>
References: <153260898648.12474.8316095450186108842.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ftrace_nr_registered_ops() because it is no more used.

ftrace_nr_registered_ops() has been introduced by commit
ea701f11da44 ("ftrace: Add selftest to test function trace
recursion protection"), but its caller has been removed by
commit 05cbbf643b8e ("tracing: Fix selftest function
recursion accounting"). So it is not called anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

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

