Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E11CC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F4021717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wUTlYd+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F4021717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeHCE2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:28:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35351 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeHCE22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:28:28 -0400
Received: by mail-qt0-f195.google.com with SMTP id a5-v6so4702510qtp.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 19:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0vLw2pXtNo8xo2lrSjlBaA2pCmifQL71m7xlk33/Vk=;
        b=wUTlYd+kL/JbpkwQ33yjODCH0Sct5TgbNBYI1tEzwthYPiSElssQjxZxABrVipaETZ
         giK4EF3A2+G0oaAUJ4JOusaex9PgbEaWB/lP4Q3CUhCRvSUUKoADhL5kvlajUKk+QO17
         b8wE9Sd+W7Sl9XcCz+Tu1WkdYB3IFrIRatPAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0vLw2pXtNo8xo2lrSjlBaA2pCmifQL71m7xlk33/Vk=;
        b=soAOMbjZ3aZUiZv8w15zTRIi63rV/VrrlSMhjgsnWRPzz4pm1heCXfYL1Q0ZsEN6f/
         QZxZHfDFbzprNNURTOklY5CohuxjaCEBTzdmHlpY3vyK5WK/QJiSEiBDIHMmrRmE5H1c
         q3acRB8NQEQCmYCbW+0cV+q6XnHmewAGoSBqMs3TEfwKIGmNTeSvKzxfYb0Lfn5gT5Vb
         T6y32kdrWdHkx0QXM7gWCdu/t1yAlW+tgRt588ntdMebm6PAruvn9vctyvSCSg/nQ3fH
         nCuHDxqXQwcC9SCgjH6H3/6+59xSxCK7VUfoX9SZjHLLtEQkSk1cRA8W739+KKMMfiSZ
         RJrA==
X-Gm-Message-State: AOUpUlHpz7Nzi+x83PafuvCdqfOgYFeUsXIkO5uWNUnnm5eSNvoSKu06
        6hr6Y++/DVd5OGEZy/Z0/s5KaP2wJzg=
X-Google-Smtp-Source: AAOMgpccSqAUxlb0WcRam232dMvae9ThjwM6ICeeemGJ18/R4l60/HlpTwkiCB6jPntHGMixgzlZFg==
X-Received: by 2002:ac8:2d61:: with SMTP id o30-v6mr2040637qta.253.1533263667083;
        Thu, 02 Aug 2018 19:34:27 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com ([2600:1003:b86a:e60f:a119:1efd:28c9:65f7])
        by smtp.gmail.com with ESMTPSA id t34-v6sm3206934qtt.81.2018.08.02.19.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 19:34:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org
Subject: [PATCH] trace: Use rcu_dereference_raw for hooks from trace-event subsystem
Date:   Thu,  2 Aug 2018 19:34:07 -0700
Message-Id: <20180803023407.225852-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we switched to using SRCU for tracepoints used in the idle path,
we can no longer use rcu_dereference_sched for dereferencing points in
trace-event hooks.

Since tracepoints can now use either SRCU or sched-RCU, just use
rcu_dereference_raw for traceevents just like we're doing when
dereferencing the tracepoint table.

This prevents an RCU warning reported by Masami:

[  282.060593] WARNING: can't dereference registers at 00000000f3c7f62b
[  282.063200] =============================
[  282.064082] WARNING: suspicious RCU usage
[  282.064963] 4.18.0-rc6+ #15 Tainted: G        W        
[  282.066048] -----------------------------
[  282.066923] /home/mhiramat/ksrc/linux/kernel/trace/trace_events.c:242
				suspicious rcu_dereference_check() usage!
[  282.068974] 
[  282.068974] other info that might help us debug this:
[  282.068974] 
[  282.070770] 
[  282.070770] RCU used illegally from idle CPU!
[  282.070770] rcu_scheduler_active = 2, debug_locks = 1
[  282.072938] RCU used illegally from extended quiescent state!
[  282.074183] no locks held by swapper/0/0.
[  282.075071] 
[  282.075071] stack backtrace:
[  282.076121] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
[  282.077782] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
[  282.079604] Call Trace:
[  282.080212]  <IRQ>
[  282.080755]  dump_stack+0x85/0xcb
[  282.081523]  trace_event_ignore_this_pid+0x66/0x70
[  282.082541]  trace_event_raw_event_preemptirq_template+0xa2/0xb0
[  282.083774]  ? interrupt_entry+0xc4/0xe0
[  282.084665]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  282.085669]  trace_hardirqs_off_caller+0x90/0xd0
[  282.086597]  trace_hardirqs_off_thunk+0x1a/0x1c
[  282.087433]  ? call_function_interrupt+0xa/0x20
[  282.088201]  interrupt_entry+0xc4/0xe0
[  282.088848]  ? call_function_interrupt+0xa/0x20
[  282.089579]  </IRQ>
[  282.090029]  ? native_safe_halt+0x2/0x10
[  282.090695]  ? default_idle+0x1f/0x160
[  282.091330]  ? default_idle_call+0x24/0x40
[  282.091997]  ? do_idle+0x210/0x250
[  282.092658]  ? cpu_startup_entry+0x6f/0x80
[  282.093338]  ? start_kernel+0x49d/0x4bd
[  282.093987]  ? secondary_startup_64+0xa5/0xb0

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 14ff4ff3caab..7b508ce8ac44 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -239,7 +239,7 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
 	struct trace_array_cpu *data;
 	struct trace_pid_list *pid_list;
 
-	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	if (!pid_list)
 		return false;
 
@@ -512,7 +512,7 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
-	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, NULL, task);
 }
 
-- 
2.18.0.597.ga71716f1ad-goog

