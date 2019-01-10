Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26DCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6797A2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547089095;
	bh=Xv5OzXSHjGSc0XjZHsImy5SwDPRNMpFpsQfpnURglKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L+1LILqGgwqtj6ru5+1WrVKUiA8vCM/zBHjraU1zthLubPOSVKyp+MzHKaIS6ddAB
	 n3BIvt9jLyQzXNLC6B/ijdegvEQmz++OR4MHsZ83h7TOKcJWUl0Qur/5vzUjy06iHO
	 R6GeaVJYWmaZW2Qn3goZRM+wUK1w8vy5fx2v90Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfAJC6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:58:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfAJC6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:58:13 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21C7214DA;
        Thu, 10 Jan 2019 02:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547089093;
        bh=Xv5OzXSHjGSc0XjZHsImy5SwDPRNMpFpsQfpnURglKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYQb0a3H9EDPhxU/IcZC3KFqIWKHH84W4SJRnavb+vLJnmV5YpT7Xi834YgqezEkZ
         LagrUjIQzM12XrJLMzV6/JiQc/fqvmjpwth1EO0pEztPnZO89EhZKkIKpx/9HzPnTI
         3i6ewQOXUaoI/GJ2A9xSaM7SrDNMR9Wpou3eTX5I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH 8/9] kprobes: Prohibit probing on RCU debug routine
Date:   Thu, 10 Jan 2019 11:57:50 +0900
Message-Id: <154708907005.6325.13292027062251288029.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154708884117.6325.4454464467156828009.stgit@devbox>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
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

