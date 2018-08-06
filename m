Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB32C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E24219C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aKOgs/Jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E24219C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeHFFsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:48:00 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43097 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeHFFsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:48:00 -0400
Received: by mail-qt0-f196.google.com with SMTP id f18-v6so12327795qtp.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 20:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKNwJ5EqUfyx9QUAap7+RzSwtUflqtaLiEiMq3Zrg3o=;
        b=aKOgs/JmTeJKhBhIRaQEHgbY0SnvKObCLyGRyIBtK5Zr8pZ1BF5vS9qc058aYoj3hq
         yj7lnc+Cp/9nOEmiwq0UepZS0ADBXxMtYM3QjhBaga/XhpgZBgcRem6dzTCZrVYFtt3S
         R3OYgFObR2zarxaOVSu4it5py6fQ9JcQY1ewc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKNwJ5EqUfyx9QUAap7+RzSwtUflqtaLiEiMq3Zrg3o=;
        b=s+Hl3cCSznVtvreqTiPGKPhRRuAtaqyQo8t6wU4dFeC7271CxWF3cSWfIvx4E70d5o
         OrgnR7oZvT5WzlM4lheoy4SuYdmDfwgHK+49guQq29KxjN/NwwD7LQ0Z4++hlPmnvnsR
         FYItKK3z7sQcl4/7uX/0+pyumbu8DrdVrdJ5i1Zd094xwVHkZAGELZSzrI5vhHbFBc6W
         R97KGgouOhWCT/VpV2qlyrW7y8VFB4kIslKfFEFLm9OZV9cp+jiYsX/0psTyhL8OxEp7
         2vnU2Us/EVzB1af9G13dTx+cVbK0cOpyQk66e6lAtcQlrzMMfY+yFyaUbXbu5cAlip2s
         6MEQ==
X-Gm-Message-State: AOUpUlEdSgUnHcteIk5PN+ip3Xcep6fsoSIqbxaw5cz6SGaO91BdZ6MT
        2oiHZovsz42dxeGzYSQmfxHPfwyuoXHZ8Q==
X-Google-Smtp-Source: AAOMgpfrPzlpyiPPy5X0n/4JWJYmWN7iGA5IRiCVkxYfc9yaV5Z+fnFia5Ll0wF6xydunwzRf6VCcw==
X-Received: by 2002:a0c:9dd0:: with SMTP id p16-v6mr11699787qvf.211.1533526854960;
        Sun, 05 Aug 2018 20:40:54 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com ([4.78.42.66])
        by smtp.gmail.com with ESMTPSA id 16-v6sm7218620qkd.93.2018.08.05.20.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 20:40:54 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        paulmck@linux.vnet.ibm.com, mathieu.desnoyers@efficios.com,
        namhyung@kernel.org, peterz@infradead.org
Subject: [PATCH ftrace/core] tracing: irqsoff: Account for additional preempt_disable
Date:   Sun,  5 Aug 2018 20:40:49 -0700
Message-Id: <20180806034049.67949-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we tried to make the preemptirqsoff tracer to use irqsoff
tracepoint probes. However this causes issues as reported by Masami:

[2.271078] Testing tracer preemptirqsoff: .. no entries found ..FAILED!
[2.381015] WARNING: CPU: 0 PID: 1 at /home/mhiramat/ksrc/linux/kernel/
trace/trace.c:1512 run_tracer_selftest+0xf3/0x154

This is due to the tracepoint code increasing the preempt nesting count
by calling an additional preempt_disable before calling into the
preemptoff tracer which messes up the preempt_count() check in
tracer_hardirqs_off.

To fix this, make the irqsoff tracer probes balance the additional outer
preempt_disable with a preempt_enable_notrace.

The other way to fix this is to just use SRCU for all tracepoints.
However we can't do that because we can't use NMIs from RCU context.

Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints
                      and unify their usage")
Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace_irqsoff.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 770cd30cda40..ffbf1505d5bc 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -603,14 +603,40 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
  */
 static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
 {
+	/*
+	 * Tracepoint probes are expected to be called with preempt disabled,
+	 * We don't care about being called with preempt disabled but we need
+	 * to know in the future if that changes so we can remove the next
+	 * preempt_enable.
+	 */
+	WARN_ON_ONCE(!preempt_count());
+
+	/* Tracepoint probes disable preemption atleast once, account for that */
+	preempt_enable_notrace();
+
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(a0, a1);
+
+	preempt_disable_notrace();
 }
 
 static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
 {
+	/*
+	 * Tracepoint probes are expected to be called with preempt disabled,
+	 * We don't care about being called with preempt disabled but we need
+	 * to know in the future if that changes so we can remove the next
+	 * preempt_enable.
+	 */
+	WARN_ON_ONCE(!preempt_count());
+
+	/* Tracepoint probes disable preemption atleast once, account for that */
+	preempt_enable_notrace();
+
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(a0, a1);
+
+	preempt_disable_notrace();
 }
 
 static int irqsoff_tracer_init(struct trace_array *tr)
-- 
2.18.0.597.ga71716f1ad-goog

