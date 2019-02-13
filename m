Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20022C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3B0222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391161AbfBMJCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:02:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfBMJCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:02:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D90l8o196091
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:00:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D90llS196088;
        Wed, 13 Feb 2019 01:00:47 -0800
Date:   Wed, 13 Feb 2019 01:00:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-0eae81dc9f026d899c70f3931bf3bca6d7aa6938@git.kernel.org>
Cc:     mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        righi.andrea@gmail.com, mhiramat@kernel.org, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de
Reply-To: mhiramat@kernel.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
          rostedt@goodmis.org, righi.andrea@gmail.com, tglx@linutronix.de,
          acme@redhat.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          torvalds@linux-foundation.org
In-Reply-To: <154998796400.31052.8406236614820687840.stgit@devbox>
References: <154998796400.31052.8406236614820687840.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] x86/kprobes: Prohibit probing on IRQ handlers
 directly
Git-Commit-ID: 0eae81dc9f026d899c70f3931bf3bca6d7aa6938
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0eae81dc9f026d899c70f3931bf3bca6d7aa6938
Gitweb:     https://git.kernel.org/tip/0eae81dc9f026d899c70f3931bf3bca6d7aa6938
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 13 Feb 2019 01:12:44 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:39 +0100

x86/kprobes: Prohibit probing on IRQ handlers directly

Prohibit probing on IRQ handlers in irqentry_text because
if it interrupts user mode, at that point we haven't changed
to kernel space yet and which eventually leads a double fault.
E.g.

 # echo p apic_timer_interrupt > kprobe_events
 # echo 1 > events/kprobes/enable
 PANIC: double fault, error_code: 0x0
 CPU: 1 PID: 814 Comm: less Not tainted 4.20.0-rc3+ #30
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 RIP: 0010:error_entry+0x12/0xf0
 [snip]
 Call Trace:
  <ENTRY_TRAMPOLINE>
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x30
  ? trace_hardirqs_on_thunk+0x1c/0x1c
  ? error_entry+0x7c/0xf0
  ? async_page_fault+0x8/0x30
  ? native_iret+0x7/0x7
  ? int3+0xa/0x20
  ? trace_hardirqs_on_thunk+0x1c/0x1c
  ? error_entry+0x7c/0xf0
  ? int3+0xa/0x20
  ? apic_timer_interrupt+0x1/0x20
  </ENTRY_TRAMPOLINE>
 Kernel panic - not syncing: Machine halted.
 Kernel Offset: disabled
 ---[ end Kernel panic - not syncing: Machine halted. ]---

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998796400.31052.8406236614820687840.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4ba75afba527..a034cb808e7e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1028,6 +1028,13 @@ NOKPROBE_SYMBOL(kprobe_fault_handler);
 
 int __init arch_populate_kprobe_blacklist(void)
 {
+	int ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__irqentry_text_start,
+					 (unsigned long)__irqentry_text_end);
+	if (ret)
+		return ret;
+
 	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,
 					 (unsigned long)__entry_text_end);
 }
