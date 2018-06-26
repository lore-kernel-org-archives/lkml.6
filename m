Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48457C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E922F2442C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XUzklTF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E922F2442C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935122AbeFZAIr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:08:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:47016 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933778AbeFZAIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:08:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so7199090pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pSV2NEgN9zEOPW5KG4nyzf276xloMwEH4f0E5/TFDKg=;
        b=XUzklTF2hYBAE3Xl0rBhGcTfsP1qQjfNBst7xlJ26Ezlxv9dVw9+E75559VMFQQw8K
         YfymPdr/ZmZIl/u0S0ksxj/V4m6zH6BJNkau4Nl2q8iMQbqCcrKYABtDUXKPBpREPNOy
         NKJg/a+pyFU4RzwwvbkwEAWnPM8B3VAXmPSnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pSV2NEgN9zEOPW5KG4nyzf276xloMwEH4f0E5/TFDKg=;
        b=SU0K+HhMYBtkXIoBdk+pDrgonZaurTxjTGtII3O7myV+H8Wb+uwOZvPKDNZAMXuWxV
         1qbA3tJtWbHxt1BwwcOo0e9zb1vtlAzcemhfOrB61ZHyWDMzOkdwYjegagCo90FoskV5
         pHdR/ndPxSGWmY4ewJIUqt4xKU0z3u2WMwXW6oIksjk/uBvtElbnuTSQImqP2974mWjI
         wb7oQlD3DEFamkicHeLmZGcRapmjyOggsguoaiHF66JwWUb8I6MpsO/Qm5JbpiUrYFTs
         yMjE/5Gs4tJ0bT77rLudujOkq77G/Skj+qLNfywPQMzU29dbAIk/J4QFGyLtzCzsEs32
         bYQQ==
X-Gm-Message-State: APt69E2QNF50ikgt/c0o2h8pQ1Q2gmktFvRmnhKrMzGFBl+hA2LqWW4p
        t8GTmFhqEoxjsMPAoWbXr7KySVoJh2E=
X-Google-Smtp-Source: ADUXVKKHl63NrMwPK4zU4dO6Oz2DBhiLQXnAOp60UCZyxPg72U9PndMDhZDH+DBXL+oUpsdELqPSAA==
X-Received: by 2002:a62:ee01:: with SMTP id e1-v6mr14912574pfi.2.1529971721127;
        Mon, 25 Jun 2018 17:08:41 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id z26-v6sm253359pfd.60.2018.06.25.17.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:08:40 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        jreck@google.com, tkjos@google.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] trace: Reorder display of TGID to be after PID
Date:   Mon, 25 Jun 2018 17:08:22 -0700
Message-Id: <20180626000822.113931-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Currently ftrace displays data in trace output like so:

                                       _-----=> irqs-off
                                      / _----=> need-resched
                                     | / _---=> hardirq/softirq
                                     || / _--=> preempt-depth
                                     ||| /     delay
            TASK-PID   CPU    TGID   ||||    TIMESTAMP  FUNCTION
               | |       |      |    ||||       |         |
            bash-1091  [000] ( 1091) d..2    28.313544: sched_switch:

However Android's trace visualization tools expect a slightly different
format due to an out-of-tree patch patch that was been carried for a
decade, notice that the TGID and CPU fields are reversed:

                                       _-----=> irqs-off
                                      / _----=> need-resched
                                     | / _---=> hardirq/softirq
                                     || / _--=> preempt-depth
                                     ||| /     delay
            TASK-PID    TGID   CPU   ||||    TIMESTAMP  FUNCTION
               | |        |      |   ||||       |         |
            bash-1091  ( 1091) [002] d..2    64.965177: sched_switch:

From kernel v4.13 onwards, during which TGID was introduced, tracing
with systrace on all Android kernels will break (most Android kernels
have been on 4.9 with Android patches, so this issues hasn't been seen
yet). From v4.13 onwards things will break.

The chrome browser's tracing tools also embed the systrace viewer which
uses the legacy TGID format and updates to that are known to be
difficult to make.

Considering this, I suggest we make this change to the upstream kernel
and backport it to all Android kernels. I believe this feature is merged
recently enough into the upstream kernel that it shouldn't be a problem.
Also logically, IMO it makes more sense to group the TGID with the
TASK-PID and the CPU after these.

Fixes: 441dae8f2f29 ("tracing: Add support for display of tgid in trace output")
Cc: jreck@google.com
Cc: tkjos@google.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace.c        | 8 ++++----
 kernel/trace/trace_output.c | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c9336e98ac59..5711ca3ba4c9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3364,8 +3364,8 @@ static void print_func_help_header(struct trace_buffer *buf, struct seq_file *m,
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#           TASK-PID   CPU#   %s  TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
-	seq_printf(m, "#              | |       |    %s     |         |\n",	 tgid ? "  |      " : "");
+	seq_printf(m, "#           TASK-PID   %s  CPU#   TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
+	seq_printf(m, "#              | |     %s    |       |         |\n",	 tgid ? "  |      " : "");
 }
 
 static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file *m,
@@ -3385,9 +3385,9 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 		   tgid ? tgid_space : space);
 	seq_printf(m, "#                          %s||| /     delay\n",
 		   tgid ? tgid_space : space);
-	seq_printf(m, "#           TASK-PID   CPU#%s||||    TIMESTAMP  FUNCTION\n",
+	seq_printf(m, "#           TASK-PID %sCPU#  ||||    TIMESTAMP  FUNCTION\n",
 		   tgid ? "   TGID   " : space);
-	seq_printf(m, "#              | |       | %s||||       |         |\n",
+	seq_printf(m, "#              | |   %s  |   ||||       |         |\n",
 		   tgid ? "     |    " : space);
 }
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 90db994ac900..1c8e30fda46a 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -594,8 +594,7 @@ int trace_print_context(struct trace_iterator *iter)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%16s-%-5d [%03d] ",
-			       comm, entry->pid, iter->cpu);
+	trace_seq_printf(s, "%16s-%-5d ", comm, entry->pid);
 
 	if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
 		unsigned int tgid = trace_find_tgid(entry->pid);
@@ -606,6 +605,8 @@ int trace_print_context(struct trace_iterator *iter)
 			trace_seq_printf(s, "(%5d) ", tgid);
 	}
 
+	trace_seq_printf(s, "[%03d] ", iter->cpu);
+
 	if (tr->trace_flags & TRACE_ITER_IRQ_INFO)
 		trace_print_lat_fmt(s, entry);
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

