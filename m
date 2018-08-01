Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E79C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8543E208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8543E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbeHAMUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:20:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33606 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbeHAMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:20:32 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=neptun.guests.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
        (Exim 4.80)
        (envelope-from <erica.bugden@linutronix.de>)
        id 1fkoTB-0004Bf-6d; Wed, 01 Aug 2018 12:35:07 +0200
From:   Erica Bugden <erica.bugden@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, peterz@infradead.org, tglx@linutronix.de,
        anna-maria@linutronix.de, bigeasy@linutronix.de,
        Erica Bugden <erica.bugden@linutronix.de>
Subject: [PATCH] ftrace: Add missing check for existing hwlat thread
Date:   Wed,  1 Aug 2018 12:45:54 +0200
Message-Id: <1533120354-22923-1-git-send-email-erica.bugden@linutronix.de>
X-Mailer: git-send-email 2.1.4
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Erica Bugden <erica.bugden@linutronix.de>
---
 kernel/trace/trace_hwlat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d7c8e4e..2d9d36d 100644
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
2.1.4

