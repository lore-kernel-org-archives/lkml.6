Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F4FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C95220870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547260164;
	bh=VND5k2JW7QtV9ySj2wCYQ+iFgA8ygUhr6ofMEiu+/Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b+0LadjCJIvSt6JyehwZB8Jh8pHeXXrKIpaZLDIBM9PJFhqMv3nuQN40C0NI7buiQ
	 aXMBak0+D2G/dOwKpPDXJWZCHsXUBKTl44fX8lhpwVCMnav5J8NcCjUIVEhtPUhLwC
	 Ow+YRfFeTydJw6PWQpol4WSQMe0w8F+kCfO4A/Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfALC3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:29:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfALC3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:29:22 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE2D204FD;
        Sat, 12 Jan 2019 02:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547260162;
        bh=VND5k2JW7QtV9ySj2wCYQ+iFgA8ygUhr6ofMEiu+/Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xH/55XssX8Ybo4OGJjYdH9wtOFR92YytHdiY/sHH5DQrQQ+D+QW4eMfUSE8W/HS71
         QvEVJYb5pFiIAxfYiV9ZABbtkQbq72kEaa46uPoVop+13DlVKmdjg3GuHOEUUA5xgT
         MED+Xu0w0sqhOEG+CV6MjPjpVVP19J3ZMytQGHjE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 7/9] kprobes: Prohibit probing on preempt_check debug functions
Date:   Sat, 12 Jan 2019 11:28:59 +0900
Message-Id: <154726013890.18060.11204538289611057483.stgit@devbox>
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

