Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0207D2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549988104;
	bh=Xv5OzXSHjGSc0XjZHsImy5SwDPRNMpFpsQfpnURglKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JQCZAQT/j9yY5nnyOy/hrbwpvKOxvveun7qDbRmngmdVLhEBX2JpmT6SMnxzc9YMs
	 4zYWkWu4zFO7kt99h97gpZw0w/Ej0FMtqhWGAtHToSZbWnDFTPAZLNZDYDHk6YMbAK
	 7zmpoYWKrD9t6Uq/zNjf8QxKPRIGScAREuIbZoNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfBLQPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:15:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbfBLQPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:15:00 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 606EC21773;
        Tue, 12 Feb 2019 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549988100;
        bh=Xv5OzXSHjGSc0XjZHsImy5SwDPRNMpFpsQfpnURglKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4ZhZ47R1zi/Iq36B7tHASuS0xrDSB9K2U70RbAb7WkGBcBe4L1IojSf3LsQQ0lWU
         WL3QAG0MW/GN1X/+U73EmEaK3TwrLQ+g5IMjsS3eftUeXUCkAU1wKA8H/sgRod0u4/
         O2ZbLNVaBP7OQ6zNX8c4waAdBUe5MySbsjpM4XmE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 08/10] kprobes: Prohibit probing on RCU debug routine
Date:   Wed, 13 Feb 2019 01:14:37 +0900
Message-Id: <154998807741.31052.11229157537816341591.stgit@devbox>
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

Since kprobe itself depends on RCU, probing on RCU debug
routine can cause recursive breakpoint problem.
Prohibit probing on RCU debug routines.

int3
 ->do_int3()
   ->ist_enter()
     ->RCU_LOCKDEP_WARN()
       ->debug_lockdep_rcu_enabled() -> int3

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/rcu/update.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1971869c4072..f4ca36d92138 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -52,6 +52,7 @@
 #include <linux/tick.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/isolation.h>
+#include <linux/kprobes.h>
 
 #define CREATE_TRACE_POINTS
 
@@ -249,6 +250,7 @@ int notrace debug_lockdep_rcu_enabled(void)
 	       current->lockdep_recursion == 0;
 }
 EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
+NOKPROBE_SYMBOL(debug_lockdep_rcu_enabled);
 
 /**
  * rcu_read_lock_held() - might we be in RCU read-side critical section?

