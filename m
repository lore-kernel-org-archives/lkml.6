Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE04C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716C421738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547089066;
	bh=VND5k2JW7QtV9ySj2wCYQ+iFgA8ygUhr6ofMEiu+/Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uiBhOcJzbC3VFrDGsRClECtv3oj/vZdaJku9FtpVW+eri2sXwpuG7V5HL07jz7JDR
	 o2R5/2s6V0aX4Go4NoSuvsB5kIq4oRCNs1eITCpE9ijNz04i9+soWBwDbMXnbPHOQ6
	 gAotwB9K+MBtA5IYCHWem/Jy1MMTmaNjiqCZkl1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfAJC5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:57:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfAJC5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:57:45 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E638214DA;
        Thu, 10 Jan 2019 02:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547089064;
        bh=VND5k2JW7QtV9ySj2wCYQ+iFgA8ygUhr6ofMEiu+/Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7pZwBKhGE4bM3Yej+SE3irxDzGgKj5xhN8oynT04+++SS2CYRyGokHzXO+yodu3B
         LVmLkqSGU3ATfpg/Ay6N8+Bh44eLFbc1yl0+2fxwyQjSPnZQBqDFfHl3UJ60aehtOp
         DV+/NhPR2TK1hCp1i9PqDoufp76wnoPeqemTX/so=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH 7/9] kprobes: Prohibit probing on preempt_check debug functions
Date:   Thu, 10 Jan 2019 11:57:21 +0900
Message-Id: <154708904161.6325.9897869265517636291.stgit@devbox>
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

Since kprobes depends on preempt disable/enable, probing
on the preempt debug routine can cause recursive breakpoint
problem.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/smp_processor_id.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 85925aaa4fff..157d9e31f6c2 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -5,10 +5,11 @@
  * DEBUG_PREEMPT variant of smp_processor_id().
  */
 #include <linux/export.h>
+#include <linux/kprobes.h>
 #include <linux/sched.h>
 
-notrace static unsigned int check_preemption_disabled(const char *what1,
-							const char *what2)
+notrace static nokprobe_inline
+unsigned int check_preemption_disabled(const char *what1, const char *what2)
 {
 	int this_cpu = raw_smp_processor_id();
 
@@ -56,9 +57,11 @@ notrace unsigned int debug_smp_processor_id(void)
 	return check_preemption_disabled("smp_processor_id", "");
 }
 EXPORT_SYMBOL(debug_smp_processor_id);
+NOKPROBE_SYMBOL(debug_smp_processor_id);
 
 notrace void __this_cpu_preempt_check(const char *op)
 {
 	check_preemption_disabled("__this_cpu_", op);
 }
 EXPORT_SYMBOL(__this_cpu_preempt_check);
+NOKPROBE_SYMBOL(__this_cpu_preempt_check);

