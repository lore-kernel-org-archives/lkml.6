Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AC2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F142177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547260220;
	bh=cOlAHv51eBswt07zXB4jFJAKiWwANnHtBJxD9PP7ZOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JGMLuTWdnTZKHBeL2xwKnGySvC4sPIL0qKmMCYaPR0z0FCiHsFJC0zW45rtC8O+9p
	 hzgN76KMHQ+3HiRL4aUVbOWSuUvSiQOsUTcinX2cdxYLLtmswZN8XB35DNWiEsCd0V
	 trzARnE3cDu6uXywZ6Kana8I5W0Z/4x56Q+dAB5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfALCaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfALCaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:30:19 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93CFD204FD;
        Sat, 12 Jan 2019 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547260218;
        bh=cOlAHv51eBswt07zXB4jFJAKiWwANnHtBJxD9PP7ZOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cX/d58a/PL273eYdQOlJhUk8/PUEx/pdQOH5egfUinTeT4PDN6TGWi1fi4VN+vm4r
         yBcmrxH8fuFFQJtZmqoZUc4n0o8+tGUgGjNjkSMRIY/AUgF8f5uiSIRSoJv1oLfKBB
         FtSm7C0mXwGbUBhg5elsKS5TyTFqp/llf3z2GIwU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 9/9] kprobes: Prohibit probing on lockdep functions
Date:   Sat, 12 Jan 2019 11:29:55 +0900
Message-Id: <154726019565.18060.11682510369627582640.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154725993986.18060.2759150647140353514.stgit@devbox>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some lockdep functions can be involved in breakpoint handling
and probing on those functions can cause a breakpoint recursion.
Prohibit probing on those functions by blacklist.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/locking/lockdep.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 95932333a48b..bc35a54ae3d4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -50,6 +50,7 @@
 #include <linux/random.h>
 #include <linux/jhash.h>
 #include <linux/nmi.h>
+#include <linux/kprobes.h>
 
 #include <asm/sections.h>
 
@@ -2814,6 +2815,7 @@ void lockdep_hardirqs_on(unsigned long ip)
 	__trace_hardirqs_on_caller(ip);
 	current->lockdep_recursion = 0;
 }
+NOKPROBE_SYMBOL(lockdep_hardirqs_on);
 
 /*
  * Hardirqs were disabled:
@@ -2843,6 +2845,7 @@ void lockdep_hardirqs_off(unsigned long ip)
 	} else
 		debug_atomic_inc(redundant_hardirqs_off);
 }
+NOKPROBE_SYMBOL(lockdep_hardirqs_off);
 
 /*
  * Softirqs will be enabled:
@@ -3650,7 +3653,8 @@ __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 	return 0;
 }
 
-static int __lock_is_held(const struct lockdep_map *lock, int read)
+static nokprobe_inline
+int __lock_is_held(const struct lockdep_map *lock, int read)
 {
 	struct task_struct *curr = current;
 	int i;
@@ -3883,6 +3887,7 @@ int lock_is_held_type(const struct lockdep_map *lock, int read)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lock_is_held_type);
+NOKPROBE_SYMBOL(lock_is_held_type);
 
 struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 {

