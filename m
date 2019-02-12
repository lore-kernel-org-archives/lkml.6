Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D483C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B36A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549988131;
	bh=NGj09ZlYvwysKa4bog5Nt7sVBbwEh+ImPCiZvgE5neI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pCsrNUxiTtYvma8ktUn6rCecJONw/03uTmQTIKYC4MGmx0rNxMLKYeicAVAsrxD5y
	 ZUhIUlJ4jFZ3wR3UgHwZbNuUhbA18g8gvMeC7WWZVkRVInB1iR4xZjbVpPcH769U2l
	 YMSERWOupE9byoIGuuXB62mHA3QIsgF+GCyldJW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfBLQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbfBLQP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:15:29 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B155921773;
        Tue, 12 Feb 2019 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549988128;
        bh=NGj09ZlYvwysKa4bog5Nt7sVBbwEh+ImPCiZvgE5neI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4Zk1RjI5+UXq61nxM3NUP15hl6Yi8J9KD8zwDSG54AozNLAKsAkUqTSmubW8IaQ/
         hKNjRXd+tV2Xa0hNgN2UK0V+laemq6jBBiUVb2Nc4czZ5Sntyc8MmnLYvpF9y9mjlg
         6932fd+I+M3cwS9z93aA/Uy1Dd0xGJ+iwZlIsZM4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 09/10] kprobes: Prohibit probing on lockdep functions
Date:   Wed, 13 Feb 2019 01:15:05 +0900
Message-Id: <154998810578.31052.1680977921449292812.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998785011.31052.1475728497912659748.stgit@devbox>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
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
index 7f7db23fc002..c1653a1b57b7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -50,6 +50,7 @@
 #include <linux/random.h>
 #include <linux/jhash.h>
 #include <linux/nmi.h>
+#include <linux/kprobes.h>
 
 #include <asm/sections.h>
 
@@ -2796,6 +2797,7 @@ void lockdep_hardirqs_on(unsigned long ip)
 	__trace_hardirqs_on_caller(ip);
 	current->lockdep_recursion = 0;
 }
+NOKPROBE_SYMBOL(lockdep_hardirqs_on);
 
 /*
  * Hardirqs were disabled:
@@ -2825,6 +2827,7 @@ void lockdep_hardirqs_off(unsigned long ip)
 	} else
 		debug_atomic_inc(redundant_hardirqs_off);
 }
+NOKPROBE_SYMBOL(lockdep_hardirqs_off);
 
 /*
  * Softirqs will be enabled:
@@ -3638,7 +3641,8 @@ __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 	return 0;
 }
 
-static int __lock_is_held(const struct lockdep_map *lock, int read)
+static nokprobe_inline
+int __lock_is_held(const struct lockdep_map *lock, int read)
 {
 	struct task_struct *curr = current;
 	int i;
@@ -3871,6 +3875,7 @@ int lock_is_held_type(const struct lockdep_map *lock, int read)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lock_is_held_type);
+NOKPROBE_SYMBOL(lock_is_held_type);
 
 struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 {

