Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4016DC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5122217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5122217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeHKQYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbeHKQYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871AC217AE;
        Sat, 11 Aug 2018 13:50:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHW-00069r-9Y; Sat, 11 Aug 2018 09:50:14 -0400
Message-Id: <20180811135014.190080722@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Erica Bugden <erica.bugden@linutronix.de>
Subject: [for-next][PATCH 19/34] ftrace: Add missing check for existing hwlat thread
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erica Bugden <erica.bugden@linutronix.de>

The hwlat tracer uses a kernel thread to measure latencies. The function
that creates this kernel thread, start_kthread(), can be called when the
tracer is initialized and when the tracer is explicitly enabled.
start_kthread() does not check if there is an existing hwlat kernel
thread and will create a new one each time it is called.

This causes the reference to the previous thread to be lost. Without the
thread reference, the old kernel thread becomes unstoppable and
continues to use CPU time even after the hwlat tracer has been disabled.
This problem can be observed when a system is booted with tracing
enabled and the hwlat tracer is configured like this:

	echo hwlat > current_tracer; echo 1 > tracing_on

Add the missing check for an existing kernel thread in start_kthread()
to prevent this problem. This function and the rest of the hwlat kernel
thread setup and teardown are already serialized because they are called
through the tracer core code with trace_type_lock held.

[
 Note, this only fixes the symptom. The real fix was not to call
 this function when tracing_on was already one. But this still makes
 the code more robust, so we'll add it.
]

Link: http://lkml.kernel.org/r/1533120354-22923-1-git-send-email-erica.bugden@linutronix.de

Signed-off-by: Erica Bugden <erica.bugden@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_hwlat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d7c8e4ec3d9d..2d9d36dd5fe7 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -354,6 +354,9 @@ static int start_kthread(struct trace_array *tr)
 	struct task_struct *kthread;
 	int next_cpu;
 
+	if (hwlat_kthread)
+		return 0;
+
 	/* Just pick the first CPU on first iteration */
 	current_mask = &save_cpumask;
 	get_online_cpus();
-- 
2.18.0


