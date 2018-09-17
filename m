Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED02DECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00CD214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00CD214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIQOPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:15:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeIQOPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:15:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04BF2C057F4E;
        Mon, 17 Sep 2018 08:48:59 +0000 (UTC)
Received: from f28server.default (ovpn-117-244.phx2.redhat.com [10.3.117.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C02F17B51;
        Mon, 17 Sep 2018 08:48:57 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <daniel@bristot.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH 2/2] trace,x86: Add nmi to the irq_vectors class
Date:   Mon, 17 Sep 2018 10:48:53 +0200
Message-Id: <998ff6da1fe084c94cb7eedcee697b7ec1fbd66c.1537173660.git.bristot@redhat.com>
In-Reply-To: <461ac057690a58e05395d07d0e1994855bb3cd7d.1537173660.git.bristot@redhat.com>
References: <461ac057690a58e05395d07d0e1994855bb3cd7d.1537173660.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 17 Sep 2018 08:48:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the irq_vector class of tracepoints does not include the NMI
entry. The NMI was in the first set of tracepoints for IRQs, but it was
dropped off because of the logic of switching IDT when enabling trace[1].
However, as the switching IDT logic was removed [2], it is possible to add
the NMI tracepoints back.

The tracepoints looks like:
 <idle>-0     [000] d.Z.   179.594315: nmi_entry: vector=2
 <idle>-0     [000] d.Z.   179.594396: nmi_exit: vector=2

[1] trace,x86: irq vector tracepoint support
    https://lwn.net/Articles/555465/
[2] commit 4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/include/asm/trace/irq_vectors.h | 5 +++++
 arch/x86/kernel/nmi.c                    | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index bc9669df97c9..5b93e1a6b1fe 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -144,6 +144,11 @@ DEFINE_IRQ_VECTOR_EVENT(thermal_apic);
  */
 DEFINE_IRQ_VECTOR_EVENT(external_interrupt);
 
+/*
+ * nmi - called when entering/exiting from nmi vector handler.
+ */
+DEFINE_IRQ_VECTOR_EVENT(nmi);
+
 TRACE_EVENT(vector_config,
 
 	TP_PROTO(unsigned int irq, unsigned int vector,
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 18bc9b51ac9b..fa2d16b3af60 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -37,6 +37,8 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
+#undef CREATE_TRACE_POINTS
+#include <asm/trace/irq_vectors.h>
 
 struct nmi_desc {
 	raw_spinlock_t lock;
@@ -514,12 +516,14 @@ do_nmi(struct pt_regs *regs, long error_code)
 #endif
 
 	nmi_enter();
+	trace_nmi_entry(2);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
+	trace_nmi_exit(2);
 	nmi_exit();
 
 #ifdef CONFIG_X86_64
-- 
2.17.1

